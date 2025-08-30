# Configurazione Tecnica Unificata

## Input Manager Universale
```javascript
class UniversalInputManager {
  constructor(gameConfig) {
    this.touchEnabled = 'ontouchstart' in window;
    this.gamepadEnabled = navigator.getGamepads;
    this.keyboardEnabled = true;
    this.currentMappings = gameConfig.controls;
  }
  
  // Mapping universale azioni
  getAction(input) {
    // touch/gamepad/keyboard → azione di gioco standardizzata
  }
}
```

## Difficulty System Esteso
```json
{
  "educational": {
    "very_easy": { "speed": 0.5, "hints": true, "auto_complete": true },
    "easy": { "speed": 0.75, "hints": true, "auto_complete": false },
    "normal": { "speed": 1.0, "hints": false, "auto_complete": false }
  },
  "adventure": {
    "very_easy": { "speed": 0.6, "combat": false, "auto_movement": true },
    "easy": { "speed": 0.8, "combat": "simple", "auto_movement": false },
    "normal": { "speed": 1.0, "combat": "full", "auto_movement": false }
  },
  "sports": {
    "very_easy": { "ai_delay": 1500, "power_assist": true, "auto_select": true },
    "easy": { "ai_delay": 1000, "power_assist": true, "auto_select": true },
    "normal": { "ai_delay": 600, "power_assist": false, "auto_select": false }
  }
}
```

## Gamepad Mapping Standard
```json
{
  "universal_mapping": {
    "move": ["dpad", "left_stick"],
    "primary_action": ["button_0", "button_2"],
    "secondary_action": ["button_1", "button_3"],
    "menu": ["button_9", "button_8"],
    "pause": ["button_9"],
    "back_to_catalog": ["button_8", "button_6"]
  },
  "digital_subbuteo_specific": {
    "aim": ["left_stick"],
    "power": ["right_trigger", "button_0"],
    "select_player": ["button_2"],
    "quick_pass": ["button_1"],
    "goalkeeper_dive": ["button_3"]
  }
}
```

---

# PRD B — Landing Page Personali

## Concept
Landing pages personalizzate per ogni bambino che mostrano il loro progresso, giochi preferiti e achievement. Design colorato e motivante con elementi interattivi sicuri.

## Features Principali
- **Profilo Personale**: Avatar personalizzabile e nome del bambino
- **Dashboard Progresso**: Visualizzazione giochi completati e skill sviluppate
- **Giochi Preferiti**: Accesso rapido ai giochi più giocati
- **Achievement System**: Badge e ricompense per motivare l'apprendimento
- **Controllo Genitori**: Sezione dedicata per impostazioni e monitoraggio

---

# Setup Modulare (setup.sh)

Il setup sarà suddiviso in moduli indipendenti per facilitare manutenzione e deployment parziali.

## Struttura Moduli Setup
1. **core-setup.sh** - Struttura base directory e file comuni
2. **educational-games-setup.sh** - Giochi educativi tradizionali + Letter Safari
3. **adventure-games-setup.sh** - Nuovi giochi avventura
4. **sports-games-setup.sh** - Digital Subbuteo e futuri giochi sportivi
5. **vehicle-games-setup.sh** - Sky & Road Rush e futuri giochi veicoli
6. **config-setup.sh** - File configurazione e profili
6. **assets-setup.sh** - Media files e risorse
7. **deployment-setup.sh** - Build e deploy finale

Ogni modulo può essere eseguito indipendentemente per aggiornamenti mirati o nuove installazioni.

```bash
# educational-games-setup.sh  
#!/bin/bash
echo "Setting up Educational Games module..."

# Create Letter Safari Adventure directory structure
mkdir -p games/educational/letter-safari-adventure/{js,css,assets,sounds}
mkdir -p games/educational/letter-safari-adventure/assets/{environments,creatures,characters}
mkdir -p games/educational/letter-safari-adventure/sounds/{letters,effects,ambient}

# Copy core educational game files
cp templates/educational-base.js games/educational/letter-safari-adventure/js/
cp templates/letter-creature-manager.js games/educational/letter-safari-adventure/js/
cp templates/adaptive-difficulty.js games/educational/letter-safari-adventure/js/
cp templates/learning-progress-tracker.js games/educational/letter-safari-adventure/js/

# Copy Letter Safari specific assets
cp assets/environments/safari-jungle.png games/educational/letter-safari-adventure/assets/environments/
cp assets/environments/ocean-floor.png games/educational/letter-safari-adventure/assets/environments/
cp assets/environments/space-planets.png games/educational/letter-safari-adventure/assets/environments/
cp assets/creatures/letter-animals.png games/educational/letter-safari-adventure/assets/creatures/
cp assets/characters/explorer-sprites.png games/educational/letter-safari-adventure/assets/characters/

# Copy letter pronunciation sounds
cp sounds/letters/letter_*.wav games/educational/letter-safari-adventure/sounds/letters/
cp sounds/effects/creature_capture.wav games/educational/letter-safari-adventure/sounds/effects/
cp sounds/ambient/jungle_sounds.wav games/educational/letter-safari-adventure/sounds/ambient/

# Update games catalog
echo "Adding Letter Safari Adventure to games.json..."
python3 scripts/update-catalog.py --add "letter-safari-adventure" --category "educational"

echo "Educational Games module setup complete!"
```

```bash
# sports-games-setup.sh
#!/bin/bash
echo "Setting up Sports Games module..."

# Create Digital Subbuteo directory structure
mkdir -p games/adventure/digital-subbuteo/{js,css,assets,sounds}

# Copy core sports game files
cp templates/sports-base.js games/adventure/digital-subbuteo/js/
cp templates/physics-engine.js games/adventure/digital-subbuteo/js/
cp templates/ai-controller.js games/adventure/digital-subbuteo/js/

# Copy sports-specific assets
cp assets/sports/soccer-field.png games/adventure/digital-subbuteo/assets/
cp assets/sports/ball-trail.png games/adventure/digital-subbuteo/assets/
cp sounds/sports/*.wav games/adventure/digital-subbuteo/sounds/

# Update games catalog
echo "Adding Digital Subbuteo to games.json..."
python3 scripts/update-catalog.py --add "digital-subbuteo" --category "adventure"

echo "Sports Games module setup complete!"
```

---

# Roadmap Aggiornata

## Fase 1 (MVP + Enhanced Educational) - Q3 2025
- Core platform + giochi educativi base
- **Letter Safari Adventure con 3 ambienti (safari, ocean, space)**
- Supporto gamepad basic
- 2 profili utente (figlio1/figlio2)

## Fase 2 (Adventure + Sports + Vehicles) - Q4 2025  
- BlockWorld + Speedy Adventures + Dino Explorer
- **Digital Subbuteo con modalità single e multiplayer**
- **Sky & Road Rush con 3 modalità veicolo (auto, elicottero, aereo)**
- Advanced gamepad mapping
- PWA support

## Fase 3 (Enhanced Multiplayer) - Q1 2026
- Multiplayer locale esteso (2-4 gamepad simultanei)
- Tornei Digital Subbuteo con bracket system
- Voice commands sperimentali
- Analytics privacy-safe per genitori

## Fase 4 (Vehicles + Sports Expansion) - Q2 2026
- **Veicoli Acquatici**: Barca Rush, Submarine Explorer
- **Nuovi giochi sportivi**: Digital Air Hockey, Mini Tennis, Basket Shoot
- **Advanced vehicle physics**: Più realistici ma sempre kid-friendly
- Plugin system per giochi di terze parti
- Community content (moderato)
- Advanced accessibility features

## Fase 5 (Social + Racing Features) - Q3 2026
- **Family Tournaments**: competizioni familiari sicure per tutti i giochi
- **Time Trials**: modalità cronometrate per Sky & Road Rush
- **Vehicle Customization**: personalizzazione colori e accessori
- **Achievement Sharing**: condivisione progress tra fratelli
- **Leaderboard Locali**: classifiche solo famiglia
- **Replay System**: salvataggio e condivisione delle migliori partite e corse

---

# Quality Assurance

## Test Matrix Esteso
- **Dispositivi**: PC Windows/Mac, Android 8+, tablet 10"
- **Gamepad**: PS4/PS5, Xbox One/Series, Generic HID
- **Multiplayer**: Test con 2 controller simultanei per Digital Subbuteo
- **Vehicle Controls**: Test responsiveness per auto/elicottero/aereo
- **Performance**: 60fps PC, 30fps mobile minimo con scrolling fluido
- **Accessibilità**: colorblind-friendly, high-contrast mode

## Metriche di Successo Aggiornate
- Tempo di caricamento gioco < 2s
- Crash rate < 0.1%
- Input lag < 50ms su tutti i dispositivi
- **Letter recognition improvement**: 80% bambini migliorano riconoscimento lettere
- **Educational engagement**: Tempo medio Letter Safari > 5 minuti per sessione
- **Multiplayer sync**: < 16ms delay tra giocatori locali
- **Vehicle smoothness**: Scrolling senza stuttering al 95%
- User retention: 80% ritorno seconda sessione
- **Sports engagement**: 70% completamento almeno 1 partita Digital Subbuteo
- **Vehicle preference**: Distribuzione bilanciata tra auto/elicottero/aereo

## Test Specifici Letter Safari Adventure
- **Creature AI**: Comportamenti creature distinguibili e coinvolgenti
- **Learning Adaptation**: Sistema adattivo difficoltà funziona per età 5-6 anni  
- **Audio Quality**: Pronuncia lettere chiara e comprensibile
- **Environment Performance**: 3 ambienti caricano fluidi senza lag
- **Progress Tracking**: Sistema tracciamento apprendimento accurato

## Test Specifici Sky & Road Rush
- **Scrolling Performance**: Movimento fluido senza lag visibile
- **Obstacle Detection**: Collisioni accurate con feedback positivo
- **Vehicle Physics**: Controlli responsivi per ogni tipo di veicolo
- **Kid-Friendly Collisions**: Nessun game over, solo effetti divertenti
- **Visual Effects**: Trail e particelle senza impatto su performance

## Test Specifici Digital Subbuteo
- **Physics accuracy**: Collision detection precisa al 99%
- **AI behavior**: 3 livelli difficoltà distinguibili nei test utente
- **Touch controls**: Riconoscimento gesti flick con 95% accuracy
- **Gamepad responsiveness**: Input-to-action delay < 33ms
- **Multiplayer fairness**: Bilanciamento controlli per età 5-6 anni

---

# Deployment Strategy

## Progressive Rollout
1. **Alpha**: Core team testing (2 settimane)
2. **Beta Familiare**: 5 famiglie con bambini target (4 settimane)
3. **Release Candidate**: Fix basati su feedback beta (2 settimane)
4. **Production**: Deploy graduale con monitoring

## Monitoring KPIs
- **Engagement per gioco**: tempo medio sessione per categoria
- **Letter learning effectiveness**: miglioramento riconoscimento lettere nel tempo
- **Educational vs Entertainment balance**: ratio tempo educativi vs adventure games
- **Difficulty distribution**: quale livello scelgono i bambini per tipo di gioco
- **Vehicle preference**: statistiche uso auto vs elicottero vs aereo
- **Multiplayer adoption**: % famiglie che usano modalità 2-player
- **Device performance**: FPS medio per dispositivo e tipo gioco
- **Error tracking**: crash reports e bug categorizzati per gioco

---

**Fine PRD v2.3 - Letter Safari Adventure integrato con successo!**# PRD — KidsPlay Web Arcade & Landing Pages (Versione Aggiornata)
**Data:** 20 Agosto 2025  
**Autore:** [Gianpy99] - Aggiornato da Claude  
**Versione:** 2.1

---

## Sommario
1. [PRD A — KidsPlay Web Arcade (Piattaforma giochi educativi, modulare e multi-profilo)](#prd-a---kidsplay-web-arcade)  
2. [Specifiche Nuovi Giochi Adventure](#specifiche-nuovi-giochi-adventure)
3. [PRD B — Landing Page Personali](#prd-b---landing-page-personali)  
4. [Configurazione e Struttura](#configurazione-e-struttura)  
5. [Setup Modulare](#setup-modulare)  
6. [Roadmap & Deployment](#roadmap--deployment)  

---

# PRD A — KidsPlay Web Arcade
**Versione:** 2.1  
**Scopo:** Piattaforma browser di giochi educativi e d'avventura per bambini 5–6 anni, modulare e multi-profilo con supporto gamepad universale.

## 1 — Visione Aggiornata
Fornire un ecosistema di giochi sicuri che combinino apprendimento e avventura. La piattaforma supporta sia giochi educativi tradizionali che esperienze più dinamiche ispirate ai franchise popolari, mantenendo sempre controlli adatti all'età e velocità configurabile.

## 2 — Obiettivi Principali (Aggiornati)
- **Esperienza kid-friendly**: UI semplice, feedback multimodale (visivo/audio/tattile), controlli adattivi
- **Educazione + Avventura**: bilanciamento tra apprendimento e intrattenimento dinamico
- **Accessibilità universale**: supporto touch, gamepad, e controlli vocali opzionali
- **Performance cross-platform**: ottimizzazione per PC e mobile Android
- **Configurabilità totale**: velocità, difficoltà, e meccaniche per profilo utente

## 3 — Scope MVP Esteso

### Giochi Educativi Base (Confermati)
- Memory Lettere & Parole
- **Letter Safari Adventure** (Caccia alle Lettere dinamica)  
- Matematica Facile
- Number Block (2048 semplificato)
- Push Block (Sokoban kid-friendly)
- Campo Minato (griglia 6x6, modalità "scoperta")
- Snake (velocità regolabile)

### Nuovi Giochi Adventure (Aggiunti)
- **BlockWorld** (ispirato Minecraft)
- **Speedy Adventures** (ispirato Sonic)
- **Dino Explorer** (tematica dinosauri)
- **Digital Subbuteo** (calcio da tavolo digitale)
- **Sky & Road Rush** (veicoli e ostacoli)

## 4 — Requisiti Tecnici Aggiornati

### Performance Cross-Platform
- **PC**: 60fps stabile, supporto gamepad USB/Bluetooth
- **Mobile Android**: 30fps minimo, controlli touch ottimizzati, gamepad Bluetooth
- **Gamepad Support**: PlayStation, Xbox, Amazon Luna, controller generici HID
- **Responsive Design**: layout adattivo da 5" a 32" di schermo

### Input Management
- **Touch**: gesture semplici (tap, swipe, pinch limitato)
- **Gamepad**: mappatura configurabile per ogni gioco
- **Keyboard**: WASD + frecce + spazio/enter
- **Fallback**: sempre disponibile controllo touch su tutti i dispositivi

### Architettura Migliorata
```
/kidsplay
  /config
    figlio1.json
    figlio2.json
    difficulty.json
    gamepad-mappings.json
  /games
    /educational (giochi base)
      /snake
      /memory-letters
      /letter-safari-adventure
      /math-easy
      ...
    /adventure (nuovi giochi)
      /blockworld
      /speedy-adventures  
      /dino-explorer
      /digital-subbuteo
      /sky-road-rush
      ...
  /common
    /core
      game-engine.js
      input-manager.js
      audio-manager.js
      ui-components.js
    /styles
      base.css
      mobile.css
      gamepad-ui.css
  /assets
    /sounds
    /images
    /fonts
  index.html
  games.json
  manifest.json (PWA)
```

---

# Specifiche Nuovi Giochi Adventure

## 0. Letter Safari Adventure (Caccia alle Lettere Rivoluzionata)

### Concept
Trasformare la ricerca lettere tradizionale in un'avventura esplorativa dove le lettere sono "creature animali" da catturare in ambienti dinamici e colorati. Addio griglia statica noiosa!

### Meccaniche Core
- **3 Ambienti**: Giungla Safari, Ocean Dive, Space Adventure
- **Lettere-Creature**: Ogni lettera è un animaletto animato con personalità (timido, giocherellone, curioso)
- **Movimento Intelligente**: Le lettere si nascondono, saltellano, nuotano, orbitano
- **Cattura Dinamica**: Il bambino controlla un esploratore che insegue le creature-lettere
- **Audio Educativo**: Ogni lettera pronuncia il suo suono quando catturata
- **Progressione**: Album lettere, carte creature, personalizzazione personaggio

### Modalità di Gioco
- **Safari Mode**: Giungla animata con lettere che si nascondono dietro alberi e saltano sui rami
- **Ocean Dive**: Fondale marino con lettere-perle che seguono pesci colorati
- **Space Adventure**: Sistema solare con cristalli-lettere che orbitano pianeti
- **Word Formation**: Le lettere catturate si combinano per formare parole semplici
- **Racing Mode**: Multiplayer gara a chi trova più lettere

### Controlli
- **Touch**: Tap per muoversi, drag per catturare, pinch per zoom, hold per hint
- **Gamepad**: Left stick=movimento, A=cattura, Y=hint, B=panoramica
- **Keyboard**: WASD=movimento, Spazio=cattura, H=hint, Tab=zoom

### Parametri Configurabili
- `environment`: "safari", "ocean", "space"
- `letter_speed`: "slow" (principianti), "normal", "fast" (esperti)
- `creature_behavior`: "friendly" (si avvicinano), "shy" (scappano), "playful" (giocano)
- `hint_level`: "strong" (evidenziature), "subtle" (piccoli indizi), "none"
- `target_letters`: set personalizzabile di lettere da trovare
- `difficulty_mode`: "adaptive" (si adatta automaticamente), "fixed"
- `audio_support`: "full" (pronuncia + effetti), "minimal", "silent"

### Sistema Adattivo
```json
{
  "difficulty_levels": {
    "principiante": {
      "letters_count": 5,
      "movement_speed": 0.3,
      "highlighting": "strong",
      "distractors": 0,
      "auto_hints": true
    },
    "intermedio": {
      "letters_count": 8, 
      "movement_speed": 0.6,
      "highlighting": "subtle",
      "distractors": 2,
      "auto_hints": false
    },
    "esperto": {
      "letters_count": 12,
      "movement_speed": 1.0,
      "highlighting": "none",
      "distractors": 5,
      "auto_hints": false
    }
  }
}
```

### Educational Value
- Riconoscimento lettere multimodale (visivo, auditivo, motorio)
- Coordinazione occhio-mano avanzata
- Memoria visiva e spaziale
- Problem solving (capire pattern movimento creature)
- Sequencing (trovare lettere in ordine alfabetico)
- Vocabolario (formazione parole quando disponibile)

### Architettura Tecnica
```javascript
class LetterSafari {
  constructor(config) {
    this.environment = new GameEnvironment(config.theme);
    this.player = new Explorer(config.character);
    this.letterManager = new LetterCreatureManager();
    this.progressTracker = new LearningProgressTracker();
    this.audioManager = new EducationalAudioManager();
  }
  
  spawnLetterCreature(letter) {
    const creature = new LetterCreature({
      letter: letter,
      personality: this.getRandomPersonality(),
      behavior: this.getEnvironmentBehavior(),
      animation: new CreatureAnimation(letter)
    });
    return creature;
  }
}
```

## 1. Digital Subbuteo (Calcio da Tavolo Digitale)

### Concept
Un calcio da tavolo digitale kid-friendly con controlli semplificati, squadre colorate e modalità sia single-player che multiplayer. Focus su fisica divertente, controlli facili e celebrazione di ogni goal.

### Meccaniche Core
- **Campo**: Vista dall'alto, campo da calcio semplificato (ratio 16:10 per compatibilità schermo)
- **Squadre**: 6 giocatori per lato (1 portiere + 5 di movimento)
- **Fisica**: Fisica della palla semplificata ma soddisfacente con rimbalzi dolci
- **Gol**: Primo a 3 gol vince (configurabile: 1, 3, 5, o basato su tempo)
- **Celebrazione**: Ogni gol attiva animazioni divertenti ed effetti sonori

### Stile Visivo
- **Colori Vivaci**: Colori squadra ad alto contrasto e compatibili per daltonici
- **Giocatori Semplici**: Dischi circolari con colori squadra ed espressioni facciali semplici
- **Pallone Animato**: Pallone da calcio leggermente sovradimensionato con effetti scia
- **Campo**: Campo verde pulito con linee bianche chiare e porte

### Modalità di Gioco
- **VS AI**: Gioca contro il computer con 3 livelli di difficoltà
- **Sfide Abilità**: 5 mini-giochi (rigori, punizioni, percorso dribbling, parate portiere, passaggi precisione)
- **Torneo**: Bracket semplice con 4 squadre AI
- **Due Giocatori**: Multiplayer locale, stesso dispositivo, controlli divisi
- **Turn-based**: Ogni giocatore muove un disco per turno, poi cambia
- **Tempo reale**: Entrambi i giocatori possono muoversi simultaneamente (modalità caos!)

### Controlli
- **Touch**: Flick (tocca e trascina) dal disco giocatore per impostare direzione e potenza
- **Power Indicator**: Arco visuale che mostra traiettoria e forza
- **Gamepad**: Left stick=mira, RT=potenza, A=seleziona, B=passaggio veloce, Y=mossa speciale portiere
- **Keyboard**: WASD=mira P1, Frecce=mira P2, Spazio/Enter=tiro potente, Tab/Shift=cambia giocatori

### Parametri Configurabili
- `difficulty_level`: "easy" (AI lento, aiuti attivi), "normal" (bilanciato), "hard" (AI veloce e preciso)
- `match_length`: 1, 3, 5 gol o 2, 5, 10 minuti
- `player_count`: 4v4, 6v6 (default), 8v8
- `physics_mode`: "arcade" (rimbalzi esagerati), "realistic" (fisica più vera)
- `celebration_level`: "minimal", "normal", "full" (animazioni estese)
- `team_colors`: personalizzazione colori e nomi squadre
- `input_assistance`: aiuti mira e selezione automatica giocatore più vicino

### Educational Value
- Coordinazione occhio-mano e controllo motorio fine
- Pensiero strategico e pianificazione mosse
- Comprensione fisica di base (traiettoria, rimbalzi)
- Abilità sociali (aspettare il turno, fair play)
- Pazienza e osservazione delle mosse avversarie
- Consapevolezza spaziale e comprensione angoli

## 2. Sky & Road Rush (Veicoli e Ostacoli)

### Concept
Un gioco di veicoli kid-friendly dove il bambino pilota auto, elicotteri e aerei attraverso percorsi colorati evitando ostacoli dolci. Focus su riflessi, coordinazione e celebrazione del progresso senza mai punire i fallimenti.

### Meccaniche Core
- **3 Modalità Veicolo**: Auto (strada), Elicottero (cielo basso), Aereo (cielo alto)
- **Movimento**: Scorrimento automatico configurable, controllo solo su/giù o sinistra/destra
- **Ostacoli**: Mai letali - rallentamenti temporanei e rimbalzi divertenti
- **Collezionabili**: Stelle colorate, carburante arcobaleno, power-up temporanei
- **Percorsi**: 12 livelli corti (45-90 secondi) con temi variabili (città, montagne, nuvole, spazio)
- **Power-ups**: Scudo temporaneo, velocità controllata, magnetismo per collezionabili

### Modalità di Gioco

#### Modalità Auto (Road Rush)
- **Ambientazione**: Strada colorata con colline dolci e curve ampie
- **Controlli**: Solo steering sinistra/destra, velocità automatica
- **Ostacoli**: Buche colorate (rallentano), rocce morbide (rimbalzo), pozzanghere (splash divertente)
- **Scenari**: Campagna, città cartoon, spiaggia, montagna
- **Veicoli**: 4 auto diverse (berlina, SUV, cabrio, auto sportiva) con colori personalizzabili

#### Modalità Elicottero (Sky Hover)
- **Ambientazione**: Volo a bassa quota tra edifici friendly e alberi giganti
- **Controlli**: Su/giù per altezza, movimento laterale automatico o manuale
- **Ostacoli**: Nuvole grigie (visibilità ridotta), uccellini amichevoli (deviazione), palloncini (pop divertente)
- **Scenari**: Sopra la città, foresta magica, valle dei fiori, arcipelago tropicale
- **Veicoli**: 3 elicotteri (rescue, turistico, cargo) con pale rotanti animate

#### Modalità Aereo (Cloud Cruiser)
- **Ambientazione**: Alto cielo con nuvole soffici e arcobaleni
- **Controlli**: Movimento libero ma velocità costante in avanti
- **Ostacoli**: Nuvole tempesta (turbolenza), stormi di uccelli (deviazione), fulmini cartoon (scintille)
- **Scenari**: Atmosfera terrestre, attraversamento nuvole, aurora boreale, spazio vicino
- **Veicoli**: 3 aerei (caccia carino, aereo passeggeri, jet acrobatico)

### Sistema di Progressione
- **Distanza**: Ogni run traccia metri percorsi (obiettivo: raggiungere traguardi graduali)
- **Collezionabili**: Stelle per sbloccare nuovi veicoli e personalizzazioni  
- **Perfect Runs**: Bonus per completare livelli senza toccare ostacoli
- **Time Challenges**: Modalità opzionale per completare percorsi in tempo target
- **Exploration Mode**: Modalità libera senza ostacoli per esplorare scenari

### Controlli
- **Touch**: Tap o hold per movimento (auto=sterzo, elicottero=altezza, aereo=direzione)
- **Gamepad**: Left stick=movimento, A=boost temporaneo, B=freno delicato, Y=power-up
- **Keyboard**: Frecce=movimento, Spazio=boost, X=power-up, P=pausa

### Parametri Configurabili
- `vehicle_speed`: "slow" (0.6x), "normal" (1.0x), "fast" (1.3x)
- `obstacle_density`: "light" (pochi ostacoli), "normal", "busy" (più ostacoli ma mai impossibile)
- `auto_steering_assist`: true/false (correzione automatica traiettoria)
- `collision_consequence`: "bounce" (rimbalzo divertente), "slow" (rallentamento), "none" (attraversamento)
- `power_up_frequency`: "rare", "normal", "frequent"
- `level_length`: "short" (45s), "medium" (90s), "long" (2m)
- `visual_effects`: "minimal", "normal", "spectacular" (trail effects, particelle)

### Sistema di Collisione Kid-Friendly
```javascript
class KidFriendlyCollision {
  handleCollision(vehicle, obstacle) {
    switch(obstacle.type) {
      case 'soft': 
        // Rimbalzo dolce con effetti stelline
        vehicle.addBounceEffect();
        obstacle.playSquishAnimation();
        break;
      case 'water':
        // Splash divertente, nessun danno
        vehicle.addSplashEffect();
        this.playSound('happy_splash');
        break;
      case 'creature':
        // Incontro amichevole, deviazione
        obstacle.playWaveAnimation();
        vehicle.addFriendlyDeflection();
        break;
    }
    // Non c'è mai game over, solo effetti positivi
    this.addEncouragementFeedback();
  }
}
```

### Educational Value
- **Coordinazione visuomotoria**: Controllo preciso veicoli in movimento
- **Anticipazione e pianificazione**: Prevedere posizione ostacoli
- **Riflessi e tempo di reazione**: Risposta rapida ma non stressante
- **Comprensione spazio 3D**: Altezza, profondità, prospettiva
- **Persistenza**: Incoraggiamento a riprovare senza frustrazione
- **Conoscenza veicoli**: Differenze tra auto, elicotteri, aerei

### Architettura Tecnica

```javascript
class SkyRoadRush {
  constructor(config) {
    this.vehicleType = config.vehicleType; // 'car', 'helicopter', 'plane'
    this.currentLevel = config.startLevel || 1;
    this.difficulty = config.difficulty || 'easy';
    
    this.vehicle = new Vehicle(this.vehicleType);
    this.world = new ScrollingWorld(this.vehicleType);
    this.obstacleManager = new ObstacleManager();
    this.collectibleManager = new CollectibleManager();
    this.physics = new KidFriendlyPhysics();
    
    this.gameState = 'ready'; // 'ready', 'playing', 'paused', 'completed'
    this.stats = new GameStats();
  }
  
  update(deltaTime) {
    if (this.gameState !== 'playing') return;
    
    this.vehicle.update(deltaTime);
    this.world.scroll(this.vehicle.speed * deltaTime);
    this.obstacleManager.update(deltaTime, this.world.position);
    this.collectibleManager.update(deltaTime, this.world.position);
    
    this.checkCollisions();
    this.updateUI();
  }
}

class Vehicle {
  constructor(type) {
    this.type = type; // 'car', 'helicopter', 'plane'
    this.position = { x: 0, y: 0, z: 0 };
    this.velocity = { x: 0, y: 0 };
    this.speed = this.getBaseSpeed();
    this.controls = this.getControlScheme();
    
    // Visual properties
    this.trail = [];
    this.powerUps = new Map();
    this.animations = new AnimationController();
  }
  
  getControlScheme() {
    switch(this.type) {
      case 'car':
        return { 
          primary: 'horizontal', // Left/right steering
          secondary: null,
          boost: true 
        };
      case 'helicopter':
        return { 
          primary: 'vertical', // Up/down altitude
          secondary: 'horizontal', // Optional side movement
          boost: false 
        };
      case 'plane':
        return { 
          primary: 'both', // Full 2D movement
          secondary: null,
          boost: true 
        };
    }
  }
  
  handleInput(input, intensity) {
    const maxMovement = this.getMaxMovementForType();
    
    switch(this.controls.primary) {
      case 'horizontal':
        this.velocity.x = input.horizontal * maxMovement.x;
        break;
      case 'vertical':
        this.velocity.y = input.vertical * maxMovement.y;
        break;
      case 'both':
        this.velocity.x = input.horizontal * maxMovement.x;
        this.velocity.y = input.vertical * maxMovement.y;
        break;
    }
    
    // Kid-friendly input smoothing
    this.applySmoothMovement(0.1);
  }
}

class ObstacleManager {
  constructor() {
    this.obstacles = [];
    this.spawnTimer = 0;
    this.patterns = this.loadObstaclePatterns();
  }
  
  loadObstaclePatterns() {
    return {
      car: [
        { type: 'pothole', size: 'medium', behavior: 'static' },
        { type: 'rock', size: 'small', behavior: 'bounce' },
        { type: 'puddle', size: 'large', behavior: 'splash' }
      ],
      helicopter: [
        { type: 'cloud', size: 'large', behavior: 'obscure' },
        { type: 'bird', size: 'small', behavior: 'friendly_avoid' },
        { type: 'balloon', size: 'medium', behavior: 'pop' }
      ],
      plane: [
        { type: 'storm_cloud', size: 'large', behavior: 'turbulence' },
        { type: 'bird_flock', size: 'medium', behavior: 'deflect' },
        { type: 'lightning', size: 'small', behavior: 'sparkle' }
      ]
    };
  }
  
  spawnObstacle(vehicleType, worldPosition) {
    const patterns = this.patterns[vehicleType];
    const pattern = patterns[Math.floor(Math.random() * patterns.length)];
    
    const obstacle = new KidFriendlyObstacle({
      type: pattern.type,
      position: { x: worldPosition.x + 1000, y: this.getRandomY() },
      behavior: pattern.behavior,
      kidSafe: true // Always non-lethal
    });
    
    this.obstacles.push(obstacle);
  }
}
```

## 3. BlockWorld (Ispirato Minecraft)

---

## 4. Game Architecture

### Core Classes

```javascript
class DigitalSubbuteo {
  constructor(config) {
    this.gameMode = config.mode; // 'single', 'multiplayer', 'skills'
    this.difficulty = config.difficulty; // 'easy', 'normal', 'hard'
    this.matchLength = config.matchLength; // 1, 3, 5 goals or time-based
    
    this.field = new GameField();
    this.players = {
      team1: new Team('blue', 'left'),
      team2: new Team('red', 'right')
    };
    this.ball = new Ball();
    this.physics = new PhysicsEngine();
    this.ai = new AIController();
    this.ui = new GameUI();
    
    this.gameState = 'menu'; // 'menu', 'playing', 'paused', 'goal', 'finished'
    this.currentPlayer = null;
    this.score = { team1: 0, team2: 0 };
    this.turn = 'team1';
  }
}

class GameField {
  constructor() {
    this.width = 1000;
    this.height = 625;
    this.goals = {
      left: { x: 0, y: 250, width: 20, height: 125 },
      right: { x: 980, y: 250, width: 20, height: 125 }
    };
    this.boundaries = this.setupBoundaries();
  }
  
  setupBoundaries() {
    // Define field boundaries with gentle bouncing
    return {
      top: 50,
      bottom: 575,
      left: 50,
      right: 950
    };
  }
  
  checkGoal(ballPosition) {
    // Check if ball is in goal area
    if (ballPosition.x <= this.goals.left.x + this.goals.left.width &&
        ballPosition.y >= this.goals.left.y &&
        ballPosition.y <= this.goals.left.y + this.goals.left.height) {
      return 'team2'; // Goal for team2
    }
    
    if (ballPosition.x >= this.goals.right.x &&
        ballPosition.y >= this.goals.right.y &&
        ballPosition.y <= this.goals.right.y + this.goals.right.height) {
      return 'team1'; // Goal for team1
    }
    
    return null;
  }
}

class Team {
  constructor(color, side) {
    this.color = color;
    this.side = side; // 'left' or 'right'
    this.players = this.setupPlayers();
    this.goalkeeper = this.players[0];
    this.selectedPlayer = null;
  }
  
  setupPlayers() {
    const players = [];
    const baseX = this.side === 'left' ? 200 : 800;
    
    // Goalkeeper
    players.push(new Player({
      id: 0,
      type: 'goalkeeper',
      position: { x: this.side === 'left' ? 100 : 900, y: 312.5 },
      color: this.color,
      team: this.side
    }));
    
    // Field players in simple formation
    const positions = [
      { x: baseX, y: 200 },      // Defender 1
      { x: baseX, y: 425 },      // Defender 2
      { x: baseX + 150, y: 150 }, // Midfielder 1
      { x: baseX + 150, y: 312.5 }, // Midfielder 2
      { x: baseX + 150, y: 475 }, // Midfielder 3
    ];
    
    positions.forEach((pos, index) => {
      players.push(new Player({
        id: index + 1,
        type: 'field',
        position: pos,
        color: this.color,
        team: this.side
      }));
    });
    
    return players;
  }
  
  selectNearestPlayer(ballPosition) {
    let nearest = null;
    let minDistance = Infinity;
    
    this.players.forEach(player => {
      if (player.type === 'goalkeeper') return; // Skip GK for auto-selection
      
      const distance = Math.sqrt(
        Math.pow(player.position.x - ballPosition.x, 2) +
        Math.pow(player.position.y - ballPosition.y, 2)
      );
      
      if (distance < minDistance) {
        minDistance = distance;
        nearest = player;
      }
    });
    
    this.selectedPlayer = nearest;
    return nearest;
  }
}

class Player {
  constructor(config) {
    this.id = config.id;
    this.type = config.type; // 'goalkeeper' or 'field'
    this.position = config.position;
    this.color = config.color;
    this.team = config.team;
    this.radius = config.type === 'goalkeeper' ? 25 : 20;
    this.selected = false;
    this.canMove = true;
    
    // Animation properties
    this.targetPosition = { ...this.position };
    this.velocity = { x: 0, y: 0 };
    this.animationTime = 0;
  }
  
  flick(direction, power) {
    if (!this.canMove) return false;
    
    // Calculate movement based on direction and power
    const maxDistance = 150; // Maximum flick distance
    const actualPower = Math.min(power, 1.0);
    
    this.targetPosition = {
      x: this.position.x + (direction.x * maxDistance * actualPower),
      y: this.position.y + (direction.y * maxDistance * actualPower)
    };
    
    // Clamp to field boundaries
    this.clampToField();
    
    // Set velocity for smooth animation
    this.velocity = {
      x: (this.targetPosition.x - this.position.x) * 0.1,
      y: (this.targetPosition.y - this.position.y) * 0.1
    };
    
    this.canMove = false;
    this.animationTime = 0.5; // 500ms animation
    
    return true;
  }
  
  clampToField() {
    const bounds = {
      minX: 70,
      maxX: 930,
      minY: 70,
      maxY: 555
    };
    
    // Goalkeeper stays near goal
    if (this.type === 'goalkeeper') {
      bounds.minX = this.team === 'left' ? 70 : 850;
      bounds.maxX = this.team === 'left' ? 150 : 930;
    }
    
    this.targetPosition.x = Math.max(bounds.minX, Math.min(bounds.maxX, this.targetPosition.x));
    this.targetPosition.y = Math.max(bounds.minY, Math.min(bounds.maxY, this.targetPosition.y));
  }
  
  update(deltaTime) {
    if (this.animationTime > 0) {
      this.animationTime -= deltaTime;
      
      // Smooth movement towards target
      this.position.x += this.velocity.x * deltaTime * 10;
      this.position.y += this.velocity.y * deltaTime * 10;
      
      // Apply friction
      this.velocity.x *= 0.95;
      this.velocity.y *= 0.95;
      
      if (this.animationTime <= 0) {
        this.position = { ...this.targetPosition };
        this.velocity = { x: 0, y: 0 };
        this.canMove = true;
      }
    }
  }
}

class Ball {
  constructor() {
    this.position = { x: 500, y: 312.5 }; // Center of field
    this.velocity = { x: 0, y: 0 };
    this.radius = 15;
    this.isMoving = false;
    this.trail = []; // For visual trail effect
  }
  
  kick(direction, power, fromPosition) {
    const maxPower = 300; // Maximum ball speed
    
    this.velocity = {
      x: direction.x * power * maxPower,
      y: direction.y * power * maxPower
    };
    
    this.isMoving = true;
  }
  
  update(deltaTime, field) {
    if (!this.isMoving && Math.abs(this.velocity.x) < 5 && Math.abs(this.velocity.y) < 5) {
      this.velocity = { x: 0, y: 0 };
      return;
    }
    
    // Update position
    this.position.x += this.velocity.x * deltaTime;
    this.position.y += this.velocity.y * deltaTime;
    
    // Apply friction
    this.velocity.x *= 0.98;
    this.velocity.y *= 0.98;
    
    // Boundary collisions
    this.handleBoundaryCollisions(field);
    
    // Update trail
    this.updateTrail();
    
    // Check if ball has stopped
    if (Math.abs(this.velocity.x) < 10 && Math.abs(this.velocity.y) < 10) {
      this.isMoving = false;
    }
  }
  
  handleBoundaryCollisions(field) {
    // Top and bottom boundaries
    if (this.position.y - this.radius <= field.boundaries.top) {
      this.position.y = field.boundaries.top + this.radius;
      this.velocity.y = -this.velocity.y * 0.8; // Bounce with energy loss
    }
    if (this.position.y + this.radius >= field.boundaries.bottom) {
      this.position.y = field.boundaries.bottom - this.radius;
      this.velocity.y = -this.velocity.y * 0.8;
    }
    
    // Left and right boundaries (excluding goal areas)
    if (this.position.x - this.radius <= field.boundaries.left) {
      this.position.x = field.boundaries.left + this.radius;
      this.velocity.x = -this.velocity.x * 0.8;
    }
    if (this.position.x + this.radius >= field.boundaries.right) {
      this.position.x = field.boundaries.right - this.radius;
      this.velocity.x = -this.velocity.x * 0.8;
    }
  }
  
  updateTrail() {
    if (this.isMoving) {
      this.trail.push({ ...this.position });
      if (this.trail.length > 10) {
        this.trail.shift();
      }
    } else {
      this.trail = [];
    }
  }
  
  checkPlayerCollision(player) {
    const distance = Math.sqrt(
      Math.pow(this.position.x - player.position.x, 2) +
      Math.pow(this.position.y - player.position.y, 2)
    );
    
    return distance <= (this.radius + player.radius);
  }
  
  reset() {
    this.position = { x: 500, y: 312.5 };
    this.velocity = { x: 0, y: 0 };
    this.isMoving = false;
    this.trail = [];
  }
}

class AIController {
  constructor(difficulty = 'easy') {
    this.difficulty = difficulty;
    this.reactionTime = this.getReactionTime();
    this.accuracy = this.getAccuracy();
    this.strategy = this.getStrategy();
  }
  
  getReactionTime() {
    switch (this.difficulty) {
      case 'easy': return 1000; // 1 second delay
      case 'normal': return 600; // 0.6 seconds
      case 'hard': return 300;   // 0.3 seconds
      default: return 800;
    }
  }
  
  getAccuracy() {
    switch (this.difficulty) {
      case 'easy': return 0.6;   // 60% accuracy
      case 'normal': return 0.8; // 80% accuracy
      case 'hard': return 0.95;  // 95% accuracy
      default: return 0.7;
    }
  }
  
  getStrategy() {
    return {
      defensive: this.difficulty === 'easy' ? 0.7 : 0.5,
      aggressive: this.difficulty === 'hard' ? 0.8 : 0.3,
      passing: this.difficulty === 'normal' ? 0.6 : 0.4
    };
  }
  
  decideBestMove(team, ball, opposingTeam) {
    const availablePlayers = team.players.filter(p => p.canMove);
    if (availablePlayers.length === 0) return null;
    
    // Simple AI logic: choose player closest to ball
    let bestPlayer = null;
    let minDistance = Infinity;
    
    availablePlayers.forEach(player => {
      const distance = Math.sqrt(
        Math.pow(player.position.x - ball.position.x, 2) +
        Math.pow(player.position.y - ball.position.y, 2)
      );
      
      if (distance < minDistance) {
        minDistance = distance;
        bestPlayer = player;
      }
    });
    
    if (!bestPlayer) return null;
    
    // Decide direction: aim towards goal with some randomness
    const goalX = team.side === 'left' ? 950 : 50;
    const goalY = 312.5 + (Math.random() - 0.5) * 100; // Add some variation
    
    const direction = {
      x: goalX - bestPlayer.position.x,
      y: goalY - bestPlayer.position.y
    };
    
    // Normalize direction
    const magnitude = Math.sqrt(direction.x * direction.x + direction.y * direction.y);
    direction.x /= magnitude;
    direction.y /= magnitude;
    
    // Add accuracy variation
    const accuracyVariation = (1 - this.accuracy) * 0.5;
    direction.x += (Math.random() - 0.5) * accuracyVariation;
    direction.y += (Math.random() - 0.5) * accuracyVariation;
    
    return {
      player: bestPlayer,
      direction: direction,
      power: 0.6 + Math.random() * 0.3 // Random power between 0.6-0.9
    };
  }
}

class PhysicsEngine {
  constructor() {
    this.gravity = 0;
    this.friction = 0.98;
    this.bounceDamping = 0.8;
  }
  
  checkBallPlayerCollisions(ball, allPlayers) {
    allPlayers.forEach(player => {
      if (ball.checkPlayerCollision(player)) {
        this.handleBallPlayerCollision(ball, player);
      }
    });
  }
  
  handleBallPlayerCollision(ball, player) {
    // Calculate collision direction
    const direction = {
      x: ball.position.x - player.position.x,
      y: ball.position.y - player.position.y
    };
    
    const distance = Math.sqrt(direction.x * direction.x + direction.y * direction.y);
    
    if (distance === 0) return; // Prevent division by zero
    
    // Normalize direction
    direction.x /= distance;
    direction.y /= distance;
    
    // Separate ball from player
    const overlap = (ball.radius + player.radius) - distance;
    ball.position.x += direction.x * overlap;
    ball.position.y += direction.y * overlap;
    
    // Apply collision impulse
    const collisionForce = 100;
    ball.velocity.x += direction.x * collisionForce;
    ball.velocity.y += direction.y * collisionForce;
    
    ball.isMoving = true;
  }
}
```

---

## 5. Configuration Parameters

### Difficulty Settings
```json
{
  "easy": {
    "ai_reaction_time": 1000,
    "ai_accuracy": 0.6,
    "match_length": 1,
    "power_assistance": true,
    "auto_player_select": true
  },
  "normal": {
    "ai_reaction_time": 600,
    "ai_accuracy": 0.8,
    "match_length": 3,
    "power_assistance": false,
    "auto_player_select": true
  },
  "hard": {
    "ai_reaction_time": 300,
    "ai_accuracy": 0.95,
    "match_length": 5,
    "power_assistance": false,
    "auto_player_select": false
  }
}
```

### Team Customization
```json
{
  "teams": [
    { "name": "Blue Lions", "color": "#4A90E2", "keeper_color": "#2E5C8A" },
    { "name": "Red Eagles", "color": "#E74C3C", "keeper_color": "#A93226" },
    { "name": "Green Frogs", "color": "#27AE60", "keeper_color": "#1E8449" },
    { "name": "Yellow Bees", "color": "#F1C40F", "keeper_color": "#B7950B" }
  ]
}
```

---

## 6. Educational Value

### Skills Developed
- **Hand-eye coordination**: Aiming and power control
- **Strategic thinking**: Player positioning and timing
- **Physics understanding**: Ball trajectory and bouncing
- **Social skills**: Turn-taking and fair play
- **Patience**: Waiting for turn, observing opponent moves
- **Spatial awareness**: Field positioning and angles

### Kid-Friendly Features
- **No player injuries**: Players just bounce gently
- **Celebration animations**: Every goal is celebrated
- **Colorful feedback**: Visual effects for all actions
- **Simple rules**: Easy to understand, hard to master
- **Positive reinforcement**: Encourage good sportsmanship

---

## 7. Technical Implementation Notes

### Performance Optimizations
- **Object pooling**: Reuse particle effects and trail segments
- **Simplified physics**: Focus on fun over realism
- **Efficient collision detection**: Spatial partitioning for large numbers of objects
- **Smooth 60fps**: Priority on consistent framerate

### Mobile Adaptations
- **Touch-friendly**: Large touch targets, clear visual feedback
- **Portrait mode support**: Rotate field for mobile screens
- **Haptic feedback**: Vibration on ball contact and goals
- **Battery efficient**: Optimize rendering for mobile devices

### Accessibility Features
- **Color-blind support**: High contrast team colors
- **Large UI elements**: Easy to see and interact with
- **Sound cues**: Audio feedback for all major events
- **Simple controls**: One-finger gameplay possible