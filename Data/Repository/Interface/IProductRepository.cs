using whoshippedit.Models;

namespace whoshippedit.Data.Repository.Interface;

public interface IProductRepository
{
    Task<string?> GetSlugAsync(string slug);
    Task<string?> GetByDomainAsync(string domain);
    Task<Product?> GetBySlugAsync(string slug);
    Task<Guid> InsertProductAsync(Product product, string slug, string domain, short status, short source, Guid addedBy);
    Task<short?> GetUserWouldBuildVoteAsync(Guid productId, Guid userId);
    Task UpsertWouldBuildVoteAsync(Guid productId, Guid userId, short vote);
    Task DeleteWouldBuildVoteAsync(Guid productId, Guid userId);
    Task<(List<Product> Items, int TotalCount)> GetProductsAsync(
        string? search = null,
        string? categorySlug = null,
        string? mrr = null,
        string? country = null,
        string? sort = null,
        int page = 1,
        int pageSize = 50);
}
