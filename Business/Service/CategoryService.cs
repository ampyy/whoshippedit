using whoshippedit.Models;
using whoshippedit.Data.Repository.Interface;
using whoshippedit.Business.Service.Interface;

namespace whoshippedit.Business.Service;

public class CategoryService : ICategoryService
{
    private readonly ICategoryRepository _categoryRepo;

    public CategoryService(ICategoryRepository categoryRepo)
    {
        _categoryRepo = categoryRepo;
    }

    public async Task<IEnumerable<Category>> GetCategoriesAsync()
    {
        return await _categoryRepo.GetAllAsync();
    }
}
