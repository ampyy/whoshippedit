using whoshippedit.Models;

namespace whoshippedit.Data.Repository.Interface;

public interface IProductRepository
{
    Task<string?> GetSlugAsync(string slug);
    Task<string?> GetByDomainAsync(string domain);
    Task<Product?> GetBySlugAsync(string slug);
    Task<Guid> InsertProductAsync(Product product, string slug, string domain, short status, short source, Guid addedBy);
}
