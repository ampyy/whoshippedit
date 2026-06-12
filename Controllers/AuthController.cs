using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using whoshippedit.Business;
using whoshippedit.Models.Auth;

namespace whoshippedit.Controllers;

public class AuthController : Controller
{
    private readonly IAuthService _auth;
    private readonly IEmailService _email;
    private readonly ILogger<AuthController> _logger;

    public AuthController(IAuthService auth, IEmailService email, ILogger<AuthController> logger)
    {
        _auth = auth;
        _email = email;
        _logger = logger;
    }

    // ── GET /auth/login ────────────────────────────────────────────────────────
    [HttpGet("/auth/login")]
    public IActionResult Login(string? returnUrl = null)
    {
        if (User.Identity?.IsAuthenticated == true)
            return Redirect(returnUrl ?? "/");

        ViewBag.ReturnUrl = returnUrl;
        return View(new LoginViewModel());
    }

    // ── POST /auth/login  (send magic link) ───────────────────────────────────
    [HttpPost("/auth/login")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Login(LoginViewModel model, string? returnUrl = null)
    {
        if (string.IsNullOrWhiteSpace(model.Email) || !model.Email.Contains('@'))
        {
            model.ErrorMessage = "Please enter a valid email address.";
            return View(model);
        }

        var baseUrl = $"{Request.Scheme}://{Request.Host}";
        var magicUrl = await _auth.CreateMagicLinkAsync(model.Email, returnUrl, baseUrl);

        await _email.SendMagicLinkAsync(model.Email, magicUrl);

        model.EmailSent = true;
        return View(model);
    }

    // ── POST /auth/login-password  (email + password direct login) ────────────
    [HttpPost("/auth/login-password")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> LoginPassword(DirectLoginViewModel model, string? returnUrl = null)
    {
        if (string.IsNullOrWhiteSpace(model.Email) || string.IsNullOrWhiteSpace(model.Password))
        {
            model.ErrorMessage = "Email and password are required.";
            return View("Login", new LoginViewModel { ErrorMessage = model.ErrorMessage });
        }

        var user = await _auth.ValidatePasswordLoginAsync(model.Email, model.Password);
        if (user is null)
        {
            return View("Login", new LoginViewModel
            {
                Email = model.Email,
                ErrorMessage = "Incorrect email or password."
            });
        }

        await SignInUserAsync(user.Id, user.Email);
        return Redirect(returnUrl ?? "/");
    }

    // ── GET /auth/verify?token= ───────────────────────────────────────────────
    [HttpGet("/auth/verify")]
    public async Task<IActionResult> Verify(string token, string? returnUrl = null)
    {
        if (string.IsNullOrWhiteSpace(token))
            return RedirectToAction(nameof(Login));

        var user = await _auth.VerifyMagicLinkAsync(token);
        if (user is null)
        {
            return View("Login", new LoginViewModel
            {
                ErrorMessage = "This sign-in link is invalid or has expired. Please request a new one."
            });
        }

        await SignInUserAsync(user.Id, user.Email);

        // First-time user or user without password → prompt to set one
        if (!user.HasPassword)
            return RedirectToAction(nameof(SetPassword), new { returnUrl });

        return Redirect(returnUrl ?? "/");
    }

    // ── GET /auth/set-password ────────────────────────────────────────────────
    [HttpGet("/auth/set-password")]
    public IActionResult SetPassword(string? returnUrl = null)
    {
        if (User.Identity?.IsAuthenticated != true)
            return RedirectToAction(nameof(Login));

        ViewBag.ReturnUrl = returnUrl;
        return View(new SetPasswordViewModel());
    }

    // ── POST /auth/set-password ───────────────────────────────────────────────
    [HttpPost("/auth/set-password")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> SetPassword(SetPasswordViewModel model, string? returnUrl = null)
    {
        if (!User.Identity?.IsAuthenticated == true)
            return RedirectToAction(nameof(Login));

        if (string.IsNullOrWhiteSpace(model.Password) || model.Password.Length < 8)
        {
            model.ErrorMessage = "Password must be at least 8 characters.";
            return View(model);
        }

        if (model.Password != model.ConfirmPassword)
        {
            model.ErrorMessage = "Passwords do not match.";
            return View(model);
        }

        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (!Guid.TryParse(userIdClaim, out var userId))
            return RedirectToAction(nameof(Login));

        await _auth.SetPasswordAsync(userId, model.Password);

        return Redirect(returnUrl ?? "/");
    }

    // ── POST /auth/logout ─────────────────────────────────────────────────────
    [HttpPost("/auth/logout")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Logout()
    {
        await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
        return Redirect("/");
    }

    // ── Helper: issue the auth cookie ─────────────────────────────────────────
    private async Task SignInUserAsync(Guid userId, string email)
    {
        var claims = new List<Claim>
        {
            new(ClaimTypes.NameIdentifier, userId.ToString()),
            new(ClaimTypes.Email, email),
            new(ClaimTypes.Name, email)
        };

        var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
        var principal = new ClaimsPrincipal(identity);

        await HttpContext.SignInAsync(
            CookieAuthenticationDefaults.AuthenticationScheme,
            principal,
            new AuthenticationProperties
            {
                IsPersistent = true,
                ExpiresUtc = DateTimeOffset.UtcNow.AddDays(7)
            });
    }
}
