# Breaking News Finder - Project Documentation

## Project Goal

**Breaking News Finder** is a competitor content intelligence dashboard for **Zee Gujarati** that monitors and analyzes how competing Gujarati news publishers cover stories. The tool tracks:

- Who breaks news first (Coverage Race)
- Duplicate content across competitors (who re-publishes whose content)
- Coverage gaps (stories missed by certain competitors)

This enables editorial teams to understand competitive positioning, identify content theft/copying, and find gaps in their coverage.

---

## Competitors Monitored

| Publisher | Website | Sitemap URL |
|-----------|---------|-------------|
| News18 Gujarati | https://gujarati.news18.com/ | news18_sitemap_url |
| TV9 Gujarati | https://tv9gujarati.com/ | tv9_sitemap_url |
| ABP Gujarati | https://gujarati.abplive.com/ | abp_sitemap_url |
| Gujarat Samachar | https://www.gujaratsamachar.com/ | gujaratsamachar_sitemap_url |
| Sandesh | https://sandesh.com/ | sandesh_sitemap_url |
| Divya Bhaskar | https://www.divyabhaskar.co.in/ | divyabhaskar_sitemap_url |

---

## Tabs & Functionality

### 1. 🏁 Coverage Race Tab

**Purpose**: Shows which competitor published each story first, with time gaps.

**Features**:
- **Filters**: Date range picker + Source selector dropdown
- **Search**: Text search across title, keywords, source, and URL
- **Podium Display**: Medal icons (🥇🥈🥉) for top 3 fastest publishers per story
- **Timeline Table**: Chronological list of stories with first publisher
- **Chronological Feed**: All articles sorted by publish time with URL links

**Logic**:
1. Articles are keyed by first 50 characters of title
2. First publish time determines the "winner" for each story
3. All competitors who covered the same story are ranked by their publish time
4. Time gap calculated as difference from earliest publisher

---

### 2. 🔁 Duplicate Content Tab

**Purpose**: Identifies articles that are duplicates/copies across different competitors.

**Features**:
- **Filters**: Date range picker + Source selector dropdown
- **Story Cards**: Grouped cards showing duplicate stories sorted by duplicate %
- **Medal Rankings**: Up to 7 publishers per story ranked by publish time
- **Duplicate Score Badge**: Color-coded percentage (gold ≥80%, red ≥50%, blue <50%)
- **Per-Story Tables**: Individual tables for each story with publish time, source, URL
- **Summary Table**: All duplicates with Duplicate_Sr_no. (DUP101, DUP102...), URL links, duplicate %
- **CSV Download**: Export all data as CSV

**Logic**:
1. Similar articles retrieved from NLP analysis (`similar_articles`)
2. Pairs are grouped by title prefix (first 50 chars)
3. Within each group, unique publishers extracted (deduplication)
4. Publishers ranked by publish time (earliest = first)
5. Sorted by highest duplicate % descending
6. DUP serial numbers start from 101

---

## Data Flow & Logic

### Data Fetching Pipeline

```
Sitemap URLs → sitemap_parser.py → Articles → JSON Cache
                                        ↓
                                  NLP Engine
                                        ↓
                              Similar Articles + Keywords
                                        ↓
                                  JSON Analysis Cache
```

1. **sitemap_parser.py** fetches sitemaps for all competitors
2. Parses article metadata (title, URL, published_at, source)
3. Saves raw articles to `data/news_data.json`
4. **nlp_engine.py** performs similarity analysis
5. Results saved to `data/analysis_results.json`

---

### NLP Analysis Pipeline

**File**: `nlp_engine.py`

1. **Text Preparation**: Combines title + keywords for TF-IDF input
2. **TF-IDF Vectorization**: Converts text to numerical vectors
3. **Cosine Similarity**: Computes pairwise similarity between articles
4. **DBSCAN Clustering**: Groups similar articles into topics
5. **Keyword Extraction**: Top n-grams per competitor via TF-IDF

**Key Thresholds** (from `config.py`):
- `MIN_SIMILARITY_THRESHOLD = 0.35` - Minimum to consider articles similar
- `HIGH_SIMILARITY_THRESHOLD = 0.65` - High similarity indicator

---

### Duplicate Detection Logic

```python
# Simplified duplicate detection flow
for pair in similar_articles:
    a1, a2 = pair["article_1"], pair["article_2"]
    key1, key2 = a1["title"][:50], a2["title"][:50]
    topic_key = min(key1, key2)  # Group by story
    
    # Track unique publishers per story
    if topic_key not in topic_groups:
        topic_groups[topic_key] = []
    
    # Add both articles to the group
    topic_groups[topic_key].append({
        "article": a1,
        "ts": parse_ts(a1["published_at"]),
        "similarity": pair["similarity_score"]
    })
```

---

### Key Technical Decisions

1. **Title Prefix (50 chars)**: Used as story identifier to handle minor title variations
2. **48-Hour Lookback**: Default window to focus on recent/breaking news
3. **Datetime Handling**: `.dt` accessor requires `notna()` check before use
4. **Medal Icons**: Up to 7 per story (🥇🥈🥉4️⃣5️⃣6️⃣7️⃣)
5. **DUP Serial Format**: DUP101, DUP102... (starts at 101)

---

## Project Structure

```
breaking-news-finder/
├── app.py              # Main Streamlit dashboard (all UI)
├── config.py           # Competitor URLs, NLP thresholds
├── sitemap_parser.py   # Sitemap fetching & parsing
├── nlp_engine.py      # NLP analysis (TF-IDF, similarity, clustering)
├── data_store.py      # JSON persistence layer
├── requirements.txt   # Dependencies
├── data/              # Cached JSON files
│   ├── news_data.json         # Raw articles
│   └── analysis_results.json  # NLP results
├── .gemini/skills/    # Skill documentation
│   ├── ui.md
│   ├── data_fetching.md
│   ├── nlp.md
│   └── data_storage.md
├── start.sh           # Bash startup script
└── start.ps1          # PowerShell startup script
```

---

## Dependencies

- **streamlit** - Web UI framework
- **pandas** - Data manipulation
- **plotly** - Interactive charts
- **requests** - HTTP requests
- **lxml** - XML parsing
- **beautifulsoup4** - HTML parsing
- **scikit-learn** - TF-IDF, cosine similarity, DBSCAN
- **nltk** - Text processing
- **openpyxl** - Excel export
- **python-dateutil** - Date parsing

---

## Configuration Options

Edit `config.py` to modify:

| Setting | Default | Description |
|---------|---------|-------------|
| `REQUEST_TIMEOUT` | 30 | HTTP request timeout (seconds) |
| `MAX_RETRIES` | 3 | Number of retry attempts |
| `CHUNK_SIZE` | 500 | Articles per processing chunk |
| `MIN_SIMILARITY_THRESHOLD` | 0.35 | Minimum similarity for duplicate detection |
| `HIGH_SIMILARITY_THRESHOLD` | 0.65 | High similarity indicator |
| `TOP_KEYWORDS_COUNT` | 20 | Keywords to extract per competitor |
| `NGRAM_RANGE` | (1, 3) | N-gram range for TF-IDF |

---

## Running the Application

### Quick Start

```powershell
.\start.ps1
```

Or:

```bash
./start.sh
```

### Manual Start

```bash
cd breaking-news-finder
pip install -r requirements.txt
streamlit run app.py
```

Open **http://localhost:8501** in your browser.

---

## UI Features

- **Dark Theme**: Glassmorphism styling with gradient backgrounds
- **Inter Font**: Google Fonts Inter for modern typography
- **Medal Icons**: Visual ranking indicators for publishers
- **Color-Coded Scores**: Gold (≥80%), Red (≥50%), Blue (<50%)
- **Responsive Cards**: Hover animations and transitions
- **Container Width Tables**: Full-width data tables
