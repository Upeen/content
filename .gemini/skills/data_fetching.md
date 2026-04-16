# 🌐 Skill: Data Fetching & Sitemap Parsing

## Overview
This skill provides instructions for the data fetching pipeline that collects articles from 6 Gujarati news competitor websites via their XML sitemaps.

## 🛠️ Implementation Details
- **Main Script**: `sitemap_parser.py`
- **Competitors**: News18 Gujarati, TV9 Gujarati, ABP Gujarati, Gujarat Samachar, Sandesh, Divya Bhaskar
- **Data Format**: XML sitemaps (Google News format and standard sitemap format)
- **Fetching Strategy**: Parallel fetch using ThreadPoolExecutor with 6 workers

## 📊 Data Flow
1. `fetch_all_competitors(hours=24)` is called from the sidebar button
2. For each competitor, `fetch_competitor_articles()` fetches the sitemap URL
3. If it's a sitemap index, child sitemaps are fetched (max 5)
4. `parse_news_sitemap()` extracts articles from XML
5. Articles are filtered by `cutoff_time` (last N hours)
6. All articles returned as list of dictionaries

## 🔧 Key Functions

### `fetch_url(url, retries=3)`
- Fetches URL content with retry logic and exponential backoff
- Uses browser User-Agent to avoid blocking
- Returns bytes content or None on failure

### `parse_news_sitemap(xml_content, source_name, cutoff_time)`
- Parses XML and extracts URL elements
- Auto-detects namespaces from root element
- Extracts: title, publication_date, keywords, loc (URL), lastmod, image_url

### `fetch_all_competitors(hours=24)`
- Main entry point for parallel fetching
- Returns combined list from all 6 competitors

## ⚙️ Configuration (config.py)
```python
COMPETITORS = {
    "News18 Gujarati": {"website": "...", "sitemap": "...", "color": "..."},
    # ... other competitors
}
REQUEST_TIMEOUT = 30
MAX_RETRIES = 3
RETRY_DELAY = 2
CHUNK_SIZE = 500
```

## 🚀 Execution
```bash
cd breaking-news-finder
python -c "from sitemap_parser import fetch_all_competitors; articles = fetch_all_competitors(hours=48); print(f'Fetched {len(articles)} articles')"
```

## ⚠️ Constraints
- Some sitemaps may use different namespace prefixes
- Articles without timestamps use URL path as title fallback
- Empty keywords field is normal for some sources
