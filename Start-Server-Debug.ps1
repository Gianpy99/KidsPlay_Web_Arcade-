# KidsPlay Server Setup and Start Script with Performance Monitoring
# This script installs dependencies and starts the server with enhanced monitoring

Write-Host "KidsPlay Server - Setup & Start with Performance Monitoring" -ForegroundColor Cyan
Write-Host "================================================================" -ForegroundColor Cyan

# Check if we're in the right directory
$currentDir = Get-Location
Write-Host "Current directory: $currentDir" -ForegroundColor Yellow

# Navigate to backend directory
$backendDir = Join-Path $PSScriptRoot "src\backend"
if (Test-Path $backendDir) {
    Set-Location $backendDir
    Write-Host "Changed to backend directory: $backendDir" -ForegroundColor Green
} else {
    Write-Host "Backend directory not found: $backendDir" -ForegroundColor Red
    exit 1
}

# Check if Python is installed
try {
    $pythonVersion = (& python --version) 2>&1
    Write-Host "Python found: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "Python not found. Please install Python 3.7 or higher." -ForegroundColor Red
    Write-Host "   Download from: https://www.python.org/downloads/" -ForegroundColor Yellow
    exit 1
}

# Install requirements
Write-Host "Installing Python dependencies..." -ForegroundColor Yellow
if (Test-Path "requirements.txt") {
    try {
        & pip install -r requirements.txt
        Write-Host "Dependencies installed successfully" -ForegroundColor Green
    } catch {
        Write-Host "Error installing dependencies: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "   Trying to install psutil manually..." -ForegroundColor Yellow
        & pip install psutil
    }
} else {
    Write-Host "requirements.txt not found, installing psutil manually..." -ForegroundColor Yellow
    & pip install psutil
}

# Create logs directory if it doesn't exist
$logsDir = Join-Path $PSScriptRoot "logs"
if (-not (Test-Path $logsDir)) {
    New-Item -ItemType Directory -Path $logsDir -Force | Out-Null
    Write-Host "Created logs directory: $logsDir" -ForegroundColor Green
}

# Display monitoring information
Write-Host ""
Write-Host "Performance Monitoring Features:" -ForegroundColor Cyan
Write-Host "   • Real-time request timing and system resource monitoring" -ForegroundColor White
Write-Host "   • Automatic detection of slow requests (>500ms)" -ForegroundColor White
Write-Host "   • System CPU and memory usage tracking" -ForegroundColor White
Write-Host "   • Detailed logging to: logs\server_performance.log" -ForegroundColor White
Write-Host "   • Web dashboard: http://localhost:8080/debug/performance" -ForegroundColor White
Write-Host "   • Performance stats API: http://localhost:8080/debug/performance" -ForegroundColor White
Write-Host ""

Write-Host "Starting KidsPlay server with performance monitoring..." -ForegroundColor Green
Write-Host ""

# Start the server
try {
    & python server.py
} catch {
    Write-Host "Error starting server: $($_.Exception.Message)" -ForegroundColor Red
    Set-Location $currentDir
    exit 1
} finally {
    # Return to original directory
    Set-Location $currentDir
}

Write-Host ""
Write-Host "KidsPlay server stopped. Check logs/server_performance.log for detailed performance data." -ForegroundColor Yellow
