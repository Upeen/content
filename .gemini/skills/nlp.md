# 🧠 Skill: NLP Engine & Analysis Pipeline

## Overview
This skill provides instructions for the NLP/ML analysis pipeline that performs similarity detection, topic clustering, keyword extraction, coverage gap analysis, and first-publisher determination.

## 🛠️ Implementation Details
- **Main Script**: `nlp_engine.py`
- **Libraries**: scikit-learn (TF-IDF, cosine similarity, DBSCAN), pandas, numpy
- **Processing**: Chunked processing for large datasets (CHUNK_SIZE=500)

## 📊 Analysis Pipeline

### `run_full_analysis(articles)`
Main entry point that runs all analyses and returns a comprehensive results dictionary:
```python
results = {
    "summary": analyzer.generate_summary(),
    "similar_articles": analyzer.find_similar_articles()[:100],
    "topic_clusters": analyzer.cluster_topics(),
    "keyword_comparison": analyzer.keyword_comparison(),
    "coverage_gaps": analyzer.coverage_gap_analysis(),
    "first_publisher": analyzer.first_publisher_analysis(),
}
```

## 🔧 Key Functions

### Text Preprocessing
- `clean_text(text)`: Removes URLs, normalizes whitespace, lowercases
- `combine_article_text(article)`: Combines title + keywords for vectorization

### Similarity Detection
- `NewsAnalyzer.find_similar_articles()`: Uses TF-IDF + cosine similarity
- MIN_SIMILARITY_THRESHOLD = 0.35 (configurable)
- HIGH_SIMILARITY_THRESHOLD = 0.65 (likely duplicate)
- Only cross-source pairs are considered

### Topic Clustering
- `NewsAnalyzer.cluster_topics(eps=0.5, min_samples=2)`: DBSCAN on TF-IDF matrix
- Distance matrix = 1 - cosine_similarity
- Noise articles (label=-1) are skipped

### Keyword Analysis
- `NewsAnalyzer.extract_top_keywords(source=None)`: TF-IDF scores per term
- `NewsAnalyzer.keyword_comparison()`: Top keywords per competitor
- TOP_KEYWORDS_COUNT = 20 (config.py)

### Coverage Gap Analysis
- `NewsAnalyzer.coverage_gap_analysis()`: Unique vs missed keywords per source
- Compares each source against all others

### First Publisher Analysis
- `NewsAnalyzer.first_publisher_analysis()`: For similar pairs with timestamps
- Determines who published first and time gap in minutes

## ⚙️ Configuration (config.py)
```python
MIN_SIMILARITY_THRESHOLD = 0.35
HIGH_SIMILARITY_THRESHOLD = 0.65
TOP_KEYWORDS_COUNT = 20
NGRAM_RANGE = (1, 3)
CHUNK_SIZE = 500
```

## 🚀 Execution
```bash
cd breaking-news-finder
python -c "
from sitemap_parser import fetch_all_competitors
from nlp_engine import run_full_analysis
articles = fetch_all_competitors(hours=24)
results = run_full_analysis(articles)
print(f'Summary: {results[\"summary\"]}')"
```

## ⚠️ Constraints
- Large datasets (>500 articles) use chunked similarity computation to save memory
- DBSCAN eps parameter controls cluster sensitivity (higher = larger clusters)
- NLTK data is required for advanced text processing (if added later)
