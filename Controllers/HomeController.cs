using Microsoft.AspNetCore.Mvc;
using whoshippedit.Business.Service.Interface;

namespace whoshippedit.Controllers;

public class HomeController : Controller
{
    private readonly ICategoryService _categoryService;
    private readonly IUserService _userService;

    public HomeController(ICategoryService categoryService, IUserService userService)
    {
        _categoryService = categoryService;
        _userService = userService;
    }

    public async Task<IActionResult> Index()
    {
        var categories = await _categoryService.GetCategoriesAsync();
        ViewBag.Categories = categories.ToList();
        
        return View();
    }

    [HttpGet("verified")]
    public IActionResult Verified()
    {
        return View();
    }

    [HttpGet("categories")]
    public async Task<IActionResult> Categories()
    {
        var categories = await _categoryService.GetCategoriesAsync();
        return View(categories.ToList());
    }

    [HttpGet("terms")]
    public IActionResult Terms()
    {
        return View();
    }

    [HttpGet("privacy")]
    public IActionResult Privacy()
    {
        return View();
    }

    [HttpGet("migrate-linkedin")]
    public async Task<IActionResult> Migrate()
    {
        await _userService.MigrateLinkedinAsync();
        return Ok("Migration done");
    }
}
