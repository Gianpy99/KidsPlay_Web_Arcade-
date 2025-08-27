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
        if (gamepad.buttons[12] && gamepad.buttons[12].pressed) this.handleAction('up');
        if (gamepad.buttons[13] && gamepad.buttons[13].pressed) this.handleAction('down');
        if (gamepad.buttons[14] && gamepad.buttons[14].pressed) this.handleAction('left');
        if (gamepad.buttons[15] && gamepad.buttons[15].pressed) this.handleAction('right');
        
        // Handle face buttons
        if (gamepad.buttons[0] && gamepad.buttons[0].pressed) this.handleAction('action_a');
        if (gamepad.buttons[1] && gamepad.buttons[1].pressed) this.handleAction('action_b');
        if (gamepad.buttons[2] && gamepad.buttons[2].pressed) this.handleAction('action_x');
        if (gamepad.buttons[3] && gamepad.buttons[3].pressed) this.handleAction('action_y');
        
        // Handle analog sticks
        if (gamepad.axes[0] && Math.abs(gamepad.axes[0]) > 0.3) {
            this.handleAction(gamepad.axes[0] > 0 ? 'right' : 'left');
        }
        if (gamepad.axes[1] && Math.abs(gamepad.axes[1]) > 0.3) {
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
