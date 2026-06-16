using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using whoshippedit.Business.Service.Interface;
using whoshippedit.Models;

namespace whoshippedit.Controllers
{
    public class DirectoryController : Controller
    {
        private readonly ICategoryService _categoryService;
        private readonly IProductService _productService;
        private readonly ICommentService _commentService;

        public DirectoryController(
            ICategoryService categoryService,
            IProductService productService,
            ICommentService commentService)
        {
            _categoryService = categoryService;
            _productService = productService;
            _commentService = commentService;
        }

        [Route("directory")]
        public async Task<IActionResult> Index(
            string? search = null,
            string? category = null,
            string? mrr = null,
            string? country = null,
            string? sort = null)
        {
            var categories = await _categoryService.GetCategoriesAsync();
            ViewBag.Categories = categories.ToList();

            var (products, totalCount) = await _productService.GetProductsAsync(
                search: search,
                categorySlug: category,
                mrr: mrr,
                country: country,
                sort: sort,
                page: 1,
                pageSize: 100);

            ViewBag.TotalCount = totalCount;
            ViewBag.Search = search;
            ViewBag.SelectedCategory = category;
            ViewBag.SelectedMrr = mrr;
            ViewBag.SelectedCountry = country;
            ViewBag.SelectedSort = sort ?? "latest";

            return View(products);
        }

        /// <summary>
        /// AJAX endpoint for infinite scroll. Returns JSON array of product card HTML.
        /// GET /directory/products?page=2&search=...&category=...&mrr=...&country=...&sort=...
        /// </summary>
        [HttpGet("directory/products")]
        public async Task<IActionResult> GetProducts(
            string? search = null,
            string? category = null,
            string? mrr = null,
            string? country = null,
            string? sort = null,
            int page = 1)
        {
            const int pageSize = 50;

            var (products, totalCount) = await _productService.GetProductsAsync(
                search: search,
                categorySlug: category,
                mrr: mrr,
                country: country,
                sort: sort,
                page: page,
                pageSize: pageSize);

            var items = products.Select(p => new
            {
                id          = p.Id,
                slug        = p.Slug,
                name        = p.Name,
                tagline     = p.Tagline,
                description = p.Description,
                logoUrl     = p.LogoUrl,
                founderName = p.FounderName,
                categoryName = p.CategoryName,
                isVerified  = p.IsVerified,
                mrr         = p.Mrr,
                upvoteCount = p.UpvoteCount,
                wouldBuildYes = p.WouldBuildYes,
                wouldBuildNo  = p.WouldBuildNo,
            });

            return Json(new
            {
                items,
                totalCount,
                page,
                pageSize,
                hasMore = (page * pageSize) < totalCount
            });
        }

        [Route("directory/tool/{slug}")]
        public async Task<IActionResult> Tool(string slug)
        {
            var product = await _productService.GetBySlugAsync(slug);
            if (product == null)
                return NotFound();

            short? userVote = null;
            if (User.Identity?.IsAuthenticated == true)
            {
                var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
                if (Guid.TryParse(userIdClaim, out var userId))
                {
                    userVote = await _productService.GetUserWouldBuildVoteAsync(product.Id, userId);
                }
            }

            var comments = (await _commentService.GetProductCommentsAsync(product.Id)).ToList();

            // Fetch next 6 relevant products
            var categories = await _categoryService.GetCategoriesAsync();
            var category = categories.FirstOrDefault(c => c.Id == product.CategoryId);

            var (relatedProducts, _) = await _productService.GetProductsAsync(
                categorySlug: category?.Slug,
                pageSize: 10
            );

            var relevant = relatedProducts
                .Where(p => p.Id != product.Id)
                .Take(6)
                .ToList();

            if (relevant.Count < 6)
            {
                var (allProducts, _) = await _productService.GetProductsAsync(pageSize: 20);
                var extra = allProducts
                    .Where(p => p.Id != product.Id && !relevant.Any(r => r.Id == p.Id))
                    .Take(6 - relevant.Count);
                relevant.AddRange(extra);
            }

            ViewBag.RelevantProducts = relevant;
            ViewBag.Comments = comments;
            ViewBag.UserVote = userVote;
            return View(product);
        }

        [HttpPost("directory/tool/{slug}/vote")]
        public async Task<IActionResult> Vote(string slug, short voteType)
        {
            if (User.Identity?.IsAuthenticated != true)
                return Unauthorized();

            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (!Guid.TryParse(userIdClaim, out var userId))
                return Unauthorized();

            if (voteType < 0 || voteType > 1)
                return BadRequest("Invalid vote type");

            var success = await _productService.VoteWouldBuildAsync(slug, userId, voteType);
            if (!success) return NotFound();

            var product = await _productService.GetBySlugAsync(slug);
            if (product == null) return NotFound();

            var newVote = await _productService.GetUserWouldBuildVoteAsync(product.Id, userId);

            return Json(new
            {
                upvoteCount = product.UpvoteCount,
                wouldBuildYes = product.WouldBuildYes,
                wouldBuildNo = product.WouldBuildNo,
                userVote = newVote
            });
        }

        [HttpPost("directory/tool/{slug}/comment")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> PostComment(string slug, [FromForm] string body, [FromForm] Guid? parentId)
        {
            if (User.Identity?.IsAuthenticated != true)
                return Unauthorized();

            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (!Guid.TryParse(userIdClaim, out var userId))
                return Unauthorized();

            var product = await _productService.GetBySlugAsync(slug);
            if (product == null)
                return NotFound();

            try
            {
                var comment = await _commentService.PostCommentAsync(product.Id, userId, body, parentId);
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
}
