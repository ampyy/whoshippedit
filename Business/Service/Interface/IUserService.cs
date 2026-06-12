using whoshippedit.Models;

namespace whoshippedit.Business.Service.Interface;

public interface IUserService
{
    Task<User?> GetUserByIdAsync(Guid id);
    Task<bool> IsMasterAdminAsync(Guid userId);
    Task UpdateProfileAsync(Guid userId, string name, string? twitterHandle, string? linkedinHandle, string bio);
    Task MigrateLinkedinAsync();
}
