# 💾 Skill: Data Storage & Persistence

## Overview
This skill provides instructions for the JSON-based data persistence layer that stores fetched articles and analysis results.

## 🛠️ Implementation Details
- **Main Script**: `data_store.py`
- **Storage Location**: `data/` directory
- **Files**: `news_data.json` (articles), `analysis_results.json` (analysis)

## 📁 Data Structure

### news_data.json
```json
{
  "metadata": {
    "fetched_at": "2026-04-16T23:30:00+00:00",
    "total_articles": 150,
    "sources": ["News18 Gujarati", "TV9 Gujarati", ...]
  },
  "articles": [
    {
      "source": "News18 Gujarati",
      "title": "Article title...",
      "url": "https://...",
      "published_at": "2026-04-16T22:30:00+00:00",
      "keywords": "election, bjp, gujarat",
      "publication_name": "News18 Gujarati",
      "image_url": "",
      "lastmod": "2026-04-16",
      "fetched_at": "2026-04-16T23:30:00+00:00"
    },
    ...
  ]
}
```

### analysis_results.json
```json
{
  "metadata": {
    "analyzed_at": "2026-04-16T23:31:00+00:00"
  },
  "results": {
    "summary": {...},
    "similar_articles": [...],
    "topic_clusters": {...},
    "keyword_comparison": {...},
    "coverage_gaps": {...},
    "first_publisher": {...}
  }
}
```

## 🔧 Key Functions

### `save_articles(articles, filepath)`
- Saves articles with metadata to JSON
- Overwrites previous data (each run is a fresh snapshot)
- Returns filepath saved to

### `load_articles(filepath)`
- Loads articles from JSON file
- Returns empty list if file not found or corrupt
- Logs warning if data file missing

### `save_analysis(results, filepath)`
- Saves analysis results with metadata
- Uses `default=str` for non-serializable objects

### `load_analysis(filepath)`
- Loads analysis results from JSON
- Returns None if file not found or corrupt

### `get_data_freshness()`
- Returns the `fetched_at` timestamp from metadata
- Returns None if no data cached

## 🚀 Execution
```bash
cd breaking-news-finder
python -c "
from data_store import load_articles, load_analysis
articles = load_articles()
analysis = load_analysis()
print(f'Loaded {len(articles)} articles')
"
```

## ⚠️ Constraints
- Each fetch run overwrites previous data (no append mode)
- Large datasets may take time to serialize/deserialize
- Always ensure `data/` directory exists before saving
