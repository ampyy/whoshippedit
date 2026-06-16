-- ==========================================
-- schema_update.sql
-- Merges new tables and alters existing ones
-- ==========================================

-- 1. Alter existing users table to add new columns
ALTER TABLE users ADD COLUMN IF NOT EXISTS name varchar(100);
ALTER TABLE users ADD COLUMN IF NOT EXISTS twitter_handle varchar(50);
ALTER TABLE users ADD COLUMN IF NOT EXISTS linkedin_handle varchar(100);
ALTER TABLE users ADD COLUMN IF NOT EXISTS bio varchar(300);
ALTER TABLE users ADD COLUMN IF NOT EXISTS is_master_admin boolean default false;
ALTER TABLE users ADD COLUMN IF NOT EXISTS last_seen_at timestamptz;

-- Copy display_name to name just in case
UPDATE users SET name = display_name WHERE name IS NULL AND display_name IS NOT NULL;


-- 2. Drop existing ideas/votes tables to recreate them with smallint
DROP TABLE IF EXISTS idea_votes CASCADE;
DROP TABLE IF EXISTS ideas CASCADE;
DROP TABLE IF EXISTS milestones CASCADE;
DROP TABLE IF EXISTS customer_signals CASCADE;
DROP TABLE IF EXISTS comment_votes CASCADE;
DROP TABLE IF EXISTS comments CASCADE;
DROP TABLE IF EXISTS would_build_votes CASCADE;
DROP TABLE IF EXISTS votes CASCADE;
DROP TABLE IF EXISTS products CASCADE;

-- 3. Create Products Table
create table products (
  id              uuid primary key default gen_random_uuid(),
  slug            varchar(80) unique not null,
  domain          varchar(100) unique not null,
  name            varchar(100) not null,
  tagline         varchar(160) not null,
  description     text,
  logo_url        text,
  website_url     text not null,

  -- classification
  category_id     uuid references categories(id),
  tags            text[],
  founded_year    smallint,
  country_code    char(2),              -- "IN" "US" "GB"

  -- founder
  founder_name      varchar(100),
  founder_twitter   varchar(50),
  founder_linkedin  varchar(100),

  -- revenue (real numbers now)
  mrr               int,               -- 4250
  arr               int,               -- 51000
  currency          char(3) default 'USD',

  -- pricing (filterable)
  pricing_type      smallint,          -- 0=free 1=freemium 2=paid 3=one-time
  price_from        int,               -- 9
  price_to          int,               -- 99 (null if single plan)

  -- details
  tech_stack        text[],

  -- flags
  is_featured       boolean default false,
  is_verified       boolean default false,
  is_claimed        boolean default false,
  status            smallint default 0,
  source            smallint default 0,
  added_by          uuid references users(id),
  claimed_by        uuid references users(id),
  claimed_at        timestamptz,
  featured_until    timestamptz,
  created_at        timestamptz default now(),

  -- cached by triggers
  upvote_count      int default 0,
  comment_count     int default 0,
  would_build_yes   int default 0,
  would_build_no    int default 0
);

-- 4. Create Votes Table
create table votes (
  id          uuid primary key default gen_random_uuid(),
  product_id  uuid references products(id) on delete cascade,
  user_id     uuid references users(id) on delete cascade,
  created_at  timestamptz default now(),
  unique(product_id, user_id)
);

-- 5. Create Would Build Votes Table
create table would_build_votes (
  id          uuid primary key default gen_random_uuid(),
  product_id  uuid references products(id) on delete cascade,
  user_id     uuid references users(id) on delete cascade,
  vote        smallint not null,              -- 0=yes, 1=no
  created_at  timestamptz default now(),
  unique(product_id, user_id)
);

-- 6. Create Ideas Table (Recreated)
create table ideas (
  id              uuid primary key default gen_random_uuid(),
  slug            varchar(80) unique not null,
  title           varchar(160) not null,
  problem         text not null,
  target_customer varchar(200),
  proposed_price  varchar(100),
  category_id     uuid references categories(id),
  submitted_by    uuid references users(id) ON DELETE CASCADE,
  converted_to    uuid references products(id),
  status          smallint default 1,        -- 0=pending, 1=active, 2=removed
  created_at      timestamptz default now(),

  -- cached by triggers
  comment_count   int default 0,
  building_count  int default 0
);

-- 7. Create Idea Votes Table (Recreated)
create table idea_votes (
  id          uuid primary key default gen_random_uuid(),
  idea_id     uuid references ideas(id) on delete cascade,
  user_id     uuid references users(id) on delete cascade,
  vote        smallint not null,             -- 0=yes, 1=maybe, 2=no, 3=building
  created_at  timestamptz default now(),
  unique(idea_id, user_id)
);

-- 8. Create Comments Table
create table comments (
  id          uuid primary key default gen_random_uuid(),
  product_id  uuid references products(id) on delete cascade,
  idea_id     uuid references ideas(id) on delete cascade,
  user_id     uuid references users(id) on delete cascade,
  parent_id   uuid references comments(id) on delete cascade,
  body        text not null,
  upvote_count int default 0,
  status      smallint default 0,            -- 0=active, 1=flagged, 2=deleted
  created_at  timestamptz default now(),
  check (
    (product_id is not null and idea_id is null) or
    (product_id is null and idea_id is not null)
  )
);

-- 9. Create Comment Votes Table
create table comment_votes (
  id          uuid primary key default gen_random_uuid(),
  comment_id  uuid references comments(id) on delete cascade,
  user_id     uuid references users(id) on delete cascade,
  created_at  timestamptz default now(),
  unique(comment_id, user_id)
);

-- 10. Create Customer Signals Table
create table customer_signals (
  id          uuid primary key default gen_random_uuid(),
  product_id  uuid references products(id) on delete cascade,
  user_id     uuid references users(id) on delete cascade,
  type        smallint not null,             -- 0=customer, 1=building_similar
  created_at  timestamptz default now(),
  unique(product_id, user_id, type)
);

-- 11. Create Milestones Table
create table milestones (
  id          uuid primary key default gen_random_uuid(),
  product_id  uuid references products(id) on delete cascade,
  user_id     uuid references users(id) on delete cascade,
  value       varchar(100) not null,         -- "$1,234 MRR"
  note        varchar(300),
  is_approved boolean default false,
  created_at  timestamptz default now()
);

-- 12. Create Triggers

-- upvote count
create or replace function sync_upvote_count()
returns trigger as $$
begin
  if TG_OP = 'INSERT' then
    update products set upvote_count = upvote_count + 1 where id = NEW.product_id;
  elsif TG_OP = 'DELETE' then
    update products set upvote_count = upvote_count - 1 where id = OLD.product_id;
  end if;
  return null;
end;
$$ language plpgsql;

DROP TRIGGER IF EXISTS trg_upvote_count ON votes;
create trigger trg_upvote_count
after insert or delete on votes
for each row execute function sync_upvote_count();

-- comment count on products
create or replace function sync_comment_count()
returns trigger as $$
begin
  if TG_OP = 'INSERT' and NEW.product_id is not null then
    update products set comment_count = comment_count + 1 where id = NEW.product_id;
  elsif TG_OP = 'DELETE' and OLD.product_id is not null then
    update products set comment_count = comment_count - 1 where id = OLD.product_id;
  end if;
  if TG_OP = 'INSERT' and NEW.idea_id is not null then
    update ideas set comment_count = comment_count + 1 where id = NEW.idea_id;
  elsif TG_OP = 'DELETE' and OLD.idea_id is not null then
    update ideas set comment_count = comment_count - 1 where id = OLD.idea_id;
  end if;
  return null;
end;
$$ language plpgsql;

DROP TRIGGER IF EXISTS trg_comment_count ON comments;
create trigger trg_comment_count
after insert or delete on comments
for each row execute function sync_comment_count();

-- would build counts
create or replace function sync_would_build_count()
returns trigger as $$
begin
  if TG_OP = 'INSERT' then
    if NEW.vote = 0 then
      update products set would_build_yes = would_build_yes + 1 where id = NEW.product_id;
    else
      update products set would_build_no = would_build_no + 1 where id = NEW.product_id;
    end if;
  elsif TG_OP = 'DELETE' then
    if OLD.vote = 0 then
      update products set would_build_yes = would_build_yes - 1 where id = OLD.product_id;
    else
      update products set would_build_no = would_build_no - 1 where id = OLD.product_id;
    end if;
  elsif TG_OP = 'UPDATE' then
    if OLD.vote = 0 then
      update products set would_build_yes = would_build_yes - 1,
                          would_build_no = would_build_no + 1 where id = NEW.product_id;
    else
      update products set would_build_no = would_build_no - 1,
                          would_build_yes = would_build_yes + 1 where id = NEW.product_id;
    end if;
  end if;
  return null;
end;
$$ language plpgsql;

DROP TRIGGER IF EXISTS trg_would_build_count ON would_build_votes;
create trigger trg_would_build_count
after insert or delete or update on would_build_votes
for each row execute function sync_would_build_count();

-- building count on ideas
create or replace function sync_building_count()
returns trigger as $$
begin
  if TG_OP = 'INSERT' and NEW.vote = 3 then
    update ideas set building_count = building_count + 1 where id = NEW.idea_id;
  elsif TG_OP = 'DELETE' and OLD.vote = 3 then
    update ideas set building_count = building_count - 1 where id = OLD.idea_id;
  end if;
  return null;
end;
$$ language plpgsql;

DROP TRIGGER IF EXISTS trg_building_count ON idea_votes;
create trigger trg_building_count
after insert or delete on idea_votes
for each row execute function sync_building_count();

-- 13. Add data_source_url and updated_at to products
alter table products add column if not exists data_source_url text;
alter table products add column if not exists updated_at timestamptz default now();

-- auto-update updated_at on any change
create or replace function update_updated_at()
returns trigger as $$
begin
  NEW.updated_at = now();
  return NEW;
end;
$$ language plpgsql;

DROP TRIGGER IF EXISTS trg_updated_at ON products;
create trigger trg_updated_at
before update on products
for each row execute function update_updated_at();
