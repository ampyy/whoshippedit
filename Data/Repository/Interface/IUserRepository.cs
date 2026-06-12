using whoshippedit.Models;

namespace whoshippedit.Data.Repository.Interface;

public interface IUserRepository
{
    Task<User?> GetByIdAsync(Guid id);
    Task<User?> GetByEmailAsync(string email);
    Task<bool> IsMasterAdminAsync(Guid userId);
    Task<User?> UpsertUserByEmailAsync(string email);
    Task UpdatePasswordHashAsync(Guid userId, string passwordHash);
    Task UpdateProfileAsync(Guid userId, string name, string? twitterHandle, string? linkedinHandle, string bio);
    Task MigrateLinkedinAsync();
    
    // Magic link tokens
    Task CreateMagicLinkTokenAsync(string email, string token, string? redirectTo);
    Task<dynamic?> GetMagicLinkTokenAsync(string token);
    Task MarkMagicLinkTokenUsedAsync(Guid tokenId);
}
