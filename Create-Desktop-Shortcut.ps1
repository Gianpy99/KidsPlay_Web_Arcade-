# Create Desktop Shortcut for KidsPlay Web Arcade
# This script creates a desktop shortcut with a custom icon

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  KidsPlay Desktop Shortcut Creator" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Get the desktop path
$desktopPath = [Environment]::GetFolderPath("Desktop")
Write-Host "Desktop path: $desktopPath" -ForegroundColor Yellow

# Define paths
$shortcutPath = Join-Path $desktopPath "KidsPlay Web Arcade.lnk"
$targetPath = Join-Path $PSScriptRoot "Launch-KidsPlay.ps1"
$iconPath = Join-Path $PSScriptRoot "KidsPlay.ico"

# Check if the launcher script exists
if (-not (Test-Path $targetPath)) {
    Write-Host "Error: Launch-KidsPlay.ps1 not found!" -ForegroundColor Red
    Write-Host "Expected location: $targetPath" -ForegroundColor Yellow
    exit 1
}

# Check if the icon exists
if (-not (Test-Path $iconPath)) {
    Write-Host "Warning: KidsPlay.ico not found at $iconPath" -ForegroundColor Yellow
    Write-Host "Creating icon..." -ForegroundColor Yellow
    
    # Try to create the icon
    $iconCreatorPath = Join-Path $PSScriptRoot "create_launcher_icon.py"
    if (Test-Path $iconCreatorPath) {
        & python $iconCreatorPath
        if (-not (Test-Path $iconPath)) {
            Write-Host "Warning: Could not create icon, shortcut will use default PowerShell icon" -ForegroundColor Yellow
            $iconPath = $null
        }
    } else {
        Write-Host "Warning: Icon creator script not found, using default icon" -ForegroundColor Yellow
        $iconPath = $null
    }
}

# Create the shortcut using WScript.Shell COM object
try {
    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($shortcutPath)
    
    # Set the target to PowerShell with the launch script
    $Shortcut.TargetPath = "powershell.exe"
    $Shortcut.Arguments = "-ExecutionPolicy Bypass -NoProfile -File `"$targetPath`""
    $Shortcut.WorkingDirectory = $PSScriptRoot
    $Shortcut.Description = "Launch KidsPlay Web Arcade - Educational games for kids"
    
    # Set the icon if available
    if ($iconPath) {
        $Shortcut.IconLocation = $iconPath
    }
    
    # Set to run minimized to reduce window clutter
    $Shortcut.WindowStyle = 1  # 1 = Normal, 3 = Maximized, 7 = Minimized
    
    # Save the shortcut
    $Shortcut.Save()
    
    Write-Host ""
    Write-Host "Success! Desktop shortcut created!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Shortcut details:" -ForegroundColor Cyan
    Write-Host "  Name: KidsPlay Web Arcade" -ForegroundColor White
    Write-Host "  Location: $shortcutPath" -ForegroundColor White
    if ($iconPath) {
        Write-Host "  Icon: $iconPath" -ForegroundColor White
    }
    Write-Host ""
    Write-Host "Double-click the shortcut on your desktop to:" -ForegroundColor Yellow
    Write-Host "  1. Start the KidsPlay server" -ForegroundColor White
    Write-Host "  2. Open the game in your browser automatically" -ForegroundColor White
    Write-Host ""
    Write-Host "Enjoy playing!" -ForegroundColor Green
    
} catch {
    Write-Host ""
    Write-Host "Error creating shortcut: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "You can manually create a shortcut:" -ForegroundColor Yellow
    Write-Host "  1. Right-click on Launch-KidsPlay.ps1" -ForegroundColor White
    Write-Host "  2. Select 'Create shortcut'" -ForegroundColor White
    Write-Host "  3. Move the shortcut to your desktop" -ForegroundColor White
    exit 1
}

Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
