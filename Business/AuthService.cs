using whoshippedit.Models;
using whoshippedit.Utilities;
using whoshippedit.Data.Repository.Interface;

namespace whoshippedit.Business;

public interface IAuthService
{
    Task<string> CreateMagicLinkAsync(string email, string? redirectTo, string baseUrl);
    Task<User?> VerifyMagicLinkAsync(string token);
    Task SetPasswordAsync(Guid userId, string plainPassword);
    Task<User?> ValidatePasswordLoginAsync(string email, string plainPassword);
    Task<User?> GetUserByIdAsync(Guid userId);
}

public class AuthService : IAuthService
{
    private readonly IUserRepository _userRepo;
    private readonly ILogger<AuthService> _logger;

    public AuthService(IUserRepository userRepo, ILogger<AuthService> logger)
    {
        _userRepo = userRepo;
        _logger = logger;
    }

    /// <summary>
    /// Creates a magic link token in the DB and returns the full clickable URL.
    /// </summary>
    public async Task<string> CreateMagicLinkAsync(string email, string? redirectTo, string baseUrl)
    {
        email = email.Trim().ToLowerInvariant();

        // Generate a cryptographically random 64-byte token → 128 hex chars
        var tokenBytes = System.Security.Cryptography.RandomNumberGenerator.GetBytes(64);
        var token = Convert.ToHexString(tokenBytes).ToLowerInvariant();

        await _userRepo.CreateMagicLinkTokenAsync(email, token, redirectTo);

        var url = $"{baseUrl}/auth/verify?token={token}";
        _logger.LogInformation("Magic link for {Email}: {Url}", email, url);

        return url;
    }

    /// <summary>
    /// Validates the magic link token. Creates the user if first sign-in.
    /// Returns null if token is invalid or expired.
    /// </summary>
    public async Task<User?> VerifyMagicLinkAsync(string token)
    {
        // Fetch and validate token in one query
        var row = await _userRepo.GetMagicLinkTokenAsync(token);

        if (row is null) return null;

        var rowDict = (System.Collections.Generic.IDictionary<string, object>)row;
        DateTime expiresAt = (DateTime)rowDict["expires_at"];
        DateTime? usedAt = rowDict["used_at"] as DateTime?;

        if (usedAt.HasValue || expiresAt < DateTime.UtcNow)
            return null;

        // Mark as used
        await _userRepo.MarkMagicLinkTokenUsedAsync((Guid)rowDict["id"]);

        string email = (string)rowDict["email"];

        // Upsert user — create if first time, otherwise just update last_login_at
        var user = await _userRepo.UpsertUserByEmailAsync(email);

        return user;
    }

    /// <summary>
    /// Hashes and stores a bcrypt password for the user.
    /// </summary>
    public async Task SetPasswordAsync(Guid userId, string plainPassword)
    {
        var hash = BCrypt.Net.BCrypt.HashPassword(plainPassword, workFactor: 12);

        await _userRepo.UpdatePasswordHashAsync(userId, hash);
    }

    /// <summary>
    /// Validates an email + password sign-in. Returns null if invalid.
    /// </summary>
    public async Task<User?> ValidatePasswordLoginAsync(string email, string plainPassword)
    {
        email = email.Trim().ToLowerInvariant();

        var user = await _userRepo.GetByEmailAsync(email);

        if (user is null || string.IsNullOrEmpty(user.PasswordHash))
            return null;

        return BCrypt.Net.BCrypt.Verify(plainPassword, user.PasswordHash) ? user : null;
    }

    /// <summary>
    /// Looks up a user by ID. Used to rehydrate the session on each request.
    /// </summary>
    public async Task<User?> GetUserByIdAsync(Guid userId)
    {
        return await _userRepo.GetByIdAsync(userId);
    }
}
