# KidsPlay Web Arcade 🎮

Una piattaforma di giochi educativi per bambini di 5-6 anni, progettata per essere sicura, divertente e accessibile.

## 🌟 Caratteristiche

- **🎯 Giochi Educativi**: Memory, matematica, lettura e altro
- **🎮 Supporto Gamepad**: Compatibile con PlayStation, Xbox e controller generici
- **📱 Mobile-Friendly**: Design responsive per tablet e smartphone
- **👥 Multi-Profilo**: Configurazioni separate per ogni bambino
- **🔊 Audio Controllato**: Suoni kid-friendly con controlli parentali
- **🌐 PWA Ready**: Installabile come app su dispositivi mobili

## 🏗️ Struttura del Progetto

```
KidsPlay_Web_Arcade/
├── index.html                   # Redirect alla piattaforma
├── src/
│   └── frontend/
│       ├── index.html           # Homepage principale
│       ├── manifest.json        # PWA manifest
│       ├── sw.js               # Service worker
│       ├── config/             # Configurazioni profili
│       │   ├── figlio1.json
│       │   ├── figlio2.json
│       │   └── default.json
│       ├── data/
│       │   └── games.json      # Catalogo giochi (8 giochi)
│       ├── games/              # Directory giochi
│       │   ├── educational/    # 4 giochi educativi
│       │   │   ├── snake/
│       │   │   ├── memory-letters/
│       │   │   ├── letter-hunt/
│       │   │   └── math-easy/
│       │   └── adventure/      # 4 giochi avventura
│       │       ├── blockworld/
│       │       ├── speedy-adventures/
│       │       ├── dino-explorer/
│       │       └── digital-subbuteo/
│       ├── shared/
│       │   └── common/
│       │       ├── core/       # Engine di gioco
│       │       │   ├── game-engine.js
│       │       │   ├── input-manager.js
│       │       │   └── audio-manager.js
│       │       └── styles/     # CSS
│       │           ├── base.css
│       │           └── mobile.css
│       └── js/
│           └── user-manager.js  # Gestione utenti
└── docs/                       # Documentazione
```

## 🚀 Avvio Rapido

### 1. Test Locale

Per testare immediatamente la piattaforma:

```bash
# Con Python 3 (dalla root del progetto)
cd src/frontend
python -m http.server 8080

# Oppure usa il server personalizzato
python server.py
```

Poi apri http://localhost:8080 nel browser.

### 2. Test Mobile

Per testare su dispositivi mobili:

1. Trova il tuo IP locale: `ipconfig` (Windows) o `ifconfig` (Mac/Linux)
2. Avvia il server come sopra
3. Apri `http://[tuo-ip]:8080` sul dispositivo mobile

### 3. Test Gamepad

1. Collega un controller USB o Bluetooth
2. Apri Chrome o Edge (miglior supporto gamepad)
3. Dovrai vedere "🎮 Controller connesso" in alto a destra

## 🎮 Controlli Supportati

### Tastiera
- **Frecce / WASD**: Movimento
- **Spazio / Enter**: Azione primaria
- **Esc**: Menu/Pausa

### Gamepad
- **D-Pad / Stick sinistro**: Movimento
- **A (Xbox) / X (PlayStation)**: Azione primaria
- **B (Xbox) / O (PlayStation)**: Azione secondaria
- **Start**: Menu

### Touch (Mobile)
- **Tap**: Azione
- **Swipe**: Movimento direzionale
- **Long press**: Azioni alternative

## 👶 Giochi Disponibili

### Educativi ✅
- **🐍 Snake Educativo**: Coordinazione e direzioni
- **🔤 Memory Lettere**: Memoria e alfabeto
- **🔍 Caccia alle Lettere**: Trova le lettere nascoste
- **🔢 Matematica Facile**: Somme e sottrazioni fino a 10

### Avventura ✅
- **🧱 BlockWorld**: Creatività stile Minecraft
- **💨 Speedy Adventures**: Platform runner veloce
- **🦕 Dino Explorer**: Esplora il mondo dei dinosauri (Pokemon-style)
- **⚽ Digital Subbuteo**: Calcio da tavolo digitale

**Totale: 8 giochi completamente funzionanti!**
- **💨 Speedy Adventures**: Platform veloce
- **🦕 Dino Explorer**: Esplorazione educativa

## ⚙️ Configurazione Profili

Ogni profilo ha configurazioni personalizzabili:

```json
{
    "profile_name": "figlio1",
    "age": 5,
    "difficulty_level": "easy",
    "enabled_games": ["snake", "memory-letters"],
    "gamepad_enabled": true,
    "parental_controls": {
        "max_session_time": 30,
        "volume_limit": 0.7
    }
}
```

## 🌐 Deployment Produzione

### Hosting Statico

La piattaforma può essere deployata su qualsiasi hosting statico:

- **Netlify**: Drag & drop della cartella
- **Vercel**: Deploy automatico da Git
- **GitHub Pages**: Push al repository
- **Web server tradizionale**: Copia i file

### Configurazione Domini

Per profili multipli via sottodominio:

```
kidsplay.tuodominio.com     → Profilo default
figlio1.kidsplay.tuodominio.com → Profilo figlio1
figlio2.kidsplay.tuodominio.com → Profilo figlio2
```

## 🔧 Sviluppo

### Aggiungere Nuovi Giochi

1. Crea directory `games/[categoria]/[nome-gioco]/`
2. Aggiungi `index.html` con il gioco
3. Aggiorna `games.json` con metadati
4. Testa con parametri: `?profile=figlio1&difficulty=easy`

### API Giochi

Ogni gioco deve:
- Accettare parametri via query string
- Includere pulsante "Torna ai Giochi"
- Supportare controlli universali
- Essere responsivo mobile

### Struttura HTML Gioco

```html
<!DOCTYPE html>
<html>
<head>
    <title>Nome Gioco - KidsPlay</title>
</head>
<body>
    <a href="../../../index.html" id="backToCatalog">← Torna</a>
    <!-- Contenuto gioco -->
    <script>
        // Leggi parametri profilo
        const params = new URLSearchParams(window.location.search);
        const profile = params.get('profile') || 'default';
        const difficulty = params.get('difficulty') || 'easy';
    </script>
</body>
</html>
```

## 🐛 Troubleshooting

### Gamepad Non Rilevato
- Verifica compatibilità browser (Chrome/Edge consigliati)
- Prova a premere un pulsante per "svegliare" il controller
- Su mobile, usa controller Bluetooth compatibili

### Audio Non Funziona
- I browser richiedono interazione utente prima di riprodurre audio
- Clicca/tocca la schermata prima che inizi l'audio
- Verifica impostazioni volume nel profilo

### PWA Non Si Installa
- Usa HTTPS in produzione (non localhost)
- Verifica manifest.json sia accessibile
- Assicurati che service worker sia registrato

## 📞 Supporto

Per problemi o suggerimenti:

1. Controlla la console browser (F12) per errori
2. Testa su browser/dispositivo diverso
3. Verifica configurazione profilo JSON

## 📝 Licenza

Progetto personale - Uso familiare

---

**🎮 Buon divertimento con KidsPlay! 🎮**