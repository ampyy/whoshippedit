using whoshippedit.Models;

namespace whoshippedit.Business.Service.Interface;

public interface ITargetCustomerService
{
    Task<IEnumerable<TargetCustomer>> GetTargetCustomersAsync();
    Task SaveProductTargetsAsync(Guid productId, IReadOnlyList<Guid> targetIds);
    Task<IEnumerable<Guid>> GetProductTargetIdsAsync(Guid productId);
}
