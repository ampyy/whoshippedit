using Microsoft.AspNetCore.Authentication.Cookies;
using whoshippedit.Business;
using whoshippedit.Utilities;
using whoshippedit.Data.Repository;
using whoshippedit.Data.Repository.Interface;
using whoshippedit.Business.Service;
using whoshippedit.Business.Service.Interface;

var builder = WebApplication.CreateBuilder(args);

var environmentName = builder.Environment.EnvironmentName;
builder.Configuration
    .SetBasePath(builder.Environment.ContentRootPath)
    .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
    .AddJsonFile($"appsettings.{environmentName}.json", optional: true, reloadOnChange: true)
    .AddEnvironmentVariables();

// ── Services ──────────────────────────────────────────────────────────────────
Dapper.DefaultTypeMap.MatchNamesWithUnderscores = true;

builder.Services.AddControllersWithViews();
builder.Services.AddTransient<IDbConnectionHelper, DbConnectionHelper>();
builder.Services.AddTransient<IAuthService, AuthService>();
builder.Services.AddTransient<IEmailService, EmailService>();

// ── Repositories ──────────────────────────────────────────────────────────────
builder.Services.AddTransient<IUserRepository, UserRepository>();
builder.Services.AddTransient<ICategoryRepository, CategoryRepository>();
builder.Services.AddTransient<IProductRepository, ProductRepository>();
builder.Services.AddTransient<IIdeaRepository, IdeaRepository>();
builder.Services.AddTransient<ITargetCustomerRepository, TargetCustomerRepository>();
builder.Services.AddTransient<ICommentRepository, CommentRepository>();

// ── Business Services ─────────────────────────────────────────────────────────
builder.Services.AddTransient<IUserService, UserService>();
builder.Services.AddTransient<ICategoryService, CategoryService>();
builder.Services.AddTransient<IProductService, ProductService>();
builder.Services.AddTransient<IIdeaService, IdeaService>();
builder.Services.AddTransient<ITargetCustomerService, TargetCustomerService>();
builder.Services.AddTransient<ICommentService, CommentService>();

// ── Cookie Authentication ─────────────────────────────────────────────────────
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        options.LoginPath        = "/auth/login";
        options.LogoutPath       = "/auth/logout";
        options.AccessDeniedPath = "/auth/login";
        options.Cookie.Name      = "wsi_session";
        options.Cookie.HttpOnly  = true;
        options.Cookie.SecurePolicy = CookieSecurePolicy.SameAsRequest;
        options.Cookie.SameSite  = SameSiteMode.Lax;
        options.ExpireTimeSpan   = TimeSpan.FromDays(7);
        options.SlidingExpiration = true;
    });

var app = builder.Build();

// ── Pipeline ──────────────────────────────────────────────────────────────────
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseRouting();

app.UseAuthentication();   // ← must be before UseAuthorization
app.UseAuthorization();

app.MapStaticAssets();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}")
    .WithStaticAssets();

app.Run();
