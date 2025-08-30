# TEMPLATE: How to add a new game to KidsPlay Web Arcade

This template describes the minimal folder structure, required files and conventions for adding a new game to the KidsPlay Web Arcade.

1) Directory structure
```
/games/<category>/<game-id>/
  index.html         # game entrypoint (must accept query params)
  game.js            # core game logic (optional if embedded)
  assets/            # images/sounds/fonts
  README.md          # short developer notes
```

2) index.html requirements
- Must accept query params: `profile`, `difficulty`, `language` (via `URLSearchParams`).
- Must export or expose a global `initGame(config)` function or run automatically when loaded.
- Should not depend on external CDNs for critical assets.

3) Configuration and metadata
- Add an entry in `games.json` with keys: `id`, `title`, `category`, `min_age`, `icon`.
- Provide optional default config `config.json` inside game folder for level defaults.

4) Input & controls
- Use `UniversalInputManager` (or implement touch/gamepad/keyboard fallbacks).
- Provide clear on-screen controls for touch devices.

5) Accessibility
- Provide text alternatives for important images.
- Provide audio on/off and visual-only mode.

6) Offline
- Keep assets size reasonable. Use Service Worker to cache game assets for offline play.

7) Acceptance tests
- Game loads from catalog URL and starts within 3s on a standard dev machine.
- Controls respond to touch/keyboard/gamepad.
- No console errors.

8) Example metadata for `games.json`
```
{
  "id": "my-game",
  "title": "My Game",
  "category": "educational",
  "min_age": 5,
  "icon": "/games/educational/my-game/icon-192.png"
}
```
