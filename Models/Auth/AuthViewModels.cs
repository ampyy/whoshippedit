namespace whoshippedit.Models.Auth;

public class LoginViewModel
{
    public string Email { get; set; } = "";
    public string? ErrorMessage { get; set; }
    public bool EmailSent { get; set; } = false;
}

public class SetPasswordViewModel
{
    public string Password { get; set; } = "";
    public string ConfirmPassword { get; set; } = "";
    public string? ErrorMessage { get; set; }
}

public class DirectLoginViewModel
{
    public string Email { get; set; } = "";
    public string Password { get; set; } = "";
    public string? ErrorMessage { get; set; }
}
