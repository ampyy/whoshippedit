using whoshippedit.Models;

namespace whoshippedit.Data.Repository.Interface;

public interface ICommentRepository
{
    Task<IEnumerable<Comment>> GetByProductIdAsync(Guid productId);
    Task<IEnumerable<Comment>> GetByIdeaIdAsync(Guid ideaId);
    Task<Comment?> GetByIdAsync(Guid id);
    Task<Guid> InsertAsync(Comment comment);
}
