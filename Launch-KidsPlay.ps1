# KidsPlay Launcher - Start Server and Open Browser
# This script starts the Python server and automatically opens the game in the default browser

param(
    [switch]$NoOpen  # Optional parameter to skip opening the browser
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   KidsPlay Web Arcade Launcher" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Store the root directory
$rootDir = $PSScriptRoot

# Navigate to backend directory
$backendDir = Join-Path $rootDir "src\backend"
if (-not (Test-Path $backendDir)) {
    Write-Host "Error: Backend directory not found at: $backendDir" -ForegroundColor Red
    Write-Host "Press any key to exit..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Set-Location $backendDir

# Check if Python is installed
try {
    $pythonVersion = (& python --version) 2>&1
    Write-Host "Python detected: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: Python not found!" -ForegroundColor Red
    Write-Host "Please install Python 3.7 or higher from: https://www.python.org/downloads/" -ForegroundColor Yellow
    Write-Host "Press any key to exit..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# Check if dependencies are installed
Write-Host "Checking dependencies..." -ForegroundColor Yellow
if (Test-Path "requirements.txt") {
    try {
        & pip install -q -r requirements.txt
        Write-Host "Dependencies ready" -ForegroundColor Green
    } catch {
        Write-Host "Warning: Could not verify all dependencies" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Starting KidsPlay server..." -ForegroundColor Cyan

# Start the server in the background
$serverJob = Start-Job -ScriptBlock {
    param($backendPath)
    Set-Location $backendPath
    & python server.py
} -ArgumentList $backendDir

# Wait a moment for the server to start
Start-Sleep -Seconds 2

# Check if server started successfully
if ($serverJob.State -eq "Running") {
    Write-Host "Server started successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Game URL: http://localhost:8080" -ForegroundColor White
    Write-Host "Performance Dashboard: http://localhost:8080/debug/performance" -ForegroundColor White
    Write-Host ""
    
    # Open the browser unless -NoOpen is specified
    if (-not $NoOpen) {
        Write-Host "Opening KidsPlay in your browser..." -ForegroundColor Cyan
        Start-Sleep -Seconds 1
        Start-Process "http://localhost:8080"
    }
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  Server is running!" -ForegroundColor Green
    Write-Host "  Close this window to stop the server" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    
    # Keep the script running and show server output
    try {
        while ($serverJob.State -eq "Running") {
            Receive-Job $serverJob
            Start-Sleep -Seconds 1
        }
    } finally {
        # Cleanup when window is closed
        Write-Host ""
        Write-Host "Stopping server..." -ForegroundColor Yellow
        Stop-Job $serverJob
        Remove-Job $serverJob
        Set-Location $rootDir
        Write-Host "Server stopped." -ForegroundColor Red
    }
} else {
    Write-Host "Error: Server failed to start" -ForegroundColor Red
    Receive-Job $serverJob
    Remove-Job $serverJob
    Set-Location $rootDir
    Write-Host "Press any key to exit..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}
