Speedy Adventures - Developer Notes

This folder contains the Speedy Adventures game.

Required files:
- index.html
- assets/ (icons, sprites, audio)

How to run locally:
1. Start the dev server (python server.py from `src/backend`)
2. Open: http://localhost:8080/games/adventure/speedy-adventures/index.html

Game specifics:
- Accepts query params: `profile`, `difficulty`, `language`
- Exposes global `Game` object with `start()` method (recommended)

Notes:
- Keep asset sizes small for fast load
- Use `UniversalInputManager` for input handling
