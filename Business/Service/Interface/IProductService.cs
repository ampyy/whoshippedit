using whoshippedit.Models;

namespace whoshippedit.Business.Service.Interface;

public interface IProductService
{
    Task<Product?> GetBySlugAsync(string slug);
    Task<Guid> SubmitProductAsync(Product product, Guid addedBy);
    Task<short?> GetUserWouldBuildVoteAsync(Guid productId, Guid userId);
    Task<bool> VoteWouldBuildAsync(string slug, Guid userId, short voteType);
    Task<(List<Product> Items, int TotalCount)> GetProductsAsync(
        string? search = null,
        string? categorySlug = null,
        string? mrr = null,
        string? country = null,
        string? sort = null,
        int page = 1,
        int pageSize = 50);
}
