using whoshippedit.Models;
using whoshippedit.Data.Repository.Interface;
using whoshippedit.Business.Service.Interface;

namespace whoshippedit.Business.Service;

public class IdeaService : IIdeaService
{
    private readonly IIdeaRepository _ideaRepo;

    public IdeaService(IIdeaRepository ideaRepo)
    {
        _ideaRepo = ideaRepo;
    }

    public async Task<IEnumerable<Idea>> GetUserIdeasWithVotesAsync(Guid userId)
    {
        return await _ideaRepo.GetUserIdeasWithVotesAsync(userId);
    }

    public async Task<IEnumerable<Idea>> GetIdeasWithVotesAsync(short status)
    {
        return await _ideaRepo.GetIdeasWithVotesAsync(status);
    }

    public async Task<Idea?> GetIdeaBySlugWithVotesAsync(string slug)
    {
        return await _ideaRepo.GetIdeaBySlugWithVotesAsync(slug);
    }

    public async Task<string> SubmitIdeaAsync(string title, string problem, string targetCustomer, string proposedPrice, string? category, Guid userId)
    {
        var slug = GenerateSlug(title);

        var existingSlug = await _ideaRepo.GetSlugAsync(slug);
        if (existingSlug != null)
        {
            slug = $"{slug}-{new Random().Next(1000, 9999)}";
        }

        Guid? categoryId = null;
        if (!string.IsNullOrEmpty(category) && Guid.TryParse(category, out var cid))
        {
            categoryId = cid;
        }

        await _ideaRepo.InsertIdeaAsync(
            slug,
            title,
            problem,
            targetCustomer,
            proposedPrice,
            categoryId,
            userId,
            AppConstants.Status.Approved
        );

        return slug;
    }

    public async Task<Idea?> CheckDuplicateTitleAsync(string title)
    {
        if (string.IsNullOrWhiteSpace(title)) return null;

        var searchPattern = $"%{title.Trim().ToLower()}%";
        var idea = await _ideaRepo.GetBySimilarTitleAsync(searchPattern);

        if (idea != null && !string.Equals(idea.Title, title, StringComparison.OrdinalIgnoreCase))
        {
            return idea;
        }

        return null;
    }

    public async Task<short?> GetUserVoteAsync(Guid ideaId, Guid userId)
    {
        return await _ideaRepo.GetUserVoteAsync(ideaId, userId);
    }

    public async Task<bool> VoteAsync(string slug, Guid userId, short voteType)
    {
        var idea = await _ideaRepo.GetIdeaBySlugAsync(slug);
        if (idea == null) return false;

        await _ideaRepo.UpsertVoteAsync(idea.Id, userId, voteType);
        return true;
    }

    private string GenerateSlug(string phrase)
    {
        string str = phrase.ToLowerInvariant();
        str = System.Text.RegularExpressions.Regex.Replace(str, @"[^a-z0-9\s-]", "");
        str = System.Text.RegularExpressions.Regex.Replace(str, @"\s+", "-").Trim('-');
        return str.Length <= 60 ? str : str.Substring(0, 60).Trim('-');
    }
}
