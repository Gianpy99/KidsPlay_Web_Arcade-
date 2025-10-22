# Dino Explorer - AI Image Generation Setup

## 🎨 Funzionalità AI

Dino Explorer ora include la **generazione di immagini AI** usando Google Gemini 2.5 Flash Image API! Quando scopri un dinosauro, il gioco può generare automaticamente un'immagine educativa del dinosauro stesso.

## 🚀 Nuove Funzionalità Implementate

### 1. **Blocchi Spingibili (Sokoban-Style)** 📦
- Blocchi che puoi spingere per risolvere puzzle
- Usa strategia per muovere i blocchi e raggiungere i dinosauri
- I blocchi si spingono nella direzione del movimento

### 2. **Dinosauri Mobili (Nemici)** 🦖
- Dinosauri che si muovono ogni turno verso il giocatore
- Approccio simile agli scacchi: movimento intelligente basato sulla posizione
- **ATTENZIONE**: Se un dinosauro mobile ti raggiunge, devi ricominciare il livello!

### 3. **Generazione Immagini AI** 🎨
- Immagini uniche generate da Gemini AI per ogni dinosauro scoperto
- Stile educativo e adatto ai bambini
- Immagini salvate in cache per accesso veloce

### 4. **Persistenza Immagini** 💾
- Le immagini generate vengono salvate nel browser (localStorage)
- Cache automatica per 30 giorni
- Nessun bisogno di rigenerare immagini già viste

## 🔧 Configurazione API Gemini

### Passo 1: Ottieni la tua API Key

1. Vai su [Google AI Studio](https://aistudio.google.com/apikey)
2. Accedi con il tuo account Google
3. Clicca su "Get API Key" o "Create API Key"
4. Copia la chiave API generata

### Passo 2: Configura il Gioco

Apri il file `game-config.js` e modifica la riga:

```javascript
geminiApiKey: 'YOUR_GEMINI_API_KEY_HERE',
```

Sostituisci `'YOUR_GEMINI_API_KEY_HERE'` con la tua chiave API effettiva.

**Esempio formato chiave:**
```javascript
// La tua chiave avrà un formato simile a questo (ma con caratteri diversi):
geminiApiKey: 'AIzaSy_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
```

### Passo 3: Attiva la Generazione AI

Il gioco rileverà automaticamente la chiave API e attiverà la generazione di immagini.

Verifica nella console del browser:
- ✅ **"Gemini API configured - AI image generation enabled"** → Tutto ok!
- ℹ️ **"Gemini API not configured - using emoji dinosaurs"** → Configura l'API key

## 🎮 Come Giocare con le Nuove Funzionalità

### Blocchi Spingibili 📦
- Quando ti muovi contro un blocco (📦), lo spingi nella direzione del movimento
- Usa i blocchi strategicamente per creare percorsi
- I blocchi non possono essere spinti contro muri o altri oggetti

### Dinosauri Mobili 🦖
- I dinosauri rossi (🦖) si muovono ogni volta che ti muovi
- Si muovono verso di te usando logica "a scacchi"
- **EVITALI!** Se ti toccano, devi ricominciare il livello
- Pianifica i tuoi movimenti per evitarli

### Immagini AI 🎨
- Quando scopri un dinosauro, l'immagine viene generata automaticamente
- Vedrai "🎨 Generazione immagine AI..." mentre viene creata
- L'immagine appare nel modal del dinosauro
- Immagini salvate per future scoperte dello stesso dinosauro

## 🛠️ Configurazioni Avanzate

In `game-config.js` puoi controllare:

```javascript
// Abilita/Disabilita funzionalità
enableAIImages: false,          // Generazione AI (auto-attivato con API key)
enablePushableBlocks: true,     // Blocchi spingibili
enableMovingDinosaurs: true,    // Dinosauri mobili
```

## 📊 Gestione Cache

### Visualizza Statistiche Cache
Nella console del browser:
```javascript
geminiImageService.getCacheStats()
// Ritorna: { count: 5, totalSize: 123456, totalSizeMB: "0.12" }
```

### Pulire Cache
Per liberare spazio o ricominciare:
```javascript
geminiImageService.clearAllCache()
```

## 🔒 Sicurezza API Key

⚠️ **IMPORTANTE**: 
- Non condividere la tua API key pubblicamente
- Non committare `game-config.js` con la chiave reale su repository pubblici
- Considera l'uso di variabili d'ambiente per deployment in produzione

### Per Sviluppo Locale
Puoi usare la chiave direttamente in `game-config.js` (assicurati di non committare il file)

### Per Produzione
Considera di usare:
- Variabili d'ambiente
- Backend proxy per nascondere la chiave
- Sistemi di gestione segreti (AWS Secrets Manager, Azure Key Vault, ecc.)

## 🐛 Risoluzione Problemi

### "⚠️ Gemini API not configured"
- Verifica di aver inserito la chiave API in `game-config.js`
- Assicurati che la chiave non sia vuota o uguale al placeholder

### "❌ Error generating dinosaur image"
- Verifica la connessione internet
- Controlla che l'API key sia valida
- Verifica nella console del browser per dettagli dell'errore
- Assicurati di non aver superato i limiti di utilizzo dell'API

### "⚠️ Immagine non disponibile"
- Gemini potrebbe essere temporaneamente non disponibile
- Il gioco continua a funzionare con emoji dinosauri
- Riprova più tardi

### Cache Piena
Se localStorage è pieno:
```javascript
geminiImageService.clearAllCache()
```

## 📈 Limiti API Gemini

Google Gemini ha limiti di utilizzo:
- **Free tier**: Limitato a un certo numero di richieste/giorno
- Monitora l'uso su [Google AI Studio](https://aistudio.google.com/)
- Le immagini in cache non contano verso il limite

## 🎯 Prossimi Miglioramenti

Possibili future funzionalità:
- [ ] Selezione qualità immagine (veloce/dettagliata)
- [ ] Temi visivi personalizzabili
- [ ] Galleria di tutti i dinosauri scoperti
- [ ] Esportazione immagini
- [ ] Modalità offline con immagini pre-generate

## 📝 Crediti

- **Game Design**: KidsPlay Web Arcade
- **AI Image Generation**: Google Gemini 2.5 Flash Image
- **Implementation Pattern**: Basato su seasonal_quest_app

---

**Buona esplorazione e divertiti a scoprire i dinosauri! 🦕🦖**
