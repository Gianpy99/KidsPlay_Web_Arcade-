Digital Subbuteo - Developer Notes

This folder contains the Digital Subbuteo game - a kid-friendly digital table football game.

Features:
- Touch/mouse controls for player movement and ball kicking
- Turn-based gameplay
- Goal celebration animations
- Penalty shootout mode
- Responsive design for mobile/tablet

Required files:
- index.html (complete game implementation)
- assets/ (future icons, sounds, sprites)

How to run locally:
1. Start the dev server (python server.py from `src/backend`)
2. Open: http://localhost:8080/games/adventure/digital-subbuteo/index.html

Game specifics:
- Accepts query params: `profile`, `difficulty`, `language`
- Drag and flick controls for players and ball
- First to 3 goals wins
- Kid-friendly: no harsh collisions, positive feedback

Controls:
- Touch/Mouse: Drag from player or ball to set direction and power
- Keyboard: R=reset, 1=normal mode, 2=skills mode

Notes:
- Self-contained in single HTML file
- Uses inline CSS and JavaScript for simplicity
- Integrates with user-manager.js when available
