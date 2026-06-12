using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using whoshippedit.Models;
using whoshippedit.Business.Service.Interface;

namespace whoshippedit.Controllers;

[Route("profile")]
[Authorize]
public class ProfileController : Controller
{
    private readonly IUserService _userService;

    public ProfileController(IUserService userService)
    {
        _userService = userService;
    }

    [HttpGet("")]
    public async Task<IActionResult> Index()
    {
        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (!Guid.TryParse(userIdClaim, out var userId))
            return Redirect("/auth/login");

        var user = await _userService.GetUserByIdAsync(userId);
        if (user == null) return NotFound();

        var model = new ProfileUpdateViewModel
        {
            Name = user.Name ?? string.Empty,
            TwitterHandle = user.TwitterHandle ?? string.Empty,
            LinkedinHandle = user.LinkedinHandle ?? string.Empty,
            Bio = user.Bio ?? string.Empty
        };

        return View(model);
    }

    [HttpPost("")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Index(ProfileUpdateViewModel model)
    {
        if (!ModelState.IsValid)
            return View(model);

        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (!Guid.TryParse(userIdClaim, out var userId))
            return Redirect("/auth/login");

        await _userService.UpdateProfileAsync(
            userId,
            model.Name,
            model.TwitterHandle,
            model.LinkedinHandle,
            model.Bio
        );

        TempData["SuccessMessage"] = "Profile updated successfully!";
        return RedirectToAction("Index");
    }
}

public class ProfileUpdateViewModel
{
    public string Name { get; set; } = string.Empty;
    public string TwitterHandle { get; set; } = string.Empty;
    public string LinkedinHandle { get; set; } = string.Empty;
    public string Bio { get; set; } = string.Empty;
}
