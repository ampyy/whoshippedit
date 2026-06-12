-- ============================================================
--  WhoShippedIt — Database Schema
--  PostgreSQL
--  Last updated: 2026-06-01
-- ============================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";


-- ============================================================
--  TABLE: users
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
    id              uuid            PRIMARY KEY DEFAULT gen_random_uuid(),
    email           varchar(255)    UNIQUE NOT NULL,
    display_name    varchar(100),
    avatar_url      varchar(500),
    password_hash   varchar(72),                -- bcrypt output is always ≤72 chars
    email_verified  boolean         NOT NULL DEFAULT true,
    last_login_at   timestamptz,
    created_at      timestamptz     NOT NULL DEFAULT now(),
    updated_at      timestamptz     NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_users_email ON users (email);

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();


-- ============================================================
--  TABLE: magic_link_tokens
--  Short-lived, single-use tokens sent via email.
-- ============================================================
CREATE TABLE IF NOT EXISTS magic_link_tokens (
    id          uuid            PRIMARY KEY DEFAULT gen_random_uuid(),
    email       varchar(255)    NOT NULL,
    token       varchar(128)    UNIQUE NOT NULL,    -- 64-byte crypto-random, hex-encoded
    redirect_to varchar(2048),
    expires_at  timestamptz     NOT NULL DEFAULT (now() + interval '15 minutes'),
    used_at     timestamptz,
    created_at  timestamptz     NOT NULL DEFAULT now()
);

-- Single index on email only — tokens are single-use lookups by token (PK scan is fine),
-- email index is useful for "resend" and cleanup queries
CREATE INDEX IF NOT EXISTS idx_magic_link_tokens_email ON magic_link_tokens (email);


-- ============================================================
--  TABLE: user_sessions
--  Server-side session records for audit / sign-out-all.
-- ============================================================
CREATE TABLE IF NOT EXISTS user_sessions (
    id              uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         uuid        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    session_token   varchar(128) UNIQUE NOT NULL,
    ip_address      varchar(45),
    user_agent      varchar(512),
    last_seen_at    timestamptz NOT NULL DEFAULT now(),
    expires_at      timestamptz NOT NULL,
    created_at      timestamptz NOT NULL DEFAULT now()
);

-- Only one index: fetching active sessions for a user (sign out all, profile page)
CREATE INDEX IF NOT EXISTS idx_user_sessions_user_id ON user_sessions (user_id);


-- ============================================================
--  CLEANUP HELPERS
-- ============================================================

-- View to inspect expired/used tokens
CREATE OR REPLACE VIEW expired_magic_links AS
    SELECT * FROM magic_link_tokens
    WHERE expires_at < now() OR used_at IS NOT NULL;

-- Periodically run this to keep the table clean:
-- DELETE FROM magic_link_tokens WHERE expires_at < now() OR used_at IS NOT NULL;
-- DELETE FROM user_sessions WHERE expires_at < now();

-- ============================================================
--  TABLE: ideas (Validate Idea Feature)
-- ============================================================
CREATE TABLE IF NOT EXISTS ideas (
  id              uuid primary key default gen_random_uuid(),
  slug            varchar(100) unique not null,
  title           varchar(80) not null,
  problem         varchar(300) not null,
  target_customer varchar(255) not null,
  proposed_price  varchar(50) not null,
  category_id     uuid, -- References Categories if added later
  submitted_by    uuid references users(id) ON DELETE CASCADE,
  converted_to    uuid, -- References Products if converted later
  status          varchar(20) default 'active',
  created_at      timestamptz default now()
);

-- ============================================================
--  TABLE: idea_votes
-- ============================================================
CREATE TABLE IF NOT EXISTS idea_votes (
  id         uuid primary key default gen_random_uuid(),
  idea_id    uuid references ideas(id) ON DELETE CASCADE,
  user_id    uuid references users(id) ON DELETE CASCADE,
  vote       varchar(20) not null, -- "pay_9", "pay_19", "pay_49", "no", "building"
  created_at timestamptz default now(),
  unique(idea_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_ideas_slug ON ideas (slug);
CREATE INDEX IF NOT EXISTS idx_ideas_created_at ON ideas (created_at DESC);
CREATE INDEX IF NOT EXISTS idx_idea_votes_idea_id ON idea_votes (idea_id);


-- Table
create table categories (
  id          uuid primary key default gen_random_uuid(),
  name        text not null,
  slug        text unique not null,
  description text,
  icon        text,          -- lucide icon name
  sort_order  int default 0,
  created_at  timestamptz default now()
);

-- Insert queries
insert into categories (name, slug, description, icon, sort_order) values
('Analytics',          'analytics',          'Track, measure and visualize data',                    'BarChart2',       1),
('Developer Tools',    'developer-tools',    'Tools built for developers and engineers',             'Code2',           2),
('Marketing',          'marketing',          'Grow and reach your audience',                         'Megaphone',       3),
('SEO',                'seo',                'Search engine optimization and content ranking',        'Search',          4),
('Email',              'email',              'Email sending, tracking and automation',               'Mail',            5),
('AI Tools',           'ai-tools',           'Products powered by AI and LLMs',                     'Sparkles',        6),
('Productivity',       'productivity',       'Get more done, faster',                               'Zap',             7),
('Forms & Surveys',    'forms-surveys',      'Collect data, feedback and responses',                 'ClipboardList',   8),
('Payments & Billing', 'payments-billing',   'Accept payments, manage subscriptions',               'CreditCard',      9),
('Customer Support',   'customer-support',   'Help desks, live chat, ticketing',                    'MessageCircle',   10),
('Content & Writing',  'content-writing',    'Write, edit and publish content',                     'PenLine',         11),
('Social Media',       'social-media',       'Schedule, grow and manage social accounts',           'Share2',          12),
('Scheduling',         'scheduling',         'Booking, calendar and appointment tools',             'CalendarDays',    13),
('E-commerce',         'ecommerce',          'Sell products and manage online stores',              'ShoppingBag',     14),
('Monitoring',         'monitoring',         'Uptime, errors, logs and alerts',                     'Activity',        15),
('HR & Recruiting',    'hr-recruiting',      'Hire, onboard and manage teams',                      'Users',           16),
('Finance',            'finance',            'Accounting, invoicing and financial tools',           'DollarSign',      17),
('No-Code',            'no-code',            'Build without writing code',                          'Blocks',          18),
('Security',           'security',           'Auth, compliance and data protection',                'ShieldCheck',     19),
('Directory & Lists',  'directory-lists',    'Curated databases and resource directories',          'List',            20);-- Table
create table categories (
  id          uuid primary key default gen_random_uuid(),
  name        text not null,
  slug        text unique not null,
  description text,
  icon        text,          -- lucide icon name
  sort_order  int default 0,
  created_at  timestamptz default now()
);

-- Insert queries
insert into categories (name, slug, description, icon, sort_order) values
('Analytics',          'analytics',          'Track, measure and visualize data',                    'BarChart2',       1),
('Developer Tools',    'developer-tools',    'Tools built for developers and engineers',             'Code2',           2),
('Marketing',          'marketing',          'Grow and reach your audience',                         'Megaphone',       3),
('SEO',                'seo',                'Search engine optimization and content ranking',        'Search',          4),
('Email',              'email',              'Email sending, tracking and automation',               'Mail',            5),
('AI Tools',           'ai-tools',           'Products powered by AI and LLMs',                     'Sparkles',        6),
('Productivity',       'productivity',       'Get more done, faster',                               'Zap',             7),
('Forms & Surveys',    'forms-surveys',      'Collect data, feedback and responses',                 'ClipboardList',   8),
('Payments & Billing', 'payments-billing',   'Accept payments, manage subscriptions',               'CreditCard',      9),
('Customer Support',   'customer-support',   'Help desks, live chat, ticketing',                    'MessageCircle',   10),
('Content & Writing',  'content-writing',    'Write, edit and publish content',                     'PenLine',         11),
('Social Media',       'social-media',       'Schedule, grow and manage social accounts',           'Share2',          12),
('Scheduling',         'scheduling',         'Booking, calendar and appointment tools',             'CalendarDays',    13),
('E-commerce',         'ecommerce',          'Sell products and manage online stores',              'ShoppingBag',     14),
('Monitoring',         'monitoring',         'Uptime, errors, logs and alerts',                     'Activity',        15),
('HR & Recruiting',    'hr-recruiting',      'Hire, onboard and manage teams',                      'Users',           16),
('Finance',            'finance',            'Accounting, invoicing and financial tools',           'DollarSign',      17),
('No-Code',            'no-code',            'Build without writing code',                          'Blocks',          18),
('Security',           'security',           'Auth, compliance and data protection',                'ShieldCheck',     19),
('Directory & Lists',  'directory-lists',    'Curated databases and resource directories',          'List',            20);
