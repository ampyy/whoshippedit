using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using whoshippedit.Models;
using whoshippedit.Business.Service.Interface;

namespace whoshippedit.Controllers;

[Authorize]
[Route("dashboard")]
public class DashboardController : Controller
{
    private readonly IIdeaService _ideaService;

    public DashboardController(IIdeaService ideaService)
    {
        _ideaService = ideaService;
    }

    [HttpGet("")]
    public IActionResult Index() => RedirectToAction("Ideas");

    [HttpGet("saas")]
    public IActionResult Saas()
    {
        ViewBag.Tab = "saas";
        return View("Index", new List<Idea>());
    }

    [HttpGet("bookmarked")]
    public IActionResult Bookmarked()
    {
        ViewBag.Tab = "bookmarked";
        return View("Index", new List<Idea>());
    }

    [HttpGet("ideas")]
    public async Task<IActionResult> Ideas()
    {
        ViewBag.Tab = "ideas";
        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (!Guid.TryParse(userIdClaim, out var userId))
            return Redirect("/auth/login");

        var ideas = await _ideaService.GetUserIdeasWithVotesAsync(userId);

        return View("Index", ideas.ToList());
    }
}
