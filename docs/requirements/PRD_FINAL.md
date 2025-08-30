## PRD — KidsPlay Web Arcade (FINAL)

Version: 2.1
Last updated: 2025-08-30

Overview
--------
KidsPlay Web Arcade is a safe, ad-free, browser-first platform of educational and light-adventure games for young children (target 5–8 years). The product is modular: games are self-contained packages and profiles (subdomains or local configs) determine available content and difficulty.

Goals
-----
- Kid-friendly UI and controls
- Educational value combined with playful mechanics
- Fast loading and responsive on desktop/tablet/mobile
- Configurable profiles (figlio1, figlio2) and gamepad support

Scope (MVP)
-------------
- Core catalog + games.json
- 8 core games (educational + light arcade)
- Per-profile JSON config and two sample profiles
- Service worker for offline caching (select games)

Key Features
------------
- Catalog populated from `games.json`
- Per-game `/games/<id>/index.html` accepting query params (profile, difficulty, language)
- Universal input manager (touch, keyboard, gamepad)
- Simple parental controls (local JSON + optional backend later)

Architecture & File Layout
-------------------------
```
/kidsplay
  /config
  /games
  /common
  /assets
  index.html
  games.json
```

New Adventure Games (MVP+)
--------------------------
- BlockWorld (creative 2D block builder)
- Speedy Adventures (short platformer levels)
- Dino Explorer (exploration and collectible cards)

Detailed Game Specs
-------------------

1) BlockWorld (2D creative builder)

Concept
- Grid-based 2D creative sandbox focused on construction and simple puzzles. No resource collection; emphasis on creativity and spatial reasoning.

Core Mechanics
- World: grid 20x15 (configurable)
- Blocks: six types (ground, stone, wood, leaf, water, air)
- Place/remove blocks instantly (non-destructive UX for kids)
- Puzzle Mode: small guided tasks (bridge, house) with visual hints

Controls
- Touch: tap to select/place, long-press to open block palette, drag to pan
- Gamepad: D-pad/left stick move, A place, B remove, Y palette
- Keyboard: WASD move, Space place, X remove, Tab palette

Config Parameters (example JSON)
```
{
  "id":"blockworld",
  "world_size":"medium",
  "puzzle_mode":"guided",
  "creatures_active":true,
  "auto_save":true
}
```

Acceptance Criteria
- World loads with given size; blocks place/remove with <100ms latency
- Puzzle sequences complete and provide positive feedback
- Controls work on touch, keyboard and gamepad

Edge cases
- Very large world sizes degrade performance (limit enforced)
- Rapid place/remove spam gracefully throttled

2) Speedy Adventures (short platformer)

Concept
- Short, bright platformer levels emphasizing speed, timing and color/gem collection. Always forgiving: collisions slow or push back, never instant death.

Core Mechanics
- Auto-run optional; manual jump
- Levels: 8 short levels (30-90s) with progressive difficulty
- Collect gems for counting/color exercises
- Two simple boss encounters (non-punitive)

Controls
- Touch: tap jump, hold to charge higher jump, swipe for special
- Gamepad: A jump, RT run/boost
- Keyboard: Space jump, Shift run

Config Parameters (example JSON)
```
{
  "id":"speedy-adventures",
  "speed_level":2,
  "auto_run":true,
  "boss_encounters":"simple",
  "gem_count_max":15
}
```

Acceptance Criteria
- Levels load and finish without fatal states
- Gem collection counts correctly and persists in session
- Gamepad and touch inputs produce same behavior

Edge cases
- Level asset missing -> show friendly fallback screen with reload option
- Audio context unavailable -> game runs silently with visible cues

3) Dino Explorer (exploration + cards)

Concept
- Safe exploration in mini-biomes with collectible dinosaur cards and simple educational mini-games.

Core Mechanics
- 5 biomes, up to 10 dinos per world
- Collect dinos to fill an album; each dino has simple facts
- Mini-games: matching, fossil cleaning, feeding

Controls
- Touch: tap to interact, drag to play mini-games
- Gamepad: D-pad move, A interact
- Keyboard: WASD move, E interact

Config Parameters (example JSON)
```
{
  "id":"dino-explorer",
  "world_size":"medium",
  "dino_count":10,
  "discovery_help":"hints",
  "minigame_difficulty":"easy",
  "educational_mode":"facts_simple"
}
```

Acceptance Criteria
- Dinosaurs collectible UI updates on collection
- Mini-games load and score simple positive feedback
- Album persistence across session

Edge cases
- Missing asset shows placeholder card
- Mini-game failure -> retry allowed without penalty

Performance & Non-functional
---------------------------
- Target: <2s game load, 60fps on desktop, 30fps on mobile
- No personal data collection; COPPA-aware design
- Accessibility: large fonts, high-contrast mode, audio toggle

Roadmap
-------
Phase 1: Core + 8 games (MVP)
Phase 2: Adventure games + PWA + advanced gamepad mapping
Phase 3: Local multiplayer, voice commands experiments

QA & Acceptance
----------------
- Each game loads directly from catalog with query params
- Profile config affects difficulty
- Basic input tests (touch, keyboard, gamepad) pass

Acceptance Test Checklist
-------------------------
- [ ] Catalog (`games.json`) loads and lists all games
- [ ] Opening `/games/<id>/index.html?profile=figlio1` loads the selected game
- [ ] Controls: touch, keyboard, gamepad produce expected actions
- [ ] Audio toggle mutes/unmutes without breaking game
- [ ] Offline: service worker serves at least 3 selected games when offline
- [ ] Profiles: `config/figlio1.json` parameters affect game behavior
- [ ] Edge case: missing asset shows friendly fallback and allows retry

Data Shape Examples
-------------------

`games.json` sample
```
[
  {
    "id": "speedy-adventures",
    "title": "Speedy Adventures",
    "category": "adventure",
    "min_age": 5,
    "icon": "/games/adventure/speedy-adventures/icon-192.png"
  },
  {
    "id": "dino-explorer",
    "title": "Dino Explorer",
    "category": "adventure",
    "min_age": 5,
    "icon": "/games/adventure/dino-explorer/icon-192.png"
  }
]
```

`config/figlio1.json` sample
```
{
  "name": "Marco",
  "language": "it",
  "theme": "blue",
  "games": ["memory-letters","speedy-adventures","dino-explorer"],
  "difficulty": {"speedy-adventures":"easy","memory-letters":"normal"}
}
```

Contact
-------
Owner: Gianpy99
