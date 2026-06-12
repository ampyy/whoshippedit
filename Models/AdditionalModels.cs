using System;

namespace whoshippedit.Models
{
    public class Vote
    {
        public Guid Id { get; set; }
        public Guid? ProductId { get; set; }
        public Guid? UserId { get; set; }
        public DateTime CreatedAt { get; set; }
    }

    public class WouldBuildVote
    {
        public Guid Id { get; set; }
        public Guid? ProductId { get; set; }
        public Guid? UserId { get; set; }
        public short Vote { get; set; } // 0=yes, 1=no
        public DateTime CreatedAt { get; set; }
    }

    public class CustomerSignal
    {
        public Guid Id { get; set; }
        public Guid? ProductId { get; set; }
        public Guid? UserId { get; set; }
        public short Type { get; set; } // 0=customer, 1=building_similar
        public DateTime CreatedAt { get; set; }
    }

    public class Milestone
    {
        public Guid Id { get; set; }
        public Guid? ProductId { get; set; }
        public Guid? UserId { get; set; }
        public string Value { get; set; } = string.Empty;
        public string? Note { get; set; }
        public bool IsApproved { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}
