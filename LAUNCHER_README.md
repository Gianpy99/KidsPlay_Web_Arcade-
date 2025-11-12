# KidsPlay Web Arcade - Desktop Launcher Setup

This directory contains the desktop launcher system for KidsPlay Web Arcade.

## 🎮 Quick Start

1. **Create Desktop Shortcut** (One-time setup):
   ```powershell
   .\Create-Desktop-Shortcut.ps1
   ```
   This creates a shortcut on your desktop with a custom icon.

2. **Launch KidsPlay**:
   - Double-click the "KidsPlay Web Arcade" shortcut on your desktop
   - OR run directly: `.\Launch-KidsPlay.ps1`

## 📁 Files

### Launch Scripts
- **`Launch-KidsPlay.ps1`** - Main launcher that starts the server and opens the browser
- **`Start-Server-Debug.ps1`** - Debug version with detailed performance monitoring
- **`Create-Desktop-Shortcut.ps1`** - Creates the desktop shortcut with custom icon

### Icon Files
- **`KidsPlay.ico`** - Windows icon file (multi-resolution)
- **`KidsPlay_Icon.png`** - PNG version of the icon (for reference)
- **`create_launcher_icon.py`** - Python script to regenerate the icon

## 🚀 Features

### Launch-KidsPlay.ps1
- ✅ Automatically starts the Python server
- ✅ Opens the game in your default browser
- ✅ Checks Python installation and dependencies
- ✅ Clean, user-friendly console output
- ✅ Closes server when you close the window

### Desktop Shortcut
- 🎨 Custom colorful game controller icon
- 🖱️ One-click launch from desktop
- 🔧 Automatic server management
- 🌐 Opens browser automatically

## 🎨 Icon Design

The KidsPlay icon features:
- Vibrant blue gradient background
- White game controller with colorful buttons
- Golden star accent
- Playful confetti circles
- Kid-friendly, modern design

## 🔧 Regenerating the Icon

If you want to customize the icon:

1. Install Pillow if not already installed:
   ```powershell
   pip install Pillow
   ```

2. Edit `create_launcher_icon.py` to customize colors, shapes, etc.

3. Run the icon generator:
   ```powershell
   python create_launcher_icon.py
   ```

4. Recreate the shortcut to apply the new icon:
   ```powershell
   .\Create-Desktop-Shortcut.ps1
   ```

## 📝 Notes

- The server runs on `http://localhost:8080`
- Performance dashboard available at `http://localhost:8080/debug/performance`
- Close the PowerShell window to stop the server
- The shortcut works even if you move the project folder (uses absolute paths)

## 🐛 Troubleshooting

**Shortcut doesn't work?**
- Right-click the shortcut → Properties
- Verify "Target" points to the correct Launch-KidsPlay.ps1 path
- Try running Launch-KidsPlay.ps1 directly first

**Icon not showing?**
- Run `python create_launcher_icon.py` to regenerate
- Run `.\Create-Desktop-Shortcut.ps1` again

**Server won't start?**
- Check that Python 3.7+ is installed: `python --version`
- Install dependencies: `pip install -r src\backend\requirements.txt`
- Check if port 8080 is already in use

## 🎯 Usage Examples

### Normal Launch (opens browser automatically)
```powershell
.\Launch-KidsPlay.ps1
```

### Launch without opening browser
```powershell
.\Launch-KidsPlay.ps1 -NoOpen
```

### Debug mode with performance monitoring
```powershell
.\Start-Server-Debug.ps1
```
