using whoshippedit.Models;
using whoshippedit.Utilities;
using whoshippedit.Data.Repository.Interface;

namespace whoshippedit.Data.Repository;

public class UserRepository : IUserRepository
{
    private readonly IDbConnectionHelper _db;

    public UserRepository(IDbConnectionHelper db)
    {
        _db = db;
    }

    public async Task<User?> GetByIdAsync(Guid id)
    {
        return await _db.QueryFirstOrDefaultAsync<User>(
            @"SELECT id, email, name, avatar_url as AvatarUrl, 
                     twitter_handle as TwitterHandle, 
                     linkedin_handle as LinkedinHandle, 
                     bio, password_hash as PasswordHash, 
                     email_verified as EmailVerified, 
                     last_login_at as LastLoginAt, 
                     created_at as CreatedAt, 
                     updated_at as UpdatedAt 
              FROM users WHERE id = @Id", 
            new { Id = id });
    }

    public async Task<User?> GetByEmailAsync(string email)
    {
        return await _db.QueryFirstOrDefaultAsync<User>(
            "SELECT * FROM users WHERE email = @Email", 
            new { Email = email });
    }

    public async Task<bool> IsMasterAdminAsync(Guid userId)
    {
        return await _db.QueryFirstOrDefaultAsync<bool>(
            "SELECT is_master_admin FROM users WHERE id = @Id", 
            new { Id = userId });
    }

    public async Task<User?> UpsertUserByEmailAsync(string email)
    {
        return await _db.QueryFirstOrDefaultAsync<User>(
            @"INSERT INTO users (email)
              VALUES (@Email)
              ON CONFLICT (email) DO UPDATE SET last_login_at = now()
              RETURNING *",
            new { Email = email });
    }

    public async Task UpdatePasswordHashAsync(Guid userId, string passwordHash)
    {
        await _db.ExecuteAsync(
            "UPDATE users SET password_hash = @Hash WHERE id = @Id",
            new { Hash = passwordHash, Id = userId });
    }

    public async Task UpdateProfileAsync(Guid userId, string name, string? twitterHandle, string? linkedinHandle, string bio)
    {
        var sql = @"
            UPDATE users 
            SET name = @Name, 
                twitter_handle = @TwitterHandle, 
                linkedin_handle = @LinkedinHandle, 
                bio = @Bio,
                updated_at = now()
            WHERE id = @Id
        ";

        await _db.ExecuteAsync(sql, new 
        { 
            Name = name,
            TwitterHandle = twitterHandle?.TrimStart('@'),
            LinkedinHandle = linkedinHandle,
            Bio = bio,
            Id = userId
        });
    }

    public async Task MigrateLinkedinAsync()
    {
        await _db.ExecuteAsync("ALTER TABLE users ADD COLUMN IF NOT EXISTS linkedin_handle varchar(100);");
    }

    public async Task CreateMagicLinkTokenAsync(string email, string token, string? redirectTo)
    {
        await _db.ExecuteAsync(
            @"INSERT INTO magic_link_tokens (email, token, redirect_to)
              VALUES (@Email, @Token, @RedirectTo)",
            new { Email = email, Token = token, RedirectTo = redirectTo });
    }

    public async Task<dynamic?> GetMagicLinkTokenAsync(string token)
    {
        return await _db.QueryFirstOrDefaultAsync<dynamic>(
            @"SELECT id, email, expires_at, used_at
              FROM magic_link_tokens
              WHERE token = @Token",
            new { Token = token });
    }

    public async Task MarkMagicLinkTokenUsedAsync(Guid tokenId)
    {
        await _db.ExecuteAsync(
            "UPDATE magic_link_tokens SET used_at = now() WHERE id = @Id",
            new { Id = tokenId });
    }
}
