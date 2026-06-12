using whoshippedit.Models;

namespace whoshippedit.Data.Repository.Interface;

public interface ITargetCustomerRepository
{
    /// <summary>Fetch all target customers ordered by sort_order.</summary>
    Task<IEnumerable<TargetCustomer>> GetAllAsync();

    /// <summary>Get the target customer IDs currently linked to a product.</summary>
    Task<IEnumerable<Guid>> GetProductTargetIdsAsync(Guid productId);

    /// <summary>
    /// Replace all target links for a product in a single transaction.
    /// Deletes existing rows then inserts the new set.
    /// </summary>
    Task SaveProductTargetsAsync(Guid productId, IReadOnlyList<Guid> targetIds);
}
