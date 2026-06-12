using whoshippedit.Models;

namespace whoshippedit.Business.Service.Interface;

public interface IIdeaService
{
    Task<IEnumerable<Idea>> GetUserIdeasWithVotesAsync(Guid userId);
    Task<IEnumerable<Idea>> GetIdeasWithVotesAsync(short status);
    Task<Idea?> GetIdeaBySlugWithVotesAsync(string slug);
    Task<string> SubmitIdeaAsync(string title, string problem, string targetCustomer, string proposedPrice, string? category, Guid userId);
    Task<Idea?> CheckDuplicateTitleAsync(string title);
    Task<short?> GetUserVoteAsync(Guid ideaId, Guid userId);
    Task<bool> VoteAsync(string slug, Guid userId, short voteType);
}
