using System.Data;
using Dapper;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Npgsql;

namespace whoshippedit.Utilities;

/// <summary>
/// Implementation of IDbConnectionHelper using Dapper and Npgsql.
/// </summary>
public class DbConnectionHelper : IDbConnectionHelper
{
    private readonly string _connectionString;

    public DbConnectionHelper(IConfiguration configuration, IHostEnvironment hostEnvironment)
    {
        // Explicitly choose connection string key based on the environment
        string connectionKey = hostEnvironment.IsDevelopment() 
            ? "DefaultConnection" 
            : "ProductionConnection";

        var rawConnectionString = configuration.GetConnectionString(connectionKey)
            ?? configuration.GetConnectionString("DefaultConnection") // Fallback
            ?? throw new InvalidOperationException($"Connection string for environment '{hostEnvironment.EnvironmentName}' (key '{connectionKey}') not found in configuration.");

        _connectionString = ConvertPostgresUriToConnectionString(rawConnectionString);
    }

    /// <summary>
    /// Creates and returns a new NpgsqlConnection. The caller is responsible for disposing it.
    /// </summary>
    public IDbConnection GetConnection()
    {
        return new NpgsqlConnection(_connectionString);
    }

    #region Helper Methods to Convert PostgreSQL URI to ADO.NET Connection String

    /// <summary>
    /// Converts a postgresql:// or postgres:// URI into a standard ADO.NET Npgsql connection string.
    /// If the connection string is already in a key-value format, it is returned unchanged.
    /// </summary>
    public static string ConvertPostgresUriToConnectionString(string input)
    {
        if (string.IsNullOrWhiteSpace(input))
            return input;

        input = input.Trim();

        if (input.StartsWith("postgresql://", StringComparison.OrdinalIgnoreCase) ||
            input.StartsWith("postgres://", StringComparison.OrdinalIgnoreCase))
        {
            try
            {
                var uri = new Uri(input);
                var builder = new NpgsqlConnectionStringBuilder();

                // 1. Host and Port
                builder.Host = uri.Host;
                if (uri.Port > 0)
                {
                    builder.Port = uri.Port;
                }

                // 2. Database
                builder.Database = uri.AbsolutePath.TrimStart('/');

                // 3. Credentials
                if (!string.IsNullOrEmpty(uri.UserInfo))
                {
                    var userInfoParts = uri.UserInfo.Split(':');
                    builder.Username = userInfoParts[0];
                    if (userInfoParts.Length > 1)
                    {
                        builder.Password = Uri.UnescapeDataString(userInfoParts[1]);
                    }
                }

                // 4. SSL Configuration
                builder.SslMode = SslMode.Require;

                // 5. Query string parameters parsing (e.g. sslmode, channel_binding, etc.)
                var query = uri.Query.TrimStart('?');
                if (!string.IsNullOrEmpty(query))
                {
                    var queryParameters = query.Split('&');
                    foreach (var param in queryParameters)
                    {
                        var keyValue = param.Split('=');
                        if (keyValue.Length == 2)
                        {
                            var key = keyValue[0].ToLowerInvariant();
                            var val = Uri.UnescapeDataString(keyValue[1]);

                            switch (key)
                            {
                                case "sslmode":
                                    if (Enum.TryParse<SslMode>(val, true, out var sslMode))
                                    {
                                        builder.SslMode = sslMode;
                                    }
                                    else if (val.Equals("require", StringComparison.OrdinalIgnoreCase))
                                    {
                                        builder.SslMode = SslMode.Require;
                                    }
                                    break;
                                case "channel_binding":
                                    // Some PostgreSQL hosts support/require channel binding parameters.
                                    // Modern NpgsqlConnectionStringBuilder supports custom connection parameters
                                    // and specific properties. We can add custom logic if needed or let Npgsql default.
                                    break;
                            }
                        }
                    }
                }

                return builder.ConnectionString;
            }
            catch (Exception)
            {
                // Fallback to the raw connection string if URI parsing fails
                return input;
            }
        }

        return input;
    }

    #endregion

    #region Asynchronous Operations Implementation

    public async Task<IEnumerable<T>> QueryAsync<T>(string sql, object? param = null, IDbTransaction? transaction = null, int? commandTimeout = null, CommandType? commandType = null)
    {
        using var connection = GetConnection();
        return await connection.QueryAsync<T>(sql, param, transaction, commandTimeout, commandType);
    }

    public async Task<T?> QueryFirstOrDefaultAsync<T>(string sql, object? param = null, IDbTransaction? transaction = null, int? commandTimeout = null, CommandType? commandType = null)
    {
        using var connection = GetConnection();
        return await connection.QueryFirstOrDefaultAsync<T>(sql, param, transaction, commandTimeout, commandType);
    }

    public async Task<T> QuerySingleAsync<T>(string sql, object? param = null, IDbTransaction? transaction = null, int? commandTimeout = null, CommandType? commandType = null)
    {
        using var connection = GetConnection();
        return await connection.QuerySingleAsync<T>(sql, param, transaction, commandTimeout, commandType);
    }

    public async Task<int> ExecuteAsync(string sql, object? param = null, IDbTransaction? transaction = null, int? commandTimeout = null, CommandType? commandType = null)
    {
        using var connection = GetConnection();
        return await connection.ExecuteAsync(sql, param, transaction, commandTimeout, commandType);
    }

    public async Task<T?> ExecuteScalarAsync<T>(string sql, object? param = null, IDbTransaction? transaction = null, int? commandTimeout = null, CommandType? commandType = null)
    {
        using var connection = GetConnection();
        return await connection.ExecuteScalarAsync<T>(sql, param, transaction, commandTimeout, commandType);
    }

    #endregion

    #region Synchronous Operations Implementation

    public IEnumerable<T> Query<T>(string sql, object? param = null, IDbTransaction? transaction = null, bool buffered = true, int? commandTimeout = null, CommandType? commandType = null)
    {
        using var connection = GetConnection();
        return connection.Query<T>(sql, param, transaction, buffered, commandTimeout, commandType);
    }

    public T? QueryFirstOrDefault<T>(string sql, object? param = null, IDbTransaction? transaction = null, int? commandTimeout = null, CommandType? commandType = null)
    {
        using var connection = GetConnection();
        return connection.QueryFirstOrDefault<T>(sql, param, transaction, commandTimeout, commandType);
    }

    public int Execute(string sql, object? param = null, IDbTransaction? transaction = null, int? commandTimeout = null, CommandType? commandType = null)
    {
        using var connection = GetConnection();
        return connection.Execute(sql, param, transaction, commandTimeout, commandType);
    }

    public T? ExecuteScalar<T>(string sql, object? param = null, IDbTransaction? transaction = null, int? commandTimeout = null, CommandType? commandType = null)
    {
        using var connection = GetConnection();
        return connection.ExecuteScalar<T>(sql, param, transaction, commandTimeout, commandType);
    }

    #endregion
}
