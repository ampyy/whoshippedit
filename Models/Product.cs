using System;

namespace whoshippedit.Models
{
    public class Product
    {
        public Guid Id { get; set; }
        public string Slug { get; set; } = string.Empty;
        public string Domain { get; set; } = string.Empty;
        public string Name { get; set; } = string.Empty;
        public string Tagline { get; set; } = string.Empty;
        public string? Description { get; set; }
        public string? LogoUrl { get; set; }
        public string WebsiteUrl { get; set; } = string.Empty;

        // classification
        public Guid? CategoryId { get; set; }
        public string[]? Tags { get; set; }
        public short? FoundedYear { get; set; }
        public string? CountryCode { get; set; }     // e.g. "IN", "US", "GB"

        // founder
        public string? FounderName { get; set; }
        public string? FounderTwitter { get; set; }
        public string? FounderLinkedin { get; set; } // just the handle

        // revenue (real numbers)
        public int? Mrr { get; set; }                // 4250
        public int? Arr { get; set; }                // 51000
        public string? Currency { get; set; } = "USD";

        // pricing (filterable)
        public short? PricingType { get; set; }      // 0=free 1=freemium 2=paid 3=one-time
        public int? PriceFrom { get; set; }          // 9
        public int? PriceTo { get; set; }            // 99 (null if single plan)

        // details
        public string[]? TechStack { get; set; }

        // flags
        public bool IsFeatured { get; set; }
        public bool IsVerified { get; set; }
        public bool IsClaimed { get; set; }

        public short Status { get; set; } = AppConstants.Status.Pending;
        public short Source { get; set; } = AppConstants.Source.Manual;

        public Guid? AddedBy { get; set; }
        public Guid? ClaimedBy { get; set; }
        public DateTime? ClaimedAt { get; set; }
        public DateTime? FeaturedUntil { get; set; }
        public DateTime CreatedAt { get; set; }

        public int UpvoteCount { get; set; }
        public int CommentCount { get; set; }
        public int WouldBuildYes { get; set; }
        public int WouldBuildNo { get; set; }

        // Display property (populated by JOIN, not a DB column)
        public string? CategoryName { get; set; }
    }
}
