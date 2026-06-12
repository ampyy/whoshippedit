using System;

namespace whoshippedit.Models
{
    public class Comment
    {
        public Guid Id { get; set; }
        public Guid? ProductId { get; set; }
        public Guid? IdeaId { get; set; }
        public Guid? UserId { get; set; }
        public Guid? ParentId { get; set; }
        public string Body { get; set; } = string.Empty;
        public int UpvoteCount { get; set; }
        public short Status { get; set; } = AppConstants.CommentStatus.Active;
        public DateTime CreatedAt { get; set; }

        // Display properties (populated by JOINs, not mapped to columns)
        public string? UserName { get; set; }
        public string? UserAvatarUrl { get; set; }
    }

    public class CommentVote
    {
        public Guid Id { get; set; }
        public Guid? CommentId { get; set; }
        public Guid? UserId { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}
