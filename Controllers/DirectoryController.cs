using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using whoshippedit.Business.Service.Interface;

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
        public async Task<IActionResult> Index()
        {
            var categories = await _categoryService.GetCategoriesAsync();
            ViewBag.Categories = categories.ToList();
            
            return View();
        }

        [Route("directory/tool/{slug}")]
        public async Task<IActionResult> Tool(string slug)
        {
            var product = await _productService.GetBySlugAsync(slug);
            if (product == null)
                return NotFound();

            var comments = (await _commentService.GetProductCommentsAsync(product.Id)).ToList();

            ViewBag.Comments = comments;
            return View(product);
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
