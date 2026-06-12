using whoshippedit.Models;
using whoshippedit.Data.Repository.Interface;
using whoshippedit.Business.Service.Interface;

namespace whoshippedit.Business.Service;

public class TargetCustomerService : ITargetCustomerService
{
    private readonly ITargetCustomerRepository _repo;

    public TargetCustomerService(ITargetCustomerRepository repo)
    {
        _repo = repo;
    }

    public Task<IEnumerable<TargetCustomer>> GetTargetCustomersAsync()
        => _repo.GetAllAsync();

    public Task SaveProductTargetsAsync(Guid productId, IReadOnlyList<Guid> targetIds)
        => _repo.SaveProductTargetsAsync(productId, targetIds);

    public Task<IEnumerable<Guid>> GetProductTargetIdsAsync(Guid productId)
        => _repo.GetProductTargetIdsAsync(productId);
}
