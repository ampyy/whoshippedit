using whoshippedit.Models;
using whoshippedit.Utilities;
using whoshippedit.Data.Repository.Interface;
using System.Text;

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

    public async Task<(List<Product> Items, int TotalCount)> GetProductsAsync(
        string? search = null,
        string? categorySlug = null,
        string? mrr = null,
        string? country = null,
        string? sort = null,
        int page = 1,
        int pageSize = 50)
    {
        var where = new StringBuilder("WHERE p.status = 1");
        var parameters = new Dapper.DynamicParameters();

        if (!string.IsNullOrWhiteSpace(search))
        {
            where.Append(" AND (p.name ILIKE @Search OR p.tagline ILIKE @Search OR p.description ILIKE @Search)");
            parameters.Add("Search", $"%{search.Trim()}%");
        }

        if (!string.IsNullOrWhiteSpace(categorySlug))
        {
            where.Append(" AND c.slug = @CategorySlug");
            parameters.Add("CategorySlug", categorySlug);
        }

        if (!string.IsNullOrWhiteSpace(mrr))
        {
            switch (mrr)
            {
                case "0":
                    where.Append(" AND p.mrr IS NULL");
                    break;
                case "1k":
                    where.Append(" AND p.mrr >= 0 AND p.mrr < 1000");
                    break;
                case "10k":
                    where.Append(" AND p.mrr >= 1000 AND p.mrr < 10000");
                    break;
                case "100k":
                    where.Append(" AND p.mrr >= 10000 AND p.mrr < 100000");
                    break;
                case "1m":
                    where.Append(" AND p.mrr >= 100000 AND p.mrr < 1000000");
                    break;
                case "big":
                    where.Append(" AND p.mrr >= 1000000");
                    break;
            }
        }

        if (!string.IsNullOrWhiteSpace(country))
        {
            where.Append(" AND p.country_code = @Country");
            parameters.Add("Country", country.ToUpper());
        }

        var orderBy = sort switch
        {
            "trending"  => "p.upvote_count DESC NULLS LAST",
            "mrr"       => "p.mrr DESC NULLS LAST",
            "upvotes"   => "p.upvote_count DESC NULLS LAST",
            "score"     => "p.would_build_yes DESC NULLS LAST",
            _           => "p.created_at DESC"
        };

        var offset = (page - 1) * pageSize;
        parameters.Add("Limit",  pageSize);
        parameters.Add("Offset", offset);

        var countSql = $@"
            SELECT COUNT(*) FROM products p
            LEFT JOIN categories c ON c.id = p.category_id
            {where}
        ";

        var dataSql = $@"
            SELECT p.*, c.name AS category_name
            FROM products p
            LEFT JOIN categories c ON c.id = p.category_id
            {where}
            ORDER BY {orderBy}
            LIMIT @Limit OFFSET @Offset
        ";

        var totalCount = await _db.QueryFirstOrDefaultAsync<int>(countSql, parameters);
        var items = (await _db.QueryAsync<Product>(dataSql, parameters)).ToList();

        return (items, totalCount);
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
                status, source, added_by, data_source_url
            )
            VALUES (
                @Slug, @Domain, @Name, @Tagline, @Description, @WebsiteUrl, @CategoryId,
                @FoundedYear, @CountryCode,
                @FounderName, @FounderTwitter, @FounderLinkedin,
                @Mrr, @Arr, @Currency,
                @PricingType, @PriceFrom, @PriceTo,
                @Status, @Source, @AddedBy, @DataSourceUrl
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
            AddedBy = addedBy,
            DataSourceUrl = product.DataSourceUrl
        });
    }

    public async Task<short?> GetUserWouldBuildVoteAsync(Guid productId, Guid userId)
    {
        return await _db.QueryFirstOrDefaultAsync<short?>(
            "SELECT vote FROM would_build_votes WHERE product_id = @ProductId AND user_id = @UserId LIMIT 1",
            new { ProductId = productId, UserId = userId });
    }

    public async Task UpsertWouldBuildVoteAsync(Guid productId, Guid userId, short vote)
    {
        var sql = @"
            INSERT INTO would_build_votes (product_id, user_id, vote)
            VALUES (@ProductId, @UserId, @Vote)
            ON CONFLICT (product_id, user_id) 
            DO UPDATE SET vote = @Vote, created_at = now()
        ";

        await _db.ExecuteAsync(sql, new { ProductId = productId, UserId = userId, Vote = vote });

        if (vote == 0)
        {
            await _db.ExecuteAsync(@"
                INSERT INTO votes (product_id, user_id)
                VALUES (@ProductId, @UserId)
                ON CONFLICT (product_id, user_id) DO NOTHING
            ", new { ProductId = productId, UserId = userId });
        }
        else
        {
            await _db.ExecuteAsync(@"
                DELETE FROM votes
                WHERE product_id = @ProductId AND user_id = @UserId
            ", new { ProductId = productId, UserId = userId });
        }
    }

    public async Task DeleteWouldBuildVoteAsync(Guid productId, Guid userId)
    {
        await _db.ExecuteAsync("DELETE FROM would_build_votes WHERE product_id = @ProductId AND user_id = @UserId", new { ProductId = productId, UserId = userId });
        await _db.ExecuteAsync("DELETE FROM votes WHERE product_id = @ProductId AND user_id = @UserId", new { ProductId = productId, UserId = userId });
    }
}
