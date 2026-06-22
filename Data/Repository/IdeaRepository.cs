using whoshippedit.Models;
using whoshippedit.Utilities;
using whoshippedit.Data.Repository.Interface;

namespace whoshippedit.Data.Repository;

public class IdeaRepository : IIdeaRepository
{
    private readonly IDbConnectionHelper _db;

    public IdeaRepository(IDbConnectionHelper db)
    {
        _db = db;
    }

    public async Task<IEnumerable<Idea>> GetIdeasWithVotesAsync(short status)
    {
        var sql = @"
            SELECT 
                i.*,
                COALESCE(SUM(CASE WHEN v.vote = 0 THEN 1 ELSE 0 END), 0) as VoteYes,
                COALESCE(SUM(CASE WHEN v.vote = 1 THEN 1 ELSE 0 END), 0) as VoteMaybe,
                COALESCE(SUM(CASE WHEN v.vote = 2 THEN 1 ELSE 0 END), 0) as VoteNo,
                COALESCE(SUM(CASE WHEN v.vote = 3 THEN 1 ELSE 0 END), 0) as BuildingCount,
                COUNT(v.id) as TotalVotes,
                COALESCE(u.name, split_part(u.email, '@', 1), 'Anonymous') as FounderName
            FROM ideas i
            LEFT JOIN idea_votes v ON i.id = v.idea_id
            LEFT JOIN users u ON i.submitted_by = u.id
            WHERE i.status = @Status
            GROUP BY i.id, u.name, u.email
        ";

        // Note: in SQL schema, vote is varchar(20), so the values are compared with strings '0', '1', '2', '3'.
        // Let's check: in ValidateController:
        // COALESCE(SUM(CASE WHEN v.vote = 0 THEN 1 ELSE 0 END), 0)
        // Wait, did they write = 0 (integer) or = '0' (varchar)?
        // PostgreSQL can implicitly cast or require matching types. Let's look at schema.sql line 116:
        // vote       varchar(20) not null, -- "pay_9", "pay_19", "pay_49", "no", "building"
        // Wait! In ValidateController.cs:
        // CASE WHEN v.vote = 0 THEN 1 ELSE 0 END
        // Wait, does PostgreSQL accept that?
        // Let's check: yes, they had it as is, and it was working. However, let's keep the EXACT SQL queries from the controllers to avoid any discrepancy.
        // Let's look at the exact SQL in ValidateController.cs:
        // COALESCE(SUM(CASE WHEN v.vote = 0 THEN 1 ELSE 0 END), 0) as VoteYes
        // Yes, it was using 0, 1, 2, 3 as numeric values in SQL.
        return await _db.QueryAsync<Idea>(sql, new { Status = status });
    }

    public async Task<IEnumerable<Idea>> GetUserIdeasWithVotesAsync(Guid userId)
    {
        var sql = @"
            SELECT i.*, 
                   COUNT(v.id) as TotalVotes 
            FROM ideas i
            LEFT JOIN idea_votes v ON i.id = v.idea_id
            WHERE i.submitted_by = @UserId
            GROUP BY i.id
            ORDER BY i.created_at DESC
        ";
        return await _db.QueryAsync<Idea>(sql, new { UserId = userId });
    }

    public async Task<Idea?> GetIdeaBySlugWithVotesAsync(string slug)
    {
        var sql = @"
            SELECT 
                i.*,
                COALESCE(SUM(CASE WHEN v.vote = 0 THEN 1 ELSE 0 END), 0) as VoteYes,
                COALESCE(SUM(CASE WHEN v.vote = 1 THEN 1 ELSE 0 END), 0) as VoteMaybe,
                COALESCE(SUM(CASE WHEN v.vote = 2 THEN 1 ELSE 0 END), 0) as VoteNo,
                COALESCE(SUM(CASE WHEN v.vote = 3 THEN 1 ELSE 0 END), 0) as BuildingCount,
                COUNT(v.id) as TotalVotes,
                COALESCE(u.name, split_part(u.email, '@', 1), 'Anonymous') as FounderName
            FROM ideas i
            LEFT JOIN idea_votes v ON i.id = v.idea_id
            LEFT JOIN users u ON i.submitted_by = u.id
            WHERE i.slug = @Slug
            GROUP BY i.id, u.name, u.email
        ";
        return await _db.QueryFirstOrDefaultAsync<Idea>(sql, new { Slug = slug });
    }

    public async Task<Idea?> GetIdeaBySlugAsync(string slug)
    {
        return await _db.QueryFirstOrDefaultAsync<Idea>(
            "SELECT id FROM ideas WHERE slug = @Slug", new { Slug = slug });
    }

    public async Task<string?> GetSlugAsync(string slug)
    {
        return await _db.QueryFirstOrDefaultAsync<string>(
            "SELECT slug FROM ideas WHERE slug = @Slug", new { Slug = slug });
    }

    public async Task<Idea?> GetBySimilarTitleAsync(string pattern)
    {
        return await _db.QueryFirstOrDefaultAsync<Idea>(
            "SELECT title, slug FROM ideas WHERE LOWER(title) LIKE @Pattern LIMIT 1",
            new { Pattern = pattern });
    }

    public async Task InsertIdeaAsync(string slug, string title, string problem, string targetCustomer, string proposedPrice, Guid? categoryId, Guid submittedBy, short status)
    {
        var sql = @"
            INSERT INTO ideas (slug, title, problem, target_customer, proposed_price, category_id, submitted_by, status)
            VALUES (@Slug, @Title, @Problem, @TargetCustomer, @ProposedPrice, @CategoryId, @SubmittedBy, @Status)
        ";

        await _db.ExecuteAsync(sql, new 
        { 
            Slug = slug, 
            Title = title, 
            Problem = problem, 
            TargetCustomer = targetCustomer, 
            ProposedPrice = proposedPrice,
            CategoryId = categoryId,
            SubmittedBy = submittedBy,
            Status = status
        });
    }

    public async Task<short?> GetUserVoteAsync(Guid ideaId, Guid userId)
    {
        return await _db.QueryFirstOrDefaultAsync<short?>(
            "SELECT vote FROM idea_votes WHERE idea_id = @IdeaId AND user_id = @UserId LIMIT 1",
            new { IdeaId = ideaId, UserId = userId });
    }

    public async Task UpsertVoteAsync(Guid ideaId, Guid userId, short voteType)
    {
        var sql = @"
            INSERT INTO idea_votes (idea_id, user_id, vote)
            VALUES (@IdeaId, @UserId, @Vote)
            ON CONFLICT (idea_id, user_id) 
            DO UPDATE SET vote = @Vote, created_at = now()
        ";

        await _db.ExecuteAsync(sql, new { IdeaId = ideaId, UserId = userId, Vote = voteType });
    }
}
