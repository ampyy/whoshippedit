using whoshippedit.Models;
using whoshippedit.Utilities;
using whoshippedit.Data.Repository.Interface;

namespace whoshippedit.Data.Repository;

public class CategoryRepository : ICategoryRepository
{
    private readonly IDbConnectionHelper _db;

    public CategoryRepository(IDbConnectionHelper db)
    {
        _db = db;
    }

    public async Task<IEnumerable<Category>> GetAllAsync()
    {
        return await _db.QueryAsync<Category>("SELECT * FROM categories ORDER BY sort_order ASC");
    }
}
