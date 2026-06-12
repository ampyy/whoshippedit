using whoshippedit.Models;

namespace whoshippedit.Business.Service.Interface;

public interface ICommentService
{
    Task<IEnumerable<Comment>> GetProductCommentsAsync(Guid productId);
    Task<Comment?> PostCommentAsync(Guid productId, Guid userId, string body, Guid? parentId = null);
    Task<IEnumerable<Comment>> GetIdeaCommentsAsync(Guid ideaId);
    Task<Comment?> PostIdeaCommentAsync(Guid ideaId, Guid userId, string body, Guid? parentId = null);
}
