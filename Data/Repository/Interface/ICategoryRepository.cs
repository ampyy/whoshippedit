using whoshippedit.Models;

namespace whoshippedit.Data.Repository.Interface;

public interface ICategoryRepository
{
    Task<IEnumerable<Category>> GetAllAsync();
}
