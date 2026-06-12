using whoshippedit.Models;
using whoshippedit.Utilities;
using whoshippedit.Data.Repository.Interface;

namespace whoshippedit.Data.Repository;

public class ProductRepository : IProductRepository
{
    private readonly IDbConnectionHelper _db;

    public ProductRepository(IDbConnectionHelper db)
    {
        _db = db;
    }

    public async Task<string?> GetSlugAsync(string slug)
    {
        return await _db.QueryFirstOrDefaultAsync<string>(
            "SELECT slug FROM products WHERE slug = @Slug", new { Slug = slug });
    }

    public async Task<string?> GetByDomainAsync(string domain)
    {
        return await _db.QueryFirstOrDefaultAsync<string>(
            "SELECT domain FROM products WHERE domain = @Domain", new { Domain = domain });
    }

    public async Task<Product?> GetBySlugAsync(string slug)
    {
        var sql = @"
            SELECT p.*, c.name AS category_name
            FROM products p
            LEFT JOIN categories c ON c.id = p.category_id
            WHERE p.slug = @Slug
        ";

        return await _db.QueryFirstOrDefaultAsync<Product>(sql, new { Slug = slug });
    }

    public async Task<Guid> InsertProductAsync(Product product, string slug, string domain, short status, short source, Guid addedBy)
    {
        var sql = @"
            INSERT INTO products (
                slug, domain, name, tagline, description, website_url, category_id,
                founded_year, country_code,
                founder_name, founder_twitter, founder_linkedin,
                mrr, arr, currency,
                pricing_type, price_from, price_to,
                status, source, added_by
            )
            VALUES (
                @Slug, @Domain, @Name, @Tagline, @Description, @WebsiteUrl, @CategoryId,
                @FoundedYear, @CountryCode,
                @FounderName, @FounderTwitter, @FounderLinkedin,
                @Mrr, @Arr, @Currency,
                @PricingType, @PriceFrom, @PriceTo,
                @Status, @Source, @AddedBy
            )
            RETURNING id
        ";

        return await _db.QueryFirstOrDefaultAsync<Guid>(sql, new 
        { 
            Slug = slug, 
            Domain = domain,
            Name = product.Name, 
            Tagline = product.Tagline ?? "",
            Description = product.Description,
            WebsiteUrl = product.WebsiteUrl,
            CategoryId = product.CategoryId,
            FoundedYear = product.FoundedYear,
            CountryCode = product.CountryCode,
            FounderName = product.FounderName,
            FounderTwitter = product.FounderTwitter,
            FounderLinkedin = product.FounderLinkedin,
            Mrr = product.Mrr,
            Arr = product.Arr,
            Currency = product.Currency ?? "USD",
            PricingType = product.PricingType,
            PriceFrom = product.PriceFrom,
            PriceTo = product.PriceTo,
            Status = status,
            Source = source,
            AddedBy = addedBy
        });
    }
}
