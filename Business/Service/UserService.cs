using whoshippedit.Models;
using whoshippedit.Data.Repository.Interface;
using whoshippedit.Business.Service.Interface;

namespace whoshippedit.Business.Service;

public class UserService : IUserService
{
    private readonly IUserRepository _userRepo;

    public UserService(IUserRepository userRepo)
    {
        _userRepo = userRepo;
    }

    public async Task<User?> GetUserByIdAsync(Guid id)
    {
        return await _userRepo.GetByIdAsync(id);
    }

    public async Task<bool> IsMasterAdminAsync(Guid userId)
    {
        return await _userRepo.IsMasterAdminAsync(userId);
    }

    public async Task UpdateProfileAsync(Guid userId, string name, string? twitterHandle, string? linkedinHandle, string bio)
    {
        await _userRepo.UpdateProfileAsync(userId, name, twitterHandle, linkedinHandle, bio);
    }

    public async Task MigrateLinkedinAsync()
    {
        await _userRepo.MigrateLinkedinAsync();
    }
}
