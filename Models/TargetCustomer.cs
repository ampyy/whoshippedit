namespace whoshippedit.Models;

public class TargetCustomer
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public short SortOrder { get; set; }
}
