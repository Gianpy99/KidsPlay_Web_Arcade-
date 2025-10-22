# 🦕 Dinosaur Images Directory

## Come aggiungere le tue immagini di dinosauri

Metti qui le immagini PNG dei dinosauri con i nomi esatti degli ID dal database.

### Naming Convention (IMPORTANTE!)

Il nome del file DEVE corrispondere esattamente all'ID del dinosauro nel `dinosaur-database.js`:

```
assets/dinosaurs/
├── tyrannosaurus.png       ← DinosaurDatabase.carnivores.tyrannosaurus
├── stegosaurus.png         ← DinosaurDatabase.herbivores.stegosaurus  
├── brontosaurus.png        ← DinosaurDatabase.herbivores.brontosaurus
├── triceratops.png         ← DinosaurDatabase.herbivores.triceratops
├── velociraptor.png        ← DinosaurDatabase.carnivores.velociraptor
├── pteranodon.png          ← DinosaurDatabase.flying.pteranodon
├── ankylosaurus.png        ← DinosaurDatabase.armored.ankylosaurus
├── parasaurolophus.png     ← DinosaurDatabase.herbivores.parasaurolophus
├── pachycephalosaurus.png  ← DinosaurDatabase.herbivores.pachycephalosaurus
├── spinosaurus.png         ← DinosaurDatabase.carnivores.spinosaurus
├── iguanodon.png           ← DinosaurDatabase.herbivores.iguanodon
├── allosaurus.png          ← DinosaurDatabase.carnivores.allosaurus
├── brachiosaurus.png       ← DinosaurDatabase.herbivores.brachiosaurus
├── diplodocus.png          ← DinosaurDatabase.herbivores.diplodocus
├── carnotaurus.png         ← DinosaurDatabase.carnivores.carnotaurus
└── dilophosaurus.png       ← DinosaurDatabase.carnivores.dilophosaurus
```

### Specifiche Immagini

- **Formato**: PNG con trasparenza (consigliato)
- **Dimensioni consigliate**: 512x512 px o 1024x1024 px
- **Stile**: Realistico, colorato, adatto ai bambini
- **Background**: Trasparente o neutro

### Ordine di Caricamento

Il gioco carica le immagini in questo ordine:

1. **Immagine Locale** (assets/dinosaurs/[id].png) ← **PRIORITÀ MASSIMA**
2. **AI Gemini** (solo se abilitato E il dinosauro è NUOVO)
3. **Cache AI** (se il dinosauro era già stato scoperto in precedenza)
4. **Nessuna immagine** (nasconde il container)

### Ottimizzazione AI

- **Primo scoperta**: Genera immagine AI (se locale non disponibile)
- **Ri-scoperta**: Usa solo cache (non rigenera)
- Questo evita chiamate API inutili e costi aggiuntivi!

### Testing

Per testare le tue immagini:

1. Aggiungi un file PNG con il nome corretto (es: `tyrannosaurus.png`)
2. Ricarica la pagina (Ctrl+Shift+R)
3. Scopri quel dinosauro nel gioco
4. L'immagine locale dovrebbe apparire immediatamente

Se l'immagine non appare:
- Verifica il nome del file (deve essere esattamente `[id].png`)
- Controlla la console per errori
- Verifica che l'immagine sia nella cartella corretta
