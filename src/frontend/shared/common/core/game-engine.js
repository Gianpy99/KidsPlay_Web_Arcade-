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
            const response = await fetch('data/games.json');
            if (!response.ok) {
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }
            const catalogData = await response.json();
            this.gamesList = catalogData.games;
            console.log(`🎲 Loaded ${this.gamesList.length} games from catalog`);
            
            // Check for digital-subbuteo specifically
            const digitalSubbuteo = this.gamesList.find(g => g.id === 'digital-subbuteo');
            if (digitalSubbuteo) {
                console.log('✅ Digital Subbuteo loaded successfully');
            }
        } catch (error) {
            console.error('❌ Failed to load games catalog:', error);
            this.gamesList = [];
        }
    }
    
    setupUI() {
        this.renderGamesCatalog();
        this.setupGamepadIndicator();
        this.updateProfileIndicator();
    }
    
    renderGamesCatalog() {
        const catalogElement = document.getElementById('game-catalog');
        if (!catalogElement) {
            console.error('❌ game-catalog element not found!');
            return;
        }
        
        catalogElement.innerHTML = '';
        
        // Filter games based on profile configuration
        const availableGames = this.gamesList.filter(game => {
            return this.config.enabled_games.includes(game.id);
        });
        
        if (availableGames.length === 0) {
            console.warn('⚠️ No games available to render!');
            catalogElement.innerHTML = '<p style="text-align: center; color: #666; padding: 20px;">Nessun gioco disponibile</p>';
            return;
        }
        
        availableGames.forEach(game => {
            const gameCard = this.createGameCard(game);
            catalogElement.appendChild(gameCard);
        });
        
        console.log(`� Rendered ${availableGames.length} games successfully`);
        
        // Verify Digital Subbuteo is rendered
        const digitalSubbuteo = availableGames.find(g => g.id === 'digital-subbuteo');
        if (digitalSubbuteo) {
            console.log('✅ Digital Subbuteo rendered in catalog');
        }
    }
    
    createGameCard(game) {
        const card = document.createElement('div');
        card.className = 'game-card';
        card.innerHTML = `
            <div class="game-icon">${game.icon}</div>
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
        // Profile indicator rimosso - ora gestito dall'UserManager
        console.log('Profile indicator disabled - managed by UserManager');
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
            enabled_games: [
                'memory-letters',
                'letter-hunt',
                'math-easy',
                'snake',
                'blockworld',
                'speedy-adventures',
                'dino-explorer',
                'digital-subbuteo'
            ],
            speed_multiplier: 0.8
        };
    }
}

// Initialize engine when page loads
document.addEventListener('DOMContentLoaded', () => {
    window.kidsPlayEngine = new KidsPlayEngine();
});
