using System;
using System.ComponentModel.DataAnnotations;

namespace whoshippedit.Models
{
    public class Idea
    {
        public Guid Id { get; set; }
        public string Slug { get; set; } = string.Empty;
        public string Title { get; set; } = string.Empty;
        public string Problem { get; set; } = string.Empty;
        public string TargetCustomer { get; set; } = string.Empty;
        public string ProposedPrice { get; set; } = string.Empty;
        public Guid? CategoryId { get; set; }
        public Guid? SubmittedBy { get; set; }
        public Guid? ConvertedTo { get; set; }
        public short Status { get; set; } = AppConstants.Status.Pending;
        public DateTime CreatedAt { get; set; }

        // Denormalized fields for UI convenience
        public int TotalVotes { get; set; }
        public int VoteYes { get; set; }
        public int VoteMaybe { get; set; }
        public int VoteNo { get; set; }
        public int BuildingCount { get; set; }
        public int CommentCount { get; set; }
        public string FounderName { get; set; } = "Anonymous";
        
        // UI helper
        public double HotScore => (TotalVotes > 0) ? 
            ((double)(VoteYes + VoteMaybe) / TotalVotes) * Math.Log(TotalVotes + 1) : 0;
            
        public double DemandPercentage => (TotalVotes > 0) ? 
            ((double)(VoteYes + VoteMaybe) / TotalVotes) : 0;
    }

    public class IdeaVote
    {
        public Guid Id { get; set; }
        public Guid IdeaId { get; set; }
        public Guid UserId { get; set; }
        public short Vote { get; set; } // 0=yes, 1=maybe, 2=no, 3=building
        public DateTime CreatedAt { get; set; }
    }

    public class IdeaSubmitViewModel
    {
        [Required]
        [MaxLength(80, ErrorMessage = "Title must be 80 characters or fewer.")]
        public string Title { get; set; } = string.Empty;

        [Required]
        [MaxLength(300, ErrorMessage = "Problem description must be 300 characters or fewer.")]
        public string Problem { get; set; } = string.Empty;

        [Required]
        public string TargetCustomer { get; set; } = string.Empty;

        [Required]
        public string ProposedPrice { get; set; } = string.Empty;
        
        public string Category { get; set; } = string.Empty;
    }
}
