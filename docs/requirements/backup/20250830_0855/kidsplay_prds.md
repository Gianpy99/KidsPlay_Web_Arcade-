
# PRD — KidsPlay Web Arcade & Landing Pages (Markdown Export)
**Data:** 13 Agosto 2025
**Autore:** [Tuo nome]

---

## Sommario
1. [PRD A — KidsPlay Web Arcade (Piattaforma giochi educativi, modulare e multi-profilo)](#prd-a---kidsplay-web-arcade-piattaforma-giochi-educativi-modulare-e-multi-profilo)
2. [PRD B — Landing Page Personali (figlio1 / figlio2)](#prd-b---landing-page-personali-figlio1--figlio2)
3. [Esempi di configurazione JSON e struttura file](#esempi-di-configurazione-json-e-struttura-file)
4. [Roadmap & Prossimi passi](#roadmap--prossimi-passi)
5. [Note tecniche e deployment](#note-tecniche-e-deployment)
6. [Deliverable & QA](#deliverable--qa)

---

# PRD A — KidsPlay Web Arcade (Piattaforma giochi educativi, modulare e multi-profilo)
**Versione:** 1.2  
**Scopo:** Piattaforma browser di giochi educativi e classici per bambini 5–6 anni, modulare e con supporto a configurazioni utente (profilo) determinate da sottodominio.  
**Data:** 13 Agosto 2025

## 1 — Visione
Fornire un set di giochi semplici, sicuri e divertenti che allenino lettura, scrittura e matematica di base. La piattaforma è modulare: nuovi giochi si aggiungono come pacchetti indipendenti e ogni profilo/sottodominio può attivare una selezione diversa.

## 2 — Obiettivi principali
- Esperienza “kid-friendly”: interfaccia semplice, feedback visivo/sonoro, controlli ridotti.
- Educazione + divertimento: giochi mirati a lettura, scrittura e basi di matematica.
- Facile estendibilità: ogni gioco è un modulo indipendente.
- Multi-profilo: parametri e set giochi per profilo (es. figlio1/figlio2).

## 3 — Scope MVP
**Giochi inclusi (MVP):**
- Memory Lettere & Parole (educativo)  
- Caccia alle Lettere (educativo)  
- Matematica Facile (somma/sottrazione 0–10)  
- Number Block — versione semplificata di 2048  
- Push Block — versione Sokoban semplificata  
- Campo Minato — griglia semplificata, perdite non punitive  
- Snake — controlli semplici, velocità regolabile  
- Mini-platform ispirata a Sonic — grafica originale (evitare copyright)

**Funzionalità MVP:**
- Catalogo dinamico (JSON) che popola la home.
- Ogni gioco con schermata di start, pulsante Gioca e Torna al Catalogo.
- Parametri di difficoltà passabili dal profilo.
- Font grandi, contrasto alto, audio opzionale.

## 4 — Requisiti funzionali
- Caricamento giochi via `games/<game-id>/index.html`.
- `games.json` centrale con metadati (title, icon, category, min_age).
- Profilo utente determinato dal sottodominio (es. `figlio1.borrello.co.uk` → carica `config/figlio1.json`).
- Ogni gioco accetta params (difficulty, language) da query params o API di configurazione.

## 5 — Requisiti non funzionali
- Compatibilità: Chrome/Edge/Firefox/Safari (desktop e tablet).  
- Performance: singolo gioco caricato in ≤2s su connessioni moderate.  
- Sicurezza/privacy: nessuna raccolta di dati personali; niente pubblicità; link esterni opzionali e controllati.  
- Accessibilità: testo leggibile, audio on/off, controlli touch friendly.

## 6 — Architettura e struttura file (consigliata)
```
/kidsplay
  /config
     figlio1.json
     figlio2.json
  /games
     /snake
       index.html, main.js, assets...
     /minesweeper
     ...
  /common
     styles.css, catalog.js, helpers.js
  index.html  (catalog)
  games.json
```

### Esempio `games.json`
```json
[
  {"id":"snake","title":"Snake","category":"Classic","icon":"assets/snake.png"},
  {"id":"memory","title":"Memory Lettere","category":"Educational","icon":"assets/memory.png"}
]
```

### Esempio `config/figlio1.json`
```json
{
  "name":"Marco",
  "theme":"blue",
  "language":"it",
  "games":["memory","letter-hunt","math-easy","snake","mini-platform"],
  "difficulty":{"snake":"easy","minesweeper":"small"}
}
```

## 7 — Flusso utente (MVP)
1. Accesso al sottodominio → catalog caricato con `config/<sottodominio>.json`.  
2. Clic su gioco → `games/<game-id>/index.html?profile=figlio1` oppure loader centrale che passa parametri.  
3. Gioco in fullscreen → Feedback → ritorno al catalogo.

## 8 — Deliverable MVP
- Codice frontend statico (catalog + common CSS/JS).  
- 8 giochi funzionanti (statici, senza backend).  
- File `games.json` e `config/figlioX.json`.  
- Documentazione developer: come aggiungere un gioco (README).

## 9 — QA e acceptance criteria
- Ogni gioco è raggiungibile dal catalogo nel relativo profilo.  
- I parametri di difficoltà definiti nel profilo influenzano il gioco.  
- UI leggibile su tablet (test su iPad / Android).  
- Nessuna risorsa esterna bloccata; tutti i link esterni aprono nuova scheda.

## 10 — Deployment & Hosting
- Static hosting (Netlify / GitHub Pages) o Nginx su VPS / Raspberry Pi.  
- DNS: configurare A/CNAME per `figlioX.borrello.co.uk` → server.  
- Certificati TLS (Let's Encrypt).

## 11 — Roadmap sintetica (consigliata)
- Fase 0: Preparazione struttura + template catalog (1–2 giorni).  
- Fase 1: Implementare 4 giochi base (1 settimana).  
- Fase 2: Aggiungere altri 4 giochi + profilazione subdomain (1 settimana).  
- Fase 3: QA e test usabilità con i bambini (3–5 giorni).

## 12 — Rischi e mitigazioni
- Copyright (mini-platform): usare grafica originale.  
- Complessità mobile: test touch e performance; limitare animazioni pesanti.  
- Scalabilità: static hosting evita bisogno di backend ma limita salvataggio persistente.

---

# PRD B — Landing Page Personali (figlio1 / figlio2)
**Versione:** 1.1  
**Scopo:** Due landing page semplici e personalizzate su `figlio1.borrello.co.uk` e `figlio2.borrello.co.uk`, che fungano da portali personali con link sicuri alle risorse (incluso il catalogo giochi).  
**Data:** 13 Agosto 2025

## 1 — Visione
Ogni sottodominio mostra una pagina di benvenuto personalizzata per il bambino, con grafica a tema, grande messaggio di saluto e una griglia di pulsanti grandi che rimandano a risorse controllate (giochi, scuola, video, ecc.).

## 2 — Obiettivi
- Landing personalizzata e sicura per ciascun bambino.  
- Gestione semplice dei link (via JSON).  
- Design responsive e touch-friendly.  
- Nessuna pubblicità o contenuto non verificato.

## 3 — Scope MVP
- 2 landing (figlio1, figlio2).  
- Template unico + `config.json` per ogni landing.  
- Pulsanti link configurabili (icone emoji o PNG), apertura in nuova scheda.  
- Area header con nome e breve messaggio, immagine/illustrazione centrale, footer parental note.

## 4 — Requisiti funzionali
- Template HTML che carica `config.json` relativo alla cartella o determinato dal sottodominio.  
- Pulsanti con proprietà: `{icon,label,url,openInNewTab}`.  
- Opzione tema: palette colori e immagine di sfondo.  
- Possibilità di aggiornare link senza toccare HTML (modifica solo JSON).

### Esempio `config.json`
```json
{
  "name":"Marco",
  "greeting":"Ciao Marco! Pronto per giocare?",
  "theme":"blue",
  "heroImage":"assets/hero-marco.png",
  "links":[
    {"icon":"🎮","label":"Giochi","url":"https://giochi.borrello.co.uk","newTab":true},
    {"icon":"📚","label":"Scuola","url":"https://scuola.borrello.co.uk","newTab":true}
  ]
}
```

## 5 — Requisiti non funzionali
- Caricamento istantaneo (<1s ideale).  
- Compatibilità cross-browser e responsive.  
- Nessuna raccolta dati personali.  
- Accessibilità: testi leggibili, contrasto adeguato.

## 6 — UX / Design guidelines
- Titolo grande (es. 48px su desktop, 32px tablet).  
- Pulsanti grandi con sufficiente spazio touch (min 48px target).  
- Icone semplici ed esplicite (emoji ok).  
- Colori vivaci ma non saturi, per non affaticare.

## 7 — Flusso di modifica / manutenzione
- Editatore rapido: modificare `config.json` nella cartella `landing/figlioX/`.  
- Per modifiche grafiche (hero image), sostituire il file in `assets`.

## 8 — Deliverable MVP
- Template HTML/CSS/JS responsive.  
- Due cartelle `landing/figlio1` e `landing/figlio2` con rispettivi `config.json` e asset.  
- README: come aggiungere/modificare link e temi.

## 9 — Deployment
- Sottodomini DNS puntano alla stessa webroot o a path distinti sul server.  
- Nginx/Apache: gestire root per `figlio1.borrello.co.uk` → `/var/www/landing/figlio1`.  
- Certificato TLS auto-provisioned via Let’s Encrypt.

## 10 — QA e acceptance
- Verificare che i link si aprano in nuova scheda.  
- Test responsive su dispositivi reali o emulatori.  
- Controllo che modifiche a `config.json` appaiano senza cambiare HTML.

---

# Esempi di configurazione JSON e struttura file
Di seguito un riepilogo pratico per partire:

**Struttura suggerita (webroot):**
```
/var/www/kidsplay
  /landing
    /figlio1
      index.html
      config.json
      /assets
    /figlio2
      index.html
      config.json
      /assets
  /games
    /snake
    /memory
    ...
  games.json
  common.css
```

**Esempio `games.json` (catalogo base):**
```json
[
  {"id":"snake","title":"Snake","category":"Classic","icon":"/assets/icons/snake.png","min_age":5},
  {"id":"memory","title":"Memory Lettere","category":"Educational","icon":"/assets/icons/memory.png","min_age":5}
]
```

**Esempio `config/figlio2.json` per profilazione subdomain:**
```json
{
  "name":"Luca",
  "theme":"green",
  "language":"it",
  "games":["push-block","number-block","minesweeper","snake"],
  "difficulty":{"snake":"medium","minesweeper":"medium"}
}
```

---

# Roadmap & Prossimi passi (azione consigliata)
1. **Definire i nomi reali** dei profili e scegliere immagini/hero per ogni landing.  
2. **Creare cartelle** `landing/figlio1` e `landing/figlio2` con `config.json` d’esempio.  
3. **Implementare template landing** (HTML/CSS/JS) e testare localmente (modifica `hosts` per sottodomini).  
4. **Preparare skeleton catalog** (`index.html`, `games.json`) che i link delle landing possano puntare.  
5. **Implementare 4 giochi base** (MVP), verificare parametri di difficoltà via `config.json`.  
6. **QA con i bambini** e raccolta feedback.  
7. **Iterazioni**: aggiunta giochi, salvataggio punteggi, eventuale backend se necessario.

---

# Note tecniche e deployment
- DNS: punti A/CNAME di `figlio1.borrello.co.uk` / `figlio2.borrello.co.uk` all'IP del server (o CDN).  
- Web server: Nginx con root path per ogni sottodominio, oppure redirect verso path interni.  
- HTTPS: Let's Encrypt/Certbot.  
- Backup: versione di `config.json` in repository git.  
- Local testing: mappare `figlio1.borrello.co.uk` → `127.0.0.1` nel file hosts se servito localmente.

---

# Deliverable & QA
- Markdown PRD (questo file).  
- Cartella `landing/figlio1` e `landing/figlio2` con `config.json` di esempio (da creare in sviluppo).  
- README con istruzioni rapide per aggiungere link e giochi.
- Checklist QA: responsive, performance, accessibilità, nessun contenuto esterno non autorizzato.

---

## Contatti e note finali
Quando rientri dalle ferie, riprendiamo direttamente da questa PRD. Se vuoi, posso generare anche:
- Mockup grafici (PNG) per figlio1/figlio2.  
- Template HTML/CSS pronto all'uso.  
- Skeleton dei giochi in JS (starter kits).

Buone vacanze — ci risentiamo a settembre!

