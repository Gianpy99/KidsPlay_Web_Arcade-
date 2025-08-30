/**
 * KidsPlay User Management System
 * Sistema globale di gestione utenti per tutta l'applicazione
 */

class UserManager {
    constructor() {
        this.currentUser = null;
        this.storageKey = 'kidsplay_current_user';
        this.usersKey = 'kidsplay_users';
        
        // Global gamepad management
        this.gamepad = {
            connected: false,
            index: -1,
            lastSeen: 0
        };
        
        this.loadCurrentUser();
        this.initializeGlobalGamepad();
    }
    
    // Initialize global gamepad management
    initializeGlobalGamepad() {
        // Listen for gamepad events globally
        window.addEventListener('gamepadconnected', (e) => {
            console.log('Global gamepad connected:', e.gamepad);
            this.gamepad.connected = true;
            this.gamepad.index = e.gamepad.index;
            this.gamepad.lastSeen = Date.now();
            
            // Store in sessionStorage to persist across pages
            sessionStorage.setItem('kidsplay_gamepad', JSON.stringify({
                connected: true,
                index: e.gamepad.index,
                lastSeen: Date.now()
            }));
        });
        
        window.addEventListener('gamepaddisconnected', (e) => {
            console.log('Global gamepad disconnected:', e.gamepad);
            this.gamepad.connected = false;
            this.gamepad.index = -1;
            sessionStorage.removeItem('kidsplay_gamepad');
        });
        
        // Restore gamepad state from sessionStorage
        this.restoreGamepadState();
        
        // Check gamepad status more frequently and handle reconnection better
        setInterval(() => this.checkGamepadStatus(), 500); // Check every 500ms for better responsiveness
        
        // Force immediate gamepad check
        this.checkGamepadStatus();
    }
    
    // Restore gamepad state from previous session - IMPROVED
    restoreGamepadState() {
        const stored = sessionStorage.getItem('kidsplay_gamepad');
        if (stored) {
            try {
                const gamepadData = JSON.parse(stored);
                // Extend restoration window to 2 minutes for better persistence
                if (Date.now() - gamepadData.lastSeen < 120000) {
                    this.gamepad = gamepadData;
                    console.log('🎮 Restored gamepad state:', this.gamepad);
                    
                    // Force a check to see if gamepad is still actually connected
                    setTimeout(() => this.checkGamepadStatus(), 100);
                } else {
                    console.log('🎮 Gamepad state too old, clearing...');
                    sessionStorage.removeItem('kidsplay_gamepad');
                }
            } catch (e) {
                console.warn('Error restoring gamepad state:', e);
                sessionStorage.removeItem('kidsplay_gamepad');
            }
        }
    }
    
    // Check if gamepad is still connected - IMPROVED
    checkGamepadStatus() {
        const gamepads = navigator.getGamepads();
        let found = false;
        let foundIndex = -1;
        
        // Look for any connected gamepad
        for (let i = 0; i < gamepads.length; i++) {
            if (gamepads[i] && gamepads[i].connected) {
                found = true;
                foundIndex = i;
                break;
            }
        }
        
        if (found) {
            if (!this.gamepad.connected || this.gamepad.index !== foundIndex) {
                // Gamepad connected or changed index
                this.gamepad.connected = true;
                this.gamepad.index = foundIndex;
                this.gamepad.lastSeen = Date.now();
                
                // Persist immediately
                sessionStorage.setItem('kidsplay_gamepad', JSON.stringify(this.gamepad));
                console.log('🎮 Gamepad status updated:', this.gamepad);
            } else {
                // Just update last seen time
                this.gamepad.lastSeen = Date.now();
                sessionStorage.setItem('kidsplay_gamepad', JSON.stringify(this.gamepad));
            }
        } else if (this.gamepad.connected) {
            // Gamepad disconnected
            this.gamepad.connected = false;
            this.gamepad.index = -1;
            sessionStorage.removeItem('kidsplay_gamepad');
            console.log('🎮 Gamepad disconnected');
        }
    }
    
    // Get current gamepad state
    getGamepadState() {
        return { ...this.gamepad };
    }
    
    // Method to manually update gamepad state (called from games)
    updateGamepadState(connected, index) {
        this.gamepad.connected = connected;
        this.gamepad.index = index;
        this.gamepad.lastSeen = Date.now();
        
        if (connected) {
            sessionStorage.setItem('kidsplay_gamepad', JSON.stringify(this.gamepad));
            console.log('🎮 Gamepad state manually updated:', this.gamepad);
        } else {
            sessionStorage.removeItem('kidsplay_gamepad');
            console.log('🎮 Gamepad state manually cleared');
        }
    }

    // Carica l'utente corrente dal localStorage
    loadCurrentUser() {
        const stored = localStorage.getItem(this.storageKey);
        if (stored) {
            try {
                this.currentUser = JSON.parse(stored);
            } catch (e) {
                console.warn('Errore nel caricamento utente:', e);
                this.currentUser = null;
            }
        }
    }

    // Salva l'utente corrente nel localStorage
    saveCurrentUser() {
        if (this.currentUser) {
            localStorage.setItem(this.storageKey, JSON.stringify(this.currentUser));
        } else {
            localStorage.removeItem(this.storageKey);
        }
        this.notifyUserChange();
    }

    // Ottiene tutti gli utenti registrati
    getAllUsers() {
        const stored = localStorage.getItem(this.usersKey);
        if (stored) {
            try {
                return JSON.parse(stored);
            } catch (e) {
                console.warn('Errore nel caricamento utenti:', e);
                return [];
            }
        }
        return [];
    }

    // Salva la lista utenti
    saveAllUsers(users) {
        localStorage.setItem(this.usersKey, JSON.stringify(users));
    }

    // Login/registrazione utente
    login(username) {
        if (!username || !username.trim()) {
            return { success: false, message: 'Nome utente richiesto' };
        }

        const trimmedUsername = username.trim().substring(0, 20); // Limit to 20 chars
        const users = this.getAllUsers();
        
        // Cerca se l'utente esiste già
        let user = users.find(u => u.username.toLowerCase() === trimmedUsername.toLowerCase());
        
        if (!user) {
            // Crea nuovo utente
            user = {
                username: trimmedUsername,
                createdAt: new Date().toISOString(),
                lastLogin: new Date().toISOString(),
                gamesPlayed: 0,
                totalScore: 0
            };
            users.push(user);
            this.saveAllUsers(users);
        } else {
            // Aggiorna ultimo login
            user.lastLogin = new Date().toISOString();
            this.saveAllUsers(users);
        }

        this.currentUser = user;
        this.saveCurrentUser();
        
        return { success: true, user: user };
    }

    // Logout
    logout() {
        this.currentUser = null;
        this.saveCurrentUser();
        return { success: true };
    }

    // Ottiene l'utente corrente
    getCurrentUser() {
        return this.currentUser;
    }

    // Verifica se un utente è loggato
    isLoggedIn() {
        return this.currentUser !== null;
    }

    // Ottiene il nome dell'utente corrente o 'Ospite'
    getCurrentUsername() {
        return this.currentUser ? this.currentUser.username : 'Ospite';
    }

    // Aggiorna statistiche utente
    updateUserStats(gamesPlayed = 0, scoreToAdd = 0) {
        if (!this.currentUser) return;

        const users = this.getAllUsers();
        const userIndex = users.findIndex(u => u.username === this.currentUser.username);
        
        if (userIndex !== -1) {
            users[userIndex].gamesPlayed += gamesPlayed;
            users[userIndex].totalScore += scoreToAdd;
            users[userIndex].lastLogin = new Date().toISOString();
            
            this.currentUser = users[userIndex];
            this.saveAllUsers(users);
            this.saveCurrentUser();
        }
    }

    // Notifica i cambiamenti utente agli altri componenti
    notifyUserChange() {
        // Dispatch custom event
        window.dispatchEvent(new CustomEvent('userChanged', {
            detail: { user: this.currentUser }
        }));

        // Aggiorna display nome utente se presente
        this.updateUserDisplay();
    }

    // Aggiorna il display del nome utente in tutti gli elementi
    updateUserDisplay() {
        console.log('updateUserDisplay called, current user:', this.currentUser);
        
        const userDisplays = document.querySelectorAll('.user-display, #currentUser, .current-username');
        console.log('Found user displays:', userDisplays.length);
        userDisplays.forEach(display => {
            display.textContent = this.getCurrentUsername();
        });

        const loginBtn = document.getElementById('loginBtn');
        const logoutBtn = document.getElementById('logoutBtn');
        const userInfo = document.querySelector('.user-info');
        
        console.log('Found buttons:', { loginBtn, logoutBtn, userInfo });

        if (this.isLoggedIn()) {
            console.log('User is logged in');
            if (loginBtn) loginBtn.style.display = 'none';
            if (logoutBtn) logoutBtn.style.display = 'inline-block';
            if (userInfo) userInfo.style.display = 'block';
        } else {
            console.log('User is not logged in');
            if (loginBtn) loginBtn.style.display = 'inline-block';
            if (logoutBtn) logoutBtn.style.display = 'none';
            if (userInfo) userInfo.style.display = 'none';
        }
    }

    // Mostra dialog di login
    showLoginDialog() {
        return new Promise((resolve) => {
            const username = prompt('🎮 Inserisci il tuo nome utente:', this.getCurrentUsername());
            if (username) {
                const result = this.login(username);
                resolve(result);
            } else {
                resolve({ success: false, message: 'Login annullato' });
            }
        });
    }

    // Inizializza il sistema utenti per una pagina
    initializeForPage() {
        // Aggiorna display utente
        this.updateUserDisplay();

        // Setup event listeners
        document.addEventListener('DOMContentLoaded', () => {
            this.updateUserDisplay();
        });

        // Auto-prompt per login se non loggato (opzionale)
        if (!this.isLoggedIn()) {
            // Uncomment if you want auto-prompt:
            // setTimeout(() => this.showLoginDialog(), 1000);
        }
    }
}

// Crea istanza globale
console.log('Creating UserManager instance...');
window.userManager = new UserManager();
console.log('UserManager created:', window.userManager);

// Funzioni globali per facilità d'uso
window.loginUser = () => {
    console.log('loginUser called');
    return window.userManager.showLoginDialog();
};
window.logoutUser = () => {
    console.log('logoutUser called');
    window.userManager.logout();
    if (confirm('🎮 Logout effettuato! Vuoi ricaricare la pagina?')) {
        location.reload();
    }
};

console.log('Login/Logout functions created:', window.loginUser, window.logoutUser);

// Auto-inizializza
if (document.readyState === 'loading') {
    console.log('DOM loading, adding event listener...');
    document.addEventListener('DOMContentLoaded', () => {
        console.log('DOM loaded, initializing...');
        window.userManager.initializeForPage();
    });
} else {
    console.log('DOM already loaded, initializing immediately...');
    window.userManager.initializeForPage();
}
