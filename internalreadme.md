# Internal Database Configuration & Dapper Wrapper Readme

This document explains in simple words how the database connection and the Dapper wrappers have been set up in this project, and how you can use them to read and write from the PostgreSQL database.

---

## 🛠️ What Was Done

We integrated **PostgreSQL** and **Dapper** (a fast, lightweight micro-ORM) into the **whoshippedit** project.

1. **Installed Dependencies**:
   - Installed `Dapper` for high-performance object mapping.
   - Installed `Npgsql` as the official PostgreSQL provider for .NET.

2. **Configured Connection String (Environment-based)**:
   - Added the active Neon PostgreSQL connection string directly to `appsettings.Development.json` under the key `"DefaultConnection"` for development.
   - Added a safe production placeholder in `appsettings.json` under the key `"ProductionConnection"`.
   - **Environment Choice Logic**: Programmed the database helper to dynamically detect the running environment using `IHostEnvironment`. It automatically selects the `"DefaultConnection"` connection string during development, and the `"ProductionConnection"` connection string in other environments (such as Production), with a built-in fallback.

3. **Created Database Wrappers**:
   - Created **`IDbConnectionHelper.cs`** in the `Utilities` folder. This interface outlines standard async and sync database methods (e.g. `QueryAsync`, `ExecuteAsync`, `ExecuteScalarAsync`).
   - Created **`DbConnectionHelper.cs`** in the `Utilities` folder. This is the helper class that implements the interface.
   - **Feature**: Cloud database hosts (like Neon) provide connection strings in the `postgresql://` URI format. Standard Npgsql doesn't natively parse these URIs. Our helper includes a robust converter that automatically parses and converts the URI format into the standard ADO.NET format behind the scenes!

4. **Dependency Injection Registration**:
   - Registered `IDbConnectionHelper` in `Program.cs` as a `Transient` service. This means it is fully injectable into any Controller, Service, or Business logic class.

---

## 🚀 How to Use It

Because we registered `IDbConnectionHelper` in the DI container, you can simply inject it into any controller or service constructor.

### 1. Basic Injection Example (Controller)

Here is a simple example showing how to inject and use the wrapper inside a controller to fetch data and write data:

```csharp
using Microsoft.AspNetCore.Mvc;
using whoshippedit.Utilities;

public class ShipmentsController : Controller
{
    private readonly IDbConnectionHelper _db;

    // Inject IDbConnectionHelper through constructor
    public ShipmentsController(IDbConnectionHelper db)
    {
        _db = db;
    }

    // 1. READ: Query multiple rows
    public async Task<IActionResult> Index()
    {
        string sql = "SELECT * FROM shipments ORDER BY created_at DESC;";
        
        // This will query and map database rows automatically to your C# model class
        var shipments = await _db.QueryAsync<Shipment>(sql);
        
        return View(shipments);
    }

    // 2. READ: Query a single row or default
    public async Task<IActionResult> Details(int id)
    {
        string sql = "SELECT * FROM shipments WHERE id = @Id LIMIT 1;";
        
        var shipment = await _db.QueryFirstOrDefaultAsync<Shipment>(sql, new { Id = id });
        if (shipment == null)
        {
            return NotFound();
        }
        
        return View(shipment);
    }

    // 3. WRITE: Insert or update data
    [HttpPost]
    public async Task<IActionResult> Create(string trackingNumber, string carrier)
    {
        string sql = "INSERT INTO shipments (tracking_number, carrier) VALUES (@TrackingNumber, @Carrier);";
        
        // This will execute the command and return the number of affected rows
        int rowsAffected = await _db.ExecuteAsync(sql, new { TrackingNumber = trackingNumber, Carrier = carrier });
        
        return RedirectToAction(nameof(Index));
    }
    
    // 4. WRITE & RETURN AUTO-INCREMENTED ID
    [HttpPost]
    public async Task<IActionResult> CreateAndReturnId(string trackingNumber, string carrier)
    {
        string sql = "INSERT INTO shipments (tracking_number, carrier) VALUES (@TrackingNumber, @Carrier) RETURNING id;";
        
        // This will execute the query and return the first column of the first row (the ID)
        int newId = await _db.ExecuteScalarAsync<int>(sql, new { TrackingNumber = trackingNumber, Carrier = carrier });
        
        return Ok(new { Id = newId });
    }
}

// Simple Model Class for illustration
public class Shipment
{
    public int Id { get; set; }
    public string TrackingNumber { get; set; } = string.Empty;
    public string Carrier { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
}
```

---

## 💎 Best Practices Applied

- **Asynchronous by Default**: All high-throughput methods support `async`/`await` to ensure non-blocking I/O in your web application.
- **Resource Management**: Each query automatically creates, opens, and disposes the SQL connection (`using var connection = GetConnection()`) under the hood to prevent connection leaks.
- **Security**: The wrapper fully supports parameterized queries using anonymous objects (e.g. `new { Id = id }`), which completely immunizes your application against **SQL Injection** attacks.
- **Zero Configuration Obsoletion**: The build has been fully polished with modern Npgsql configurations to run with `0 warnings` and `0 errors`.

---

## 🗃️ Git & Environment Configuration

### 1. `.gitignore` Added
We added a standard `.gitignore` file to ignore:
- Build artifacts (`bin/`, `obj/`, `Debug/`, `Release/`).
- IDE files (`.vs/`, `.vscode/`, `.idea/`).
- NPM Packages and dependencies (`node_modules/`, `package-lock.json`).
- User secrets and system files (`.DS_Store`, `Thumbs.db`).

### 2. Tailwind CSS Configuration & Styling
We integrated **Tailwind CSS v4** based on the **WhoBuiltThis** design specification.
- **Design Configuration (`tailwind.config.js`)**: Configured customized color schemes, Geist typography scale, flat spacings, and custom borders (like `0.5px` default) to enforce the high-fidelity UI constraints.
- **Input CSS (`wwwroot/css/input.css`)**: Imports the Google Font **Geist** (limited to weights 400 and 500) and configures standard `@tailwind` directives.
- **Output CSS (`wwwroot/css/site.css`)**: Holds the fully compiled, highly-optimized production-ready utility classes.

#### NPM Scripts for Tailwind:
You can run the following commands in your terminal:
- **Build CSS once**: `npm run build:css`
- **Watch & Live Compile (Recommended for local dev)**: `npm run watch:css` *(automatically watches for any changes in your `.cshtml` razor views and compiles the CSS on the fly!)*.

### 3. How to Run the App in Development Environment
To run your application locally forcing it to use **only** the `appsettings.Development.json` (active Neon database connection), you have two choices:

#### Choice A: Run via Console Command (Recommended)
Run the following standard command in your terminal. This explicitly tells the .NET runtime to load the Development environment configuration:
```bash
dotnet run --environment Development
```

#### Choice B: Set the Terminal Environment Variable
Set the environment variable in your terminal session before launching the application:
```bash
export ASPNETCORE_ENVIRONMENT=Development
dotnet run
```
