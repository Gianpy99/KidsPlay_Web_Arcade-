/**
 * 🦕 Dino Explorer - Database Dinosauri
 * Organizzato per tipologie con metadati completi
 */

const DinosaurDatabase = {
    
    // 🦖 Dinosauri Carnivori (Predatori)
    carnivores: {
        tyrannosaurus: {
            id: "tyrannosaurus",
            name: "T-Rex",
            scientificName: "Tyrannosaurus Rex",
            type: "carnivore",
            rarity: "legendary",
            habitat: ["forest", "plains"],
            period: "Cretaceo",
            size: "giant",
            image: "assets/dinosaurs/carnivores/tyrannosaurus.png",
            description: "Il re indiscusso dei dinosauri! Con i suoi denti affilati e la forza devastante, il T-Rex dominava il suo territorio.",
            facts: [
                "Lungo fino a 12 metri",
                "Pesava quanto un elefante",
                "Aveva denti lunghi come banane!"
            ],
            discoveryChance: 5, // 5% di trovarlo
            friendliness: 10, // 10/100 - molto difficile da avvicinare
            speed: 85,
            strength: 100,
            intelligence: 70
        },
        
        velociraptor: {
            id: "velociraptor",
            name: "Velociraptor",
            scientificName: "Velociraptor Mongoliensis",
            type: "carnivore", 
            rarity: "uncommon",
            habitat: ["desert", "plains"],
            period: "Cretaceo",
            size: "small",
            image: "assets/dinosaurs/carnivores/velociraptor.png",
            description: "Veloce e intelligente, il Velociraptor cacciava in gruppo ed era molto astuto!",
            facts: [
                "Veloce come un'auto in città",
                "Cacciava in branchi",
                "Aveva un artiglio ricurvo su ogni piede"
            ],
            discoveryChance: 15,
            friendliness: 30,
            speed: 95,
            strength: 60,
            intelligence: 90
        },
        
        allosaurus: {
            id: "allosaurus",
            name: "Allosaurus", 
            scientificName: "Allosaurus Fragilis",
            type: "carnivore",
            rarity: "common",
            habitat: ["forest", "swamp"],
            period: "Giurassico",
            size: "large",
            image: "assets/dinosaurs/carnivores/allosaurus.png",
            description: "Un predatore agile con braccia forti e artigli acuminati. L'Allosaurus era il terrore del Giurassico!",
            facts: [
                "Aveva piccole corna sopra gli occhi",
                "Le sue braccia erano molto forti",
                "Poteva correre a 40 km/h"
            ],
            discoveryChance: 20,
            friendliness: 20,
            speed: 75,
            strength: 85,
            intelligence: 65
        }
    },
    
    // 🌱 Dinosauri Erbivori (Pacifici)
    herbivores: {
        triceratops: {
            id: "triceratops",
            name: "Triceratops",
            scientificName: "Triceratops Horridus", 
            type: "herbivore",
            rarity: "common",
            habitat: ["plains", "forest"],
            period: "Cretaceo",
            size: "large",
            image: "assets/dinosaurs/herbivores/triceratops.png",
            description: "Con le sue tre corna e il grande scudo osseo, il Triceratops era un gigante gentile che amava le piante!",
            facts: [
                "Aveva tre corna per difendersi",
                "Il suo scudo pesava come un'auto",
                "Mangiava 200 kg di piante al giorno!"
            ],
            discoveryChance: 25,
            friendliness: 70,
            speed: 30,
            strength: 80,
            intelligence: 50
        },
        
        stegosaurus: {
            id: "stegosaurus", 
            name: "Stegosaurus",
            scientificName: "Stegosaurus Stenops",
            type: "herbivore",
            rarity: "uncommon",
            habitat: ["forest", "plains"],
            period: "Giurassico", 
            size: "large",
            image: "assets/dinosaurs/herbivores/stegosaurus.png",
            description: "Le placche colorate sulla schiena e la coda spinosa rendevano lo Stegosaurus unico e affascinante!",
            facts: [
                "Aveva un cervello piccolo come una noce",
                "Le placche cambiavano colore",
                "La coda aveva 4 spine affilate"
            ],
            discoveryChance: 18,
            friendliness: 60,
            speed: 25,
            strength: 70,
            intelligence: 40
        },
        
        brontosaurus: {
            id: "brontosaurus",
            name: "Brontosaurus", 
            scientificName: "Brontosaurus Excelsus",
            type: "herbivore",
            rarity: "rare",
            habitat: ["swamp", "lake"],
            period: "Giurassico",
            size: "giant",
            image: "assets/dinosaurs/herbivores/brontosaurus.png", 
            description: "Il gigante buono! Con il suo lungo collo raggiungeva le foglie più alte degli alberi.",
            facts: [
                "Alto come un palazzo di 4 piani",
                "Lungo quanto 3 autobus",
                "Il suo cuore pesava 400 kg!"
            ],
            discoveryChance: 8,
            friendliness: 80,
            speed: 15,
            strength: 95,
            intelligence: 45
        }
    },
    
    // 🥬 Dinosauri Onnivori (Misti)
    omnivores: {
        // Placeholder per futuri dinosauri onnivori
    }
};

// 🌍 Configurazione degli Habitat
const HabitatConfig = {
    forest: {
        name: "Foresta Preistorica",
        description: "Una fitta foresta con alberi giganti e felci",
        background: "linear-gradient(to bottom, #2d5a27 0%, #4a7c59 50%, #8fbc8f 100%)",
        commonDinos: ["allosaurus", "triceratops", "stegosaurus"],
        rareDinos: ["tyrannosaurus"]
    },
    
    plains: {
        name: "Pianure del Cretaceo", 
        description: "Vaste pianure erbose sotto il sole preistorico",
        background: "linear-gradient(to bottom, #87ceeb 0%, #98fb98 40%, #228b22 100%)",
        commonDinos: ["triceratops", "velociraptor"],
        rareDinos: ["tyrannosaurus"]
    },
    
    swamp: {
        name: "Palude Giurassica",
        description: "Zone umide ricche di vita acquatica",
        background: "linear-gradient(to bottom, #4682b4 0%, #5f8a5f 50%, #2f4f2f 100%)",
        commonDinos: ["allosaurus", "brontosaurus"],
        rareDinos: []
    },
    
    desert: {
        name: "Deserto del Triassico",
        description: "Terre aride con rocce rosse e cactus primitivi", 
        background: "linear-gradient(to bottom, #daa520 0%, #cd853f 50%, #a0522d 100%)",
        commonDinos: ["velociraptor"],
        rareDinos: []
    },
    
    lake: {
        name: "Lago Cristallino",
        description: "Acque pure circondate da vegetazione lussureggiante",
        background: "linear-gradient(to bottom, #87ceeb 0%, #40e0d0 50%, #008b8b 100%)",
        commonDinos: ["brontosaurus"],
        rareDinos: []
    }
};

// 🎲 Sistema di Rarità
const RaritySystem = {
    common: { color: "#22c55e", chance: 50, name: "Comune" },
    uncommon: { color: "#3b82f6", chance: 30, name: "Non Comune" }, 
    rare: { color: "#a855f7", chance: 15, name: "Raro" },
    legendary: { color: "#f59e0b", chance: 5, name: "Leggendario" }
};

// 🎯 Utilità per accesso rapido
const DinosaurUtils = {
    // Ottieni tutti i dinosauri come array
    getAllDinosaurs() {
        const allDinos = [];
        Object.values(DinosaurDatabase.carnivores).forEach(dino => allDinos.push(dino));
        Object.values(DinosaurDatabase.herbivores).forEach(dino => allDinos.push(dino));
        Object.values(DinosaurDatabase.omnivores).forEach(dino => allDinos.push(dino));
        return allDinos;
    },
    
    // Trova dinosauro per ID
    findById(id) {
        const allDinos = this.getAllDinosaurs();
        return allDinos.find(dino => dino.id === id);
    },
    
    // Filtra per habitat
    getByHabitat(habitat) {
        return this.getAllDinosaurs().filter(dino => dino.habitat.includes(habitat));
    },
    
    // Filtra per tipo
    getByType(type) {
        return DinosaurDatabase[type + 's'] || {};
    },
    
    // Genera incontro casuale per habitat
    generateRandomEncounter(habitat) {
        const availableDinos = this.getByHabitat(habitat);
        if (availableDinos.length === 0) return null;
        
        // Weighted random basato sulla discoveryChance
        const totalWeight = availableDinos.reduce((sum, dino) => sum + dino.discoveryChance, 0);
        let randomNum = Math.random() * totalWeight;
        
        for (const dino of availableDinos) {
            randomNum -= dino.discoveryChance;
            if (randomNum <= 0) {
                return dino;
            }
        }
        
        return availableDinos[0]; // fallback
    }
};

// Export per uso nel gioco
if (typeof module !== 'undefined' && module.exports) {
    module.exports = { DinosaurDatabase, HabitatConfig, RaritySystem, DinosaurUtils };
}
