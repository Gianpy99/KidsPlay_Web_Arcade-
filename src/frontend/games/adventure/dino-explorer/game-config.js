/**
 * API Configuration for Dino Explorer
 * 
 * To enable AI image generation:
 * 1. Get your Gemini API key from: https://aistudio.google.com/apikey
 * 2. Replace 'YOUR_GEMINI_API_KEY_HERE' with your actual key
 * 3. The game will automatically use AI-generated dinosaur images
 */

const GameConfig = {
    // Gemini API Configuration
    geminiApiKey: 'YOUR_GEMINI_API_KEY_HERE', // ⚠️ NEVER commit real API keys! Add to .gitignore
    
    // Imagen 3 API endpoint (correct model for image generation)
    geminiApiUrl: 'https://generativelanguage.googleapis.com/v1beta/models/imagen-3.0-generate-001:predict',
    
    // Game Settings
    enableAIImages: false, // TEMPORARILY DISABLED - API model issue
    enablePushableBlocks: true, // Enable Sokoban-style blocks
    enableMovingDinosaurs: true, // Dinosaurs move each turn
    
    // Check if API is configured
    isApiConfigured() {
        // Temporarily return false until we fix the API model
        return false;
        /* Original check:
        return this.geminiApiKey && 
               this.geminiApiKey !== 'YOUR_GEMINI_API_KEY_HERE' &&
               this.geminiApiKey.length > 10;
        */
    }
};

// Auto-enable AI images if API key is configured
if (GameConfig.isApiConfigured()) {
    GameConfig.enableAIImages = true;
    console.log('✅ Gemini API configured - AI image generation enabled');
} else {
    console.log('ℹ️ Gemini API not configured - using emoji dinosaurs');
    console.log('ℹ️ To enable AI images, add your API key to game-config.js');
}
