# PRD — KidsPlay Web Arcade & Landing Pages (Markdown Export)
**Data:** 20 Agosto 2025  
**Autore:** [Tuo nome]

---

## Sommario
1. [PRD A — KidsPlay Web Arcade (Piattaforma giochi educativi, modulare e multi-profilo)](#prd-a---kidsplay-web-arcade-piattaforma-giochi-educativi-modulare-e-multi-profilo)  
2. [PRD B — Landing Page Personali (figlio1 / figlio2)](#prd-b---landing-page-personali-figlio1--figlio2)  
3. [Esempi di configurazione JSON e struttura file](#esempi-di-configurazione-json-e-struttura-file)  
4. [Roadmap & Prossimi passi](#roadmap--prossimi-passi)  
5. [Note tecniche e deployment](#note-tecniche-e-deployment)  
6. [Deliverable & QA](#deliverable--qa)  
7. [Appendice — Script Bash modulari](#appendice---script-bash-modulari)  

---

# PRD A — KidsPlay Web Arcade (Piattaforma giochi educativi, modulare e multi-profilo)
**Versione:** 1.3  
**Scopo:** Piattaforma browser di giochi educativi e classici per bambini 5–6 anni, modulare e con supporto a configurazioni utente (profilo) determinate da sottodominio.  
**Data:** 20 Agosto 2025

## 1 — Visione
Fornire un set di giochi semplici, sicuri e divertenti che allenino lettura, scrittura e matematica di base. La piattaforma è modulare: nuovi giochi si aggiungono come pacchetti indipendenti e ogni profilo/sottodominio può attivare una selezione diversa.

## 2 — Obiettivi principali
- Esperienza “kid-friendly”: interfaccia semplice, feedback visivo/sonoro, controlli ridotti.  
- Educazione + divertimento: giochi mirati a lettura, scrittura e basi di matematica.  
- Facile estendibilità: ogni gioco è un modulo indipendente.  
- Multi-profilo: parametri e set giochi per profilo (es. figlio1/figlio2).  
- Compatibilità offline futura (PWA).  

## 3 — Scope MVP
**Giochi inclusi (MVP):**  
- Memory Lettere & Parole (educativo)  
- Caccia alle Lettere (educativo)  
- Matematica Facile (somma/sottrazione 0–10)  
- Number Block (semplificato da 2048)  
- Push Block (Sokoban semplificato)  
- Campo Minato (griglia piccola, perdite non punitive)  
- Snake (velocità regolabile, comandi semplici)  
- Mini-platform con grafica originale  

**Funzionalità MVP:**  
- Catalogo dinamico (JSON) che popola la home.  
- Ogni gioco con schermata di start, pulsante Gioca e Torna al Catalogo.  
- Parametri di difficoltà passabili dal profilo.  
- Font grandi, contrasto alto, audio opzionale.  
- Standard interfaccia giochi: ogni `index.html` deve accettare parametri via query string e contenere un bottone `#backToCatalog`.  

## 4 — Requisiti funzionali
- Caricamento giochi via `games/<game-id>/index.html`.  
- `games.json` centrale con metadati (title, icon, category, min_age).  
- Profilo utente determinato dal sottodominio (`figlio1.borrello.co.uk` → `config/figlio1.json`).  
- File `difficulty.json` comune con livelli standard, mappati dai giochi.  
- Ogni gioco deve leggere params (`difficulty`, `language`, `profile`) via query string.  

## 5 — Requisiti non funzionali
- Compatibilità: Chrome/Edge/Firefox/Safari (desktop e tablet).  
- Performance: singolo gioco caricato in ≤2s.  
- Sicurezza/privacy: nessuna raccolta dati personali.  
- Accessibilità: testo leggibile, audio on/off, controlli touch friendly, supporto “read aloud” opzionale.  

## 6 — Architettura e struttura file
```
/kidsplay
  /config
     figlio1.json
     figlio2.json
     difficulty.json
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
...
