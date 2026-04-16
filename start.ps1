# ===========================================
# Breaking News Finder - Startup Script
# Zee Gujarati Competitor Analysis Tool
# ===========================================

Write-Host ""
Write-Host "📰 Breaking News Finder" -ForegroundColor Cyan
Write-Host "========================" -ForegroundColor Cyan
Write-Host ""

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ScriptDir

# Check if virtual environment exists
if (-not (Test-Path "venv")) {
    Write-Host "🔧 Creating virtual environment..." -ForegroundColor Yellow
    python -m venv venv
}

# Activate virtual environment
Write-Host "📦 Activating virtual environment..." -ForegroundColor Yellow
& "$ScriptDir\venv\Scripts\Activate.ps1" 2>$null
if ($LASTEXITCODE -ne 0) {
    & "$ScriptDir\venv\Scripts\Activate.bat" 2>$null
}

# Install dependencies if needed
if (-not (Test-Path ".packages_installed")) {
    Write-Host "📥 Installing dependencies..." -ForegroundColor Yellow
    pip install -r requirements.txt
    New-Item -ItemType File -Path ".packages_installed" -Force | Out-Null
}

# Check if data directory exists
if (-not (Test-Path "data")) {
    Write-Host "📁 Creating data directory..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path "data" -Force | Out-Null
}

# Start Streamlit
Write-Host "🚀 Starting Streamlit server..." -ForegroundColor Green
Write-Host "🌐 Open http://localhost:8501 in your browser" -ForegroundColor Green
Write-Host ""

streamlit run app.py --server.headless false --browser.gatherUsageStats false

# Deactivate virtual environment on exit
if (Test-Path "venv\Scripts\Activate.ps1") {
    deactivate 2>$null
}
