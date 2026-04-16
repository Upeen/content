"""
Configuration for Breaking News Finder - Competitor Sitemap Sources
"""

COMPETITORS = {
    "News18 Gujarati": {
        "website": "https://gujarati.news18.com/",
        "sitemap": "https://gujarati.news18.com/commonfeeds/v1/guj/sitemap-index.xml",
        "color": "#E53935",
    },
    "TV9 Gujarati": {
        "website": "https://tv9gujarati.com/",
        "sitemap": "https://tv9gujarati.com/news-sitemap.xml",
        "color": "#1E88E5",
    },
    "ABP Gujarati": {
        "website": "https://gujarati.abplive.com/",
        "sitemap": "https://gujarati.abplive.com/news-sitemap.xml",
        "color": "#43A047",
    },
    "Gujarat Samachar": {
        "website": "https://www.gujaratsamachar.com/",
        "sitemap": "https://www.gujaratsamachar.com/sitemap.xml",
        "color": "#FB8C00",
    },
    "Sandesh": {
        "website": "https://sandesh.com/",
        "sitemap": "https://sandesh.com/top-10.xml",
        "color": "#8E24AA",
    },
    "Divya Bhaskar": {
        "website": "https://www.divyabhaskar.co.in/",
        "sitemap": "https://www.divyabhaskar.co.in/sitemaps-v1--sitemap-google-news-1.xml",
        "color": "#00897B",
    },
}

# Data storage
DATA_DIR = "data"
JSON_STORE_FILE = "data/news_data.json"
ANALYSIS_STORE_FILE = "data/analysis_results.json"

# Parsing settings
REQUEST_TIMEOUT = 30
MAX_RETRIES = 3
RETRY_DELAY = 2
CHUNK_SIZE = 500  # Process articles in chunks for memory optimization

# NLP settings
MIN_SIMILARITY_THRESHOLD = 0.35
HIGH_SIMILARITY_THRESHOLD = 0.65
TOP_KEYWORDS_COUNT = 20
NGRAM_RANGE = (1, 3)
