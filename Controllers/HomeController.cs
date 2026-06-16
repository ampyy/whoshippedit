using Microsoft.AspNetCore.Mvc;
using whoshippedit.Business.Service.Interface;

namespace whoshippedit.Controllers;

public class HomeController : Controller
{
    private readonly ICategoryService _categoryService;
    private readonly IUserService _userService;
    private readonly IProductService _productService;

    public HomeController(ICategoryService categoryService, IUserService userService, IProductService productService)
    {
        _categoryService = categoryService;
        _userService = userService;
        _productService = productService;
    }

    public async Task<IActionResult> Index(
        string? search = null,
        string? category = null,
        string? mrr = null,
        string? sort = null)
    {
        var categories = await _categoryService.GetCategoriesAsync();
        ViewBag.Categories = categories.ToList();

        var (products, totalCount) = await _productService.GetProductsAsync(
            search: search,
            categorySlug: category,
            mrr: mrr,
            sort: sort,
            pageSize: 50);

        ViewBag.TotalCount = totalCount;
        ViewBag.Search = search;
        ViewBag.SelectedCategory = category;
        ViewBag.SelectedMrr = mrr;
        ViewBag.SelectedSort = sort ?? "latest";

        return View(products);
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
