/**
 * Gemini Image Generation Service
 * Handles AI-generated dinosaur images using Google Gemini 2.5 Flash Image API
 * Based on seasonal_quest_app implementation pattern
 * 
 * Images are persisted in localStorage for 30 days to maintain consistency across sessions
 */

class GeminiImageService {
    constructor() {
        this.storagePrefix = 'dino_image_';
        this.cacheExpiry = 30 * 24 * 60 * 60 * 1000; // 30 days - images persist across sessions
    }

    /**
     * Generate dinosaur image using Gemini API
     * @param {Object} dinosaur - Dinosaur data object
     * @returns {Promise<string>} Base64 encoded PNG image data
     */
    async generateDinosaurImage(dinosaur) {
        // Check cache first
        const cached = this.getCachedImage(dinosaur.id);
        if (cached) {
            console.log(`📦 Using cached image for ${dinosaur.name}`);
            return cached;
        }

        // Check API configuration
        if (!GameConfig.isApiConfigured()) {
            console.warn('⚠️ Gemini API not configured');
            return null;
        }

        try {
            // Build prompt for Gemini
            const prompt = this.buildPrompt(dinosaur);
            console.log(`🎨 Generating AI image for ${dinosaur.name}...`);

            // Call Gemini API
            const imageData = await this.callGeminiAPI(prompt);
            
            if (imageData) {
                // Cache the result
                this.cacheImage(dinosaur.id, imageData);
                console.log(`✅ Generated and cached image for ${dinosaur.name}`);
                return imageData;
            }

            return null;
        } catch (error) {
            console.error('❌ Error generating dinosaur image:', error);
            return null;
        }
    }

    /**
     * Build detailed prompt for Gemini image generation
     */
    buildPrompt(dinosaur) {
        return `Create a high-quality, detailed illustration of a ${dinosaur.name} (${dinosaur.scientificName}). 
Style: Vibrant, educational, child-friendly cartoon illustration suitable for a kids' learning game.
Details: 
- Period: ${dinosaur.period}
- Type: ${dinosaur.type}
- Size: ${dinosaur.size}
- Habitat: ${dinosaur.habitat}
- Description: ${dinosaur.description}

The dinosaur should look friendly and appealing to children aged 6-12. 
Use bright, engaging colors. Clear details showing distinctive features.
Background: Simple, appropriate for ${dinosaur.habitat} habitat.
Style reference: Educational museum illustration meets modern children's book art.`;
    }

    /**
     * Call Gemini 2.5 Flash Image API
     * @param {string} prompt - Text prompt for image generation
     * @returns {Promise<string>} Base64 encoded image data
     */
    async callGeminiAPI(prompt) {
        const url = `${GameConfig.geminiApiUrl}?key=${GameConfig.geminiApiKey}`;
        
        const requestBody = {
            contents: [{
                parts: [{
                    text: prompt
                }]
            }],
            generationConfig: {
                responseModalities: ['image']
            }
        };

        try {
            const response = await fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(requestBody)
            });

            if (!response.ok) {
                const errorText = await response.text();
                throw new Error(`API request failed: ${response.status} - ${errorText}`);
            }

            const data = await response.json();
            
            // Extract base64 image from response
            // Response structure: candidates[0].content.parts[0].inlineData.data
            if (data.candidates && 
                data.candidates[0] && 
                data.candidates[0].content && 
                data.candidates[0].content.parts && 
                data.candidates[0].content.parts[0] && 
                data.candidates[0].content.parts[0].inlineData) {
                
                return data.candidates[0].content.parts[0].inlineData.data;
            }

            throw new Error('Invalid response structure from Gemini API');
        } catch (error) {
            console.error('Gemini API error:', error);
            throw error;
        }
    }

    /**
     * Get cached image from localStorage
     */
    getCachedImage(dinosaurId) {
        try {
            const key = this.storagePrefix + dinosaurId;
            const cached = localStorage.getItem(key);
            
            if (!cached) return null;

            const data = JSON.parse(cached);
            
            // Check if cache has expired
            if (Date.now() - data.timestamp > this.cacheExpiry) {
                localStorage.removeItem(key);
                return null;
            }

            return data.imageData;
        } catch (error) {
            console.error('Error reading cache:', error);
            return null;
        }
    }

    /**
     * Cache image to localStorage
     */
    cacheImage(dinosaurId, imageData) {
        try {
            const key = this.storagePrefix + dinosaurId;
            const data = {
                imageData: imageData,
                timestamp: Date.now()
            };
            
            localStorage.setItem(key, JSON.stringify(data));
        } catch (error) {
            console.error('Error caching image:', error);
            // localStorage might be full - clear old dino images
            this.clearOldCache();
            try {
                localStorage.setItem(key, JSON.stringify(data));
            } catch (e) {
                console.warn('Could not cache image even after cleanup');
            }
        }
    }

    /**
     * Clear old cached images to free up space
     */
    clearOldCache() {
        const now = Date.now();
        const keys = Object.keys(localStorage);
        
        keys.forEach(key => {
            if (key.startsWith(this.storagePrefix)) {
                try {
                    const data = JSON.parse(localStorage.getItem(key));
                    if (now - data.timestamp > this.cacheExpiry) {
                        localStorage.removeItem(key);
                    }
                } catch (e) {
                    // Invalid data, remove it
                    localStorage.removeItem(key);
                }
            }
        });
    }

    /**
     * Clear all cached dinosaur images
     */
    clearAllCache() {
        const keys = Object.keys(localStorage);
        keys.forEach(key => {
            if (key.startsWith(this.storagePrefix)) {
                localStorage.removeItem(key);
            }
        });
        console.log('🗑️ Cleared all cached dinosaur images');
    }

    /**
     * Get cache statistics
     */
    getCacheStats() {
        const keys = Object.keys(localStorage);
        let count = 0;
        let totalSize = 0;

        keys.forEach(key => {
            if (key.startsWith(this.storagePrefix)) {
                count++;
                totalSize += localStorage.getItem(key).length;
            }
        });

        return {
            count,
            totalSize,
            totalSizeMB: (totalSize / (1024 * 1024)).toFixed(2)
        };
    }
}

// Create global instance
const geminiImageService = new GeminiImageService();
