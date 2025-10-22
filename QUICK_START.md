# 🎮 KidsPlay Web Arcade - Quick Start Guide

## 🚀 Come Avviare la Piattaforma

### Metodo 1: Avvio Rapido
```powershell
cd "C:\Development\KidsPlay_Web_Arcade-\src\frontend"
python -m http.server 8080
```

Poi apri nel browser: **http://localhost:8080**

### Metodo 2: Dalla Root
Apri semplicemente `index.html` alla root - reindirizza automaticamente!

---

## 🎯 Cosa Puoi Fare Ora

### Giocare Subito ✅
1. Apri http://localhost:8080 nel browser
2. Scegli uno degli 8 giochi disponibili
3. Usa tastiera, mouse o gamepad per giocare

### Testare su Mobile 📱
1. Trova il tuo IP locale: `ipconfig` 
2. Avvia il server come sopra
3. Apri `http://[tuo-ip]:8080` sul mobile

### Aggiungere un Profilo 👤
Modifica `src/frontend/config/figlio1.json` o `figlio2.json`:
```json
{
  "name": "Marco",
  "language": "it",
  "theme": "blue",
  "games": ["snake", "memory-letters", "dino-explorer"],
  "difficulty": {
    "snake": "easy",
    "math-easy": "normal"
  }
}
```

### Sviluppare Nuovo Gioco 🛠️
1. Crea cartella in `src/frontend/games/educational/` o `adventure/`
2. Aggiungi `index.html` con il gioco
3. Registra in `src/frontend/data/games.json`
4. Segui la struttura degli altri giochi

---

## 📚 Giochi Disponibili

| Gioco | Categoria | Età | Skills |
|-------|-----------|-----|--------|
| 🐍 Snake | Educational | 5-10 | Coordinazione |
| 🔤 Memory Lettere | Educational | 4-7 | Memoria, Alfabeto |
| 🔍 Caccia Lettere | Educational | 5-8 | Osservazione |
| 🔢 Matematica | Educational | 5-7 | Aritmetica |
| 🧱 BlockWorld | Adventure | 6-10 | Creatività |
| 💨 Speedy | Adventure | 5-9 | Riflessi |
| 🦕 Dino Explorer | Adventure | 5-8 | Esplorazione |
| ⚽ Subbuteo | Adventure | 6-12 | Strategia |

---

## 🎮 Controlli

### Tastiera ⌨️
- **Frecce / WASD** = Movimento
- **Spazio / Enter** = Azione
- **ESC** = Pausa/Menu

### Gamepad 🎮
- **D-Pad / Stick** = Movimento  
- **A (Xbox) / X (PS)** = Azione
- **Start** = Menu

### Touch 👆
- **Tap** = Azione
- **Swipe** = Direzione

---

## ⚙️ Configurazione Profili

### Profili Disponibili
1. **default** - Configurazione base
2. **figlio1** - Profilo personalizzabile
3. **figlio2** - Secondo profilo

### Parametri Configurabili
- `name` - Nome del bambino
- `language` - Lingua (it, en)
- `theme` - Tema colori
- `games` - Lista giochi accessibili
- `difficulty` - Difficoltà per gioco
- `audio_enabled` - Controllo audio
- `max_session_time` - Limite sessione (minuti)

---

## 🐛 Risoluzione Problemi

### Il gamepad non funziona
- Usa Chrome o Edge (migliore supporto)
- Clicca sulla pagina prima di usare il gamepad
- Premi un pulsante per "svegliare" il controller

### Audio non funziona
- I browser richiedono interazione utente
- Clicca/tocca la schermata prima
- Verifica volume nel profilo

### Gioco non carica
- Controlla la console browser (F12)
- Verifica che il server sia attivo
- Controlla path nel file games.json

---

## 📞 File Importanti

- **Catalogo Giochi**: `src/frontend/data/games.json`
- **Configurazioni**: `src/frontend/config/*.json`
- **Documentazione**: `docs/` folder
- **Status Report**: `docs/STATUS_REPORT_OCT2025.md`

---

## ✅ Status Progetto

**Stato**: 🟢 Production Ready  
**Giochi**: 8/8 Completi  
**Errori**: 0  
**Test**: ✅ Passed  

**Tutto funziona! Pronto per essere usato! 🎉**
