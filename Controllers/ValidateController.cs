using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using whoshippedit.Models;
using whoshippedit.Business.Service.Interface;

namespace whoshippedit.Controllers;

[Route("validate")]
public class ValidateController : Controller
{
    private readonly ICategoryService _categoryService;
    private readonly IIdeaService _ideaService;
    private readonly ICommentService _commentService;
    private readonly ILogger<ValidateController> _logger;

    public ValidateController(ICategoryService categoryService, IIdeaService ideaService, ICommentService commentService, ILogger<ValidateController> logger)
    {
        _categoryService = categoryService;
        _ideaService = ideaService;
        _commentService = commentService;
        _logger = logger;
    }

    // ── GET /validate ────────────────────────────────────────────────────────
    [HttpGet("")]
    public async Task<IActionResult> Index(string category = "", string status = "all", string sort = "hottest")
    {
        var categories = await _categoryService.GetCategoriesAsync();
        ViewBag.Categories = categories.ToList();

        var ideasList = await _ideaService.GetIdeasWithVotesAsync(AppConstants.Status.Approved);
        var ideas = ideasList.ToList();

        // Calculate global statistics from ALL approved ideas (unfiltered)
        ViewBag.TotalIdeas = ideas.Count;
        ViewBag.AverageDemand = ideas.Any() ? (int)(ideas.Average(x => x.DemandPercentage) * 100) : 0;
        ViewBag.TotalBuilding = ideas.Sum(x => x.BuildingCount);

        // Apply filters
        if (!string.IsNullOrEmpty(category))
        {
            var cat = categories.FirstOrDefault(c => c.Slug == category);
            if (cat != null) ideas = ideas.Where(x => x.CategoryId == cat.Id).ToList();
        }

        if (status == "high_demand")
            ideas = ideas.Where(x => x.TotalVotes >= 5 && x.DemandPercentage > 0.55).ToList();
        else if (status == "building")
            ideas = ideas.Where(x => x.BuildingCount >= 1).ToList();

        // Apply sort
        if (sort == "newest" || status == "newest")
            ideas = ideas.OrderByDescending(x => x.CreatedAt).ToList();
        else if (sort == "hottest")
            ideas = ideas.OrderByDescending(x => x.HotScore).ToList();
        else if (sort == "most_would_pay")
            ideas = ideas.OrderByDescending(x => x.DemandPercentage).ThenByDescending(x => x.TotalVotes).ToList();
        else if (sort == "most_commented")
            ideas = ideas.OrderByDescending(x => x.CommentCount).ToList();

        return View(ideas);
    }

    // ── GET /validate/submit ──────────────────────────────────────────────────
    [HttpGet("submit")]
    public async Task<IActionResult> Submit()
    {
        if (User.Identity?.IsAuthenticated != true)
            return Redirect("/auth/login?returnUrl=/validate/submit");

        var categories = await _categoryService.GetCategoriesAsync();
        ViewBag.Categories = categories.ToList();

        return View(new IdeaSubmitViewModel());
    }

    // ── POST /validate/submit ─────────────────────────────────────────────────
    [HttpPost("submit")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Submit(IdeaSubmitViewModel model)
    {
        if (User.Identity?.IsAuthenticated != true)
            return Redirect("/auth/login?returnUrl=/validate/submit");

        var categories = await _categoryService.GetCategoriesAsync();
        ViewBag.Categories = categories.ToList();

        if (!ModelState.IsValid)
            return View(model);

        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (!Guid.TryParse(userIdClaim, out var userId))
            return Redirect("/auth/login");

        var slug = await _ideaService.SubmitIdeaAsync(
            model.Title,
            model.Problem,
            model.TargetCustomer,
            model.ProposedPrice,
            model.Category,
            userId
        );

        return Redirect($"/validate/{slug}");
    }

    // ── GET /validate/check-duplicate ──────────────────────────────────────────────
    [HttpGet("check-duplicate")]
    public async Task<IActionResult> CheckDuplicate(string title)
    {
        if (string.IsNullOrWhiteSpace(title)) return Json(null);
        
        var idea = await _ideaService.CheckDuplicateTitleAsync(title);

        if (idea != null)
            return Json(new { similarTitle = idea.Title, slug = idea.Slug });

        return Json(null);
    }

    // ── GET /validate/{slug} ──────────────────────────────────────────────────
    [HttpGet("{slug}")]
    public async Task<IActionResult> Detail(string slug)
    {
        var idea = await _ideaService.GetIdeaBySlugWithVotesAsync(slug);

        if (idea == null)
            return NotFound();

        short? userVote = null;
        if (User.Identity?.IsAuthenticated == true)
        {
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (Guid.TryParse(userIdClaim, out var userId))
            {
                userVote = await _ideaService.GetUserVoteAsync(idea.Id, userId);
            }
        }

        var comments = (await _commentService.GetIdeaCommentsAsync(idea.Id)).ToList();
        ViewBag.Comments = comments;

        ViewBag.UserVote = userVote;
        return View(idea);
    }

    // ── POST /validate/{slug}/vote ────────────────────────────────────────────
    [HttpPost("{slug}/vote")]
    public async Task<IActionResult> Vote(string slug, short voteType)
    {
        if (User.Identity?.IsAuthenticated != true)
            return Unauthorized();

        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (!Guid.TryParse(userIdClaim, out var userId))
            return Unauthorized();

        if (voteType < 0 || voteType > 3)
            return BadRequest("Invalid vote type");

        var success = await _ideaService.VoteAsync(slug, userId, voteType);
        if (!success) return NotFound();

        return Ok();
    }

    [HttpPost("{slug}/comment")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> PostComment(string slug, [FromForm] string body, [FromForm] Guid? parentId)
    {
        if (User.Identity?.IsAuthenticated != true)
            return Unauthorized();

        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (!Guid.TryParse(userIdClaim, out var userId))
            return Unauthorized();

        var idea = await _ideaService.GetIdeaBySlugWithVotesAsync(slug);
        if (idea == null)
            return NotFound();

        try
        {
            var comment = await _commentService.PostIdeaCommentAsync(idea.Id, userId, body, parentId);
            if (comment == null)
                return BadRequest();

            return Json(new
            {
                id = comment.Id,
                body = comment.Body,
                userName = comment.UserName ?? "Anonymous",
                userInitial = (comment.UserName ?? "A")[..1].ToUpper(),
                createdAt = comment.CreatedAt.ToString("MMM d, yyyy"),
                upvoteCount = comment.UpvoteCount,
                parentId = comment.ParentId
            });
        }
        catch (InvalidOperationException ex)
        {
            return BadRequest(new { error = ex.Message });
        }
    }
}
