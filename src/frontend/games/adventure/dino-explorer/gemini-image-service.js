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
        // Build specific features description based on dinosaur type
        const specificFeatures = this.getSpecificFeatures(dinosaur);
        
        return `Create a highly accurate, detailed illustration of a ${dinosaur.scientificName} (commonly known as ${dinosaur.name}).

CRITICAL: This MUST be a ${dinosaur.scientificName} showing its most distinctive and recognizable features.

Distinctive Features to Show:
${specificFeatures}

Scientific Details:
- Period: ${dinosaur.period}
- Type: ${dinosaur.type}
- Size: ${dinosaur.size}
- Habitat: ${dinosaur.habitat}

Style Requirements:
- Vibrant, educational illustration suitable for children aged 6-12
- Child-friendly and appealing, but scientifically accurate
- Clear view showing the dinosaur's most recognizable features
- Bright, engaging colors appropriate for the species
- Simple background with ${dinosaur.habitat} environment elements
- Educational museum quality meets modern children's book art

The illustration should be immediately recognizable as a ${dinosaur.scientificName} based on its unique physical characteristics.`;
    }
    
    /**
     * Get specific physical features for each dinosaur type
     */
    getSpecificFeatures(dinosaur) {
        const features = {
            'tyrannosaurus': `- Massive head with powerful jaws and large sharp teeth
- Short arms with two fingers
- Large muscular legs
- Long thick tail for balance
- Bipedal stance (stands on two legs)`,
            
            'triceratops': `- THREE prominent horns (two long brow horns above eyes, one shorter nose horn)
- Large bony neck frill (shield-like structure behind head)
- Parrot-like beak
- Four sturdy legs (quadrupedal stance)
- Stocky, robust body similar to a rhinoceros`,
            
            'velociraptor': `- Small to medium size (turkey-sized)
- Large curved claw on each foot (sickle-shaped killing claw)
- Long stiff tail for balance
- Feathered body (important!)
- Bipedal stance with long legs
- Sharp teeth in narrow snout`,
            
            'stegosaurus': `- Large triangular bony plates along the back in two rows
- Four large spikes on the tail (thagomizer)
- Small head relative to body
- Four sturdy legs with front legs shorter than back legs
- Arched back profile`,
            
            'brontosaurus': `- Extremely long neck (one of the longest)
- Very long whip-like tail
- Small head at end of long neck
- Massive pillar-like legs (elephant-like)
- Large barrel-shaped body
- Quadrupedal stance`,
            
            'allosaurus': `- Large head with sharp teeth and powerful jaws
- Three-fingered hands with sharp claws
- Bipedal stance with strong legs
- Long tail for balance
- Ridge above each eye
- Smaller than T-Rex but similar body plan`
        };
        
        return features[dinosaur.id] || `- Distinctive features of ${dinosaur.scientificName}
- Accurate anatomical details
- Recognizable body shape and proportions`;
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
