# 🦕 Guida Rapida - Estrazione Dinosauri con Snipping Tool

## 📋 Procedura Ottimizzata

### 1. Preparazione
- Apri le immagini originali in una cartella
- Apri Snipping Tool (o Snip & Sketch)
- Prepara la cartella di destinazione: `assets/dinosaurs/processed/`

### 2. Convenzioni di Nomenclatura
Usa questi nomi per mantenere consistenza:

**Carnivori:**
- tyrannosaurus.png
- allosaurus.png  
- carnotaurus.png
- dilophosaurus.png
- spinosaurus.png
- velociraptor.png

**Erbivori:**
- triceratops.png
- stegosaurus.png
- brontosaurus.png
- brachiosaurus.png
- ankylosaurus.png
- diplodocus.png
- parasaurolophus.png

**Altri:**
- compsognathus.png
- gallimimus.png
- iguanodon.png

### 3. Formato Standardizzato
- **Dimensioni:** ~200x200px (non deve essere perfetto)
- **Formato:** PNG con sfondo trasparente
- **Qualità:** Media/Alta

### 4. Tips per Velocizzare
1. **Hotkey:** Win + Shift + S per screenshot rapido
2. **Ritaglio:** Lascia un po' di spazio attorno al dinosauro
3. **Batch:** Fai tutti i ritagli, poi salva in batch
4. **Preview:** Non serve perfezione, basta che si distingua il dino

## 🎯 Dati per il Database

Una volta estratte, aggiorno il gioco con questi metadati:

```javascript
const dinosaurData = {
  "tyrannosaurus": {
    name: "T-Rex",
    type: "carnivore",
    rarity: "legendary", 
    habitat: "forest",
    size: "large",
    description: "Il re dei dinosauri carnivori!"
  },
  "triceratops": {
    name: "Triceratops", 
    type: "herbivore",
    rarity: "common",
    habitat: "plains", 
    size: "large",
    description: "Dinosauro con tre corna e un grande scudo osseo."
  }
  // ... altri dinosauri
}
```

## ⚡ Quick Start
1. Estrai 5-6 dinosauri per iniziare
2. Mettili in `assets/dinosaurs/processed/`
3. Testiamo il gioco con questi
4. Aggiungi gli altri gradualmente

Fai sapere quando hai estratto i primi dinosauri! 🦕
