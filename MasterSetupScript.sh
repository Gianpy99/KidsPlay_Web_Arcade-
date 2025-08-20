#!/bin/bash
# KidsPlay Modular Setup System
# Version: 2.0
# Date: August 20, 2025

# =============================================================================
# MASTER SETUP SCRIPT - setup.sh
# =============================================================================

#!/bin/bash
set -e

echo "🎮 KidsPlay Setup System v2.0"
echo "=============================="

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_section() {
    echo -e "\n${BLUE}=== $1 ===${NC}"
}

# Check if we're in the right directory
if [[ ! -f "setup.sh" ]]; then
    print_error "Please run this script from the KidsPlay root directory"
    exit 1
fi

# Create setup modules directory if it doesn't exist
mkdir -p setup-modules

# Main setup function
main_setup() {
    print_section "KidsPlay Modular Setup"
    
    echo "Available setup modules:"
    echo "1. Core Setup (required)"
    echo "2. Educational Games"
    echo "3. Adventure Games (NEW)"
    echo "4. Configuration & Profiles"
    echo "5. Assets & Media"
    echo "6. Deployment & Build"
    echo "7. All Modules (full install)"
    echo "8. Custom Selection"
    
    read -p "Select setup option [1-8]: " choice
    
    case $choice in
        1) run_module "core-setup" ;;
        2) run_module "educational-games-setup" ;;
        3) run_module "adventure-games-setup" ;;
        4) run_module "config-setup" ;;
        5) run_module "assets-setup" ;;
        6) run_module "deployment-setup" ;;
        7) run_all_modules ;;
        8) custom_selection ;;
        *) print_error "Invalid selection"; exit 1 ;;
    esac
}

# Function to run a specific module
run_module() {
    local module_name="$1"
    local module_path="setup-modules/${module_name}.sh"
    
    print_section "Running ${module_name}"
    
    if [[ -f "$module_path" ]]; then
        chmod +x "$module_path"
        bash "$module_path"
    else
        print_warning "Module $module_path not found, creating..."
        create_module "$module_name"
        chmod +x "$module_path"
        bash "$module_path"
    fi
}

# Function to run all modules in sequence
run_all_modules() {
    print_section "Full KidsPlay Installation"
    
    modules=(
        "core-setup"
        "educational-games-setup" 
        "adventure-games-setup"
        "config-setup"
        "assets-setup"
        "deployment-setup"
    )
    
    for module in "${modules[@]}"; do
        run_module "$module"
        if [[ $? -ne 0 ]]; then
            print_error "Module $module failed. Aborting."
            exit 1
        fi
    done
    
    print_status "Full installation completed successfully! 🎉"
}

# Function for custom module selection
custom_selection() {
    echo "Enter module numbers separated by spaces (e.g., 1 3 4):"
    read -a selected_modules
    
    for num in "${selected_modules[@]}"; do
        case $num in
            1) run_module "core-setup" ;;
            2) run_module "educational-games-setup" ;;
            3) run_module "adventure-games-setup" ;;
            4) run_module "config-setup" ;;
            5) run_module "assets-setup" ;;
            6) run_module "deployment-setup" ;;
            *) print_warning "Skipping invalid module: $num" ;;
        esac
    done
}

# Function to create module scripts if they don't exist
create_module() {
    local module_name="$1"
    local module_path="setup-modules/${module_name}.sh"
    
    case $module_name in
        "core-setup")
            create_core_setup_module "$module_path"
            ;;
        "educational-games-setup")
            create_educational_games_module "$module_path"
            ;;
        "adventure-games-setup")
            create_adventure_games_module "$module_path"
            ;;
        "config-setup")
            create_config_setup_module "$module_path"
            ;;
        "assets-setup")
            create_assets_setup_module "$module_path"
            ;;
        "deployment-setup")
            create_deployment_setup_module "$module_path"
            ;;
    esac
}

# =============================================================================
# MODULE CREATION FUNCTIONS
# =============================================================================

create_core_setup_module() {
    local file_path="$1"
    
    cat > "$file_path" << 'EOF'
#!/bin/bash
# Core Setup Module - KidsPlay
set -e

source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$source_dir"

echo "🏗️ Setting up core KidsPlay structure..."

# Create main directory structure
mkdir -p {config,games/{educational,adventure},common/{core,styles},assets/{sounds,images,fonts}}

# Create main index.html
cat > index.html << 'HTML'
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
    <script src="common/catalog.js"></script>
</body>
</html>
HTML

# Create basic PWA manifest
cat > manifest.json << 'JSON'
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
JSON

# Create core game engine
cat > common/core/game-engine.js << 'JS'
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
            const response = await fetch(`config/${this.currentProfile}.json`);
            this.config = await response.json();
            console.log(`📋 Profile loaded: ${this.currentProfile}`);
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
            console.log(`🎲 Loaded ${this.gamesList.length} games`);
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
            <div class="game-icon">${game.icon || '🎮'}</div>
            <h3 class="game-title">${game.title}</h3>
            <p class="game-description">${game.description || ''}</p>
            <button class="play-button" data-game-id="${game.id}">
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
        
        console.log(`🚀 Launching game: ${game.title}`);
        window.location.href = gameUrl;
    }
    
    buildGameUrl(game) {
        const baseUrl = `games/${game.category}/${game.id}/index.html`;
        const params = new URLSearchParams({
            profile: this.currentProfile,
            difficulty: this.config.difficulty_level,
            language: this.config.language || 'it',
            audio: this.config.audio_enabled ? 'on' : 'off'
        });
        
        return `${baseUrl}?${params.toString()}`;
    }
    
    updateProfileIndicator() {
        const indicator = document.getElementById('profile-indicator');
        if (indicator) {
            indicator.textContent = `👤 ${this.currentProfile}`;
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
            indicator.className = `gamepad-status ${connected ? 'connected' : 'disconnected'}`;
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
JS

# Create basic CSS
cat > common/styles/base.css << 'CSS'
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
CSS

echo "✅ Core setup completed!"
echo "   - Directory structure created"
echo "   - Main index.html generated"
echo "   - Core game engine implemented"
echo "   - Base CSS styles applied"
echo "   - PWA manifest configured"
EOF
}

create_educational_games_module() {
    local file_path="$1"
    
    cat > "$file_path" << 'EOF'
#!/bin/bash
# Educational Games Setup Module - KidsPlay
set -e

echo "📚 Setting up educational games..."

# Create educational games directory structure
mkdir -p games/educational/{snake,memory-letters,math-easy,number-block,push-block,minesweeper,letter-hunt}

# Create games.json with educational games
cat > games.json << 'JSON'
{
    "version": "2.0",
    "last_updated": "2025-08-20",
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
            "id": "number-block",
            "title": "Blocchi Numerici",
            "description": "Combina i numeri come un puzzle!",
            "category": "educational",
            "icon": "🧩",
            "min_age": 6,
            "max_age": 9,
            "skills": ["matematica", "logica"],
            "difficulty_levels": ["easy", "normal"],
            "estimated_time": "5-15 min"
        },
        {
            "id": "push-block",
            "title": "Sposta Blocchi",
            "description": "Puzzle con blocchi da spingere!",
            "category": "educational",
            "icon": "📦",
            "min_age": 6,
            "max_age": 10,
            "skills": ["logica", "problem solving"],
            "difficulty_levels": ["easy", "normal"],
            "estimated_time": "5-20 min"
        }
    ]
}
JSON

# Create Snake game (simple example)
mkdir -p games/educational/snake
cat > games/educational/snake/index.html << 'HTML'
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
                
                // Get URL parameters for difficulty
                const urlParams = new URLSearchParams(window.location.search);
                this.difficulty = urlParams.get('difficulty') || 'easy';
                this.setupDifficulty();
                
                // Input handling
                this.setupInputHandlers();
                
                // Start game loop
                this.gameLoop();
            }
            
            setupDifficulty() {
                const difficultySettings = {
                    'very_easy': { speed: 200, speedLabel: 'Molto Facile' },
                    'easy': { speed: 150, speedLabel: 'Facile' },
                    'normal': { speed: 100, speedLabel: 'Normale' }
                };
                
                const settings = difficultySettings[this.difficulty] || difficultySettings['easy'];
                this.gameSpeed = settings.speed;
                document.getElementById('level').textContent = settings.speedLabel;
            }
            
            setupInputHandlers() {
                // Keyboard controls
                document.addEventListener('keydown', (e) => {
                    if (this.dx !== 0 && this.dy !== 0) return; // Prevent reverse direction
                    
                    switch(e.code) {
                        case 'ArrowUp':
                        case 'KeyW':
                            if (this.dy !== 1) { this.dx = 0; this.dy = -1; }
                            break;
                        case 'ArrowDown':
                        case 'KeyS':
                            if (this.dy !== -1) { this.dx = 0; this.dy = 1; }
                            break;
                        case 'ArrowLeft':
                        case 'KeyA':
                            if (this.dx !== 1) { this.dx = -1; this.dy = 0; }
                            break;
                        case 'ArrowRight':
                        case 'KeyD':
                            if (this.dx !== -1) { this.dx = 1; this.dy = 0; }
                            break;
                    }
                });
                
                // Gamepad support
                this.gamepadHandler = setInterval(() => {
                    const gamepads = navigator.getGamepads();
                    for (let gamepad of gamepads) {
                        if (gamepad) {
                            // D-pad or left stick
                            const axes = gamepad.axes;
                            if (Math.abs(axes[0]) > 0.5 || Math.abs(axes[1]) > 0.5) {
                                if (Math.abs(axes[0]) > Math.abs(axes[1])) {
                                    // Horizontal movement
                                    if (axes[0] < -0.5 && this.dx !== 1) {
                                        this.dx = -1; this.dy = 0;
                                    } else if (axes[0] > 0.5 && this.dx !== -1) {
                                        this.dx = 1; this.dy = 0;
                                    }
                                } else {
                                    // Vertical movement  
                                    if (axes[1] < -0.5 && this.dy !== 1) {
                                        this.dx = 0; this.dy = -1;
                                    } else if (axes[1] > 0.5 && this.dy !== -1) {
                                        this.dx = 0; this.dy = 1;
                                    }
                                }
                            }
                            
                            // D-pad buttons
                            if (gamepad.buttons[12].pressed && this.dy !== 1) { // Up
                                this.dx = 0; this.dy = -1;
                            }
                            if (gamepad.buttons[13].pressed && this.dy !== -1) { // Down  
                                this.dx = 0; this.dy = 1;
                            }
                            if (gamepad.buttons[14].pressed && this.dx !== 1) { // Left
                                this.dx = -1; this.dy = 0;
                            }
                            if (gamepad.buttons[15].pressed && this.dx !== -1) { // Right
                                this.dx = 1; this.dy = 0;
                            }
                        }
                    }
                }, 100);
            }
            
            generateFood() {
                return {
                    x: Math.floor(Math.random() * this.tileCount),
                    y: Math.floor(Math.random() * this.tileCount)
                };
            }
            
            update() {
                const head = {x: this.snake[0].x + this.dx, y: this.snake[0].y + this.dy};
                
                // Wall collision (wrap around for kids)
                if (head.x < 0) head.x = this.tileCount - 1;
                if (head.x >= this.tileCount) head.x = 0;
                if (head.y < 0) head.y = this.tileCount - 1;
                if (head.y >= this.tileCount) head.y = 0;
                
                this.snake.unshift(head);
                
                // Check food collision
                if (head.x === this.food.x && head.y === this.food.y) {
                    this.score += 10;
                    document.getElementById('score').textContent = this.score;
                    this.food = this.generateFood();
                    
                    // Play success sound (if audio enabled)
                    this.playSound('collect');
                } else {
                    this.snake.pop();
                }
                
                // Check self collision (restart instead of game over for kids)
                for (let i = 1; i < this.snake.length; i++) {
                    if (head.x === this.snake[i].x && head.y === this.snake[i].y) {
                        this.restart();
                        return;
                    }
                }
            }
            
            draw() {
                // Clear canvas
                this.ctx.fillStyle = '#2c3e50';
                this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height);
                
                // Draw snake
                this.ctx.fillStyle = '#2ecc71';
                this.snake.forEach((segment, index) => {
                    if (index === 0) {
                        // Snake head - different color
                        this.ctx.fillStyle = '#27ae60';
                    } else {
                        this.ctx.fillStyle = '#2ecc71';
                    }
                    
                    this.ctx.fillRect(
                        segment.x * this.gridSize + 2,
                        segment.y * this.gridSize + 2,
                        this.gridSize - 4,
                        this.gridSize - 4
                    );
                });
                
                // Draw food
                this.ctx.fillStyle = '#e74c3c';
                this.ctx.fillRect(
                    this.food.x * this.gridSize + 2,
                    this.food.y * this.gridSize + 2,
                    this.gridSize - 4,
                    this.gridSize - 4
                );
                
                // Draw food emoji
                this.ctx.font = `${this.gridSize - 8}px Arial`;
                this.ctx.fillText(
                    '🍎',
                    this.food.x * this.gridSize + 2,
                    this.food.y * this.gridSize + this.gridSize - 2
                );
            }
            
            restart() {
                this.snake = [{x: 10, y: 10}];
                this.dx = 0;
                this.dy = 0;
                this.food = this.generateFood();
                // Keep score for encouragement
            }
            
            playSound(type) {
                // Simple audio feedback (if enabled)
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.get('audio') === 'off') return;
                
                // Create audio context for sound effects
                try {
                    const audioContext = new (window.AudioContext || window.webkitAudioContext)();
                    const oscillator = audioContext.createOscillator();
                    const gainNode = audioContext.createGain();
                    
                    oscillator.connect(gainNode);
                    gainNode.connect(audioContext.destination);
                    
                    if (type === 'collect') {
                        oscillator.frequency.setValueAtTime(800, audioContext.currentTime);
                        oscillator.frequency.setValueAtTime(1000, audioContext.currentTime + 0.1);
                    }
                    
                    gainNode.gain.setValueAtTime(0.1, audioContext.currentTime);
                    gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.2);
                    
                    oscillator.start(audioContext.currentTime);
                    oscillator.stop(audioContext.currentTime + 0.2);
                } catch (e) {
                    console.log('Audio not supported');
                }
            }
            
            gameLoop() {
                this.update();
                this.draw();
                setTimeout(() => this.gameLoop(), this.gameSpeed);
            }
        }
        
        // Initialize game when page loads
        document.addEventListener('DOMContentLoaded', () => {
            new SnakeGame();
        });
    </script>
</body>
</html>
HTML

echo "✅ Educational games setup completed!"
echo "   - Games catalog (games.json) created"
echo "   - Snake educational game implemented"
echo "   - Directory structure for all educational games ready"
echo "   - Gamepad and touch controls integrated"
EOF
}

create_adventure_games_module() {
    local file_path="$1"
    
    cat > "$file_path" << 'EOF'
#!/bin/bash
# Adventure Games Setup Module - KidsPlay
set -e

echo "🏃‍♂️ Setting up adventure games..."

# Create adventure games directory structure
mkdir -p games/adventure/{blockworld,speedy-adventures,dino-explorer}

# Add adventure games to the catalog (update games.json)
if [ -f games.json ]; then
    # Backup existing games.json
    cp games.json games.json.backup
    
    # Create updated games.json with adventure games
    cat > games.json << 'JSON'
{
    "version": "2.0",
    "last_updated": "2025-08-20",
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
            "description": "Costruisci e crea nel mondo dei blocchi!",
            "category": "adventure",
            "icon": "🧱",
            "min_age": 5,
            "max_age": 8,
            "skills": ["creatività", "pianificazione spaziale", "problem solving"],
            "difficulty_levels": ["very_easy", "easy", "normal"],
            "estimated_time": "10-30 min",
            "features": ["costruzione", "esplorazione", "creature amichevoli"]
        },
        {
            "id": "speedy-adventures",
            "title": "Speedy Adventures",
            "description": "Corri, salta e raccogli gemme colorate!",
            "category": "adventure",
            "icon": "💨",
            "min_age": 5,
            "max_age": 8,
            "skills": ["coordinazione", "riflessi", "conteggio"],
            "difficulty_levels": ["very_easy", "easy", "normal"],
            "estimated_time": "5-15 min",
            "features": ["platform", "collezioni", "boss amichevoli"]
        },
        {
            "id": "dino-explorer",
            "title": "Dino Explorer",
            "description": "Esplora il mondo dei dinosauri amichevoli!",
            "category": "adventure",
            "icon": "🦕",
            "min_age": 5,
            "max_age": 8,
            "skills": ["conoscenza", "osservazione", "lettura"],
            "difficulty_levels": ["easy", "normal"],
            "estimated_time": "10-25 min",
            "features": ["esplorazione", "educazione", "collezionismo"]
        }
    ]
}
JSON
fi

# Create BlockWorld game
mkdir -p games/adventure/blockworld
cat > games/adventure/blockworld/index.html << 'HTML'
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BlockWorld - KidsPlay</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(to bottom, #87CEEB 0%, #98FB98 100%);
            font-family: 'Comic Sans MS', cursive;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
            overflow: hidden;
        }
        
        .game-header {
            background: rgba(0,0,0,0.7);
            color: white;
            width: 100%;
            padding: 10px;
            text-align: center;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .back-button {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 20px;
            cursor: pointer;
            text-decoration: none;
            font-size: 0.9rem;
        }
        
        .block-palette {
            background: rgba(255,255,255,0.9);
            padding: 10px;
            margin: 10px;
            border-radius: 10px;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            justify-content: center;
        }
        
        .block-type {
            width: 40px;
            height: 40px;
            border: 2px solid #333;
            cursor: pointer;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            transition: transform 0.2s;
        }
        
        .block-type:hover,
        .block-type.selected {
            transform: scale(1.1);
            border-color: #f39c12;
        }
        
        #gameCanvas {
            border: 4px solid #8B4513;
            border-radius: 10px;
            cursor: crosshair;
            background: #87CEEB;
        }
        
        .game-info {
            background: rgba(255,255,255,0.9);
            padding: 10px 20px;
            margin: 10px;
            border-radius: 10px;
            text-align: center;
            font-weight: bold;
        }
        
        .controls-help {
            position: absolute;
            bottom: 20px;
            left: 20px;
            background: rgba(0,0,0,0.8);
            color: white;
            padding: 15px;
            border-radius: 10px;
            font-size: 0.8rem;
            max-width: 250px;
        }
    </style>
</head>
<body>
    <div class="game-header">
        <a href="../../../index.html" class="back-button" id="backToCatalog">← Torna ai Giochi</a>
        <h1>🧱 BlockWorld</h1>
        <div id="modeDisplay">Modalità: Costruzione</div>
    </div>
    
    <div class="block-palette">
        <div class="block-type selected" data-block="grass" style="background: #7CB342;">🌱</div>
        <div class="block-type" data-block="stone" style="background: #9E9E9E;">🗿</div>
        <div class="block-type" data-block="wood" style="background: #8D6E63;">🌳</div>
        <div class="block-type" data-block="water" style="background: #2196F3;">🌊</div>
        <div class="block-type" data-block="sand" style="background: #FFC107;">🏖️</div>
        <div class="block-type" data-block="air" style="background: #E3F2FD;">❌</div>
    </div>
    
    <canvas id="gameCanvas" width="800" height="500"></canvas>
    
    <div class="game-info">
        <span>Blocco selezionato: <span id="selectedBlock">Erba</span></span> | 
        <span>Creature: <span id="creatureCount">3</span></span> |
        <span>Puzzle completati: <span id="puzzleCount">0/5</span></span>
    </div>
    
    <div class="controls-help">
        <strong>Controlli:</strong><br>
        • Click/Tap: Posiziona blocco<br>
        • Tasto destro: Rimuovi blocco<br>
        • Gamepad A: Posiziona<br>
        • Gamepad B: Rimuovi<br>
        • Gamepad Y: Cambia blocco<br>
        <br>
        <strong>Obiettivi:</strong><br>
        Completa i puzzle costruttivi!
    </div>

    <script>
        class BlockWorld {
            constructor() {
                this.canvas = document.getElementById('gameCanvas');
                this.ctx = this.canvas.getContext('2d');
                
                // Game settings
                this.blockSize = 32;
                this.worldWidth = Math.floor(this.canvas.width / this.blockSize);
                this.worldHeight = Math.floor(this.canvas.height / this.blockSize);
                
                // Block types
                this.blockTypes = {
                    air: { color: 'transparent', emoji: '', solid: false },
                    grass: { color: '#7CB342', emoji: '🌱', solid: true },
                    stone: { color: '#9E9E9E', emoji: '🗿', solid: true },
                    wood: { color: '#8D6E63', emoji: '🌳', solid: true },
                    water: { color: '#2196F3', emoji: '🌊', solid: false },
                    sand: { color: '#FFC107', emoji: '🏖️', solid: true }
                };
                
                // World state
                this.world = Array(this.worldHeight).fill().map(() => 
                    Array(this.worldWidth).fill('air')
                );
                
                // Game state
                this.selectedBlock = 'grass';
                this.creatures = [];
                this.puzzleCount = 0;
                
                // Get URL parameters
                const urlParams = new URLSearchParams(window.location.search);
                this.difficulty = urlParams.get('difficulty') || 'easy';
                this.setupDifficulty();
                
                // Initialize world and controls
                this.generateInitialWorld();
                this.spawnCreatures();
                this.setupControls();
                this.setupPuzzles();
                
                // Start game loop
                this.gameLoop();
            }
            
            setupDifficulty() {
                const settings = {
                    'very_easy': { worldSize: 'small', puzzleMode: 'guided', creatures: true },
                    'easy': { worldSize: 'medium', puzzleMode: 'guided', creatures: true },
                    'normal': { worldSize: 'large', puzzleMode: 'free', creatures: true }
                };
                
                this.config = settings[this.difficulty] || settings['easy'];
            }
            
            generateInitialWorld() {
                // Generate simple terrain
                const grassLevel = Math.floor(this.worldHeight * 0.7);
                
                for (let y = 0; y < this.worldHeight; y++) {
                    for (let x = 0; x < this.worldWidth; x++) {
                        if (y > grassLevel) {
                            if (y > grassLevel + 2) {
                                this.world[y][x] = 'stone';
                            } else {
                                this.world[y][x] = 'grass';
                            }
                        } else if (y === grassLevel && Math.random() < 0.3) {
                            this.world[y][x] = 'grass';
                        }
                    }
                }
                
                // Add some trees
                for (let i = 0; i < 5; i++) {
                    const x = Math.floor(Math.random() * this.worldWidth);
                    const y = grassLevel;
                    if (this.world[y] && this.world[y][x] === 'grass') {
                        this.world[y-1][x] = 'wood';
                        this.world[y-2][x] = 'wood';
                    }
                }
            }
            
            spawnCreatures() {
                const creatureTypes = ['🐰', '🐦', '🐠'];
                
                for (let i = 0; i < 3; i++) {
                    this.creatures.push({
                        x: Math.random() * (this.canvas.width - 32),
                        y: Math.random() * (this.canvas.height - 100) + 50,
                        emoji: creatureTypes[i % creatureTypes.length],
                        vx: (Math.random() - 0.5) * 0.5,
                        vy: (Math.random() - 0.5) * 0.5
                    });
                }
            }
            
            setupControls() {
                // Mouse/touch controls
                this.canvas.addEventListener('click', (e) => this.handleCanvasClick(e));
                this.canvas.addEventListener('contextmenu', (e) => {
                    e.preventDefault();
                    this.handleCanvasRightClick(e);
                });
                
                // Block palette selection
                document.querySelectorAll('.block-type').forEach(block => {
                    block.addEventListener('click', (e) => {
                        document.querySelectorAll('.block-type').forEach(b => b.classList.remove('selected'));
                        e.target.classList.add('selected');
                        this.selectedBlock = e.target.dataset.block;
                        this.updateUI();
                    });
                });
                
                // Keyboard controls
                document.addEventListener('keydown', (e) => {
                    switch(e.code) {
                        case 'Digit1': this.selectBlock('grass'); break;
                        case 'Digit2': this.selectBlock('stone'); break;
                        case 'Digit3': this.selectBlock('wood'); break;
                        case 'Digit4': this.selectBlock('water'); break;
                        case 'Digit5': this.selectBlock('sand'); break;
                        case 'KeyX': this.selectBlock('air'); break;
                    }
                });
                
                // Gamepad support
                this.gamepadInterval = setInterval(() => this.handleGamepad(), 100);
            }
            
            handleGamepad() {
                const gamepads = navigator.getGamepads();
                for (let gamepad of gamepads) {
                    if (gamepad) {
                        // Y button to cycle blocks
                        if (gamepad.buttons[3].pressed && !this.gamepadState.yPressed) {
                            this.cycleBlock();
                            this.gamepadState.yPressed = true;
                        } else if (!gamepad.buttons[3].pressed) {
                            this.gamepadState.yPressed = false;
                        }
                    }
                }
            }
            
            handleCanvasClick(e) {
                const rect = this.canvas.getBoundingClientRect();
                const x = Math.floor((e.clientX - rect.left) / this.blockSize);
                const y = Math.floor((e.clientY - rect.top) / this.blockSize);
                
                this.placeBlock(x, y, this.selectedBlock);
            }
            
            handleCanvasRightClick(e) {
                const rect = this.canvas.getBoundingClientRect();
                const x = Math.floor((e.clientX - rect.left) / this.blockSize);
                const y = Math.floor((e.clientY - rect.top) / this.blockSize);
                
                this.placeBlock(x, y, 'air');
            }
            
            placeBlock(x, y, blockType) {
                if (x >= 0 && x < this.worldWidth && y >= 0 && y < this.worldHeight) {
                    this.world[y][x] = blockType;
                    this.checkPuzzleCompletion();
                }
            }
            
            selectBlock(blockType) {
                this.selectedBlock = blockType;
                
                // Update UI selection
                document.querySelectorAll('.block-type').forEach(block => {
                    block.classList.remove('selected');
                    if (block.dataset.block === blockType) {
                        block.classList.add('selected');
                    }
                });
                
                this.updateUI();
            }
            
            cycleBlock() {
                const blocks = ['grass', 'stone', 'wood', 'water', 'sand', 'air'];
                const currentIndex = blocks.indexOf(this.selectedBlock);
                const nextIndex = (currentIndex + 1) % blocks.length;
                this.selectBlock(blocks[nextIndex]);
            }
            
            setupPuzzles() {
                this.puzzles = [
                    { name: 'Ponte', check: () => this.checkBridge() },
                    { name: 'Casa', check: () => this.checkHouse() },
                    { name: 'Giardino', check: () => this.checkGarden() },
                    { name: 'Torre', check: () => this.checkTower() },
                    { name: 'Lago', check: () => this.checkLake() }
                ];
                
                this.gamepadState = { yPressed: false };
            }
            
            checkPuzzleCompletion() {
                let completedCount = 0;
                
                for (let puzzle of this.puzzles) {
                    if (puzzle.check()) {
                        completedCount++;
                    }
                }
                
                if (completedCount > this.puzzleCount) {
                    this.puzzleCount = completedCount;
                    this.celebratePuzzle();
                }
            }
            
            checkBridge() {
                // Check for a horizontal bridge pattern
                for (let y = 0; y < this.worldHeight - 1; y++) {
                    let bridgeLength = 0;
                    for (let x = 0; x < this.worldWidth; x++) {
                        if (this.world[y][x] === 'wood' && this.world[y+1][x] === 'air') {
                            bridgeLength++;
                        } else {
                            if (bridgeLength >= 4) return true;
                            bridgeLength = 0;
                        }
                    }
                    if (bridgeLength >= 4) return true;
                }
                return false;
            }
            
            checkHouse() {
                // Simple house: wood blocks forming walls
                for (let y = 0; y < this.worldHeight - 3; y++) {
                    for (let x = 0; x < this.worldWidth - 3; x++) {
                        if (this.world[y][x] === 'wood' && 
                            this.world[y][x+2] === 'wood' &&
                            this.world[y+2][x] === 'wood' && 
                            this.world[y+2][x+2] === 'wood') {
                            return true;
                        }
                    }
                }
                return false;
            }
            
            checkGarden() {
                // Check for grass blocks with space around them
                let grassCount = 0;
                for (let y = 1; y < this.worldHeight - 1; y++) {
                    for (let x = 1; x < this.worldWidth - 1; x++) {
                        if (this.world[y][x] === 'grass') {
                            grassCount++;
                        }
                    }
                }
                return grassCount >= 10;
            }
            
            checkTower() {
                // Check for vertical stack of blocks
                for (let x = 0; x < this.worldWidth; x++) {
                    let towerHeight = 0;
                    for (let y = this.worldHeight - 1; y >= 0; y--) {
                        if (this.world[y][x] !== 'air') {
                            towerHeight++;
                        } else {
                            if (towerHeight >= 5) return true;
                            towerHeight = 0;
                        }
                    }
                    if (towerHeight >= 5) return true;
                }
                return false;
            }
            
            checkLake() {
                // Check for water blocks
                let waterCount = 0;
                for (let y = 0; y < this.worldHeight; y++) {
                    for (let x = 0; x < this.worldWidth; x++) {
                        if (this.world[y][x] === 'water') {
                            waterCount++;
                        }
                    }
                }
                return waterCount >= 6;
            }
            
            celebratePuzzle() {
                // Simple celebration effect
                console.log('🎉 Puzzle completato!');
                
                // Visual feedback
                this.canvas.style.filter = 'brightness(1.3)';
                setTimeout(() => {
                    this.canvas.style.filter = 'brightness(1.0)';
                }, 500);
            }
            
            updateUI() {
                const blockNames = {
                    grass: 'Erba',
                    stone: 'Pietra', 
                    wood: 'Legno',
                    water: 'Acqua',
                    sand: 'Sabbia',
                    air: 'Cancella'
                };
                
                document.getElementById('selectedBlock').textContent = blockNames[this.selectedBlock];
                document.getElementById('creatureCount').textContent = this.creatures.length;
                document.getElementById('puzzleCount').textContent = `${this.puzzleCount}/5`;
            }
            
            updateCreatures() {
                this.creatures.forEach(creature => {
                    creature.x += creature.vx;
                    creature.y += creature.vy;
                    
                    // Bounce off edges
                    if (creature.x <= 0 || creature.x >= this.canvas.width - 32) {
                        creature.vx = -creature.vx;
                    }
                    if (creature.y <= 50 || creature.y >= this.canvas.height - 32) {
                        creature.vy = -creature.vy;
                    }
                    
                    // Random direction change
                    if (Math.random() < 0.01) {
                        creature.vx = (Math.random() - 0.5) * 0.5;
                        creature.vy = (Math.random() - 0.5) * 0.5;
                    }
                });
            }
            
            draw() {
                // Clear canvas
                this.ctx.fillStyle = '#87CEEB';
                this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height);
                
                // Draw world blocks
                for (let y = 0; y < this.worldHeight; y++) {
                    for (let x = 0; x < this.worldWidth; x++) {
                        const blockType = this.world[y][x];
                        if (blockType !== 'air') {
                            const block = this.blockTypes[blockType];
                            
                            // Draw block background
                            this.ctx.fillStyle = block.color;
                            this.ctx.fillRect(
                                x * this.blockSize,
                                y * this.blockSize,
                                this.blockSize,
                                this.blockSize
                            );
                            
                            // Draw block emoji
                            if (block.emoji) {
                                this.ctx.font = `${this.blockSize - 8}px Arial`;
                                this.ctx.textAlign = 'center';
                                this.ctx.fillText(
                                    block.emoji,
                                    x * this.blockSize + this.blockSize/2,
                                    y * this.blockSize + this.blockSize/2 + 6
                                );
                            }
                        }
                    }
                }
                
                // Draw grid lines (light)
                this.ctx.strokeStyle = 'rgba(255,255,255,0.2)';
                this.ctx.lineWidth = 1;
                for (let x = 0; x <= this.worldWidth; x++) {
                    this.ctx.beginPath();
                    this.ctx.moveTo(x * this.blockSize, 0);
                    this.ctx.lineTo(x * this.blockSize, this.canvas.height);
                    this.ctx.stroke();
                }
                for (let y = 0; y <= this.worldHeight; y++) {
                    this.ctx.beginPath();
                    this.ctx.moveTo(0, y * this.blockSize);
                    this.ctx.lineTo(this.canvas.width, y * this.blockSize);
                    this.ctx.stroke();
                }
                
                // Draw creatures
                this.creatures.forEach(creature => {
                    this.ctx.font = '24px Arial';
                    this.ctx.textAlign = 'center';
                    this.ctx.fillText(creature.emoji, creature.x + 16, creature.y + 20);
                });
            }
            
            gameLoop() {
                this.updateCreatures();
                this.draw();
                this.updateUI();
                requestAnimationFrame(() => this.gameLoop());
            }
        }
        
        // Initialize game
        document.addEventListener('DOMContentLoaded', () => {
            new BlockWorld();
        });
    </script>
</body>
</html>
HTML

# Create Speedy Adventures game (simplified for space)
mkdir -p games/adventure/speedy-adventures
cat > games/adventure/speedy-adventures/index.html << 'HTML'
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Speedy Adventures - KidsPlay</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(45deg, #FF6B6B, #4ECDC4, #45B7D1, #96CEB4);
            background-size: 400% 400%;
            animation: gradientShift 10s ease infinite;
            font-family: 'Comic Sans MS', cursive;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
            overflow: hidden;
        }
        
        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        
        .game-header {
            background: rgba(0,0,0,0.8);
            color: white;
            width: 100%;
            padding: 10px;
            text-align: center;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .back-button {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 20px;
            cursor: pointer;
            text-decoration: none;
            font-size: 0.9rem;
        }
        
        #gameCanvas {
            border: 4px solid white;
            border-radius: 15px;
            margin: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        
        .game-stats {
            display: flex;
            gap: 30px;
            background: rgba(255,255,255,0.9);
            padding: 15px 30px;
            border-radius: 25px;
            font-size: 1.2rem;
            font-weight: bold;
            color: #333;
        }
        
        .stat-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .controls-hint {
            position: absolute;
            bottom: 20px;
            background: rgba(0,0,0,0.8);
            color: white;
            padding: 15px;
            border-radius: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="game-header">
        <a href="../../../index.html" class="back-button" id="backToCatalog">← Torna ai Giochi</a>
        <h1>💨 Speedy Adventures</h1>
        <div>Livello: <span id="currentLevel">1</span>/8</div>
    </div>
    
    <canvas id="gameCanvas" width="900" height="400"></canvas>
    
    <div class="game-stats">
        <div class="stat-item">
            <span>💎</span>
            <span>Gemme: <span id="gemCount">0</span></span>
        </div>
        <div class="stat-item">
            <span>⚡</span>
            <span>Velocità: <span id="speedLevel">Normale</span></span>
        </div>
        <div class="stat-item">
            <span>❤️</span>
            <span>Energia: <span id="energyLevel">100%</span></span>
        </div>
    </div>
    
    <div class="controls-hint">
        <strong>Controlli:</strong> SPAZIO = Salta | FRECCE = Muovi | Gamepad A = Salta
    </div>

    <script>
        class SpeedyAdventures {
            constructor() {
                this.canvas = document.getElementById('gameCanvas');
                this.ctx = this.canvas.getContext('2d');
                
                // Get URL parameters
                const urlParams = new URLSearchParams(window.location.search);
                this.difficulty = urlParams.get('difficulty') || 'easy';
                this.setupDifficulty();
                
                // Player state
                this.player = {
                    x: 100,
                    y: 300,
                    width: 32,
                    height: 32,
                    vx: 0,
                    vy: 0,
                    onGround: false,
                    color: '#FF6B6B',
                    emoji: '🏃‍♂️'
                };
                
                // Game state
                this.gems = [];
                this.obstacles = [];
                this.powerups = [];
                this.currentLevel = 1;
                this.gemCount = 0;
                this.gameSpeed = this.config.speed;
                this.energy = 100;
                
                this.setupControls();
                this.generateLevel();
                this.gameLoop();
            }
            
            setupDifficulty() {
                const settings = {
                    'very_easy': { speed: 1, autoRun: true, obstacles: false },
                    'easy': { speed: 2, autoRun: true, obstacles: true },
                    'normal': { speed: 3, autoRun: false, obstacles: true }
                };
                
                this.config = settings[this.difficulty] || settings['easy'];
                
                document.getElementById('speedLevel').textContent = 
                    this.difficulty === 'very_easy' ? 'Lento' : 
                    this.difficulty === 'easy' ? 'Normale' : 'Veloce';
            }
            
            setupControls() {
                // Keyboard
                this.keys = {};
                document.addEventListener('keydown', (e) => {
                    this.keys[e.code] = true;
                });
                document.addEventListener('keyup', (e) => {
                    this.keys[e.code] = false;
                });
                
                // Gamepad
                this.gamepadState = { jumpPressed: false };
                this.gamepadInterval = setInterval(() => this.handleGamepad(), 50);
                
                // Touch controls for mobile
                this.canvas.addEventListener('touchstart', (e) => {
                    e.preventDefault();
                    this.jump();
                });
            }
            
            handleGamepad() {
                const gamepads = navigator.getGamepads();
                for (let gamepad of gamepads) {
                    if (gamepad) {
                        // Jump button (A)
                        if (gamepad.buttons[0].pressed && !this.gamepadState.jumpPressed) {
                            this.jump();
                            this.gamepadState.jumpPressed = true;
                        } else if (!gamepad.buttons[0].pressed) {
                            this.gamepadState.jumpPressed = false;
                        }
                        
                        // Speed boost (RT)
                        if (gamepad.buttons[7].pressed) {
                            this.gameSpeed = Math.min(this.gameSpeed + 0.1, this.config.speed * 2);
                        }
                    }
                }
            }
            
            jump() {
                if (this.player.onGround) {
                    this.player.vy = -12;
                    this.player.onGround = false;
                }
            }
            
            generateLevel() {
                this.gems = [];
                this.obstacles = [];
                this.powerups = [];
                
                // Generate gems
                for (let i = 0; i < 15; i++) {
                    this.gems.push({
                        x: 200 + i * 60 + Math.random() * 30,
                        y: 200 + Math.random() * 150,
                        color: this.getRandomColor(),
                        collected: false,
                        emoji: '💎'
                    });
                }
                
                // Generate simple obstacles (if enabled)
                if (this.config.obstacles) {
                    for (let i = 0; i < 5; i++) {
                        this.obstacles.push({
                            x: 300 + i * 200,
                            y: 350,
                            width: 40,
                            height: 20,
                            color: '#8B4513',
                            emoji: '🪨'
                        });
                    }
                }
                
                // Generate powerups
                for (let i = 0; i < 3; i++) {
                    this.powerups.push({
                        x: 400 + i * 300,
                        y: 150,
                        active: true,
                        type: 'speed',
                        emoji: '⚡'
                    });
                }
            }
            
            getRandomColor() {
                const colors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFA07A', '#DDA0DD'];
                return colors[Math.floor(Math.random() * colors.length)];
            }
            
            update() {
                // Handle input
                if (this.keys['Space'] || this.keys['ArrowUp'] || this.keys['KeyW']) {
                    this.jump();
                }
                
                // Auto-run or manual control
                if (this.config.autoRun) {
                    this.player.vx = this.gameSpeed;
                } else {
                    if (this.keys['ArrowRight'] || this.keys['KeyD']) {
                        this.player.vx = this.gameSpeed;
                    } else if (this.keys['ArrowLeft'] || this.keys['KeyA']) {
                        this.player.vx = -this.gameSpeed;
                    } else {
                        this.player.vx *= 0.8;
                    }
                }
                
                // Apply gravity
                if (!this.player.onGround) {
                    this.player.vy += 0.8;
                }
                
                // Update position
                this.player.x += this.player.vx;
                this.player.y += this.player.vy;
                
                // Ground collision
                if (this.player.y > 300) {
                    this.player.y = 300;
                    this.player.vy = 0;
                    this.player.onGround = true;
                }
                
                // Screen wrapping
                if (this.player.x > this.canvas.width) {
                    this.nextLevel();
                }
                
                // Gem collection
                this.gems.forEach(gem => {
                    if (!gem.collected && this.checkCollision(this.player, gem)) {
                        gem.collected = true;
                        this.gemCount++;
                        this.playSound('collect');
                    }
                });
                
                // Obstacle collision (bouncing, not harmful)
                this.obstacles.forEach(obstacle => {
                    if (this.checkCollision(this.player, obstacle)) {
                        this.player.vx = -this.player.vx * 0.5;
                        this.player.x -= 20;
                        this.energy = Math.max(this.energy - 5, 0);
                    }
                });
                
                // Powerup collection
                this.powerups.forEach(powerup => {
                    if (powerup.active && this.checkCollision(this.player, powerup)) {
                        powerup.active = false;
                        this.gameSpeed *= 1.5;
                        setTimeout(() => this.gameSpeed = this.config.speed, 5000);
                        this.playSound('powerup');
                    }
                });
                
                // Restore energy over time
                this.energy = Math.min(this.energy + 0.1, 100);
                
                this.updateUI();
            }
            
            checkCollision(rect1, rect2) {
                return rect1.x < rect2.x + (rect2.width || 30) &&
                       rect1.x + rect1.width > rect2.x &&
                       rect1.y < rect2.y + (rect2.height || 30) &&
                       rect1.y + rect1.height > rect2.y;
            }
            
            nextLevel() {
                this.currentLevel = Math.min(this.currentLevel + 1, 8);
                this.player.x = 100;
                this.generateLevel();
                
                if (this.currentLevel > 8) {
                    this.showVictory();
                }
            }
            
            showVictory() {
                alert('🎉 Hai completato tutti i livelli! Bravo!');
                this.currentLevel = 1;
                this.generateLevel();
            }
            
            updateUI() {
                document.getElementById('gemCount').textContent = this.gemCount;
                document.getElementById('currentLevel').textContent = this.currentLevel;
                document.getElementById('energyLevel').textContent = Math.floor(this.energy) + '%';
            }
            
            playSound(type) {
                // Simple audio feedback
                try {
                    const audioContext = new (window.AudioContext || window.webkitAudioContext)();
                    const oscillator = audioContext.createOscillator();
                    const gainNode = audioContext.createGain();
                    
                    oscillator.connect(gainNode);
                    gainNode.connect(audioContext.destination);
                    
                    if (type === 'collect') {
                        oscillator.frequency.setValueAtTime(800, audioContext.currentTime);
                    } else if (type === 'powerup') {
                        oscillator.frequency.setValueAtTime(1200, audioContext.currentTime);
                    }
                    
                    gainNode.gain.setValueAtTime(0.1, audioContext.currentTime);
                    gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.3);
                    
                    oscillator.start(audioContext.currentTime);
                    oscillator.stop(audioContext.currentTime + 0.3);
                } catch (e) {
                    console.log('Audio not supported');
                }
            }
            
            draw() {
                // Clear with animated background
                const gradient = this.ctx.createLinearGradient(0, 0, this.canvas.width, this.canvas.height);
                gradient.addColorStop(0, '#FF6B6B');
                gradient.addColorStop(0.5, '#4ECDC4');
                gradient.addColorStop(1, '#45B7D1');
                this.ctx.fillStyle = gradient;
                this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height);
                
                // Draw ground
                this.ctx.fillStyle = '#8FBC8F';
                this.ctx.fillRect(0, 330, this.canvas.width, 70);
                
                // Draw player
                this.ctx.fillStyle = this.player.color;
                this.ctx.fillRect(this.player.x, this.player.y, this.player.width, this.player.height);
                
                // Draw player emoji
                this.ctx.font = '24px Arial';
                this.ctx.fillText(this.player.emoji, this.player.x + 4, this.player.y + 24);
                
                // Draw gems
                this.gems.forEach(gem => {
                    if (!gem.collected) {
