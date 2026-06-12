namespace whoshippedit.Models
{
    public static class AppConstants
    {
        public static class Status
        {
            public const short Pending = 0;
            public const short Approved = 1;
            public const short Rejected = 2;
        }

        public static class Source
        {
            public const short Manual = 0;
            public const short ProductHunt = 1;
            public const short Submitted = 2;
            public const short Scraped = 3;
        }

        public static class WouldBuild
        {
            public const short Yes = 0;
            public const short No = 1;
        }

        public static class IdeaVote
        {
            public const short Yes = 0;
            public const short Maybe = 1;
            public const short No = 2;
            public const short Building = 3;
        }

        public static class CommentStatus
        {
            public const short Active = 0;
            public const short Flagged = 1;
            public const short Deleted = 2;
        }

        public static class Signal
        {
            public const short Customer = 0;
            public const short Building = 1;
        }
    }
}
