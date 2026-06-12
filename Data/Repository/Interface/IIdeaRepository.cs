using whoshippedit.Models;

namespace whoshippedit.Data.Repository.Interface;

public interface IIdeaRepository
{
    Task<IEnumerable<Idea>> GetIdeasWithVotesAsync(short status);
    Task<IEnumerable<Idea>> GetUserIdeasWithVotesAsync(Guid userId);
    Task<Idea?> GetIdeaBySlugWithVotesAsync(string slug);
    Task<Idea?> GetIdeaBySlugAsync(string slug);
    Task<string?> GetSlugAsync(string slug);
    Task<Idea?> GetBySimilarTitleAsync(string pattern);
    Task InsertIdeaAsync(string slug, string title, string problem, string targetCustomer, string proposedPrice, Guid? categoryId, Guid submittedBy, short status);
    Task<short?> GetUserVoteAsync(Guid ideaId, Guid userId);
    Task UpsertVoteAsync(Guid ideaId, Guid userId, short voteType);
}
