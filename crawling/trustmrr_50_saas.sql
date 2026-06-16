-- ============================================
-- TrustMRR SaaS Startups Data Import (Manual)
-- Generated: 2026-06-13 12:25:11 UTC
-- Total Startups: 50
-- ============================================

BEGIN;

-- Startup: 1Lookup
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    '1lookup', '1lookup.io', '1Lookup', 'The #1 tool for validating phone, email and IP data in real time. All through one powerful API.', 'The #1 tool for validating phone, email and IP data in real time. All through one powerful API.', 'https://d21oz30g4w22sz.cloudfront.net/logos/voicedrop-e0cd9164-7c15-4b9c-845e-68721632b2a7.jpg', 'https://www.1lookup.io',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2022, 'US',
    NULL, 'robbyfrank', NULL,
    2273, 27276, 'USD', 1,
    ARRAY['nextjs', 'postgresql', 'stripe']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/1lookup', '2026-06-13T12:25:12.298519+00:00'::timestamptz, '2026-06-13T12:25:12.298519+00:00'::timestamptz
);

-- Startup: bullgpt.io
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'bullgpt-io', 'bullgpt.io', 'bullgpt.io', 'Get pro-level analysis instantly with AI.', 'Get pro-level analysis instantly with AI.', 'https://d21oz30g4w22sz.cloudfront.net/logos/bullgpt-io-9dd9d289-7d36-4b1a-a1d6-967ab8dcca85.png', 'https://www.bullgpt.io',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2025, 'US',
    NULL, '0xveutino', NULL,
    339, 4068, 'USD', 1,
    ARRAY['vercel', 'neon', 'openai']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/bullgpt-io', '2026-06-13T12:25:16.217848+00:00'::timestamptz, '2026-06-13T12:25:16.217848+00:00'::timestamptz
);

-- Startup: My X project 2
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'my-x-project-2', 'x.com', 'My X project 2', 'my little profitable SaaS', 'my little profitable SaaS', 'https://d21oz30g4w22sz.cloudfront.net/logos/ai-music-api-a31a536b-695d-46eb-a6a2-5153744f015a.png', 'https://x.com/buildwithJames',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2024, 'AU',
    NULL, 'jamesai', NULL,
    150, 1800, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/my-x-project-2', '2026-06-13T12:25:21.100076+00:00'::timestamptz, '2026-06-13T12:25:21.100076+00:00'::timestamptz
);

-- Startup: My X project 3
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'my-x-project-3', 'my-x-project-3.com', 'My X project 3', 'my little profitable SaaS', 'my little profitable SaaS', 'https://d21oz30g4w22sz.cloudfront.net/logos/sunoapi-50b7c808-2789-4fac-bcfd-2b05327adea6.png', 'https://x.com/buildWithJames',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2025, 'AU',
    NULL, 'jamesai', NULL,
    31, 372, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/my-x-project-3', '2026-06-13T12:25:26.943068+00:00'::timestamptz, '2026-06-13T12:25:26.943068+00:00'::timestamptz
);

-- Startup: ChatSEO
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'chatseo', 'chatseo.app', 'ChatSEO', 'Find & prioritize your SEO wins by chatting with your data.', 'Find & prioritize your SEO wins by chatting with your data.', 'https://files.stripe.com/links/MDB8YWNjdF8xU1lrc0xDcUl0aVFPaXZ5fGZsX2xpdmVfTjRGUHlmSU9yU2EyOUNKSUxvRHBnSkxC00Lnym4APf', 'https://chatseo.app',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2025, 'FR',
    NULL, 'iziatask', NULL,
    212, 2544, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/chatseo', '2026-06-13T12:25:31.858292+00:00'::timestamptz, '2026-06-13T12:25:31.858292+00:00'::timestamptz
);

-- Startup: Calendesk
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'calendesk', 'calendesk.com', 'Calendesk', 'B2B SaaS helping therapists, psychologists, and service businesses manage bookings, payments, and client relationships. Features: subscription packages, white-l', 'B2B SaaS helping therapists, psychologists, and service businesses manage bookings, payments, and client relationships. Features: subscription packages, white-label branding, client portals, API-first integration. For companies seeking predictable revenue, less admin work, and a professional brand—from solo practices to large networks. Bootstrapped.', 'https://d21oz30g4w22sz.cloudfront.net/logos/mpr-sp-z-o-o-ee093960-7b1c-46ce-9e60-8c1c2e6a2b14.png', 'https://calendesk.com',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2020, 'PL',
    NULL, 'maciejcupial', NULL,
    225, 2700, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/calendesk', '2026-06-13T12:25:35.747692+00:00'::timestamptz, '2026-06-13T12:25:35.747692+00:00'::timestamptz
);

-- Startup: ConvertLabs
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'convertlabs', 'convertlabs.io', 'ConvertLabs', 'We sell a SaaS product for booking and marketing for local service businesses.', 'We sell a SaaS product for booking and marketing for local service businesses.', 'https://files.stripe.com/links/MDB8YWNjdF8xQ0xGV0FJV2RTSGZrcWtnfGZsX2xpdmVfRmljTnlsQlVJQng1WnhPTzZodjhMbHAy00ZJwZIeOS', 'https://convertlabs.io',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2018, 'US',
    NULL, 'rohangilkes', NULL,
    345, 4140, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/convertlabs', '2026-06-13T12:25:39.690012+00:00'::timestamptz, '2026-06-13T12:25:39.690012+00:00'::timestamptz
);

-- Startup: Virlo
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'virlo', 'virlo.ai', 'Virlo', 'Track, manage, leverage short-form data.', 'Track, manage, leverage short-form data.', 'https://files.stripe.com/links/MDB8YWNjdF8xUU14SnRFSVZCdnIyazRVfGZsX2xpdmVfcHRZWm12ZUlPaDhxdDJYTzJkQWhJQzVK00BZwJTAnx', 'https://virlo.ai',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2024, 'US',
    NULL, 'bolcoto', NULL,
    365, 4380, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/virlo', '2026-06-13T12:25:43.755291+00:00'::timestamptz, '2026-06-13T12:25:43.755291+00:00'::timestamptz
);

-- Startup: davidtanasescu
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'davidtanasescu', 'davidtanasescu.com', 'davidtanasescu', '17-year-old Digital Architect building, learning, and experimenting with modern tech.

Influenced by Mark Tilbury, Elisha Longsword, Alex Hormozi and Emil Anton', '17-year-old Digital Architect building, learning, and experimenting with modern tech.

Influenced by Mark Tilbury, Elisha Longsword, Alex Hormozi and Emil Anton.

Contact: hello@davidtanasescu.com', 'https://d21oz30g4w22sz.cloudfront.net/logos/davidtanasescu-62733831-8dc9-4807-a6bb-6bb2d72c7d66.webp', 'https://davidtanasescu.com',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2024, 'BE',
    NULL, 'davidtanasescu', NULL,
    0, 0, 'USD', 1,
    ARRAY['nextjs', 'react', 'tailwindcss', 'typescript', 'cloudflare', 'docker', 'github-actions', 'paypal', 'nodejs', 'stripe', 'resend', 'postgresql', 'css', 'python', 'framer']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/davidtanasescu', '2026-06-13T12:25:47.648052+00:00'::timestamptz, '2026-06-13T12:25:47.648052+00:00'::timestamptz
);

-- Startup: Angel Match
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'angel-match', 'angelmatch.io', 'Angel Match', 'Angel Match is a database of 124,000 angels and VCs to raise your seed round.', 'Angel Match is a database of 124,000 angels and VCs to raise your seed round.', 'https://files.stripe.com/links/MDB8YWNjdF8xRHUzdFRKY0lUbHJyd3o2fGZsX2xpdmVfamxlZlh4b3UwYmxNNUZWV3NVU2oxcllF00iLQTJfsK', 'https://angelmatch.io',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2019, 'US',
    NULL, 'rashidkhasanov', NULL,
    256, 3072, 'USD', 1,
    ARRAY['nodejs', 'digitalocean', 'stripe']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/angel-match', '2026-06-13T12:25:52.541647+00:00'::timestamptz, '2026-06-13T12:25:52.541647+00:00'::timestamptz
);

-- Startup: Karma
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'karma', 'karmabot.chat', 'Karma', 'Karma is SaaS product, employee recognition and rewards system for Slack and Teams.', 'Karma is SaaS product, employee recognition and rewards system for Slack and Teams.', 'https://files.stripe.com/links/MDB8YWNjdF8xT1p0QlBJZXU2RnlyVmMxfGZsX2xpdmVfd2VXWGJVblZaTGEzQnV2QkFSdGhWcDYw00FH3cDZ0p', 'https://karmabot.chat',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2024, 'NZ',
    NULL, 'karmabot_chat', NULL,
    62, 744, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/karma', '2026-06-13T12:26:57.465144+00:00'::timestamptz, '2026-06-13T12:26:57.465144+00:00'::timestamptz
);

-- Startup: Saaspa.ge
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'pdb-online-diensten', 'saaspa.ge', 'Saaspa.ge', 'The Latest Startups And Submit Your Own For A Free DoFollow Backklink', 'The Latest Startups And Submit Your Own For A Free DoFollow Backklink', 'https://d21oz30g4w22sz.cloudfront.net/logos/pdb-online-diensten-17ef8ae4-8f5b-4e73-a7d9-7d3de48fed6c.png', 'https://saaspa.ge',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2024, 'NL',
    NULL, 'peedbr', NULL,
    15, 180, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/pdb-online-diensten', '2026-06-13T12:27:01.409605+00:00'::timestamptz, '2026-06-13T12:27:01.409605+00:00'::timestamptz
);

-- Startup: Crush AI
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'crush-ai', 'trycrush.ai', 'Crush AI', 'Crush analyzes competitors, generates creatives, and optimizes your spend to scale what works and turn off what doesn''t.', 'Crush analyzes competitors, generates creatives, and optimizes your spend to scale what works and turn off what doesn''t.', 'https://d21oz30g4w22sz.cloudfront.net/logos/uab-minderse-acff623c-53ad-4b0c-bc89-4854e520bc8f.png', 'https://trycrush.ai',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2026, 'LT',
    NULL, NULL, NULL,
    204, 2448, 'USD', 1,
    NULL, FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/crush-ai', '2026-06-13T12:27:05.291684+00:00'::timestamptz, '2026-06-13T12:27:05.291684+00:00'::timestamptz
);

-- Startup: SEO STACK
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'seo-stack', 'seo-stack.io', 'SEO STACK', 'SEO stack is an SEO/marketing SaaS that offers data warehousing with AI. It is a rebuild of Google search console with Google analytics, it allows SEOs and mark', 'SEO stack is an SEO/marketing SaaS that offers data warehousing with AI. It is a rebuild of Google search console with Google analytics, it allows SEOs and marketers to get better results in search engines and LLMs, it also provides AI and LLM visibility tracking.', 'https://files.stripe.com/links/MDB8YWNjdF8xTWI4eXJKbEd6dk1EV21lfGZsX2xpdmVfTGVCNDZwYlowczZ2YlFSazhoVFp4ZUR100R4RlULkR', 'https://www.seo-stack.io',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2021, 'GB',
    NULL, 'foley_seo', NULL,
    274, 3288, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/seo-stack', '2026-06-13T12:27:09.194870+00:00'::timestamptz, '2026-06-13T12:27:09.194870+00:00'::timestamptz
);

-- Startup: ColdSire
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'coldsire', 'coldsire.com', 'ColdSire', 'We help businesses scale outreach with premium cold email inboxes.', 'We help businesses scale outreach with premium cold email inboxes.', 'https://files.stripe.com/links/MDB8YWNjdF8xTjkxbExDZWR5akxMclBRfGZsX2xpdmVfaDM3aGpteUZpcVJ5dW1KN1dkbHk2Q0JL00uqGnE9T8', 'https://coldsire.com',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2023, 'US',
    NULL, 'imadbzni', NULL,
    207, 2484, 'USD', 1,
    ARRAY['supabase', 'react', 'railway', 'vercel']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/coldsire', '2026-06-13T12:27:13.335538+00:00'::timestamptz, '2026-06-13T12:27:13.335538+00:00'::timestamptz
);

-- Startup: WorkAny Bot
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'workany-bot', 'workany.ai', 'WorkAny Bot', 'WorkAny Bot is a cloud-based OpenClaw agent that works for you anytime, 7*24 online.', 'WorkAny Bot is a cloud-based OpenClaw agent that works for you anytime, 7*24 online.', 'https://d21oz30g4w22sz.cloudfront.net/logos/workany-a1a5d9ea-4514-48e0-97fd-c53513a81405.webp', 'https://workany.ai/bot',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2026, 'US',
    NULL, 'workanyai', NULL,
    5, 60, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/workany-bot', '2026-06-13T12:27:17.666911+00:00'::timestamptz, '2026-06-13T12:27:17.666911+00:00'::timestamptz
);

-- Startup: Yadaphone
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'yadaphone', 'yadaphone.com', 'Yadaphone', 'Cheap international calls in your browser', 'Cheap international calls in your browser', 'https://files.stripe.com/links/MDB8YWNjdF8xUXlVY2pHVkU3VnVJOG92fGZsX2xpdmVfWGpMTG5OSFp6RWtreTRpNU8yVFRtWGx000nynCEgt5', 'https://yadaphone.com',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2025, 'AT',
    NULL, NULL, NULL,
    10, 120, 'USD', 1,
    NULL, FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/yadaphone', '2026-06-13T12:27:22.467391+00:00'::timestamptz, '2026-06-13T12:27:22.467391+00:00'::timestamptz
);

-- Startup: BYQ Supply
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'byq-supply', 'byq.lemonsqueezy.com', 'BYQ Supply', 'Profitable, founder-runnable hybrid SaaS + Webflow component marketplace with a measurable wedge into AI coding tools. Currently 362 paying subscribers plus 79 ', 'Profitable, founder-runnable hybrid SaaS + Webflow component marketplace with a measurable wedge into AI coding tools. Currently 362 paying subscribers plus 79 lifetime customers; $91k all-time gross via LemonSqueezy. Webflow+Framer Marketplace template royalties and a growing Framer affiliate stream included (subject to platform re-onboarding).

Catalog & product: 2,155 hand-built Webflow components across 163 collections, 285 wireframes.', 'https://cdn.lemonsqueezy.com/avatars/stores/145343/QenEOivhzGzEifIGlV8WBnCgADpTNRi3EhTcuxaF.png?fit=contain&format=auto&height=100&ixlib=php-3.3.1&width=100', 'https://byq.lemonsqueezy.com',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2025, 'PL',
    NULL, 'byq_studio', NULL,
    72, 864, 'USD', 1,
    ARRAY['typescript']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/byq-supply', '2026-06-13T12:27:27.365660+00:00'::timestamptz, '2026-06-13T12:27:27.365660+00:00'::timestamptz
);

-- Startup: Private Location Intelligence API platform
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'private-location-intelligence-api-platform', 'besttime.app', 'Private Location Intelligence API platform', 'Global Foot Traffic (Venue Visitor) data platform. Helps to find lively social scenes efficiently, avoid crowds, automate city guides, or optimize visitor sched', 'Global Foot Traffic (Venue Visitor) data platform. Helps to find lively social scenes efficiently, avoid crowds, automate city guides, or optimize visitor schedules. It forecasts hourly busyness for millions of public places. Using anonymized GPS data, it shows venue visitor patterns and peaks. Includes tools to analyze and filter countries/ cities/ neighborhoods on (live) visitor patterns, venue type, ratings, visit duration, popularity, etc. Includes API to build 3rd party apps on top of it.', 'https://d21oz30g4w22sz.cloudfront.net/logos/private-location-intelligence-venture-7c5aa686-aeee-46da-95a0-16d8021033cf.png', 'https://besttime.app',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2020, 'SG',
    NULL, NULL, NULL,
    87, 1044, 'USD', 1,
    ARRAY['python', 'docker', 'javascript', 'postgresql']::text[], FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/private-location-intelligence-api-platform', '2026-06-13T12:27:31.310658+00:00'::timestamptz, '2026-06-13T12:27:31.310658+00:00'::timestamptz
);

-- Startup: StudyScout
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'studyscout', 'joinstudyscout.com', 'StudyScout', 'StudyScout is a B2C SaaS aggregating high-paying online studies and focus groups. $0 paid ads, growth is 100% organic. Proven viral, repeatable UGC engine with ', 'StudyScout is a B2C SaaS aggregating high-paying online studies and focus groups. $0 paid ads, growth is 100% organic. Proven viral, repeatable UGC engine with massive upside via scaling content, paid ads, and email marketing. Includes a 139k untapped email list. High-margin, lean operation with strong conversion and significant room to scale revenue quickly.

Selling to pursue other projects.', 'https://d21oz30g4w22sz.cloudfront.net/logos/studyscout-ade40c26-f515-446d-a040-bfa1a3e94fe4.png', 'https://www.joinstudyscout.com',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2026, 'US',
    NULL, 'swell_kid', NULL,
    112, 1344, 'USD', 1,
    ARRAY['nextjs', 'react']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/studyscout', '2026-06-13T12:27:35.351728+00:00'::timestamptz, '2026-06-13T12:27:35.351728+00:00'::timestamptz
);

-- Startup: MkSaaS, LLC
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'mksaas-llc', 'mksaas.com', 'MkSaaS, LLC', 'Our company offers software services, including web application templates for developers, enabling them to launch their applications much faster. It’s a one-tim', 'Our company offers software services, including web application templates for developers, enabling them to launch their applications much faster. It’s a one-time payment, with users charged upon purchasing the template code.', 'https://files.stripe.com/links/MDB8YWNjdF8xVDNvWExSZTdEOEVqcEozfGZsX2xpdmVfd0VNQ2ZGbEI4ejYza2l3NExpdzgxY3Fr00XZGwL3Ve', 'https://mksaas.com',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2026, 'US',
    NULL, 'indie_maker_fox', NULL,
    0, 0, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/mksaas-llc', '2026-06-13T12:27:39.263585+00:00'::timestamptz, '2026-06-13T12:27:39.263585+00:00'::timestamptz
);

-- Startup: BettrBot
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'bettrbot', 'bettrbot.com', 'BettrBot', 'BettrBot is a desktop app that automates blackjack basic strategy across 12 sweepstakes casino platforms (Stake, Pulsz, Chumba, LuckyLand, Modo, Shuffle, Gains,', 'BettrBot is a desktop app that automates blackjack basic strategy across 12 sweepstakes casino platforms (Stake, Pulsz, Chumba, LuckyLand, Modo, Shuffle, Gains, ClubsPoker, AceBet, and others)', 'https://d21oz30g4w22sz.cloudfront.net/logos/bettrbot-80a36634-c7b0-4042-8a92-0259dccb159f.png', 'https://bettrbot.com',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2026, 'US',
    NULL, NULL, NULL,
    0, 0, 'USD', 1,
    ARRAY['electron']::text[], FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/bettrbot', '2026-06-13T12:27:44.045236+00:00'::timestamptz, '2026-06-13T12:27:44.045236+00:00'::timestamptz
);

-- Startup: FriendFilter + GroupFilter
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'friendfilter-groupfilter', 'friendfilter.com', 'FriendFilter + GroupFilter', 'FriendFilter and GroupFilter are established Chrome extensions for Facebook friend and group management. $11.3K MRR / $135.6K ARR from ~390 subscribers. Stack: ', 'FriendFilter and GroupFilter are established Chrome extensions for Facebook friend and group management. $11.3K MRR / $135.6K ARR from ~390 subscribers. Stack: Rails, Vue.js, PostgreSQL. Recent v7.2.4 maintenance release. Bonus asset: 100K dormant email list (2019–present). Growth levers already built: CWS Featured badge renomination (submitted Q1 2026), SEO landing page, Rewardful affiliate program. Asset sale to buyer''s LLC. 30 days transition support included.', 'https://files.stripe.com/links/MDB8YWNjdF8xRUd2U2NGeEJlUVBrY0pifGZsX2xpdmVfYVA5VzlEdW9yT0FnT0RJT0k4dFFsR01I00w8A7ReGc', 'https://friendfilter.com',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2019, 'US',
    NULL, 'fpslebowski', NULL,
    100, 1200, 'USD', 1,
    ARRAY['rails', 'vue', 'postgresql', 'redis', 'digitalocean']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/friendfilter-groupfilter', '2026-06-13T12:27:47.977107+00:00'::timestamptz, '2026-06-13T12:27:47.977107+00:00'::timestamptz
);

-- Startup: ToneAdapt
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'toneadapt', 'toneadapt.com', 'ToneAdapt', 'Mobile iOS app launched April 12th, already at $3,600 MRR and $12,400 revenue as of May 7th with 322 subscribers and 268 trials.

$24,000 revenue in April.

Ton', 'Mobile iOS app launched April 12th, already at $3,600 MRR and $12,400 revenue as of May 7th with 322 subscribers and 268 trials.

$24,000 revenue in April.

ToneAdapt matches guitar tones to a user''s gear in under 30 seconds. With the largest, most accurate, and most detailed guitar + amp database on the internet, and over 100,000 registered users, the demand is there. This is a unique platform, the first of it''s kind. We own the entire guitar tone distribution channel on TikTok + Instagram.', 'https://files.stripe.com/links/MDB8YWNjdF8xU2J5UWZMbTJoYnBTeVNifGZsX2xpdmVfQ1JDd3pZb2RVTm52cWdnOXlVYTRFUXBC00UwqKZgMi', 'https://www.toneadapt.com',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2025, 'US',
    NULL, 'kyanbuilds', NULL,
    94, 1128, 'USD', 1,
    ARRAY['nextjs', 'supabase', 'stripe', 'vercel']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/toneadapt', '2026-06-13T12:27:51.891449+00:00'::timestamptz, '2026-06-13T12:27:51.891449+00:00'::timestamptz
);

-- Startup: Thinkly
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'thinkly', 'thinkly.pluglab.ai', 'Thinkly', 'Hire AI Avatar based Executive Assistant at 1/100 price of Human EA', 'Hire AI Avatar based Executive Assistant at 1/100 price of Human EA', NULL, 'https://thinkly.pluglab.ai',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2024, 'US',
    NULL, 'liampluglab', NULL,
    0, 0, 'USD', 1,
    ARRAY['nextjs', 'nodejs', 'postgresql', 'openai']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/thinkly', '2026-06-13T12:27:56.688357+00:00'::timestamptz, '2026-06-13T12:27:56.688357+00:00'::timestamptz
);

-- Startup: StoryHero
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'storyhero', 'storyhero.gg', 'StoryHero', 'StoryHero is an AI-powered SaaS that automatically turns long-form videos into short, viral-ready clips for TikTok, Instagram Reels, and YouTube Shorts. Creator', 'StoryHero is an AI-powered SaaS that automatically turns long-form videos into short, viral-ready clips for TikTok, Instagram Reels, and YouTube Shorts. Creators can upload a long-form video and generate multiple engaging clips with auto-detected highlights, captions, and vertical formatting in minutes.', 'https://d21oz30g4w22sz.cloudfront.net/logos/storyhero-44362b86-3ac1-4910-bc21-2cc65e9824f5.png', 'https://www.storyhero.gg',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2024, 'US',
    NULL, NULL, NULL,
    78, 936, 'USD', 1,
    ARRAY['nextjs', 'aws', 'docker', 'python', 'typescript', 'react']::text[], FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/storyhero', '2026-06-13T12:28:00.603016+00:00'::timestamptz, '2026-06-13T12:28:00.603016+00:00'::timestamptz
);

-- Startup: NextjobConnect LLC
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'nextjobconnect-llc', 'nextjobconnect.com', 'NextjobConnect LLC', 'Real-time job leads for home service contractors. Monitors neighborhood platforms, AI-classifies posts by trade, and alerts subscribers via iOS/Android app and ', 'Real-time job leads for home service contractors. Monitors neighborhood platforms, AI-classifies posts by trade, and alerts subscribers via iOS/Android app and SMS. Contractors get high intent leads. $79-$500/month flat subscriptions, 22 paying customers, $5K MRR. Customer acquisition via outbound sales, 75% gross margins. React Native app, FastAPI backend, Stripe billing. Fully built and running.', 'https://d21oz30g4w22sz.cloudfront.net/logos/nextjobconnect-llc-363401cc-3274-4800-b023-1fea501682f7.png', 'https://nextjobconnect.com',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2025, 'US',
    NULL, NULL, NULL,
    66, 792, 'USD', 1,
    ARRAY['react', 'python', 'sqlite', 'capacitor', 'firebase', 'stripe', 'twilio']::text[], FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/nextjobconnect-llc', '2026-06-13T12:28:04.493238+00:00'::timestamptz, '2026-06-13T12:28:04.493238+00:00'::timestamptz
);

-- Startup: lifeflexia
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'lifeflexia', 'lifeflexia.com', 'lifeflexia', 'LifeFlexIA — AI Lifestyle Image Generation SaaS
LifeFlexIA is a B2C SaaS similar to Halo AI, allowing users to generate ultra-realistic AI photos of themselves ', 'LifeFlexIA — AI Lifestyle Image Generation SaaS
LifeFlexIA is a B2C SaaS similar to Halo AI, allowing users to generate ultra-realistic AI photos of themselves in premium lifestyle settings — private jets, supercars, yachts, and more — in seconds.
Key metrics:

MRR : $7 000+
Gross margin : 94%
Net profit : ~$7 500/month
Paying active users : 550
Total users since launch : 1 040
Launched : April 2026
Zero ad spend — 100% organic TikTok
No freemium — 100% paying users

Massive untapped US market.', 'https://d21oz30g4w22sz.cloudfront.net/logos/lifeflexia-08b6f5c9-c3bd-465f-9d62-20e2f4b0808f.png', 'https://www.lifeflexia.com',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2026, 'FR',
    NULL, NULL, NULL,
    63, 756, 'USD', 1,
    NULL, FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/lifeflexia', '2026-06-13T12:28:08.385320+00:00'::timestamptz, '2026-06-13T12:28:08.385320+00:00'::timestamptz
);

-- Startup: TinyLaunch
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'tinylaunch', 'tinylaunch.com', 'TinyLaunch', 'Launch Today, Get a Badge & High Authority Backlink', 'Launch Today, Get a Badge & High Authority Backlink', 'https://files.stripe.com/links/MDB8YWNjdF8xUVhOak9LQkRMMkZqMFRPfGZsX2xpdmVfSnhLdTNDRnZEalZ2dG56VFUyN0dNd3lY00210KchJZ', 'https://www.tinylaunch.com',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2024, 'DE',
    NULL, 'chrissyinspace', NULL,
    0, 0, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/tinylaunch', '2026-06-13T12:28:12.291638+00:00'::timestamptz, '2026-06-13T12:28:12.291638+00:00'::timestamptz
);

-- Startup: Trackly c/o Changeflow Ltd
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'trackly-c-o-changeflow-ltd', 'trackly.io', 'Trackly c/o Changeflow Ltd', 'B2B SaS charged through Recurly', 'B2B SaS charged through Recurly', NULL, 'https://trackly.io',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2018, 'GB',
    NULL, 'stevewillbe', NULL,
    0, 0, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/trackly-c-o-changeflow-ltd', '2026-06-13T12:28:16.312386+00:00'::timestamptz, '2026-06-13T12:28:16.312386+00:00'::timestamptz
);

-- Startup: Zescale
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'zescale', 'zescale.co', 'Zescale', 'Zescale is an all-in-one AI platform that helps businesses create professional marketing visuals in minutes. From product photos and lookbooks to UGC videos and', 'Zescale is an all-in-one AI platform that helps businesses create professional marketing visuals in minutes. From product photos and lookbooks to UGC videos and ad creatives — everything you need to market your brand, without the cost of a studio or agency.', 'https://d21oz30g4w22sz.cloudfront.net/logos/simeo-3915ef98-400f-40e2-b46c-3ea355b9f14d.png', 'https://zescale.co',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2026, 'US',
    NULL, 'realtheoecom', NULL,
    55, 660, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/zescale', '2026-06-13T12:28:20.304794+00:00'::timestamptz, '2026-06-13T12:28:20.304794+00:00'::timestamptz
);

-- Startup: MobileAPI
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'mobileapi', 'mobileapi.dev', 'MobileAPI', 'MobileAPI.dev is a REST API that provides comprehensive device specifications, images, and pricing data for 30,000+ mobile devices from 200+ brands. It covers s', 'MobileAPI.dev is a REST API that provides comprehensive device specifications, images, and pricing data for 30,000+ mobile devices from 200+ brands. It covers smartphones, tablets, smartwatches, and laptops. Features include fuzzy search with match-certainty scoring, autocomplete, manufacturer filtering, and an AI-powered natural-language query endpoint. Free tier includes 200 requests/month. Pro plan at $15/month with 10,000 requests. API key authentication, HTTPS, CORS enabled.', 'https://d21oz30g4w22sz.cloudfront.net/logos/visian-systems-limited-bc5af619-5ab6-4000-92ea-1e5ba5b8888e.png', 'https://mobileapi.dev',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2022, 'GB',
    NULL, NULL, NULL,
    35, 420, 'USD', 1,
    ARRAY['html5', 'javascript', 'django', 'python', 'css', 'postgresql', 'docker', 'cloudflare', 'nginx', 'terraform', 'elasticsearch']::text[], FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/mobileapi', '2026-06-13T12:28:24.299452+00:00'::timestamptz, '2026-06-13T12:28:24.299452+00:00'::timestamptz
);

-- Startup: Terapi365
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'terapi365', 'terapi365.com', 'Terapi365', 'Terapi365 is a digital platform that allows therapists to manage their clients, appointments, notes, payments, and more from a single dashboard.', 'Terapi365 is a digital platform that allows therapists to manage their clients, appointments, notes, payments, and more from a single dashboard.', 'https://files.stripe.com/links/MDB8YWNjdF8xUmV6bk9BSTd0QUpxYXJjfGZsX2xpdmVfajB5RmxhZnBmR2JhczUxYUdycDZOYmJJ00vP38DsVu', 'https://terapi365.com',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2025, 'CA',
    NULL, NULL, NULL,
    1, 12, 'USD', 1,
    ARRAY['nextjs', 'supabase', 'stripe', 'resend', 'openai']::text[], FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/terapi365', '2026-06-13T12:28:29.215062+00:00'::timestamptz, '2026-06-13T12:28:29.215062+00:00'::timestamptz
);

-- Startup: gosimless
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'gosimless', 'gosimless.com', 'gosimless', 'gosimless provides virtual numbers for WhatsApp Business and other chat apps without needing a SIM card.', 'gosimless provides virtual numbers for WhatsApp Business and other chat apps without needing a SIM card.', 'https://files.stripe.com/links/MDB8YWNjdF8xTUlZUlhId0ZlQUJZSEZufGZsX2xpdmVfNXpVY1UxZlpBZWlEeU5iUkRSaW92cmsx00uGbmHQGW', 'https://www.gosimless.com',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2022, 'GB',
    NULL, 'gosimless', NULL,
    48, 576, 'USD', 1,
    ARRAY['nuxt', 'vercel', 'stripe', 'cloudflare', 'supabase']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/gosimless', '2026-06-13T12:28:33.113160+00:00'::timestamptz, '2026-06-13T12:28:33.113160+00:00'::timestamptz
);

-- Startup: xxxxxxx
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'xxxxxxx', 'bbc.com', 'xxxxxxx', 'xxxxxxx', NULL, 'https://www.appatar.io/com.nyneapps.evriwhere/small', 'https://bbc.com',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], NULL, 'GB',
    NULL, NULL, NULL,
    19, 228, 'USD', 1,
    NULL, FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/xxxxxxx', '2026-06-13T12:28:37.005783+00:00'::timestamptz, '2026-06-13T12:28:37.005783+00:00'::timestamptz
);

-- Startup: SetupClaw.xyz
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'setupclaw-xyz', 'setupclaw.xyz', 'SetupClaw.xyz', 'Sell AI Assistant in one click.', 'Sell AI Assistant in one click.', NULL, 'https://www.setupclaw.xyz',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2024, 'CH',
    NULL, 'sophienesaas', NULL,
    0, 0, 'USD', 1,
    ARRAY['nextjs']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/setupclaw-xyz', '2026-06-13T12:28:40.936116+00:00'::timestamptz, '2026-06-13T12:28:40.936116+00:00'::timestamptz
);

-- Startup: Scritches
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'scritches', 'scritches.io', 'Scritches', 'Scritches is modern pet sitting and dog walking software built to help solo and small-team providers keep their business organized without the stress of spreads', 'Scritches is modern pet sitting and dog walking software built to help solo and small-team providers keep their business organized without the stress of spreadsheets and text threads.', 'https://d21oz30g4w22sz.cloudfront.net/logos/scritches-software-llc-fd6bca17-b0e4-4fce-82d6-96597235ef26.png', 'https://scritches.io',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2024, 'US',
    NULL, NULL, NULL,
    35, 420, 'USD', 1,
    ARRAY['react', 'django', 'aws']::text[], FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/scritches', '2026-06-13T12:28:44.881976+00:00'::timestamptz, '2026-06-13T12:28:44.881976+00:00'::timestamptz
);

-- Startup: MyFrank
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'myfrank', 'myfrank.io', 'MyFrank', 'MyFrank is a B2B SaaS platform that helps businesses collect and manage Google reviews by actively engaging their teams.

Each review is attributed to a specifi', 'MyFrank is a B2B SaaS platform that helps businesses collect and manage Google reviews by actively engaging their teams.

Each review is attributed to a specific employee via QR codes, enabling challenges, rewards, and performance tracking across one or multiple locations.

The platform is designed for multi-site businesses (hospitality, retail, franchises) and focuses on increasing review volume, quality, and consistency while protecting brand reputation.', 'https://files.stripe.com/links/MDB8YWNjdF8xUFk3V1RGSmw5N1JOQ2RCfGZsX2xpdmVfalFqcFJkOXEyM1picTVwaDZlTmxOTlZ300Ga1dowKl', 'https://myfrank.io',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2025, 'FR',
    NULL, NULL, NULL,
    88, 1056, 'USD', 1,
    ARRAY['php', 'vue']::text[], FALSE, TRUE, FALSE,
    1, 3, 'https://trustmrr.com/myfrank', '2026-06-13T12:28:48.976987+00:00'::timestamptz, '2026-06-13T12:28:48.976987+00:00'::timestamptz
);

-- Startup: DropPop
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'droppop', 'droppop.io', 'DropPop', 'The #1 Dropshipping Tool to Automate Depop, Vinted, Etsy and Ebay with AI.
Your all-in-one tool for automating listings, generating descriptions, changing image', 'The #1 Dropshipping Tool to Automate Depop, Vinted, Etsy and Ebay with AI.
Your all-in-one tool for automating listings, generating descriptions, changing images, and fulfilling orders seamlessly.', 'https://d21oz30g4w22sz.cloudfront.net/logos/droppop-llc-7f624e57-8c54-4557-bfac-06f8b5b99000.png', 'https://droppop.io',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2025, 'US',
    NULL, 'alexbirle', NULL,
    294, 3528, 'USD', 1,
    ARRAY['react', 'javascript', 'supabase', 'cloudflare']::text[], FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/droppop', '2026-06-13T12:28:52.875159+00:00'::timestamptz, '2026-06-13T12:28:52.875159+00:00'::timestamptz
);

-- Startup: WilderTrips
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    'wildertrips', 'wildertrips.com', 'WilderTrips', 'Road trip planning software', 'Road trip planning software', 'https://files.stripe.com/links/MDB8YWNjdF8xTTJzdzhLdVQ1NmZtQTdBfGZsX2xpdmVfYjFnTWNxZlVCdTRBR1hkT0VQc2dSUjJO00GjeIX9S1', 'https://www.wildertrips.com',
    '116b074e-c5ad-4cdc-8968-4dc0cf57b2fc'::uuid, ARRAY['SaaS']::text[], 2022, 'GB',
    NULL, 'harry_ronchetti', NULL,
    47, 564, 'USD', 1,
    NULL, FALSE, TRUE, TRUE,
    1, 3, 'https://trustmrr.com/wildertrips', '2026-06-13T12:28:56.769993+00:00'::timestamptz, '2026-06-13T12:28:56.769993+00:00'::timestamptz
);

COMMIT;