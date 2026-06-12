using whoshippedit.Models;

namespace whoshippedit.Business.Service.Interface;

public interface ICategoryService
{
    Task<IEnumerable<Category>> GetCategoriesAsync();
}
