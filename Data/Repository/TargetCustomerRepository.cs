using Dapper;
using Npgsql;
using whoshippedit.Models;
using whoshippedit.Utilities;
using whoshippedit.Data.Repository.Interface;

namespace whoshippedit.Data.Repository;

public class TargetCustomerRepository : ITargetCustomerRepository
{
    private readonly IDbConnectionHelper _db;

    public TargetCustomerRepository(IDbConnectionHelper db)
    {
        _db = db;
    }

    public async Task<IEnumerable<TargetCustomer>> GetAllAsync()
    {
        return await _db.QueryAsync<TargetCustomer>(
            "SELECT id, name, sort_order FROM target_customers ORDER BY sort_order ASC");
    }

    public async Task<IEnumerable<Guid>> GetProductTargetIdsAsync(Guid productId)
    {
        return await _db.QueryAsync<Guid>(
            "SELECT target_customer_id FROM product_targets WHERE product_id = @ProductId",
            new { ProductId = productId });
    }

    public async Task SaveProductTargetsAsync(Guid productId, IReadOnlyList<Guid> targetIds)
    {
        if (targetIds.Count > 3)
            throw new InvalidOperationException("Maximum 3 targets allowed.");

        // Open a raw connection for transaction support
        using var conn = (NpgsqlConnection)_db.GetConnection();
        await conn.OpenAsync();
        await using var tx = await conn.BeginTransactionAsync();

        try
        {
            // Delete existing links
            await conn.ExecuteAsync(
                "DELETE FROM product_targets WHERE product_id = @ProductId",
                new { ProductId = productId },
                transaction: tx);

            // Insert new links
            if (targetIds.Count > 0)
            {
                var rows = targetIds.Select(tid => new { ProductId = productId, TargetCustomerId = tid });
                await conn.ExecuteAsync(
                    "INSERT INTO product_targets (product_id, target_customer_id) VALUES (@ProductId, @TargetCustomerId)",
                    rows,
                    transaction: tx);
            }

            await tx.CommitAsync();
        }
        catch
        {
            await tx.RollbackAsync();
            throw;
        }
    }
}
