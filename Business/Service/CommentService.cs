using whoshippedit.Models;
using whoshippedit.Data.Repository.Interface;
using whoshippedit.Business.Service.Interface;

namespace whoshippedit.Business.Service;

public class CommentService : ICommentService
{
    private readonly ICommentRepository _commentRepo;

    public CommentService(ICommentRepository commentRepo)
    {
        _commentRepo = commentRepo;
    }

    public Task<IEnumerable<Comment>> GetProductCommentsAsync(Guid productId)
        => _commentRepo.GetByProductIdAsync(productId);

    public async Task<Comment?> PostCommentAsync(Guid productId, Guid userId, string body, Guid? parentId = null)
    {
        if (string.IsNullOrWhiteSpace(body))
            throw new InvalidOperationException("Comment body cannot be empty.");

        if (body.Length > 2000)
            throw new InvalidOperationException("Comment must be 2000 characters or fewer.");

        var comment = new Comment
        {
            ProductId = productId,
            UserId = userId,
            Body = body.Trim(),
            ParentId = parentId
        };

        var id = await _commentRepo.InsertAsync(comment);

        // Re-fetch to get JOINed user data
        return await _commentRepo.GetByIdAsync(id);
    }

    public Task<IEnumerable<Comment>> GetIdeaCommentsAsync(Guid ideaId)
        => _commentRepo.GetByIdeaIdAsync(ideaId);

    public async Task<Comment?> PostIdeaCommentAsync(Guid ideaId, Guid userId, string body, Guid? parentId = null)
    {
        if (string.IsNullOrWhiteSpace(body))
            throw new InvalidOperationException("Comment body cannot be empty.");

        if (body.Length > 2000)
            throw new InvalidOperationException("Comment must be 2000 characters or fewer.");

        var comment = new Comment
        {
            IdeaId = ideaId,
            UserId = userId,
            Body = body.Trim(),
            ParentId = parentId
        };

        var id = await _commentRepo.InsertAsync(comment);

        // Re-fetch to get JOINed user data
        return await _commentRepo.GetByIdAsync(id);
    }
}
