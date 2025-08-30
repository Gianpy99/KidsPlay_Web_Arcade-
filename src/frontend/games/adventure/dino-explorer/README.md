Dino Explorer - Developer Notes

This folder contains the Dino Explorer game.

Required files:
- index.html
- assets/ (sprites, audio, cards)

How to run locally:
1. Start the dev server (python server.py from `src/backend`)
2. Open: http://localhost:8080/games/adventure/dino-explorer/index.html

Game specifics:
- Accepts query params: `profile`, `difficulty`, `language`
- Prefer modular mini-games for fossil cleaning, matching, and feeding
