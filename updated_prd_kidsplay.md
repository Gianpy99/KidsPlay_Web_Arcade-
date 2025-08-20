# PRD — KidsPlay Web Arcade & Landing Pages (Versione Aggiornata)
**Data:** 20 Agosto 2025  
**Autore:** [Gianpy99] - Aggiornato da Claude  
**Versione:** 2.0

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
**Versione:** 2.0  
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
- Caccia alle Lettere  
- Matematica Facile
- Number Block (2048 semplificato)
- Push Block (Sokoban kid-friendly)
- Campo Minato (griglia 6x6, modalità "scoperta")
- Snake (velocità regolabile)

### Nuovi Giochi Adventure (Aggiunti)
- **BlockWorld** (ispirato Minecraft)
- **Speedy Adventures** (ispirato Sonic)
- **Dino Explorer** (tematica dinosauri)

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
      /math-easy
      ...
    /adventure (nuovi giochi)
      /blockworld
      /speedy-adventures  
      /dino-explorer
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

## 1. BlockWorld (Ispirato Minecraft)

### Concept
Un mondo 2D a blocchi dove il bambino può esplorare, costruire strutture semplici e interagire con creature amichevoli. Focus sulla creatività e risoluzione di problemi basilari.

### Meccaniche Core
- **Mondo**: griglia 2D 20x15 blocchi, vista laterale
- **Blocchi**: 6 tipi (terra, pietra, legno, foglie, acqua, aria)
- **Costruzione**: modalità "creativa" sempre attiva, nessuna raccolta risorse
- **Creatures**: 3 tipi amichevoli (coniglio, uccello, pesce) - solo decorativi
- **Obiettivi**: completare 5 "puzzle costruttivi" (ponte, casa, giardino, castello, barca)

### Controlli
- **Touch**: tap per posizionare/rimuovere blocchi, swipe per muovere personaggio
- **Gamepad**: D-pad movimento, A=posiziona, B=rimuove, Y=cambia blocco
- **Keyboard**: WASD movimento, Spazio=posiziona, X=rimuove, Tab=cambia blocco

### Parametri Configurabili
- `world_size`: "small" (15x10), "medium" (20x15), "large" (25x20)
- `puzzle_mode`: "guided" (tutorial step-by-step), "free" (esplorazione libera)
- `creatures_active`: true/false
- `auto_save`: true/false

### Educational Value
- Creatività e pianificazione spaziale
- Riconoscimento pattern geometrici
- Problem solving costruttivo

## 2. Speedy Adventures (Ispirato Sonic)

### Concept
Avventura platform 2D con un personaggio veloce che raccoglie gemme colorate e supera ostacoli semplici. Enfasi su coordinazione occhio-mano e timing, mai punitive.

### Meccaniche Core
- **Movimento**: corsa automatica configurabile (3 velocità), salto manuale
- **Livelli**: 8 livelli corti (30-60 secondi), temi variabili (giardino, spiaggia, montagna, spazio)
- **Collezionabili**: gemme colorate che insegnano i colori e conteggio fino a 20
- **Ostacoli**: mai letali - rimbalzi e rallentamenti temporanei
- **Power-ups**: salto più alto, velocità maggiore (temporanei)
- **Boss semplici**: 2 "sfide" Pokemon-style (rock-paper-scissors con animazioni)

### Combat System (Pokemon-style)
- **Incontri**: solo 2 boss amichevoli per tutto il gioco
- **Meccanica**: selezione di 3 azioni (Salto, Corsa, Amicizia)
- **Feedback**: sempre positivo, nessuna sconfitta possibile
- **Ricompense**: nuove gemme colorate e celebrazione

### Controlli
- **Touch**: tap per saltare, hold per correre più veloce, swipe up per power-up
- **Gamepad**: A=salto, RT=velocità, Y=power-up
- **Keyboard**: Spazio=salto, Shift=velocità, E=power-up

### Parametri Configurabili
- `speed_level`: 1 (lento), 2 (normale), 3 (veloce)
- `auto_run`: true/false
- `boss_encounters`: "none", "simple", "full"
- `gem_count_max`: 10, 15, 20
- `level_length`: "short" (30s), "medium" (60s), "long" (90s)

### Educational Value
- Coordinazione motoria
- Conteggio e riconoscimento colori  
- Timing e reazione

## 3. Dino Explorer (Tematica Dinosauri)

### Concept
Esplorazione educativa in un mondo preistorico sicuro dove il bambino scopre dinosauri amichevoli, impara i loro nomi e caratteristiche attraverso mini-giochi interattivi.

### Meccaniche Core
- **Mondo**: 5 biomi (foresta, deserto, fiume, montagna, valle)
- **Dinosauri**: 10 specie con nomi semplificati (Rex, Trio, Lungo, Vola, ecc.)
- **Scoperta**: ogni dinosauro ha una "carta" collezionabile con info base
- **Mini-giochi**: nutrire dinosauri (matching), pulire fossili (touch/drag), creare impronte
- **Combat amichevole**: solo "gioco delle coccole" - accarezzare dinosauri nel punto giusto

### Sistema di Scoperta
- **Tracce**: seguire impronte colorate per trovare dinosauri
- **Interazione**: ogni dinosauro ha 2-3 animazioni (mangia, gioca, dorme)
- **Collezionismo**: album con 10 carte, progresso visibile
- **Fatti divertenti**: 1 frase semplice per dinosauro ("Il T-Rex aveva denti grandi!")

### Combat/Interaction System
- **Meccanica**: accarezzare dinosauri nei punti luminosi
- **Feedback**: suoni felici, animazioni carine, hearts/stars
- **Nessun pericolo**: tutti i dinosauri sono amichevoli
- **Ricompense**: unlock nuove aree, carte rare, accessori per il personaggio

### Controlli
- **Touch**: tap per muoversi, drag per accarezzare, pinch per zoom carte
- **Gamepad**: D-pad movimento, A=interagisci, X=accarezza, Y=album
- **Keyboard**: WASD movimento, Spazio=interagisci, E=accarezza, Tab=album

### Parametri Configurabili
- `world_size`: "small" (3 biomi), "medium" (5 biomi), "large" (7 biomi)
- `dino_count`: 6, 10, 12
- `discovery_help`: "guided" (frecce), "hints" (sparkles), "free" (esplorazione)
- `minigame_difficulty`: "easy", "normal"
- `educational_mode`: "names_only", "facts_simple", "facts_detailed"

### Educational Value
- Conoscenza base paleontologia
- Lettura e memorizzazione nomi
- Osservazione e classificazione

---

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
  }
}
```

---

# Setup Modulare (setup.sh)

Il setup sarà suddiviso in moduli indipendenti per facilitare manutenzione e deployment parziali.

## Struttura Moduli Setup
1. **core-setup.sh** - Struttura base directory e file comuni
2. **educational-games-setup.sh** - Giochi educativi tradizionali  
3. **adventure-games-setup.sh** - Nuovi giochi avventura
4. **config-setup.sh** - File configurazione e profili
5. **assets-setup.sh** - Media files e risorse
6. **deployment-setup.sh** - Build e deploy finale

Ogni modulo può essere eseguito indipendentemente per aggiornamenti mirati o nuove installazioni.

---

# Roadmap Aggiornata

## Fase 1 (MVP) - Q3 2025
- Core platform + giochi educativi base
- Supporto gamepad basic
- 2 profili utente (figlio1/figlio2)

## Fase 2 (Adventure) - Q4 2025  
- BlockWorld + Speedy Adventures + Dino Explorer
- Advanced gamepad mapping
- PWA support

## Fase 3 (Enhanced) - Q1 2026
- Multiplayer locale (2 gamepad)
- Voice commands sperimentali
- Analytics privacy-safe per genitori

## Fase 4 (Scale) - Q2 2026
- Plugin system per giochi di terze parti
- Community content (moderato)
- Advanced accessibility features

---

# Quality Assurance

## Test Matrix
- **Dispositivi**: PC Windows/Mac, Android 8+, tablet 10"
- **Gamepad**: PS4/PS5, Xbox One/Series, Generic HID
- **Performance**: 60fps PC, 30fps mobile minimo
- **Accessibilità**: colorblind-friendly, high-contrast mode

## Metriche di Successo
- Tempo di caricamento gioco < 2s
- Crash rate < 0.1%
- Input lag < 50ms su tutti i dispositivi
- User retention: 80% ritorno seconda sessione