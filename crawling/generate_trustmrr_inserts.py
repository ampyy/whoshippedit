import os
import json
import time
import urllib.parse
import hashlib
from datetime import datetime, timezone
import requests
import psycopg2
import boto3
from botocore.config import Config

# Constants
API_KEY = "tmrr_4ddf45eb4134f96ccadaa3cea594137b"
BASE_URL = "https://trustmrr.com/api/v1"
HEADERS = {"Authorization": f"Bearer {API_KEY}"}
RATE_LIMIT_INTERVAL = 3.0  # 3 seconds between details requests (20 requests/minute)
LIMIT_STARTUPS = 5        # Limit to 5 startups for verification
OUTPUT_SQL_FILE = "trustmrr_5_saas.sql"

# Cloudflare R2 Credentials
R2_ACCOUNT_ID = "4577d62d1819c60f155979837bea93dd"
R2_ACCESS_KEY_ID = "ab99c1d5dc3e3838e43f7222fd38c9c3"
R2_SECRET_ACCESS_KEY = "491a092d79b4f2358031d61be34e6dcaed54a3fde19c2c384b04d3d512824940"
R2_BUCKET_NAME = "whoshippedit-logos"
R2_PUBLIC_URL_PREFIX = "https://pub-1793ba9684fc438a893cc5c062df259b.r2.dev"

MIME_TYPES = {
    "png": "image/png",
    "jpg": "image/jpeg",
    "jpeg": "image/jpeg",
    "webp": "image/webp",
    "svg": "image/svg+xml"
}

# Initialize Boto3 client for R2
try:
    s3_client = boto3.client(
        service_name="s3",
        endpoint_url=f"https://{R2_ACCOUNT_ID}.r2.cloudflarestorage.com",
        aws_access_key_id=R2_ACCESS_KEY_ID,
        aws_secret_access_key=R2_SECRET_ACCESS_KEY,
        config=Config(signature_version="s3v4"),
        region_name="auto"
    )
except Exception as e:
    print(f"Error initializing R2 boto3 client: {e}")
    s3_client = None

# Category Mapping (TrustMRR -> Local DB Slug)
CATEGORY_MAP = {
    # direct matches
    'Analytics':           'analytics',
    'Community':           'community',
    'Education':           'education',
    'Fintech':             'finance',
    'Marketing':           'marketing',
    'No-Code':             'no-code',
    'Productivity':        'productivity',
    'Security':            'security',
    
    # merges into existing
    'Artificial Intelligence': 'ai-tools',
    'Developer Tools':         'developer-tools',
    'E-commerce':              'ecommerce',
    'Recruiting & HR':         'hr-recruiting',
    'Social Media':            'social-media',
    'Customer Support':        'customer-support',
    
    # new categories you just added
    'Content Creation':    'content-creation',
    'Design Tools':        'design-tools',
    'Sales':               'sales',
    'Health & Fitness':    'health-fitness',
    'Mobile Apps':         'mobile-apps',
    'News & Magazines':    'news-media',
    'Utilities':           'utilities',
    
    'Crypto & Web3':       None,
    'Green Tech':          None,
    'IoT & Hardware':      None,
    'Real Estate':         None,
    'Travel':              None,
    'Games':               None,
    'Entertainment':       None,
    'SaaS':                None,
    'Marketplace':         None,
}

CATEGORY_MAPPING = {k.lower(): v for k, v in CATEGORY_MAP.items()}

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
    path = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "appsettings.Development.json"))
    with open(path, "r") as f:
        config = json.load(f)
    return config["ConnectionStrings"]["DefaultConnection"]

def get_existing_data(conn) -> tuple:
    """Get set of existing slugs and domains in the database"""
    with conn.cursor() as cur:
        cur.execute("SELECT slug, domain FROM products")
        rows = cur.fetchall()
        existing_slugs = {row[0].lower().strip() for row in rows if row[0]}
        existing_domains = {row[1].lower().strip() for row in rows if row[1]}
        
        # Strip www. from existing domains for clean checking
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
        print("Rate limited on list endpoint. Sleeping 60s...")
        time.sleep(60)
        return fetch_startups_list(page, limit)
    res.raise_for_status()
    return res.json()

def fetch_startup_details(slug: str) -> dict:
    """Fetch detailed information for a single startup"""
    url = f"{BASE_URL}/startups/{slug}"
    res = requests.get(url, headers=HEADERS)
    if res.status_code == 429:
        print(f"Rate limited on detail {slug}. Sleeping 60s...")
        time.sleep(60)
        return fetch_startup_details(slug)
    res.raise_for_status()
    return res.json()

def escape_sql_string(val: str) -> str:
    """Escape string for postgres SQL literal"""
    if val is None:
        return "NULL"
    escaped = str(val).replace("'", "''")
    return f"'{escaped}'"

def escape_sql_value(val) -> str:
    """Escape generic Python types for SQL"""
    if val is None:
        return "NULL"
    if isinstance(val, bool):
        return "TRUE" if val else "FALSE"
    if isinstance(val, (int, float)):
        return str(val)
    return escape_sql_string(val)

def format_sql_array(lst) -> str:
    """Format python list as PostgreSQL text array syntax"""
    if not lst:
        return "NULL"
    items = []
    for x in lst:
        if x:
            items.append(f"'{str(x).replace("'", "''")}'")
    if not items:
        return "NULL"
    return f"ARRAY[{', '.join(items)}]::text[]"

def download_logo(logo_url: str, slug: str) -> str:
    """Download logo image from URL and upload to Cloudflare R2"""
    if not logo_url:
        return None
    
    print(f"  [Logo] Downloading from: {logo_url}")
    try:
        # Download logo bytes
        res = requests.get(logo_url, timeout=10)
        res.raise_for_status()
        content = res.content
        
        # Compute md5 hash of content
        file_hash = hashlib.md5(content).hexdigest()[:8]
        
        # Determine file extension
        # First check response headers
        content_type = res.headers.get("content-type", "").lower()
        ext = None
        if "png" in content_type:
            ext = "png"
        elif "jpeg" in content_type or "jpg" in content_type:
            ext = "jpg"
        elif "webp" in content_type:
            ext = "webp"
        elif "svg" in content_type:
            ext = "svg"
        
        # Fallback to parsing URL if content-type headers didn't match
        if not ext:
            parsed = urllib.parse.urlparse(logo_url)
            url_path = parsed.path
            url_ext = os.path.splitext(url_path)[1].lower()
            if url_ext:
                ext = url_ext.replace(".", "")
        
        # Final fallback to png
        if not ext or len(ext) > 5:
            ext = "png"
            
        # Clean extension if any query parameters
        if "?" in ext:
            ext = ext.split("?")[0]
            
        # Generate filename: {slug}_{hash}.{ext}
        filename = f"{slug}_{file_hash}.{ext}"
        
        # Determine S3 ContentType metadata
        s3_content_type = MIME_TYPES.get(ext, "application/octet-stream")
        
        print(f"  [Logo] Uploading '{filename}' to R2 bucket '{R2_BUCKET_NAME}' as '{s3_content_type}'...")
        if not s3_client:
            raise Exception("boto3 client not initialized")
            
        s3_client.put_object(
            Bucket=R2_BUCKET_NAME,
            Key=filename,
            Body=content,
            ContentType=s3_content_type
        )
        
        r2_url = f"{R2_PUBLIC_URL_PREFIX}/{filename}"
        print(f"  [Logo] Uploaded successfully: {r2_url}")
        return r2_url
    except Exception as e:
        print(f"  [Logo] Failed to download/upload logo: {e}")
        return logo_url  # Fallback to CDN URL if download/upload fails

def main():
    # 1. Connect to Neon DB to gather schema metadata
    conn_str = load_connection_string()
    print("Connecting to Neon Postgres to fetch existing data...")
    conn = psycopg2.connect(conn_str)
    
    try:
        existing_slugs, existing_domains = get_existing_data(conn)
        db_categories = get_db_categories(conn)
        print(f"Loaded {len(existing_slugs)} existing slugs and {len(existing_domains)} domains.")
        print(f"Loaded {len(db_categories)} category mappings.")
    finally:
        conn.close()
        
    # 2. Find target SaaS startups from TrustMRR API
    new_saas_startups = []
    page = 1
    has_more = True
    
    print("Scanning TrustMRR API for new SaaS startups...")
    while has_more and len(new_saas_startups) < LIMIT_STARTUPS:
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
                        
                    new_saas_startups.append(s)
                    if len(new_saas_startups) >= LIMIT_STARTUPS:
                        break
                        
            print(f"Scanned page {page}. Found {len(new_saas_startups)}/{LIMIT_STARTUPS} candidates so far.")
            page += 1
            time.sleep(1.0)
            
        except Exception as e:
            print(f"Error scanning page {page}: {e}")
            break
            
    print(f"\nScan complete. Total candidate SaaS startups to enrich: {len(new_saas_startups)}")
    if not new_saas_startups:
        print("No new startups found to generate SQL for.")
        return

    # 3. Enrich candidates and write INSERT SQL statements to file
    sql_inserts = []
    
    # Write header
    sql_inserts.append("-- ============================================")
    sql_inserts.append("-- TrustMRR SaaS Startups Data Import (Manual)")
    sql_inserts.append(f"-- Generated: {datetime.now(timezone.utc).strftime('%Y-%m-%d %H:%M:%S UTC')}")
    sql_inserts.append(f"-- Total Startups: {len(new_saas_startups)}")
    sql_inserts.append("-- ============================================\n")
    sql_inserts.append("BEGIN;\n")
    
    for i, basic_startup in enumerate(new_saas_startups):
        slug = basic_startup.get("slug")
        print(f"[{i+1}/{len(new_saas_startups)}] Enriching: {slug}...")
        
        try:
            details_data = fetch_startup_details(slug)
            startup = details_data.get("data") or {}
            
            website = startup.get("website") or ""
            domain = clean_domain(website)
            if not domain:
                print(f"  Skipping {slug} due to empty/invalid website: {website}")
                continue
                
            name = startup.get("name", "").strip() or slug
            description = startup.get("description", "")
            tagline = description[:160] if description else name
            if not tagline:
                tagline = name
                
            trustmrr_category = (startup.get("category") or "").lower().strip()
            mapped_slug = CATEGORY_MAPPING.get(trustmrr_category, "productivity")
            category_id = db_categories.get(mapped_slug)
            
            revenue = startup.get("revenue") or {}
            if not isinstance(revenue, dict):
                revenue = {}
            mrr_cents = revenue.get("mrr", 0) or 0
            mrr = int(round(mrr_cents / 100.0)) if mrr_cents else 0
            arr = mrr * 12
            
            founder_name = startup.get("founderName") or startup.get("founder_name")
            founder_twitter = startup.get("xHandle")
            founder_linkedin = startup.get("linkedin") or startup.get("founderLinkedin")
            
            founded_date = startup.get("foundedDate")
            founded_year = "NULL"
            if founded_date:
                try:
                    founded_year = str(int(founded_date[:4]))
                except:
                    pass
            
            raw_tech = startup.get("techStack") or []
            tech_stack = []
            for t in raw_tech:
                if isinstance(t, dict):
                    slug_val = t.get("slug")
                    if slug_val:
                        tech_stack.append(slug_val)
                elif isinstance(t, str):
                    tech_stack.append(t)
                    
            # Download and upload logo to R2
            raw_logo_url = startup.get("icon")
            r2_logo_url = download_logo(raw_logo_url, slug)
            
            # Format fields for SQL statement
            sql_slug = escape_sql_string(slug)
            sql_domain = escape_sql_string(domain)
            sql_name = escape_sql_string(name)
            sql_tagline = escape_sql_string(tagline)
            sql_desc = escape_sql_value(description)
            sql_logo = escape_sql_value(r2_logo_url)
            sql_web = escape_sql_string(website)
            sql_cat_id = f"'{category_id}'::uuid" if category_id else "NULL"
            sql_tags = format_sql_array([startup.get("category")] if startup.get("category") else None)
            sql_country = escape_sql_value((startup.get("country") or "")[:2])
            sql_f_name = escape_sql_value(founder_name)
            sql_f_tw = escape_sql_value(founder_twitter)
            sql_f_li = escape_sql_value(founder_linkedin)
            sql_mrr = str(mrr)
            sql_arr = str(arr)
            sql_tech = format_sql_array(tech_stack)
            sql_is_claimed = "TRUE" if founder_twitter or founder_name else "FALSE"
            sql_ds_url = escape_sql_string(f"https://trustmrr.com/{slug}")
            sql_now = f"'{datetime.now(timezone.utc).isoformat()}'::timestamptz"
            
            insert_stmt = f"""-- Startup: {name}
INSERT INTO products (
    slug, domain, name, tagline, description, logo_url, website_url,
    category_id, tags, founded_year, country_code,
    founder_name, founder_twitter, founder_linkedin,
    mrr, arr, currency, pricing_type,
    tech_stack, is_featured, is_verified, is_claimed,
    status, source, data_source_url, created_at, updated_at
) VALUES (
    {sql_slug}, {sql_domain}, {sql_name}, {sql_tagline}, {sql_desc}, {sql_logo}, {sql_web},
    {sql_cat_id}, {sql_tags}, {founded_year}, {sql_country},
    {sql_f_name}, {sql_f_tw}, {sql_f_li},
    {sql_mrr}, {sql_arr}, 'USD', 1,
    {sql_tech}, FALSE, TRUE, {sql_is_claimed},
    1, 3, {sql_ds_url}, {sql_now}, {sql_now}
);
"""
            sql_inserts.append(insert_stmt)
            time.sleep(RATE_LIMIT_INTERVAL)
            
        except Exception as e:
            print(f"  Failed to process {slug}: {e}")
            
    sql_inserts.append("COMMIT;")
    
    # Save SQL file
    output_path = os.path.join(os.path.dirname(__file__), OUTPUT_SQL_FILE)
    with open(output_path, "w", encoding="utf-8") as f:
        f.write("\n".join(sql_inserts))
        
    print(f"\n✅ Successfully generated clean SQL insert queries for 50 SaaS startups.")
    print(f"📝 Output file: {output_path}")
    print("You can now review the file and execute it manually on Neon!")

if __name__ == "__main__":
    main()
