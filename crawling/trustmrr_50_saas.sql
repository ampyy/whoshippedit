-- ============================================
-- TrustMRR SaaS Startups Data Import (Manual)
-- Generated: 2026-06-16 21:29:24 UTC
-- Total Startups: 50
-- ============================================

BEGIN;

-- Startup: Telestars
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'telestars', 'telestars.io', 'Telestars', 'Nous proposons une plateforme de communication automatisée via Telegram, offrant des outils numériques pour améliorer l’interaction, la gestion et l’engagement ', 'Nous proposons une plateforme de communication automatisée via Telegram, offrant des outils numériques pour améliorer l’interaction, la gestion et l’engagement des utilisateurs.', 'https://d21oz30g4w22sz.cloudfront.net/logos/telestars-bc2f5bfc-9980-47eb-80db-fb3343d13561.png', 'https://telestars.io',
    NULL, ARRAY['SaaS']::text[], 2025, 'FR',
    NULL, NULL, NULL,
    5, 60, 'USD', 1,
    NULL, FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/telestars', '2026-06-16T21:31:03.710159+00:00'::timestamptz, '2026-06-16T21:31:03.710159+00:00'::timestamptz
);

-- Startup: Catering Funnels
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'catering-funnels', 'cateringfunnels.com', 'Catering Funnels', 'Catering Funnels is a combo of white label saas and done for you lead generation services for restaurants that do catering.', 'Catering Funnels is a combo of white label saas and done for you lead generation services for restaurants that do catering.', NULL, 'https://cateringfunnels.com',
    NULL, ARRAY['SaaS']::text[], 2025, 'US',
    NULL, NULL, NULL,
    39, 468, 'USD', 1,
    NULL, FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/catering-funnels', '2026-06-16T21:31:07.581764+00:00'::timestamptz, '2026-06-16T21:31:07.581764+00:00'::timestamptz
);

-- Startup: IndexBolt.com - Index you links in google
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'indexbolt-com-index-you-links-in-google', 'indexbolt.com', 'IndexBolt.com - Index you links in google', 'IndexBolt helps you get your URLs and backlinks discovered faster with powerful indexing tools built for SEOs, agencies, and website owners. Submit URLs, track ', 'IndexBolt helps you get your URLs and backlinks discovered faster with powerful indexing tools built for SEOs, agencies, and website owners. Submit URLs, track indexing progress, and save time instead of waiting endlessly for Google to find your pages. Whether you’re building links, publishing content, or managing client sites, IndexBolt makes indexing simpler, faster, and more reliable.', 'https://d21oz30g4w22sz.cloudfront.net/logos/primeiq-research-opc-private-limited-a281c887-85e3-46bb-91c1-7902b45d4a62.png', 'https://www.indexbolt.com',
    NULL, ARRAY['SaaS']::text[], 2023, 'IN',
    NULL, 'indexbolt', NULL,
    0, 0, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/indexbolt-com-index-you-links-in-google', '2026-06-16T21:31:24.825883+00:00'::timestamptz, '2026-06-16T21:31:24.825883+00:00'::timestamptz
);

-- Startup: Poach VC
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'poach-vc', 'poach.vc', 'Poach VC', 'Poach provides insights on early-stage founders for VCs.', 'Poach provides insights on early-stage founders for VCs.', 'https://files.stripe.com/links/MDB8YWNjdF8xT2VPUThJdEk2WmtNSTY2fGZsX2xpdmVfMEptM2s1VWU4RERxOHduVWRUUG1OSTBu00aYeAnUT7', 'https://poach.vc',
    NULL, ARRAY['SaaS']::text[], 2024, 'US',
    NULL, 'jaredrhizor', NULL,
    29, 348, 'USD', 1,
    ARRAY['nextjs', 'clerk', 'vercel']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/poach-vc', '2026-06-16T21:31:38.448121+00:00'::timestamptz, '2026-06-16T21:31:38.448121+00:00'::timestamptz
);

-- Startup: Coucou
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'coucou', 'getcoucou.io', 'Coucou', 'Coucou aide les salons sur Planity à collecter 20 à 40 avis Google par mois et à remonter dans le top 3 sans dépenser en publicité.', 'Coucou aide les salons sur Planity à collecter 20 à 40 avis Google par mois et à remonter dans le top 3 sans dépenser en publicité.', 'https://files.stripe.com/links/MDB8YWNjdF8xUXV4bEVJMm5tRWVlOVpEfGZsX2xpdmVfRkZ3bDNSb0ROZW13Zmcwd0JUZlpQeG5300GHnBmNYz', 'https://getcoucou.io',
    NULL, ARRAY['SaaS']::text[], 2025, 'FR',
    NULL, 'janga_lala', NULL,
    45, 540, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/coucou', '2026-06-16T21:31:54.969158+00:00'::timestamptz, '2026-06-16T21:31:54.969158+00:00'::timestamptz
);

-- Startup: Refgrow
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'refgrow', 'refgrow.com', 'Refgrow', 'Refgrow is the easiest way to add a referral program for users and affiliates to any SaaS product.', 'Refgrow is the easiest way to add a referral program for users and affiliates to any SaaS product.', 'https://files.stripe.com/links/MDB8YWNjdF8xUHZkUEJGTzFNYzdoRndXfGZsX2xpdmVfQ1B2Q2s5QzV1Tk9wWThRb3NmU2FJdUZQ008tnCdaqn', 'refgrow.com',
    NULL, ARRAY['SaaS']::text[], 2024, 'US',
    NULL, 'alexbelogubov', NULL,
    30, 360, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/refgrow', '2026-06-16T21:32:10.768256+00:00'::timestamptz, '2026-06-16T21:32:10.768256+00:00'::timestamptz
);

-- Startup: Reach Flow
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'reach-flow', 'reachflow.fr', 'Reach Flow', 'Reach Flow helps agencies and B2B businesses automate LinkedIn prospecting with AI-powered outreach and smart lead management.

Instead of spending hours sendin', 'Reach Flow helps agencies and B2B businesses automate LinkedIn prospecting with AI-powered outreach and smart lead management.

Instead of spending hours sending manual DMs, Reach Flow finds prospects, personalizes messages, and streamlines follow-ups to generate more qualified meetings consistently.

Perfect for founders, agencies, freelancers, and sales teams looking to scale outbound faster with less manual work.', 'https://files.stripe.com/links/MDB8YWNjdF8xUUpBdm9DR2JJZ3NZcVBkfGZsX2xpdmVfdUNIemhTRHoxU2p3Mm5jNDFGUmxkTXhM00syVGzaxf', 'https://reachflow.fr',
    NULL, ARRAY['SaaS']::text[], 2026, 'FR',
    NULL, 'hugo_grndd', NULL,
    26, 312, 'USD', 1,
    ARRAY['react', 'javascript', 'stripe', 'nextjs', 'tailwindcss', 'postgresql', 'vercel']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/reach-flow', '2026-06-16T21:32:24.395580+00:00'::timestamptz, '2026-06-16T21:32:24.395580+00:00'::timestamptz
);

-- Startup: Leadbomb
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'leadbomb', 'leadbomb.io', 'Leadbomb', 'Leadbomb.io is a lead generation platform that pulls business and audience data from across the web such as Google Maps, LinkedIn, Instagram, Shopify, and Yelp ', 'Leadbomb.io is a lead generation platform that pulls business and audience data from across the web such as Google Maps, LinkedIn, Instagram, Shopify, and Yelp into one place, so you can build targeted prospect lists without juggling multiple tools or manual research.', 'https://files.stripe.com/links/MDB8YWNjdF8xVEdaSGVQY3dxVzVxOGpIfGZsX2xpdmVfbFh1RjRNS0QwMGlVV0dzdDNJbXozOWNW002qh8bnC6', 'https://leadbomb.io',
    NULL, ARRAY['SaaS']::text[], 2026, 'US',
    NULL, 'kevisdeving', NULL,
    23, 276, 'USD', 1,
    ARRAY['nextjs', 'stripe', 'vercel', 'typescript', 'convex', 'resend']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/leadbomb', '2026-06-16T21:32:35.426214+00:00'::timestamptz, '2026-06-16T21:32:35.426214+00:00'::timestamptz
);

-- Startup: Tradevipe
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'tradevipe', 'tradevipe.com', 'Tradevipe', 'Tradevipe is a white-label, B2B SaaS platform serving trading communities, prop firms, and brokers by providing them with fully branded trading journal web appl', 'Tradevipe is a white-label, B2B SaaS platform serving trading communities, prop firms, and brokers by providing them with fully branded trading journal web applications tailored for their users. Founded three years ago, Tradevipe has quickly established itself as the go-to solution for organizations seeking a scalable, turn-key trading journal that enhances trader engagement, accountability, and retention under their own brand.', 'https://files.stripe.com/links/MDB8YWNjdF8xTmJrS2JIaWpBQ2h1cXZ6fGZsX2xpdmVfN3RuQzVwNnhIMTZpWHFLRHh2N0hMZjBR00MJO44Es7', 'https://www.tradevipe.com/branding',
    NULL, ARRAY['SaaS']::text[], 2023, 'BR',
    NULL, NULL, NULL,
    29, 348, 'USD', 1,
    ARRAY['python', 'react', 'postgresql', 'stripe', 'digitalocean', 'fastapi']::text[], FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/tradevipe', '2026-06-16T21:32:51.978290+00:00'::timestamptz, '2026-06-16T21:32:51.978290+00:00'::timestamptz
);

-- Startup: AI text Humanizer - Netherlands & Belgium
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'ai-text-humanizer-netherlands-belgium', 'google.com', 'AI text Humanizer - Netherlands & Belgium', 'This is a ai text humanizer for students, creators or blog writers. We got people from The Netherlands and Belgium. We got more than 9k email verified users now', 'This is a ai text humanizer for students, creators or blog writers. We got people from The Netherlands and Belgium. We got more than 9k email verified users now.

I kept the website url hidden till someone asks for it, don’t want backlinks.', NULL, 'https://google.com',
    NULL, ARRAY['SaaS']::text[], 2025, 'NL',
    NULL, 'movingsoul', NULL,
    21, 252, 'USD', 1,
    ARRAY['nextjs', 'supabase', 'vercel']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/ai-text-humanizer-netherlands-belgium', '2026-06-16T21:32:55.832717+00:00'::timestamptz, '2026-06-16T21:32:55.832717+00:00'::timestamptz
);

-- Startup: Directorly
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'directorly', 'directorly.app', 'Directorly', 'Directorly is a SaaS platform that enables businesses and organizations to create AI-powered business directories for their local communities
  or industry nich', 'Directorly is a SaaS platform that enables businesses and organizations to create AI-powered business directories for their local communities
  or industry niches. Customers discover us through
  digital marketing channels and word-of-mouth
  referrals, then use our intuitive interface to
  build comprehensive directories with automated
  data collection and intelligent search
  capabilities. We operate on a tiered subscription
  model with plans, charging based on the number of directories,
  l', 'https://files.stripe.com/links/MDB8YWNjdF8xUnBBeTFKZ3lOVks5ejVHfGZsX2xpdmVfV2tNSlRGQlQwblR3bHZWbnJHbmlDS3Jo0088PZEu98', 'https://directorly.app',
    NULL, ARRAY['SaaS']::text[], 2025, 'US',
    NULL, NULL, NULL,
    24, 288, 'USD', 1,
    ARRAY['nextjs', 'react', 'nodejs']::text[], FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/directorly', '2026-06-16T21:33:05.440379+00:00'::timestamptz, '2026-06-16T21:33:05.440379+00:00'::timestamptz
);

-- Startup: Compresto
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'compresto', 'compresto.app', 'Compresto', 'Compresto.app is a macOS app that quickly compresses images, videos, PDFs, and GIFs with minimal loss in quality, helping users reduce file sizes for storage or', 'Compresto.app is a macOS app that quickly compresses images, videos, PDFs, and GIFs with minimal loss in quality, helping users reduce file sizes for storage or sharing.', 'https://polar-public-files.s3.amazonaws.com/organization_avatar/9e7579be-2d43-4437-822b-74f82f389246/616fe42c-583b-4298-9089-4c3512d3ec16/icon_512x512.png', 'https://compresto.app',
    NULL, ARRAY['SaaS']::text[], 2023, 'VN',
    NULL, 'hieudinh_', NULL,
    2, 24, 'USD', 1,
    ARRAY['nextjs', 'css', 'swift', 'swiftui', 'tailwindcss', 'typescript', 'anthropic', 'lemonsqueezy', 'openai', 'polar', 'supabase', 'vercel']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/compresto', '2026-06-16T21:33:18.965478+00:00'::timestamptz, '2026-06-16T21:33:18.965478+00:00'::timestamptz
);

-- Startup: FastPassPhoto
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'fastpassphoto', 'fastpassphoto.com', 'FastPassPhoto', 'Passport Photo Generation. Upload a photo and get back a compliant passport photo.', 'Passport Photo Generation. Upload a photo and get back a compliant passport photo.', 'https://d21oz30g4w22sz.cloudfront.net/logos/fastpassphoto-112b751c-833f-409b-a872-91348008395b.jpg', 'https://fastpassphoto.com',
    NULL, ARRAY['SaaS']::text[], 2025, 'US',
    NULL, 'tryan310', NULL,
    0, 0, 'USD', 1,
    ARRAY['react']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/fastpassphoto', '2026-06-16T21:33:34.379984+00:00'::timestamptz, '2026-06-16T21:33:34.379984+00:00'::timestamptz
);

-- Startup: Typpout
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'typpout', 'typpout.com', 'Typpout', 'GTM agents that never let you miss a buying signal', 'GTM agents that never let you miss a buying signal', 'https://d21oz30g4w22sz.cloudfront.net/logos/worktellingenc-187eb4eb-8555-4820-b3bc-46da9d0db419.png', 'https://www.typpout.com',
    NULL, ARRAY['SaaS']::text[], 2025, 'IN',
    NULL, 'suresh_a0', NULL,
    12, 144, 'USD', 1,
    ARRAY['react', 'nodejs', 'postgresql', 'aws', 'redis']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/typpout', '2026-06-16T21:33:46.387748+00:00'::timestamptz, '2026-06-16T21:33:46.387748+00:00'::timestamptz
);

-- Startup: Legal Tech
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'legal-tech', 'legal-tech.bg', 'Legal Tech', 'Legal cloud technologies', 'Legal cloud technologies', 'https://files.stripe.com/links/MDB8YWNjdF8xU0o4TU9Fb1RhZHVrRUg2fGZsX2xpdmVfaTBIZUpOd0ZrR0JWb3lGcG9DSnhpRlZt00aLfMMUOW', 'https://legal-tech.bg',
    NULL, ARRAY['SaaS']::text[], 2025, 'BG',
    NULL, NULL, NULL,
    101, 1212, 'USD', 1,
    NULL, FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/legal-tech', '2026-06-16T21:33:56.694711+00:00'::timestamptz, '2026-06-16T21:33:56.694711+00:00'::timestamptz
);

-- Startup: Changelogfy
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'changelogfy', 'changelogfy.com', 'Changelogfy', 'Take better decisions and build impact products from user feedback', 'Take better decisions and build impact products from user feedback', 'https://files.stripe.com/links/MDB8YWNjdF8xRHpuSGRFNGtFMDB1UXlIfGZsX2xpdmVfZ2NtRTBzM0lMNHBkZDlYSWhxTTI0MXdG00BxWc7Tgr', 'https://changelogfy.com',
    NULL, ARRAY['SaaS']::text[], 2019, 'BR',
    NULL, 'paulocastellano', NULL,
    39, 468, 'USD', 1,
    ARRAY['laravel', 'vue', 'tailwindcss']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/changelogfy', '2026-06-16T21:34:09.416528+00:00'::timestamptz, '2026-06-16T21:34:09.416528+00:00'::timestamptz
);

-- Startup: Produktly
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'produktly', 'produktly.com', 'Produktly', 'SaaS for building product tours that improve onboarding, product adoption and retention. Customers can build engaging in-app product tours using our no-code edi', 'SaaS for building product tours that improve onboarding, product adoption and retention. Customers can build engaging in-app product tours using our no-code editor and integrate those into their own websites/apps.

We offer differently priced plans that are billed either monthly or yearly. So customers are charged when they choose a paid plan, and then either monthly or yearly as long as they stay active.', 'https://files.stripe.com/links/MDB8YWNjdF8xSWVwVElBZmphQzBjZFd6fGZsX2xpdmVfYmhPdlhYM0NoUmRsdmlBOWF6M2xndXpW00XAR7Hpyg', 'https://produktly.com',
    NULL, ARRAY['SaaS']::text[], 2021, 'FI',
    NULL, NULL, NULL,
    16, 192, 'USD', 1,
    NULL, FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/produktly', '2026-06-16T21:34:20.498350+00:00'::timestamptz, '2026-06-16T21:34:20.498350+00:00'::timestamptz
);

-- Startup: InsiteGPT
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'insitegpt', 'insitegpt.com', 'InsiteGPT', 'InsiteGPT turns your docs, site, and help center into a support agent that answers customers and captures leads automatically, no developer required.', 'InsiteGPT turns your docs, site, and help center into a support agent that answers customers and captures leads automatically, no developer required.', 'https://d21oz30g4w22sz.cloudfront.net/logos/paddle-business-17-457259bf-6f7a-4ce5-8c2b-0b80a3990d8c.png', 'https://www.insitegpt.com',
    NULL, ARRAY['SaaS']::text[], 2026, 'IN',
    NULL, 'rohitcbuilds', NULL,
    2, 24, 'USD', 1,
    ARRAY['nextjs', 'javascript', 'python', 'postgresql', 'openai']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/insitegpt', '2026-06-16T21:34:33.060036+00:00'::timestamptz, '2026-06-16T21:34:33.060036+00:00'::timestamptz
);

-- Startup: CORSPROXY
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'corsproxy', 'corsproxy.io', 'CORSPROXY', 'Fix every CORS Error in Seconds! Trusted by Uniswap and other large Companies around the World.', 'Fix every CORS Error in Seconds! Trusted by Uniswap and other large Companies around the World.', 'https://d21oz30g4w22sz.cloudfront.net/logos/corsproxy-io-43a9bdf7-e410-45e1-bd74-cd010578ab02.png', 'https://corsproxy.io',
    NULL, ARRAY['SaaS']::text[], 2022, 'DE',
    NULL, 'mariusbolik', NULL,
    20, 240, 'USD', 1,
    ARRAY['angular', 'astro', 'ionic', 'typescript', 'cloudflare']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/corsproxy', '2026-06-16T21:35:06.046244+00:00'::timestamptz, '2026-06-16T21:35:06.046244+00:00'::timestamptz
);

-- Startup: From Host, Inc.
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'from-host-inc', 'from-host.com', 'From Host, Inc.', 'We are a company that provides cloud services related to servers to host websites, games, etc. In some cases, we develop websites (we only developed our website', 'We are a company that provides cloud services related to servers to host websites, games, etc. In some cases, we develop websites (we only developed our website, nothing more, and we are working on developing it in the future)

Our website: https://from-host.ml
The Company''s name: From Host

Best Regards,
From Host Team', NULL, 'https://from-host.com',
    NULL, ARRAY['SaaS']::text[], 2021, 'US',
    NULL, 'hajajn200', NULL,
    13, 156, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/from-host-inc', '2026-06-16T21:35:09.952668+00:00'::timestamptz, '2026-06-16T21:35:09.952668+00:00'::timestamptz
);

-- Startup: Looktara
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'looktara', 'looktara.com', 'Looktara', 'Looktara is an AI photographer and photo product suite platform for all headshot, photography, photoshoot, social media assets and any static media needs. 

Wit', 'Looktara is an AI photographer and photo product suite platform for all headshot, photography, photoshoot, social media assets and any static media needs. 

With over 4.5 rating on trustpilot and AI azure credits, the foundation of looktara is very strong which is proved by $22000 revenue in just 150 days of launch. We have achieved 15k+ verified users, and 65k+ Headshots are created on Looktara till date.

The tool has immense potential to beat aragon, headshotpro and photoai', 'https://d21oz30g4w22sz.cloudfront.net/logos/ai-photographer-6e6787d1-9360-451f-92a3-4d322a296050.png', 'https://looktara.com',
    NULL, ARRAY['SaaS']::text[], 2025, 'IN',
    NULL, 'krissmanngupta', NULL,
    11, 132, 'USD', 1,
    ARRAY['css', 'html5', 'nextjs', 'react', 'reactnative', 'tailwindcss', 'typescript', 'aws', 'mongodb', 'openai', 'dodopayments', 'cloudflare', 'azure']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/looktara', '2026-06-16T21:35:17.953934+00:00'::timestamptz, '2026-06-16T21:35:17.953934+00:00'::timestamptz
);

-- Startup: bookmein.events
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'bookmein-events', 'bookmein.events', 'bookmein.events', 'Orchestrate events easily with BookMeIn.Events. Build custom pages, sell tickets with 0% fees for events, and use AI support. Scale easily from local meetups to', 'Orchestrate events easily with BookMeIn.Events. Build custom pages, sell tickets with 0% fees for events, and use AI support. Scale easily from local meetups to global conferences.', 'https://files.stripe.com/links/MDB8YWNjdF8xUHA3R2JHUEpFeTE5ajFpfGZsX2xpdmVfYUI5OWVaM0FhY2lTNUVBU3Z2STE5WlY000ByOB2Wnk', 'https://bookmein.events',
    NULL, ARRAY['SaaS']::text[], 2024, 'GR',
    NULL, 'eugenegioutzin', NULL,
    5, 60, 'USD', 1,
    ARRAY['vue', 'laravel', 'aws', 'stripe', 'css', 'nuxt', 'docker', 'html5', 'javascript', 'sass', 'wordpress', 'github-actions', 'mysql', 'mongodb', 'nginx', 'php', 'sendgrid', 'sentry', 'twilio', 'supabase']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/bookmein-events', '2026-06-16T21:35:31.029219+00:00'::timestamptz, '2026-06-16T21:35:31.029219+00:00'::timestamptz
);

-- Startup: TechScreen
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'techscreen', 'techscreen.app', 'TechScreen', 'AI Assistant tool', 'AI Assistant tool', 'https://files.stripe.com/links/MDB8YWNjdF8xUXhoVDVBVXdXZzZRVktTfGZsX2xpdmVfbWV6SzExT3VwTkNsNmxocFBVU3VJSmFP00qISXxaGt', 'https://techscreen.app',
    NULL, ARRAY['SaaS']::text[], 2025, 'US',
    NULL, NULL, NULL,
    16, 192, 'USD', 1,
    ARRAY['electron', 'nextjs', 'stripe', 'nodejs']::text[], FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/techscreen', '2026-06-16T21:35:41.712976+00:00'::timestamptz, '2026-06-16T21:35:41.712976+00:00'::timestamptz
);

-- Startup: One Care Portal
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'one-care-portal', 'onecareportal.com', 'One Care Portal', 'The all-in-one platform that helps adult day care centers and HCBS waiver agencies pass audits, cut documentation time in half, and get claims paid faster.', 'The all-in-one platform that helps adult day care centers and HCBS waiver agencies pass audits, cut documentation time in half, and get claims paid faster.', 'https://d21oz30g4w22sz.cloudfront.net/logos/one-care-portal-9bd86370-f018-4cf4-a2a9-a4c333cb87c9.png', 'https://onecareportal.com',
    NULL, ARRAY['SaaS']::text[], NULL, 'US',
    NULL, 'bastolaram', NULL,
    50, 600, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/one-care-portal', '2026-06-16T21:35:53.150417+00:00'::timestamptz, '2026-06-16T21:35:53.150417+00:00'::timestamptz
);

-- Startup: miranda flow
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'miranda-flow', 'mirandaflow.com', 'miranda flow', 'Logiciel de réservation de cours et gestion de studios de Pilates, yoga, danse...', 'Logiciel de réservation de cours et gestion de studios de Pilates, yoga, danse...', 'https://files.stripe.com/links/MDB8YWNjdF8xT2prcktIUUNxaFRKOTZRfGZsX2xpdmVfcU5qY0RYWkFlWUQ4U0tTUk5BUVNTWkxD00fszqUbqc', 'https://www.mirandaflow.com',
    NULL, ARRAY['SaaS']::text[], 2024, 'FR',
    NULL, NULL, NULL,
    14, 168, 'USD', 1,
    ARRAY['bubble']::text[], FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/miranda-flow', '2026-06-16T21:36:03.977880+00:00'::timestamptz, '2026-06-16T21:36:03.977880+00:00'::timestamptz
);

-- Startup: HouseGPTS
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'housegpts', 'housegpts.com', 'HouseGPTS', 'Ai powered interior, exterior, kitchen and home designer.', 'Ai powered interior, exterior, kitchen and home designer.', 'https://d21oz30g4w22sz.cloudfront.net/logos/paddle-business-6-b42c8617-4b4c-437e-b564-702609a869b9.webp', 'https://housegpts.com',
    NULL, ARRAY['SaaS']::text[], 2025, 'PK',
    NULL, 'abdullahcodesxd', NULL,
    11, 132, 'USD', 1,
    ARRAY['nextjs', 'mongodb', 'express', 'nodejs']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/housegpts', '2026-06-16T21:36:12.552586+00:00'::timestamptz, '2026-06-16T21:36:12.552586+00:00'::timestamptz
);

-- Startup: Phantom
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'phantom', 'phantomlocal.com', 'Phantom', 'Phantom is a GMB audit tool that streamlines SEO processes, and provides better insights from Google Search & Maps.', 'Phantom is a GMB audit tool that streamlines SEO processes, and provides better insights from Google Search & Maps.', 'https://files.stripe.com/links/MDB8YWNjdF8xTlZDTkpFSWMwclhtWWlZfGZsX2xpdmVfNEZLU3dGS2twZ3NQMVA4TW1sc2xWZEQz00i1m9riTQ', 'phantomlocal.com',
    NULL, ARRAY['SaaS']::text[], 2023, 'US',
    NULL, 'phantomaudits', NULL,
    11, 132, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/phantom', '2026-06-16T21:36:22.872829+00:00'::timestamptz, '2026-06-16T21:36:22.872829+00:00'::timestamptz
);

-- Startup: ArchiRise
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'archirise', 'archirise.ai', 'ArchiRise', 'L’IA pensée pour transformer les rendus et images d’architecture en photographies et vidéos d’exception.', 'L’IA pensée pour transformer les rendus et images d’architecture en photographies et vidéos d’exception.', 'https://files.stripe.com/links/MDB8YWNjdF8xU3NLUERFcWthR0Z1eDdYfGZsX2xpdmVfeDd5V0FZZTVhZjg0a0VUUVhPaDFGOVNR00dqDDuOh0', 'http://archirise.ai',
    NULL, ARRAY['SaaS']::text[], 2026, 'FR',
    NULL, 'marin_delval', NULL,
    4, 48, 'USD', 1,
    ARRAY['webflow', 'react', 'tailwindcss']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/archirise', '2026-06-16T21:36:39.558539+00:00'::timestamptz, '2026-06-16T21:36:39.558539+00:00'::timestamptz
);

-- Startup: CancelPause
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'cancelpause', 'cancelpause.com', 'CancelPause', 'CancelPause gives your SaaS a hosted cancellation flow with pause offers, discount saves, feedback collection, and Stripe billing redirects - so cancellations d', 'CancelPause gives your SaaS a hosted cancellation flow with pause offers, discount saves, feedback collection, and Stripe billing redirects - so cancellations don''t turn into silent churn.', NULL, 'https://www.cancelpause.com/',
    NULL, ARRAY['SaaS']::text[], 2026, 'SE',
    NULL, 'aidenazr', NULL,
    5, 60, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/cancelpause', '2026-06-16T21:36:44.526267+00:00'::timestamptz, '2026-06-16T21:36:44.526267+00:00'::timestamptz
);

-- Startup: DevScout
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'devscout', 'devscout.app', 'DevScout', 'Automation that send e-mails for the users directly in to the recruiters matching them', 'Automation that send e-mails for the users directly in to the recruiters matching them', NULL, 'https://devscout.app',
    NULL, ARRAY['SaaS']::text[], 2025, 'BR',
    NULL, 'adamsnows', NULL,
    8, 96, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/devscout', '2026-06-16T21:36:48.398311+00:00'::timestamptz, '2026-06-16T21:36:48.398311+00:00'::timestamptz
);

-- Startup: Nurpay Technologies
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'nurpay-technologies', 'nurpay.my', 'Nurpay Technologies', 'You don''t have a revenue problem. You have a revenue model problem. Let''s fix that. We implement & execute subscription-based business model for our partners to', 'You don''t have a revenue problem. You have a revenue model problem. Let''s fix that. We implement & execute subscription-based business model for our partners to strengthen their cashﬂow', 'https://d21oz30g4w22sz.cloudfront.net/logos/nurpay-technologies-827adef7-9199-40ea-bacb-50fa48ebb370.png', 'https://nurpay.my',
    NULL, ARRAY['SaaS']::text[], 2020, 'MY',
    NULL, 'taufiknaaim', NULL,
    10, 120, 'USD', 1,
    ARRAY['wordpress', 'cloudflare', 'digitalocean', 'openai', 'stripe', 'github-actions']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/nurpay-technologies', '2026-06-16T21:37:01.623862+00:00'::timestamptz, '2026-06-16T21:37:01.623862+00:00'::timestamptz
);

-- Startup: Lead Gravity
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'lead-gravity', 'leadgravity.ai', 'Lead Gravity', 'LinkedIn Lead Magnets on Autopilot', 'LinkedIn Lead Magnets on Autopilot', 'https://d21oz30g4w22sz.cloudfront.net/logos/lead-gravity-eb934429-b187-4e5d-9c60-501cc0d671d1.png', 'https://leadgravity.ai',
    NULL, ARRAY['SaaS']::text[], 2026, 'FR',
    NULL, 'ericdjav', NULL,
    1, 12, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/lead-gravity', '2026-06-16T21:37:11.464979+00:00'::timestamptz, '2026-06-16T21:37:11.464979+00:00'::timestamptz
);

-- Startup: MON RDV PREFECTURE
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'mon-rdv-prefecture', 'monrdvprefecture.fr', 'MON RDV PREFECTURE', 'Receive real-time notifications of available slots for your prefecture appointments.', 'Receive real-time notifications of available slots for your prefecture appointments.', 'https://files.stripe.com/links/MDB8YWNjdF8xQXRHc0xBWVlpdm5YYTI4fGZsX2xpdmVfZUZOTUpRRjJTUjdIM0lDVEFlUUs2WjZp00FDwjgMHU', 'https://www.monrdvprefecture.fr',
    NULL, ARRAY['SaaS']::text[], 2022, 'FR',
    NULL, NULL, NULL,
    9, 108, 'USD', 1,
    ARRAY['nuxt']::text[], FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/mon-rdv-prefecture', '2026-06-16T21:37:25.130745+00:00'::timestamptz, '2026-06-16T21:37:25.130745+00:00'::timestamptz
);

COMMIT;