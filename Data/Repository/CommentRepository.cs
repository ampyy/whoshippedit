using whoshippedit.Models;
using whoshippedit.Utilities;
using whoshippedit.Data.Repository.Interface;

namespace whoshippedit.Data.Repository;

public class CommentRepository : ICommentRepository
{
    private readonly IDbConnectionHelper _db;

    public CommentRepository(IDbConnectionHelper db)
    {
        _db = db;
    }

    public async Task<IEnumerable<Comment>> GetByProductIdAsync(Guid productId)
    {
        var sql = @"
            SELECT c.id, c.product_id, c.idea_id, c.user_id, c.parent_id,
                   c.body, c.upvote_count, c.status, c.created_at,
                   u.name AS user_name, u.avatar_url AS user_avatar_url
            FROM comments c
            LEFT JOIN users u ON u.id = c.user_id
            WHERE c.product_id = @ProductId AND c.status = 0
            ORDER BY c.created_at DESC
        ";

        return await _db.QueryAsync<Comment>(sql, new { ProductId = productId });
    }

    public async Task<IEnumerable<Comment>> GetByIdeaIdAsync(Guid ideaId)
    {
        var sql = @"
            SELECT c.id, c.product_id, c.idea_id, c.user_id, c.parent_id,
                   c.body, c.upvote_count, c.status, c.created_at,
                   u.name AS user_name, u.avatar_url AS user_avatar_url
            FROM comments c
            LEFT JOIN users u ON u.id = c.user_id
            WHERE c.idea_id = @IdeaId AND c.status = 0
            ORDER BY c.created_at DESC
        ";

        return await _db.QueryAsync<Comment>(sql, new { IdeaId = ideaId });
    }

    public async Task<Comment?> GetByIdAsync(Guid id)
    {
        var sql = @"
            SELECT c.id, c.product_id, c.idea_id, c.user_id, c.parent_id,
                   c.body, c.upvote_count, c.status, c.created_at,
                   u.name AS user_name, u.avatar_url AS user_avatar_url
            FROM comments c
            LEFT JOIN users u ON u.id = c.user_id
            WHERE c.id = @Id
        ";

        return await _db.QueryFirstOrDefaultAsync<Comment>(sql, new { Id = id });
    }

    public async Task<Guid> InsertAsync(Comment comment)
    {
        var sql = @"
            INSERT INTO comments (product_id, idea_id, user_id, parent_id, body)
            VALUES (@ProductId, @IdeaId, @UserId, @ParentId, @Body)
            RETURNING id
        ";

        return await _db.QueryFirstOrDefaultAsync<Guid>(sql, new
        {
            ProductId = comment.ProductId,
            IdeaId = comment.IdeaId,
            UserId = comment.UserId,
            ParentId = comment.ParentId,
            Body = comment.Body
        });
    }
}
