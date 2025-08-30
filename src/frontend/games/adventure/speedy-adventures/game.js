// Minimal Speedy Adventures Game
class SpeedyAdventuresGame {
    constructor() {
        this.canvas = document.getElementById('gameCanvas');
        this.init();
    }
    
    init() {
        if (!this.canvas) {
            console.error('Game canvas not found!');
            return;
        }
        
        this.canvas.innerHTML = `
            <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); text-align: center;">
                <h2>🏃‍♂️ Speedy Adventures</h2>
                <p>🎮 Il gioco completo sarà disponibile presto!</p>
                <p>🔄 Stiamo ottimizzando le performance...</p>
                <button onclick="window.location.href='../../../index.html'" style="
                    background: #4CAF50; 
                    color: white; 
                    border: none; 
                    padding: 10px 20px; 
                    border-radius: 5px; 
                    cursor: pointer; 
                    font-size: 16px;
                    margin-top: 20px;
                ">← Torna ai Giochi</button>
            </div>
        `;
        
        console.log('✅ Minimal game loaded successfully');
    }
}

// Initialize game when DOM is ready
let game = null;
document.addEventListener('DOMContentLoaded', () => {
    setTimeout(() => {
        game = new SpeedyAdventuresGame();
    }, 100);
});
