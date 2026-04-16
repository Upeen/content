# 📰 Breaking News Finder

**Zee Gujarati Competitor Content Intelligence & Gap Analysis Tool**

## Project Goal

Monitor and analyze how competing Gujarati news publishers cover stories. Track who breaks news first, identify duplicate content across competitors, and find coverage gaps.

---

## 🚀 Quick Start

### Option 1: PowerShell Script (Windows)
```powershell
.\start.ps1
```

### Option 2: Bash Script (WSL/Linux/Mac)
```bash
./start.sh
```

### Option 3: Manual Start
```bash
cd breaking-news-finder
pip install -r requirements.txt
streamlit run app.py
```

Then open **http://localhost:8501** in your browser.

---

## 📋 Features

### 🏁 Coverage Race Tab
- Date range filter + Source filter
- Combination word search across all columns
- **Podium Display**: Medal icons (🥇🥈🥉) for fastest publishers
- Timeline table + Chronological feed table
- URL links for all articles

### 🔁 Duplicate Content Tab
- Date range filter + Source filter
- Story cards sorted by duplicate % (descending)
- Medal rankings (up to 7 publishers per story)
- Duplicate Score badges with color coding
- Summary table with all URLs
- CSV export with Duplicate_Sr_no. (DUP101, DUP102...)

### Color Coding
- **Gold (≥80%)**: Very high duplicate similarity
- **Red (≥50%)**: High duplicate similarity
- **Blue (<50%)**: Moderate duplicate similarity

---

## 📡 Competitors Monitored

1. News18 Gujarati
2. TV9 Gujarati
3. ABP Gujarati
4. Gujarat Samachar
5. Sandesh
6. Divya Bhaskar

---

## 📁 Project Structure

```
breaking-news-finder/
├── app.py                   # Main Streamlit dashboard
├── config.py                # Competitor URLs & settings
├── sitemap_parser.py        # Sitemap fetching & parsing
├── nlp_engine.py            # NLP analysis engine
├── data_store.py            # JSON persistence
├── requirements.txt         # Python dependencies
├── data/                    # Cached articles & analysis
├── .gemini/skills/          # Skill documentation
├── PROJECT_DOCUMENTATION.md # Full project documentation
├── start.sh                 # Bash startup script
└── start.ps1               # PowerShell startup script
```

---

## ⚙️ Requirements

- Python 3.8+
- Dependencies: streamlit, requests, lxml, pandas, scikit-learn, nltk, beautifulsoup4, plotly, python-dateutil, chardet, openpyxl

---

## 🔧 Configuration

Edit `config.py` to modify:
- Competitor sitemap URLs
- Request timeout and retry settings
- NLP similarity thresholds
- Lookback window (default: 48 hours)

### Key Settings

| Setting | Default | Description |
|---------|---------|-------------|
| `MIN_SIMILARITY_THRESHOLD` | 0.35 | Minimum similarity for duplicate detection |
| `HIGH_SIMILARITY_THRESHOLD` | 0.65 | High similarity indicator |
| `TOP_KEYWORDS_COUNT` | 20 | Keywords to extract per competitor |
| `NGRAM_RANGE` | (1, 3) | N-gram range for TF-IDF |

---

## 📖 Documentation

See `PROJECT_DOCUMENTATION.md` for full documentation including:
- Tab functionality details
- Data flow & logic
- NLP analysis pipeline
- Duplicate detection algorithm
- Technical decisions
