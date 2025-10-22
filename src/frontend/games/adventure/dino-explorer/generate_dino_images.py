#!/usr/bin/env python3
"""
Script per generare immagini dei dinosauri
Usa placeholder colorati se non hai accesso a generatori AI
"""

import os
from PIL import Image, ImageDraw, ImageFont
import colorsys

# Lista dei dinosauri dal database
DINOSAURS = [
    {"id": "tyrannosaurus", "name": "T-Rex", "color": "#FF4444"},
    {"id": "velociraptor", "name": "Velociraptor", "color": "#4488FF"},
    {"id": "allosaurus", "name": "Allosaurus", "color": "#FF8844"},
    {"id": "triceratops", "name": "Triceratops", "color": "#44FF88"},
    {"id": "stegosaurus", "name": "Stegosaurus", "color": "#8844FF"},
    {"id": "brontosaurus", "name": "Brontosaurus", "color": "#FFAA44"}
]

OUTPUT_DIR = "assets/dinosaurs"
IMAGE_SIZE = 512

def hex_to_rgb(hex_color):
    """Converte colore esadecimale in RGB"""
    hex_color = hex_color.lstrip('#')
    return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))

def create_placeholder_image(dino_id, dino_name, color):
    """Crea un'immagine placeholder colorata con gradiente"""
    
    # Crea immagine con gradiente
    img = Image.new('RGB', (IMAGE_SIZE, IMAGE_SIZE))
    draw = ImageDraw.Draw(img)
    
    # Colore base
    rgb = hex_to_rgb(color)
    
    # Disegna gradiente radiale
    for y in range(IMAGE_SIZE):
        for x in range(IMAGE_SIZE):
            # Distanza dal centro
            dx = x - IMAGE_SIZE/2
            dy = y - IMAGE_SIZE/2
            distance = (dx*dx + dy*dy) ** 0.5
            max_distance = (IMAGE_SIZE/2) * 1.4
            
            # Calcola gradiente
            ratio = min(distance / max_distance, 1.0)
            
            # Colore più scuro verso i bordi
            r = int(rgb[0] * (1 - ratio * 0.4))
            g = int(rgb[1] * (1 - ratio * 0.4))
            b = int(rgb[2] * (1 - ratio * 0.4))
            
            img.putpixel((x, y), (r, g, b))
    
    # Aggiungi cornice
    draw = ImageDraw.Draw(img)
    border_width = 8
    draw.rectangle(
        [(border_width, border_width), 
         (IMAGE_SIZE - border_width, IMAGE_SIZE - border_width)],
        outline=(255, 255, 255),
        width=border_width
    )
    
    # Aggiungi testo
    try:
        # Prova a usare un font grande
        font_large = ImageFont.truetype("arial.ttf", 60)
        font_small = ImageFont.truetype("arial.ttf", 30)
    except:
        # Fallback al font di default
        font_large = ImageFont.load_default()
        font_small = ImageFont.load_default()
    
    # Emoji dinosauro al centro
    emoji = "🦕" if "saurus" in dino_name.lower() else "🦖"
    
    # Nome in alto
    text_bbox = draw.textbbox((0, 0), dino_name, font=font_large)
    text_width = text_bbox[2] - text_bbox[0]
    text_x = (IMAGE_SIZE - text_width) // 2
    
    # Sfondo semi-trasparente per il testo
    draw.rectangle(
        [(10, 50), (IMAGE_SIZE - 10, 150)],
        fill=(0, 0, 0, 180)
    )
    
    draw.text((text_x, 70), dino_name, fill=(255, 255, 255), font=font_large)
    
    # ID in basso
    id_text = f"ID: {dino_id}"
    id_bbox = draw.textbbox((0, 0), id_text, font=font_small)
    id_width = id_bbox[2] - id_bbox[0]
    id_x = (IMAGE_SIZE - id_width) // 2
    
    draw.rectangle(
        [(10, IMAGE_SIZE - 100), (IMAGE_SIZE - 10, IMAGE_SIZE - 40)],
        fill=(0, 0, 0, 180)
    )
    draw.text((id_x, IMAGE_SIZE - 80), id_text, fill=(200, 200, 200), font=font_small)
    
    return img

def main():
    """Genera tutte le immagini placeholder"""
    
    # Crea directory se non esiste
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    
    print("🦕 Generazione immagini dinosauri placeholder...")
    print(f"📁 Output directory: {OUTPUT_DIR}\n")
    
    for dino in DINOSAURS:
        output_path = os.path.join(OUTPUT_DIR, f"{dino['id']}.png")
        
        # Genera immagine
        img = create_placeholder_image(dino['id'], dino['name'], dino['color'])
        
        # Salva
        img.save(output_path, 'PNG')
        print(f"✅ Creato: {output_path}")
    
    print(f"\n🎉 Completato! Generate {len(DINOSAURS)} immagini")
    print(f"\n💡 Ora puoi sostituire queste immagini con immagini reali dei dinosauri")
    print(f"   mantenendo lo stesso nome file (es: tyrannosaurus.png)")

if __name__ == "__main__":
    main()
