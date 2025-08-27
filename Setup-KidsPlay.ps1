# KidsPlay Setup Script - PowerShell Version
# Version: 2.0
# Date: August 27, 2025

Write-Host "🎮 KidsPlay Setup System v2.0" -ForegroundColor Green
Write-Host "==============================" -ForegroundColor Green

# Function to create directory structure
function Create-ProjectStructure {
    Write-Host "🏗️ Creating project structure..." -ForegroundColor Yellow
    
    $directories = @(
        "config",
        "games\educational\snake",
        "games\educational\memory-letters", 
        "games\educational\math-easy",
        "games\educational\letter-hunt",
        "games\educational\number-block",
        "games\educational\push-block",
        "games\adventure\blockworld",
        "games\adventure\speedy-adventures",
        "games\adventure\dino-explorer",
        "common\core",
        "common\styles",
        "assets\sounds",
        "assets\images", 
        "assets\fonts",
        "setup-modules",
        "dist"
    )
    
    foreach ($dir in $directories) {
        $fullPath = Join-Path $PWD $dir
        if (!(Test-Path $fullPath)) {
            New-Item -ItemType Directory -Path $fullPath -Force | Out-Null
            Write-Host "   ✓ Created: $dir" -ForegroundColor Gray
        }
    }
}

# Function to create main index.html
function Create-MainIndex {
    Write-Host "📄 Creating main index.html..." -ForegroundColor Yellow
    
    $indexContent = @"
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KidsPlay - Giochi Educativi</title>
    <link rel="stylesheet" href="common/styles/base.css">
    <link rel="stylesheet" href="common/styles/mobile.css">
    <link rel="manifest" href="manifest.json">
</head>
<body>
    <div id="app">
        <header class="app-header">
            <h1>🎮 KidsPlay</h1>
            <div id="profile-indicator"></div>
        </header>
        
        <main id="game-catalog" class="catalog-grid">
            <!-- Games will be loaded dynamically -->
        </main>
        
        <div id="gamepad-indicator" class="gamepad-status"></div>
    </div>
    
    <script src="common/core/game-engine.js"></script>
    <script src="common/core/input-manager.js"></script>
    <script src="common/core/audio-manager.js"></script>
</body>
</html>
"@
    
    Set-Content -Path "index.html" -Value $indexContent -Encoding UTF8
}

# Function to create manifest.json for PWA
function Create-Manifest {
    Write-Host "📱 Creating PWA manifest..." -ForegroundColor Yellow
    
    $manifestContent = @"
{
    "name": "KidsPlay - Giochi Educativi",
    "short_name": "KidsPlay",
    "description": "Piattaforma di giochi educativi per bambini 5-6 anni",
    "start_url": "/",
    "display": "fullscreen",
    "background_color": "#4CAF50",
    "theme_color": "#2E7D32",
    "orientation": "landscape",
    "icons": [
        {
            "src": "assets/images/icon-192.png",
            "sizes": "192x192",
            "type": "image/png"
        },
        {
            "src": "assets/images/icon-512.png", 
            "sizes": "512x512",
            "type": "image/png"
        }
    ]
}
"@
    
    Set-Content -Path "manifest.json" -Value $manifestContent -Encoding UTF8
}

# Function to create games.json catalog
function Create-GamesCatalog {
    Write-Host "🎲 Creating games catalog..." -ForegroundColor Yellow
    
    $gamesContent = @"
{
    "version": "2.0",
    "last_updated": "2025-08-27",
    "games": [
        {
            "id": "memory-letters",
            "title": "Memory Lettere",
            "description": "Trova le coppie di lettere uguali!",
            "category": "educational",
            "icon": "🔤",
            "min_age": 4,
            "max_age": 7,
            "skills": ["memoria", "riconoscimento lettere"],
            "difficulty_levels": ["easy", "normal"],
            "estimated_time": "5-10 min"
        },
        {
            "id": "letter-hunt",
            "title": "Caccia alle Lettere",
            "description": "Trova tutte le lettere nascoste!",
            "category": "educational", 
            "icon": "🔍",
            "min_age": 5,
            "max_age": 8,
            "skills": ["alfabeto", "osservazione"],
            "difficulty_levels": ["easy", "normal", "hard"],
            "estimated_time": "3-8 min"
        },
        {
            "id": "math-easy",
            "title": "Matematica Facile",
            "description": "Somme e sottrazioni fino a 10",
            "category": "educational",
            "icon": "🔢",
            "min_age": 5,
            "max_age": 7,
            "skills": ["matematica", "logica"],
            "difficulty_levels": ["very_easy", "easy", "normal"],
            "estimated_time": "5-15 min"
        },
        {
            "id": "snake",
            "title": "Snake Educativo",
            "description": "Il serpente che insegna le direzioni!",
            "category": "educational",
            "icon": "🐍",
            "min_age": 5,
            "max_age": 10,
            "skills": ["coordinazione", "pianificazione"],
            "difficulty_levels": ["easy", "normal"],
            "estimated_time": "3-10 min"
        },
        {
            "id": "blockworld",
            "title": "BlockWorld",
            "description": "Costruisci il tuo mondo a blocchi!",
            "category": "adventure",
            "icon": "🧱",
            "min_age": 6,
            "max_age": 10,
            "skills": ["creatività", "pianificazione spaziale"],
            "difficulty_levels": ["easy", "normal"],
            "estimated_time": "10-30 min"
        },
        {
            "id": "speedy-adventures",
            "title": "Speedy Adventures",
            "description": "Corri veloce e raccogli le gemme!",
            "category": "adventure",
            "icon": "💨",
            "min_age": 5,
            "max_age": 9,
            "skills": ["coordinazione", "riflessi"],
            "difficulty_levels": ["easy", "normal"],
            "estimated_time": "5-15 min"
        },
        {
            "id": "dino-explorer",
            "title": "Dino Explorer",
            "description": "Esplora il mondo dei dinosauri!",
            "category": "adventure",
            "icon": "🦕",
            "min_age": 5,
            "max_age": 8,
            "skills": ["esplorazione", "apprendimento"],
            "difficulty_levels": ["easy", "normal"],
            "estimated_time": "10-20 min"
        }
    ]
}
"@
    
    Set-Content -Path "games.json" -Value $gamesContent -Encoding UTF8
}

# Function to create core CSS
function Create-BaseCSS {
    Write-Host "🎨 Creating base CSS..." -ForegroundColor Yellow
    
    $cssContent = @"
/* KidsPlay Base Styles v2.0 */

:root {
    --primary-color: #4CAF50;
    --secondary-color: #FF9800;
    --bg-color: #E8F5E8;
    --text-color: #2E7D32;
    --card-bg: #FFFFFF;
    --shadow: 0 4px 8px rgba(0,0,0,0.1);
}

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: 'Comic Sans MS', cursive, sans-serif;
    background: var(--bg-color);
    color: var(--text-color);
    line-height: 1.6;
    min-height: 100vh;
}

.app-header {
    background: var(--primary-color);
    color: white;
    padding: 1rem 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: var(--shadow);
}

.app-header h1 {
    font-size: 2rem;
    font-weight: bold;
}

.catalog-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 2rem;
    padding: 2rem;
    max-width: 1200px;
    margin: 0 auto;
}

.game-card {
    background: var(--card-bg);
    border-radius: 16px;
    padding: 2rem;
    text-align: center;
    box-shadow: var(--shadow);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    border: 3px solid transparent;
    cursor: pointer;
}

.game-card:hover,
.game-card:focus-within {
    transform: translateY(-8px);
    box-shadow: 0 8px 16px rgba(0,0,0,0.15);
    border-color: var(--primary-color);
}

.game-icon {
    font-size: 4rem;
    margin-bottom: 1rem;
    display: block;
}

.game-title {
    font-size: 1.5rem;
    color: var(--text-color);
    margin-bottom: 0.5rem;
}

.game-description {
    color: #666;
    margin-bottom: 1.5rem;
    font-size: 0.9rem;
}

.play-button {
    background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
    color: white;
    border: none;
    padding: 1rem 2rem;
    font-size: 1.2rem;
    font-weight: bold;
    border-radius: 50px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: var(--shadow);
    font-family: inherit;
}

.play-button:hover {
    transform: scale(1.05);
    box-shadow: 0 6px 12px rgba(0,0,0,0.2);
}

.play-button:active {
    transform: scale(0.98);
}

.gamepad-status {
    position: fixed;
    top: 20px;
    right: 20px;
    background: rgba(0,0,0,0.8);
    color: white;
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-size: 0.8rem;
    z-index: 1000;
}

.gamepad-status.connected {
    background: rgba(76, 175, 80, 0.9);
}

.gamepad-status.disconnected {
    background: rgba(158, 158, 158, 0.9);
}

#profile-indicator {
    background: rgba(255,255,255,0.2);
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-weight: bold;
}

/* Animation utilities */
@keyframes bounce {
    0%, 20%, 53%, 80%, 100% { transform: translate3d(0,0,0); }
    40%, 43% { transform: translate3d(0,-20px,0); }
    70% { transform: translate3d(0,-10px,0); }
    90% { transform: translate3d(0,-4px,0); }
}

.bounce-animation {
    animation: bounce 1s ease infinite;
}
"@
    
    Set-Content -Path "common\styles\base.css" -Value $cssContent -Encoding UTF8
}

# Function to create mobile CSS
function Create-MobileCSS {
    Write-Host "📱 Creating mobile CSS..." -ForegroundColor Yellow
    
    $mobileCSSContent = @"
/* KidsPlay Mobile Styles */

@media (max-width: 768px) {
    .app-header {
        padding: 0.5rem 1rem;
        flex-direction: column;
        gap: 0.5rem;
    }
    
    .app-header h1 {
        font-size: 1.5rem;
    }
    
    .catalog-grid {
        grid-template-columns: 1fr;
        gap: 1rem;
        padding: 1rem;
    }
    
    .game-card {
        padding: 1.5rem;
    }
    
    .game-icon {
        font-size: 3rem;
    }
    
    .game-title {
        font-size: 1.3rem;
    }
    
    .play-button {
        padding: 0.8rem 1.5rem;
        font-size: 1rem;
    }
    
    .gamepad-status {
        top: 10px;
        right: 10px;
        font-size: 0.7rem;
        padding: 0.3rem 0.8rem;
    }
}

@media (max-width: 480px) {
    .catalog-grid {
        padding: 0.5rem;
    }
    
    .game-card {
        padding: 1rem;
    }
    
    .game-icon {
        font-size: 2.5rem;
    }
}

/* Touch-friendly enhancements */
@media (pointer: coarse) {
    .play-button {
        min-height: 48px;
        min-width: 120px;
    }
    
    .game-card {
        min-height: 200px;
    }
}
"@
    
    Set-Content -Path "common\styles\mobile.css" -Value $mobileCSSContent -Encoding UTF8
}

# Function to create game engine
function Create-GameEngine {
    Write-Host "🎮 Creating game engine..." -ForegroundColor Yellow
    
    $engineContent = @"
/**
 * KidsPlay Core Game Engine v2.0
 * Universal game management and common utilities
 */

class KidsPlayEngine {
    constructor() {
        this.currentProfile = this.detectProfile();
        this.gamesList = [];
        this.inputManager = null;
        this.audioManager = null;
        this.init();
    }
    
    async init() {
        console.log('🎮 KidsPlay Engine starting...');
        
        // Initialize managers
        this.inputManager = new UniversalInputManager();
        this.audioManager = new AudioManager();
        
        // Load configuration
        await this.loadConfiguration();
        
        // Load games catalog
        await this.loadGamesCatalog();
        
        // Setup UI
        this.setupUI();
        
        console.log('✅ KidsPlay Engine ready!');
    }
    
    detectProfile() {
        const hostname = window.location.hostname;
        const subdomain = hostname.split('.')[0];
        
        // Check if subdomain matches a profile
        if (['figlio1', 'figlio2'].includes(subdomain)) {
            return subdomain;
        }
        
        return 'default';
    }
    
    async loadConfiguration() {
        try {
            const response = await fetch(`config/`+this.currentProfile+`.json`);
            this.config = await response.json();
            console.log(`📋 Profile loaded: `+this.currentProfile);
        } catch (error) {
            console.warn('Using default configuration');
            this.config = this.getDefaultConfig();
        }
    }
    
    async loadGamesCatalog() {
        try {
            const response = await fetch('games.json');
            const catalogData = await response.json();
            this.gamesList = catalogData.games;
            console.log(`🎲 Loaded `+this.gamesList.length+` games`);
        } catch (error) {
            console.error('Failed to load games catalog:', error);
        }
    }
    
    setupUI() {
        this.renderGamesCatalog();
        this.setupGamepadIndicator();
        this.updateProfileIndicator();
    }
    
    renderGamesCatalog() {
        const catalogElement = document.getElementById('game-catalog');
        if (!catalogElement) return;
        
        catalogElement.innerHTML = '';
        
        // Filter games based on profile configuration
        const availableGames = this.gamesList.filter(game => {
            return this.config.enabled_games.includes(game.id);
        });
        
        availableGames.forEach(game => {
            const gameCard = this.createGameCard(game);
            catalogElement.appendChild(gameCard);
        });
    }
    
    createGameCard(game) {
        const card = document.createElement('div');
        card.className = 'game-card';
        card.innerHTML = `
            <div class="game-icon">`+game.icon+`</div>
            <h3 class="game-title">`+game.title+`</h3>
            <p class="game-description">`+(game.description || '')+`</p>
            <button class="play-button" data-game-id="`+game.id+`">
                Gioca! 🚀
            </button>
        `;
        
        // Add click handler
        const playButton = card.querySelector('.play-button');
        playButton.addEventListener('click', () => this.launchGame(game.id));
        
        return card;
    }
    
    launchGame(gameId) {
        const game = this.gamesList.find(g => g.id === gameId);
        if (!game) {
            console.error('Game not found:', gameId);
            return;
        }
        
        // Build game URL with parameters
        const gameUrl = this.buildGameUrl(game);
        
        console.log(`🚀 Launching game: `+game.title);
        window.location.href = gameUrl;
    }
    
    buildGameUrl(game) {
        const baseUrl = `games/`+game.category+`/`+game.id+`/index.html`;
        const params = new URLSearchParams({
            profile: this.currentProfile,
            difficulty: this.config.difficulty_level,
            language: this.config.language || 'it',
            audio: this.config.audio_enabled ? 'on' : 'off'
        });
        
        return baseUrl+`?`+params.toString();
    }
    
    updateProfileIndicator() {
        const indicator = document.getElementById('profile-indicator');
        if (indicator) {
            indicator.textContent = `👤 `+this.currentProfile;
        }
    }
    
    setupGamepadIndicator() {
        const indicator = document.getElementById('gamepad-indicator');
        if (!indicator) return;
        
        // Check for gamepad connection
        const checkGamepad = () => {
            const gamepads = navigator.getGamepads();
            const connected = Array.from(gamepads).some(gp => gp !== null);
            
            indicator.textContent = connected ? '🎮 Controller connesso' : '🎮 Nessun controller';
            indicator.className = `gamepad-status `+(connected ? 'connected' : 'disconnected');
        };
        
        // Check periodically
        setInterval(checkGamepad, 1000);
        
        // Listen for gamepad events
        window.addEventListener('gamepadconnected', checkGamepad);
        window.addEventListener('gamepaddisconnected', checkGamepad);
    }
    
    getDefaultConfig() {
        return {
            difficulty_level: 'easy',
            language: 'it',
            audio_enabled: true,
            enabled_games: ['snake', 'memory-letters', 'math-easy'],
            speed_multiplier: 0.8
        };
    }
}

// Initialize engine when page loads
document.addEventListener('DOMContentLoaded', () => {
    window.kidsPlayEngine = new KidsPlayEngine();
});
"@
    
    Set-Content -Path "common\core\game-engine.js" -Value $engineContent -Encoding UTF8
}

# Function to create input manager
function Create-InputManager {
    Write-Host "🎮 Creating input manager..." -ForegroundColor Yellow
    
    $inputContent = @"
/**
 * Universal Input Manager for KidsPlay
 * Handles gamepad, keyboard, and touch input
 */

class UniversalInputManager {
    constructor() {
        this.gamepadIndex = -1;
        this.keyState = {};
        this.touchState = {};
        this.callbacks = new Map();
        this.init();
    }
    
    init() {
        this.setupKeyboardListeners();
        this.setupGamepadListeners();
        this.setupTouchListeners();
        this.startGamepadPolling();
    }
    
    setupKeyboardListeners() {
        document.addEventListener('keydown', (e) => {
            this.keyState[e.code] = true;
            this.handleAction(this.mapKeyToAction(e.code));
        });
        
        document.addEventListener('keyup', (e) => {
            this.keyState[e.code] = false;
        });
    }
    
    setupGamepadListeners() {
        window.addEventListener('gamepadconnected', (e) => {
            console.log('Gamepad connected:', e.gamepad.id);
            this.gamepadIndex = e.gamepad.index;
        });
        
        window.addEventListener('gamepaddisconnected', (e) => {
            console.log('Gamepad disconnected');
            this.gamepadIndex = -1;
        });
    }
    
    setupTouchListeners() {
        document.addEventListener('touchstart', (e) => {
            e.preventDefault();
            this.touchState.active = true;
            this.touchState.startX = e.touches[0].clientX;
            this.touchState.startY = e.touches[0].clientY;
        });
        
        document.addEventListener('touchend', (e) => {
            e.preventDefault();
            if (this.touchState.active) {
                this.handleTouchGesture();
                this.touchState.active = false;
            }
        });
        
        document.addEventListener('touchmove', (e) => {
            e.preventDefault();
            if (this.touchState.active) {
                this.touchState.currentX = e.touches[0].clientX;
                this.touchState.currentY = e.touches[0].clientY;
            }
        });
    }
    
    startGamepadPolling() {
        const poll = () => {
            this.updateGamepad();
            requestAnimationFrame(poll);
        };
        poll();
    }
    
    updateGamepad() {
        if (this.gamepadIndex === -1) return;
        
        const gamepad = navigator.getGamepads()[this.gamepadIndex];
        if (!gamepad) return;
        
        // Handle D-pad
        if (gamepad.buttons[12].pressed) this.handleAction('up');
        if (gamepad.buttons[13].pressed) this.handleAction('down');
        if (gamepad.buttons[14].pressed) this.handleAction('left');
        if (gamepad.buttons[15].pressed) this.handleAction('right');
        
        // Handle face buttons
        if (gamepad.buttons[0].pressed) this.handleAction('action_a');
        if (gamepad.buttons[1].pressed) this.handleAction('action_b');
        if (gamepad.buttons[2].pressed) this.handleAction('action_x');
        if (gamepad.buttons[3].pressed) this.handleAction('action_y');
        
        // Handle analog sticks
        if (Math.abs(gamepad.axes[0]) > 0.3) {
            this.handleAction(gamepad.axes[0] > 0 ? 'right' : 'left');
        }
        if (Math.abs(gamepad.axes[1]) > 0.3) {
            this.handleAction(gamepad.axes[1] > 0 ? 'down' : 'up');
        }
    }
    
    mapKeyToAction(keyCode) {
        const keyMap = {
            'ArrowUp': 'up',
            'ArrowDown': 'down', 
            'ArrowLeft': 'left',
            'ArrowRight': 'right',
            'KeyW': 'up',
            'KeyS': 'down',
            'KeyA': 'left',
            'KeyD': 'right',
            'Space': 'action_a',
            'Enter': 'action_a',
            'KeyX': 'action_b',
            'Escape': 'menu'
        };
        
        return keyMap[keyCode] || null;
    }
    
    handleTouchGesture() {
        if (!this.touchState.currentX) return;
        
        const deltaX = this.touchState.currentX - this.touchState.startX;
        const deltaY = this.touchState.currentY - this.touchState.startY;
        
        if (Math.abs(deltaX) > Math.abs(deltaY)) {
            this.handleAction(deltaX > 30 ? 'right' : deltaX < -30 ? 'left' : 'action_a');
        } else {
            this.handleAction(deltaY > 30 ? 'down' : deltaY < -30 ? 'up' : 'action_a');
        }
    }
    
    handleAction(action) {
        if (!action) return;
        
        const callback = this.callbacks.get(action);
        if (callback) {
            callback(action);
        }
        
        // Global action handler
        document.dispatchEvent(new CustomEvent('kidsplay-input', {
            detail: { action: action }
        }));
    }
    
    onAction(action, callback) {
        this.callbacks.set(action, callback);
    }
    
    isPressed(action) {
        // Check if action is currently pressed
        return this.keyState[this.mapActionToKey(action)] || false;
    }
    
    mapActionToKey(action) {
        const actionMap = {
            'up': 'ArrowUp',
            'down': 'ArrowDown',
            'left': 'ArrowLeft', 
            'right': 'ArrowRight',
            'action_a': 'Space'
        };
        
        return actionMap[action] || null;
    }
}
"@
    
    Set-Content -Path "common\core\input-manager.js" -Value $inputContent -Encoding UTF8
}

# Function to create audio manager
function Create-AudioManager {
    Write-Host "🔊 Creating audio manager..." -ForegroundColor Yellow
    
    $audioContent = @"
/**
 * KidsPlay Audio Manager
 * Handles all audio functionality with parental controls
 */

class AudioManager {
    constructor() {
        this.enabled = true;
        this.volume = 0.7;
        this.sounds = new Map();
        this.audioContext = null;
        this.init();
    }
    
    init() {
        try {
            this.audioContext = new (window.AudioContext || window.webkitAudioContext)();
        } catch (e) {
            console.warn('Web Audio API not supported');
        }
        
        // Load settings from profile
        const profile = window.kidsPlayEngine?.config;
        if (profile) {
            this.enabled = profile.audio_enabled;
            this.volume = profile.parental_controls?.volume_limit || 0.7;
        }
    }
    
    playSound(type, options = {}) {
        if (!this.enabled || !this.audioContext) return;
        
        switch(type) {
            case 'success':
                this.playSuccessSound();
                break;
            case 'error':
                this.playErrorSound();
                break;
            case 'collect':
                this.playCollectSound();
                break;
            case 'click':
                this.playClickSound();
                break;
            case 'victory':
                this.playVictorySound();
                break;
        }
    }
    
    playTone(frequency, duration, type = 'sine') {
        if (!this.enabled || !this.audioContext) return;
        
        const oscillator = this.audioContext.createOscillator();
        const gainNode = this.audioContext.createGain();
        
        oscillator.connect(gainNode);
        gainNode.connect(this.audioContext.destination);
        
        oscillator.frequency.value = frequency;
        oscillator.type = type;
        
        gainNode.gain.setValueAtTime(this.volume * 0.3, this.audioContext.currentTime);
        gainNode.gain.exponentialRampToValueAtTime(0.01, this.audioContext.currentTime + duration / 1000);
        
        oscillator.start(this.audioContext.currentTime);
        oscillator.stop(this.audioContext.currentTime + duration / 1000);
    }
    
    playSuccessSound() {
        const notes = [523, 659, 784, 1047]; // C5, E5, G5, C6
        notes.forEach((freq, i) => {
            setTimeout(() => this.playTone(freq, 150), i * 100);
        });
    }
    
    playErrorSound() {
        this.playTone(200, 300);
    }
    
    playCollectSound() {
        const notes = [523, 659, 784];
        notes.forEach((freq, i) => {
            setTimeout(() => this.playTone(freq, 100), i * 50);
        });
    }
    
    playClickSound() {
        this.playTone(800, 100);
    }
    
    playVictorySound() {
        const melody = [523, 587, 659, 698, 784, 880, 988, 1047];
        melody.forEach((freq, i) => {
            setTimeout(() => this.playTone(freq, 200), i * 150);
        });
    }
    
    setVolume(level) {
        this.volume = Math.max(0, Math.min(1, level));
    }
    
    toggleEnabled() {
        this.enabled = !this.enabled;
        return this.enabled;
    }
}
"@
    
    Set-Content -Path "common\core\audio-manager.js" -Value $audioContent -Encoding UTF8
}

# Function to create configuration files
function Create-Configurations {
    Write-Host "⚙️ Creating configuration files..." -ForegroundColor Yellow
    
    # figlio1.json
    $figlio1Config = @"
{
    "profile_name": "figlio1",
    "display_name": "Primo Figlio",
    "age": 5,
    "difficulty_level": "easy",
    "speed_multiplier": 0.8,
    "audio_enabled": true,
    "language": "it",
    "enabled_games": [
        "memory-letters",
        "letter-hunt", 
        "math-easy",
        "snake",
        "blockworld"
    ],
    "gamepad_enabled": true,
    "parental_controls": {
        "max_session_time": 30,
        "break_reminders": true,
        "volume_limit": 0.7
    },
    "ui_preferences": {
        "large_buttons": true,
        "high_contrast": false,
        "animations": true
    }
}
"@
    
    Set-Content -Path "config\figlio1.json" -Value $figlio1Config -Encoding UTF8
    
    # figlio2.json
    $figlio2Config = @"
{
    "profile_name": "figlio2", 
    "display_name": "Secondo Figlio",
    "age": 6,
    "difficulty_level": "normal",
    "speed_multiplier": 1.0,
    "audio_enabled": true,
    "language": "it",
    "enabled_games": [
        "memory-letters",
        "letter-hunt",
        "math-easy", 
        "number-block",
        "push-block",
        "snake",
        "speedy-adventures",
        "dino-explorer"
    ],
    "gamepad_enabled": true,
    "parental_controls": {
        "max_session_time": 45,
        "break_reminders": true,
        "volume_limit": 0.8
    },
    "ui_preferences": {
        "large_buttons": false,
        "high_contrast": false,
        "animations": true
    }
}
"@
    
    Set-Content -Path "config\figlio2.json" -Value $figlio2Config -Encoding UTF8
    
    # default.json
    $defaultConfig = @"
{
    "profile_name": "default",
    "display_name": "Guest",
    "age": 5,
    "difficulty_level": "easy",
    "speed_multiplier": 0.8,
    "audio_enabled": true,
    "language": "it",
    "enabled_games": [
        "memory-letters",
        "snake",
        "math-easy"
    ],
    "gamepad_enabled": true,
    "parental_controls": {
        "max_session_time": 20,
        "break_reminders": true,
        "volume_limit": 0.6
    },
    "ui_preferences": {
        "large_buttons": true,
        "high_contrast": false,
        "animations": true
    }
}
"@
    
    Set-Content -Path "config\default.json" -Value $defaultConfig -Encoding UTF8
}

# Function to create a sample Snake game
function Create-SampleGame {
    Write-Host "🐍 Creating sample Snake game..." -ForegroundColor Yellow
    
    $snakeGameContent = @"
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Snake Educativo - KidsPlay</title>
    <style>
        body {
            margin: 0;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Comic Sans MS', cursive;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }
        
        .game-header {
            color: white;
            text-align: center;
            margin-bottom: 20px;
        }
        
        .game-header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .controls-info {
            background: rgba(255,255,255,0.9);
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        #gameCanvas {
            border: 4px solid white;
            border-radius: 10px;
            background: #2c3e50;
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
        }
        
        .game-info {
            display: flex;
            gap: 20px;
            margin-top: 20px;
            color: white;
            font-size: 1.2rem;
        }
        
        .score-display, .level-display {
            background: rgba(255,255,255,0.2);
            padding: 10px 20px;
            border-radius: 20px;
            backdrop-filter: blur(10px);
        }
        
        .back-button {
            position: absolute;
            top: 20px;
            left: 20px;
            background: #e74c3c;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }
        
        .back-button:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <a href="../../../index.html" class="back-button" id="backToCatalog">
        ← Torna ai Giochi
    </a>
    
    <div class="game-header">
        <h1>🐍 Snake Educativo</h1>
        <div class="controls-info">
            <p><strong>Controlli:</strong> Usa le frecce ⬅️➡️⬆️⬇️ o il gamepad per muoverti!</p>
            <p>Raccogli le mele rosse 🍎 e cresci!</p>
        </div>
    </div>
    
    <canvas id="gameCanvas" width="600" height="400"></canvas>
    
    <div class="game-info">
        <div class="score-display">
            🍎 Punteggio: <span id="score">0</span>
        </div>
        <div class="level-display">
            ⚡ Velocità: <span id="level">Facile</span>
        </div>
    </div>

    <script>
        // Snake Educational Game - Kid-friendly version
        class SnakeGame {
            constructor() {
                this.canvas = document.getElementById('gameCanvas');
                this.ctx = this.canvas.getContext('2d');
                this.gridSize = 20;
                this.tileCount = this.canvas.width / this.gridSize;
                
                // Game state
                this.snake = [{x: 10, y: 10}];
                this.food = this.generateFood();
                this.dx = 0;
                this.dy = 0;
                this.score = 0;
                
                this.init();
            }
            
            init() {
                this.setupControls();
                this.gameLoop();
            }
            
            setupControls() {
                document.addEventListener('keydown', (e) => {
                    switch(e.code) {
                        case 'ArrowUp':
                        case 'KeyW':
                            if (this.dy === 0) { this.dx = 0; this.dy = -1; }
                            break;
                        case 'ArrowDown':
                        case 'KeyS':
                            if (this.dy === 0) { this.dx = 0; this.dy = 1; }
                            break;
                        case 'ArrowLeft':
                        case 'KeyA':
                            if (this.dx === 0) { this.dx = -1; this.dy = 0; }
                            break;
                        case 'ArrowRight':
                        case 'KeyD':
                            if (this.dx === 0) { this.dx = 1; this.dy = 0; }
                            break;
                    }
                });
            }
            
            generateFood() {
                return {
                    x: Math.floor(Math.random() * this.tileCount),
                    y: Math.floor(Math.random() * this.tileCount)
                };
            }
            
            gameLoop() {
                this.update();
                this.draw();
                
                setTimeout(() => {
                    this.gameLoop();
                }, 150); // Kid-friendly slow speed
            }
            
            update() {
                const head = {x: this.snake[0].x + this.dx, y: this.snake[0].y + this.dy};
                
                // Wrap around edges instead of game over
                head.x = (head.x + this.tileCount) % this.tileCount;
                head.y = (head.y + this.tileCount) % this.tileCount;
                
                this.snake.unshift(head);
                
                // Check food collision
                if (head.x === this.food.x && head.y === this.food.y) {
                    this.score += 10;
                    this.food = this.generateFood();
                    document.getElementById('score').textContent = this.score;
                    this.playCollectSound();
                } else {
                    this.snake.pop();
                }
            }
            
            draw() {
                // Clear canvas
                this.ctx.fillStyle = '#2c3e50';
                this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height);
                
                // Draw snake
                this.ctx.fillStyle = '#27ae60';
                this.snake.forEach(segment => {
                    this.ctx.fillRect(segment.x * this.gridSize, segment.y * this.gridSize, this.gridSize - 2, this.gridSize - 2);
                });
                
                // Draw food
                this.ctx.fillStyle = '#e74c3c';
                this.ctx.fillRect(this.food.x * this.gridSize, this.food.y * this.gridSize, this.gridSize - 2, this.gridSize - 2);
            }
            
            playCollectSound() {
                // Simple audio feedback
                const audioContext = new (window.AudioContext || window.webkitAudioContext)();
                const oscillator = audioContext.createOscillator();
                const gainNode = audioContext.createGain();
                
                oscillator.connect(gainNode);
                gainNode.connect(audioContext.destination);
                
                oscillator.frequency.value = 523; // C5
                oscillator.type = 'sine';
                
                gainNode.gain.setValueAtTime(0.3, audioContext.currentTime);
                gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.2);
                
                oscillator.start(audioContext.currentTime);
                oscillator.stop(audioContext.currentTime + 0.2);
            }
        }
        
        // Initialize game
        const game = new SnakeGame();
    </script>
</body>
</html>
"@
    
    Set-Content -Path "games\educational\snake\index.html" -Value $snakeGameContent -Encoding UTF8
}

# Function to create service worker for PWA
function Create-ServiceWorker {
    Write-Host "📱 Creating service worker for PWA..." -ForegroundColor Yellow
    
    $swContent = @"
const CACHE_NAME = 'kidsplay-v2.0';
const urlsToCache = [
    '/',
    '/index.html',
    '/common/core/game-engine.js',
    '/common/core/input-manager.js',
    '/common/core/audio-manager.js',
    '/common/styles/base.css',
    '/common/styles/mobile.css',
    '/games.json',
    '/manifest.json'
];

self.addEventListener('install', (event) => {
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then((cache) => cache.addAll(urlsToCache))
    );
});

self.addEventListener('fetch', (event) => {
    event.respondWith(
        caches.match(event.request)
            .then((response) => {
                if (response) {
                    return response;
                }
                return fetch(event.request);
            })
    );
});
"@
    
    Set-Content -Path "sw.js" -Value $swContent -Encoding UTF8
}

# Main execution
Write-Host ""
Write-Host "🚀 Starting KidsPlay setup..." -ForegroundColor Green
Write-Host ""

Create-ProjectStructure
Create-MainIndex
Create-Manifest
Create-GamesCatalog
Create-BaseCSS
Create-MobileCSS
Create-GameEngine
Create-InputManager
Create-AudioManager
Create-Configurations
Create-SampleGame
Create-ServiceWorker

Write-Host ""
Write-Host "✅ KidsPlay setup completed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "📁 Project structure created with:" -ForegroundColor Yellow
Write-Host "   • Main platform (index.html)" -ForegroundColor Gray
Write-Host "   • Educational and adventure games structure" -ForegroundColor Gray
Write-Host "   • Multi-profile configuration system" -ForegroundColor Gray
Write-Host "   • Universal input management (gamepad, keyboard, touch)" -ForegroundColor Gray
Write-Host "   • Audio system with parental controls" -ForegroundColor Gray
Write-Host "   • PWA support for mobile devices" -ForegroundColor Gray
Write-Host "   • Sample Snake game ready to play" -ForegroundColor Gray
Write-Host ""
Write-Host "🎮 To test the platform:" -ForegroundColor Yellow
Write-Host "   1. Open index.html in a web browser" -ForegroundColor Gray
Write-Host "   2. Try the Snake game with keyboard or gamepad" -ForegroundColor Gray
Write-Host "   3. Test on mobile devices for touch controls" -ForegroundColor Gray
Write-Host ""
Write-Host "🔧 Next steps for full implementation:" -ForegroundColor Yellow
Write-Host "   • Implement remaining educational games" -ForegroundColor Gray
Write-Host "   • Create adventure games (BlockWorld, Speedy Adventures, Dino Explorer)" -ForegroundColor Gray
Write-Host "   • Set up web server for proper deployment" -ForegroundColor Gray
Write-Host "   • Configure subdomain routing for profiles" -ForegroundColor Gray
Write-Host ""
