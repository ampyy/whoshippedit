using whoshippedit.Models;
using whoshippedit.Data.Repository.Interface;
using whoshippedit.Business.Service.Interface;

namespace whoshippedit.Business.Service;

public class ProductService : IProductService
{
    private readonly IProductRepository _productRepo;

    public ProductService(IProductRepository productRepo)
    {
        _productRepo = productRepo;
    }

    public Task<Product?> GetBySlugAsync(string slug)
        => _productRepo.GetBySlugAsync(slug);

    public Task<(List<Product> Items, int TotalCount)> GetProductsAsync(
        string? search = null,
        string? categorySlug = null,
        string? mrr = null,
        string? country = null,
        string? sort = null,
        int page = 1,
        int pageSize = 50)
        => _productRepo.GetProductsAsync(search, categorySlug, mrr, country, sort, page, pageSize);

    public async Task<Guid> SubmitProductAsync(Product product, Guid addedBy)
    {
        var slug = GenerateSlug(product.Name);
        var existingSlug = await _productRepo.GetSlugAsync(slug);
        
        if (existingSlug != null)
        {
            slug = $"{slug}-{new Random().Next(1000, 9999)}";
        }

        var domain = ExtractDomain(product.WebsiteUrl);

        var existingDomain = await _productRepo.GetByDomainAsync(domain);
        if (existingDomain != null)
        {
            throw new InvalidOperationException($"A product with the domain \"{domain}\" already exists in the directory.");
        }

        return await _productRepo.InsertProductAsync(
            product, 
            slug, 
            domain, 
            AppConstants.Status.Approved, // Auto approve since it's admin
            AppConstants.Source.Manual, 
            addedBy
        );
    }

    private string GenerateSlug(string phrase)
    {
        string str = phrase.ToLowerInvariant();
        str = System.Text.RegularExpressions.Regex.Replace(str, @"[^a-z0-9\s-]", "");
        str = System.Text.RegularExpressions.Regex.Replace(str, @"\s+", "-").Trim('-');
        return str.Length <= 60 ? str : str.Substring(0, 60).Trim('-');
    }

    private string ExtractDomain(string url)
    {
        try
        {
            if (!url.StartsWith("http")) url = "https://" + url;
            var uri = new Uri(url);
            var host = uri.Host.ToLower();
            if (host.StartsWith("www.")) host = host.Substring(4);
            return host;
        }
        catch
        {
            return url.ToLower(); // fallback
        }
    }

    public Task<short?> GetUserWouldBuildVoteAsync(Guid productId, Guid userId)
        => _productRepo.GetUserWouldBuildVoteAsync(productId, userId);

    public async Task<bool> VoteWouldBuildAsync(string slug, Guid userId, short voteType)
    {
        var product = await _productRepo.GetBySlugAsync(slug);
        if (product == null) return false;

        var existingVote = await _productRepo.GetUserWouldBuildVoteAsync(product.Id, userId);
        if (existingVote.HasValue && existingVote.Value == voteType)
        {
            await _productRepo.DeleteWouldBuildVoteAsync(product.Id, userId);
        }
        else
        {
            await _productRepo.UpsertWouldBuildVoteAsync(product.Id, userId, voteType);
        }
        return true;
    }
}
