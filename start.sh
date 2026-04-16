#!/bin/bash

# ===========================================
# Breaking News Finder - Startup Script
# Zee Gujarati Competitor Analysis Tool
# ===========================================

echo "📰 Breaking News Finder"
echo "========================"

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "🔧 Creating virtual environment..."
    python -m venv venv
fi

# Activate virtual environment
echo "📦 Activating virtual environment..."
source venv/Scripts/activate 2>/dev/null || source venv/bin/activate 2>/dev/null

# Install dependencies if needed
if [ ! -f ".packages_installed" ]; then
    echo "📥 Installing dependencies..."
    pip install -r requirements.txt
    touch .packages_installed
fi

# Check if data directory exists
if [ ! -d "data" ]; then
    echo "📁 Creating data directory..."
    mkdir -p data
fi

# Start Streamlit
echo "🚀 Starting Streamlit server..."
echo "🌐 Open http://localhost:8501 in your browser"
echo ""

streamlit run app.py --server.headless false --browser.gatherUsageStats false
