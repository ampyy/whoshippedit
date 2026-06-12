using System.Data;

namespace whoshippedit.Utilities;

/// <summary>
/// A wrapper interface for database operations using Dapper and Npgsql.
/// </summary>
public interface IDbConnectionHelper
{
    /// <summary>
    /// Creates and returns a new database connection. 
    /// The caller is responsible for disposing the connection.
    /// </summary>
    IDbConnection GetConnection();

    #region Asynchronous Operations

    /// <summary>
    /// Executes a query asynchronously, returning a list of strongly-typed data.
    /// </summary>
    Task<IEnumerable<T>> QueryAsync<T>(string sql, object? param = null, IDbTransaction? transaction = null, int? commandTimeout = null, CommandType? commandType = null);

    /// <summary>
    /// Executes a query asynchronously, returning a single strongly-typed result, or default if no row is returned.
    /// </summary>
    Task<T?> QueryFirstOrDefaultAsync<T>(string sql, object? param = null, IDbTransaction? transaction = null, int? commandTimeout = null, CommandType? commandType = null);

    /// <summary>
    /// Executes a query asynchronously, returning a single strongly-typed result. Throws if no result or multiple results.
    /// </summary>
    Task<T> QuerySingleAsync<T>(string sql, object? param = null, IDbTransaction? transaction = null, int? commandTimeout = null, CommandType? commandType = null);

    /// <summary>
    /// Executes a command asynchronously (e.g., INSERT, UPDATE, DELETE) and returns the number of rows affected.
    /// </summary>
    Task<int> ExecuteAsync(string sql, object? param = null, IDbTransaction? transaction = null, int? commandTimeout = null, CommandType? commandType = null);

    /// <summary>
    /// Executes a query asynchronously and returns the first column of the first row in the result set.
    /// </summary>
    Task<T?> ExecuteScalarAsync<T>(string sql, object? param = null, IDbTransaction? transaction = null, int? commandTimeout = null, CommandType? commandType = null);

    #endregion

    #region Synchronous Operations

    /// <summary>
    /// Executes a query synchronously, returning a list of strongly-typed data.
    /// </summary>
    IEnumerable<T> Query<T>(string sql, object? param = null, IDbTransaction? transaction = null, bool buffered = true, int? commandTimeout = null, CommandType? commandType = null);

    /// <summary>
    /// Executes a query synchronously, returning a single strongly-typed result, or default if no row is returned.
    /// </summary>
    T? QueryFirstOrDefault<T>(string sql, object? param = null, IDbTransaction? transaction = null, int? commandTimeout = null, CommandType? commandType = null);

    /// <summary>
    /// Executes a command synchronously (e.g., INSERT, UPDATE, DELETE) and returns the number of rows affected.
    /// </summary>
    int Execute(string sql, object? param = null, IDbTransaction? transaction = null, int? commandTimeout = null, CommandType? commandType = null);

    /// <summary>
    /// Executes a query synchronously and returns the first column of the first row in the result set.
    /// </summary>
    T? ExecuteScalar<T>(string sql, object? param = null, IDbTransaction? transaction = null, int? commandTimeout = null, CommandType? commandType = null);

    #endregion
}
