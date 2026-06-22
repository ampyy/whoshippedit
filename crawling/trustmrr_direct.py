import os
import json
import time
import uuid
import logging
import urllib.parse
from datetime import datetime, timezone
import requests
import psycopg2
from psycopg2.extras import execute_values

# Setup logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

# Constants
API_KEY = "tmrr_4ddf45eb4134f96ccadaa3cea594137b"
BASE_URL = "https://trustmrr.com/api/v1"
HEADERS = {"Authorization": f"Bearer {API_KEY}"}
RATE_LIMIT_INTERVAL = 3.0  # 3 seconds between details requests (20 requests/minute)

# Category Mapping (TrustMRR -> Local DB Slug)
CATEGORY_MAPPING = {
    "saas": "productivity",
    "artificial intelligence": "ai-tools",
    "ai": "ai-tools",
    "analytics": "analytics",
    "community": "community",
    "content creation": "content-writing",
    "content-creation": "content-writing",
    "crypto & web3": "finance",
    "crypto-web3": "finance",
    "customer support": "customer-support",
    "customer-support": "customer-support",
    "design tools": "productivity",
    "design-tools": "productivity",
    "developer tools": "developer-tools",
    "developer-tools": "developer-tools",
    "e-commerce": "ecommerce",
    "ecommerce": "ecommerce",
    "education": "productivity",
    "entertainment": "video-media",
    "fintech": "finance",
    "games": "video-media",
    "gaming": "video-media",
    "green tech": "productivity",
    "green-tech": "productivity",
    "health & fitness": "productivity",
    "health-fitness": "productivity",
    "iot & hardware": "developer-tools",
    "iot-hardware": "developer-tools",
    "legal": "security",
    "marketing": "marketing",
    "marketplace": "ecommerce",
    "mobile apps": "developer-tools",
    "mobile-apps": "developer-tools",
    "news & magazines": "content-writing",
    "news-magazines": "content-writing",
    "no-code": "no-code",
    "productivity": "productivity",
    "real estate": "finance",
    "real-estate": "finance",
    "recruiting & hr": "hr-recruiting",
    "recruiting": "hr-recruiting",
    "sales": "marketing",
    "security": "security",
    "social media": "social-media",
    "social-media": "social-media",
    "travel": "productivity",
    "utilities": "productivity",
    "email": "email",
    "seo": "seo",
    "scheduling": "scheduling",
    "monitoring": "monitoring",
    "payments-billing": "payments-billing",
    "forms-surveys": "forms-surveys",
    "boilerplates": "boilerplates",
    "directory-lists": "directory-lists",
    "chrome-extensions": "chrome-extensions",
    "apis-integrations": "apis-integrations",
    "lead-generation": "lead-generation",
    "video-media": "video-media",
}

def clean_domain(url: str) -> str:
    """Extract and clean domain from URL"""
    if not url:
        return ""
    try:
        parsed = urllib.parse.urlparse(url)
        domain = parsed.netloc or parsed.path
        domain = domain.lower().strip()
        if domain.startswith("www."):
            domain = domain[4:]
        return domain
    except Exception:
        return ""

def load_connection_string() -> str:
    """Load connection string from appsettings.Development.json"""
    path = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "whoshippedit", "appsettings.Development.json"))
    if not os.path.exists(path):
        path = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "appsettings.Development.json"))
    if os.path.exists(path):
        with open(path, "r") as f:
            config = json.load(f)
        return config["ConnectionStrings"]["DefaultConnection"]
    return "postgresql://neondb_owner:npg_lhyJ69BAnvRZ@ep-lively-lab-aqwysz14-pooler.c-8.us-east-1.aws.neon.tech/neondb?sslmode=require&channel_binding=require"

def get_existing_data(conn) -> tuple:
    """Get set of existing slugs and domains in the database"""
    with conn.cursor() as cur:
        cur.execute("SELECT slug, domain FROM products")
        rows = cur.fetchall()
        existing_slugs = {row[0].lower().strip() for row in rows if row[0]}
        existing_domains = {row[1].lower().strip() for row in rows if row[1]}
        
        # Also let's strip www. from existing domains for clean checking
        clean_existing_domains = set()
        for d in existing_domains:
            if d.startswith("www."):
                clean_existing_domains.add(d[4:])
            else:
                clean_existing_domains.add(d)
                
        return existing_slugs, clean_existing_domains

def get_db_categories(conn) -> dict:
    """Get category slug to ID mapping from database"""
    with conn.cursor() as cur:
        cur.execute("SELECT id, slug FROM categories")
        rows = cur.fetchall()
        return {row[1].lower().strip(): row[0] for row in rows}

def fetch_startups_list(page: int, limit: int = 50) -> dict:
    """Fetch paginated startups from TrustMRR API"""
    url = f"{BASE_URL}/startups"
    params = {"page": page, "limit": limit, "sort": "revenue-desc"}
    res = requests.get(url, headers=HEADERS, params=params)
    if res.status_code == 429:
        logger.warning("Rate limited on list endpoint. Sleeping 60s...")
        time.sleep(60)
        return fetch_startups_list(page, limit)
    res.raise_for_status()
    return res.json()

def fetch_startup_details(slug: str) -> dict:
    """Fetch detailed information for a single startup"""
    url = f"{BASE_URL}/startups/{slug}"
    res = requests.get(url, headers=HEADERS)
    if res.status_code == 429:
        logger.warning(f"Rate limited on detail {slug}. Sleeping 60s...")
        time.sleep(60)
        return fetch_startup_details(slug)
    res.raise_for_status()
    return res.json()

def main():
    # 1. Connect to Neon DB
    conn_str = load_connection_string()
    logger.info("Connecting to Neon Postgres...")
    conn = psycopg2.connect(conn_str)
    conn.autocommit = True
    
    try:
        # 2. Get existing slugs/domains and categories
        existing_slugs, existing_domains = get_existing_data(conn)
        db_categories = get_db_categories(conn)
        logger.info(f"Loaded {len(existing_slugs)} existing slugs and {len(existing_domains)} domains from database.")
        logger.info(f"Loaded {len(db_categories)} category mappings.")
        
        # 3. Find target SaaS startups from TrustMRR paginated API
        new_saas_startups = []
        page = 1
        has_more = True
        # Change this number to limit how many new startups you want to import from TrustMRR
        target_count = 10
        
        logger.info("Scanning TrustMRR API for new SaaS startups...")
        while has_more and len(new_saas_startups) < target_count:
            try:
                data = fetch_startups_list(page, limit=50)
                startups = data.get("data", [])
                meta = data.get("meta", {})
                has_more = meta.get("hasMore", False)
                
                for s in startups:
                    slug = (s.get("slug") or "").lower().strip()
                    category = (s.get("category") or "").lower().strip()
                    website = s.get("website") or ""
                    domain = clean_domain(website)
                    
                    # Filter for 'SaaS' category and check if already in DB
                    if category == "saas":
                        if slug in existing_slugs:
                            continue
                        if domain and domain in existing_domains:
                            continue
                            
                        # Add to our candidates list
                        new_saas_startups.append(s)
                        if len(new_saas_startups) >= target_count:
                            break
                            
                logger.info(f"Scanned page {page}. Found {len(new_saas_startups)} candidate SaaS startups so far.")
                page += 1
                time.sleep(1.0) # Polite delay
                
            except Exception as e:
                logger.error(f"Error scanning page {page}: {e}")
                break
                
        logger.info(f"Scan complete. Total candidate SaaS startups to enrich and import: {len(new_saas_startups)}")
        
        if not new_saas_startups:
            logger.info("No new startups found to import.")
            return

        # 4. Enrich and insert candidates one by one
        imported_count = 0
        for i, basic_startup in enumerate(new_saas_startups):
            slug = basic_startup.get("slug")
            logger.info(f"[{i+1}/{len(new_saas_startups)}] Enriching & importing: {slug}")
            
            try:
                # Fetch full details
                details_data = fetch_startup_details(slug)
                startup = details_data.get("data", {})
                
                # Check domain uniqueness again before inserting to avoid race conditions/double inserts
                website = startup.get("website", "")
                domain = clean_domain(website)
                if not domain:
                    logger.warning(f"Skipping {slug} due to empty/invalid website: {website}")
                    continue
                    
                # Re-verify slug/domain isn't imported during this run
                if slug in existing_slugs or domain in existing_domains:
                    logger.info(f"Skipping {slug} (already exists).")
                    continue
                
                # Extract and map fields
                name = startup.get("name", "").strip() or slug
                description = startup.get("description", "")
                tagline = description[:160] if description else name
                if not tagline:
                    tagline = name
                    
                # Category UUID mapping
                trustmrr_category = startup.get("category", "").lower().strip()
                mapped_slug = CATEGORY_MAPPING.get(trustmrr_category, "productivity")
                category_id = db_categories.get(mapped_slug)
                
                # Revenue conversions (cents to dollars)
                revenue = startup.get("revenue") or {}
                if not isinstance(revenue, dict):
                    revenue = {}
                mrr_cents = revenue.get("mrr", 0) or 0
                total_cents = revenue.get("total", 0) or 0
                mrr = int(round(mrr_cents / 100.0)) if mrr_cents else 0
                arr = int(round(total_cents / 100.0)) if total_cents else 0
                
                # Founder info
                founder_name = startup.get("founderName") or startup.get("founder_name")
                founder_twitter = startup.get("xHandle")
                founder_linkedin = startup.get("linkedin") or startup.get("founderLinkedin")
                
                # Founded Year
                founded_date = startup.get("foundedDate")
                founded_year = None
                if founded_date:
                    try:
                        founded_year = int(founded_date[:4])
                    except:
                        pass
                
                # Tech stack (extract slug from dicts)
                raw_tech = startup.get("techStack") or []
                tech_stack = []
                for t in raw_tech:
                    if isinstance(t, dict):
                        slug_val = t.get("slug")
                        if slug_val:
                            tech_stack.append(slug_val)
                    elif isinstance(t, str):
                        tech_stack.append(t)
                
                # Insert details directly
                with conn.cursor() as cur:
                    cur.execute("""
                        INSERT INTO products (
                            slug, domain, name, tagline, description, logo_url, website_url,
                            category_id, tags, founded_year, country_code,
                            founder_name, founder_twitter, founder_linkedin,
                            mrr, arr, currency, pricing_type,
                            tech_stack, is_featured, is_verified, is_claimed,
                            status, source, data_source_url, created_at, updated_at
                        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                    """, (
                        slug,
                        domain,
                        name,
                        tagline,
                        description,
                        startup.get("icon"), # logo_url
                        website,
                        category_id,
                        [startup.get("category")] if startup.get("category") else None,
                        founded_year,
                        (startup.get("country") or "")[:2],
                        founder_name,
                        founder_twitter,
                        founder_linkedin,
                        mrr,
                        arr,
                        "USD",
                        1, # PricingType = 1 (Freemium/Subscription)
                        tech_stack,
                        False, # is_featured
                        True,  # is_verified
                        bool(founder_twitter or founder_name), # is_claimed
                        1,     # status = Approved
                        3,     # source = Scraped
                        f"https://trustmrr.com/{slug}",
                        datetime.now(timezone.utc),
                        datetime.now(timezone.utc)
                    ))
                
                # Update our sets to prevent duplicates in current run
                existing_slugs.add(slug)
                existing_domains.add(domain)
                imported_count += 1
                
                # Respect rate limit
                time.sleep(RATE_LIMIT_INTERVAL)
                
            except Exception as e:
                logger.error(f"Failed to import {slug}: {e}")
                try:
                    conn.rollback()
                except Exception:
                    pass
                
                # Check for database/SSL connection closure to reconnect automatically
                err_msg = str(e).lower()
                if "closed" in err_msg or "ssl" in err_msg or "connection" in err_msg:
                    logger.info("Attempting to reconnect to database...")
                    try:
                        conn.close()
                    except:
                        pass
                    try:
                        conn = psycopg2.connect(conn_str)
                        conn.autocommit = True
                        logger.info("Reconnection successful.")
                    except Exception as re:
                        logger.error(f"Failed to reconnect: {re}")
                
        logger.info(f"Incremental import finished successfully. Imported {imported_count} new SaaS products.")
        
    finally:
        conn.close()

if __name__ == "__main__":
    main()
