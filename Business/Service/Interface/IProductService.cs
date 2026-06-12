using whoshippedit.Models;

namespace whoshippedit.Business.Service.Interface;

public interface IProductService
{
    Task<Product?> GetBySlugAsync(string slug);
    Task<Guid> SubmitProductAsync(Product product, Guid addedBy);
}
