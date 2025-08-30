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
