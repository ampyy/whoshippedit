namespace whoshippedit.Models;

public class User
{
    public Guid Id { get; set; }
    public string Email { get; set; } = "";
    public string? Name { get; set; }
    public string? AvatarUrl { get; set; }
    public string? TwitterHandle { get; set; }
    public string? LinkedinHandle { get; set; }
    public string? Bio { get; set; }
    public bool IsMasterAdmin { get; set; }
    public string? PasswordHash { get; set; }
    public bool EmailVerified { get; set; } = true;
    public DateTime? LastLoginAt { get; set; }
    public DateTime? LastSeenAt { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }

    public bool HasPassword => !string.IsNullOrEmpty(PasswordHash);
    public string ShortEmail => Email.Length > 30 ? Email[..27] + "..." : Email;
}
