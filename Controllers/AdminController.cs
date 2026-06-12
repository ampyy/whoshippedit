using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using whoshippedit.Models;
using whoshippedit.Utilities;
using whoshippedit.Business.Service.Interface;

namespace whoshippedit.Controllers;

[Route("admin")]
public class AdminController : Controller
{
    private readonly IUserService _userService;
    private readonly ICategoryService _categoryService;
    private readonly IProductService _productService;
    private readonly ITargetCustomerService _targetCustomerService;

    public AdminController(
        IUserService userService,
        ICategoryService categoryService,
        IProductService productService,
        ITargetCustomerService targetCustomerService)
    {
        _userService = userService;
        _categoryService = categoryService;
        _productService = productService;
        _targetCustomerService = targetCustomerService;
    }

    private async Task<bool> IsMasterAdmin()
    {
        if (User.Identity?.IsAuthenticated != true) return false;
        
        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (!Guid.TryParse(userIdClaim, out var userId)) return false;

        return await _userService.IsMasterAdminAsync(userId);
    }

    private async Task PopulateViewBagAsync()
    {
        ViewBag.Categories      = (await _categoryService.GetCategoriesAsync()).ToList();
        ViewBag.TargetCustomers = (await _targetCustomerService.GetTargetCustomersAsync()).ToList();
    }

    [HttpGet("submit-product")]
    public async Task<IActionResult> SubmitProduct()
    {
        if (!await IsMasterAdmin()) return Redirect("/");

        await PopulateViewBagAsync();
        ViewBag.SelectedTargetIds = new List<string>();

        return View(new Product());
    }

    [HttpPost("submit-product")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> SubmitProduct(Product model)
    {
        if (!await IsMasterAdmin()) return Redirect("/");

        await PopulateViewBagAsync();

        // Parse selected target IDs from the form
        var rawTargets = Request.Form["SelectedTargetIds"].ToList();
        var selectedTargetIds = rawTargets
            .Where(v => !string.IsNullOrEmpty(v) && Guid.TryParse(v, out _))
            .Select(v => Guid.Parse(v!))
            .Distinct()
            .ToList();

        ViewBag.SelectedTargetIds = rawTargets;

        if (string.IsNullOrWhiteSpace(model.Name) || string.IsNullOrWhiteSpace(model.WebsiteUrl))
        {
            ModelState.AddModelError("", "Name and Website URL are required.");
            return View(model);
        }

        if (selectedTargetIds.Count > 3)
        {
            ModelState.AddModelError("", "Maximum 3 target customers allowed.");
            return View(model);
        }

        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        Guid.TryParse(userIdClaim, out var userId);

        try
        {
            var productId = await _productService.SubmitProductAsync(model, userId);

            // Save target customers in same logical operation
            if (selectedTargetIds.Count > 0)
            {
                await _targetCustomerService.SaveProductTargetsAsync(productId, selectedTargetIds);
            }

            return Redirect("/");
        }
        catch (InvalidOperationException ex)
        {
            ModelState.AddModelError("WebsiteUrl", ex.Message);
            return View(model);
        }
    }
}
