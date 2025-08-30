#!/usr/bin/env python3
"""
Simple Dino Image Processor
Versione semplificata senza OpenCV per processare le immagini dei dinosauri
"""

import os
from PIL import Image, ImageOps, ImageFilter
import numpy as np

def remove_white_background_simple(image, threshold=240):
    """
    Rimuove lo sfondo bianco usando solo PIL
    """
    # Converti in RGBA
    if image.mode != 'RGBA':
        image = image.convert('RGBA')
    
    # Ottieni i dati dell'immagine
    data = np.array(image)
    
    # Trova pixel bianchi o quasi bianchi
    white_mask = (data[:, :, 0] > threshold) & (data[:, :, 1] > threshold) & (data[:, :, 2] > threshold)
    
    # Rendi trasparenti
    data[white_mask] = [255, 255, 255, 0]
    
    return Image.fromarray(data, 'RGBA')

def crop_to_content(image):
    """
    Ritaglia l'immagine al contenuto non trasparente
    """
    # Ottieni il bounding box del contenuto
    bbox = image.getbbox()
    if bbox:
        return image.crop(bbox)
    return image

def resize_with_padding(image, target_size=200):
    """
    Ridimensiona mantenendo proporzioni e aggiunge padding se necessario
    """
    # Calcola il ridimensionamento
    width, height = image.size
    ratio = min(target_size / width, target_size / height)
    
    new_width = int(width * ratio)
    new_height = int(height * ratio)
    
    # Ridimensiona
    resized = image.resize((new_width, new_height), Image.Resampling.LANCZOS)
    
    # Crea immagine finale con padding
    final_image = Image.new('RGBA', (target_size, target_size), (255, 255, 255, 0))
    
    # Centra l'immagine
    paste_x = (target_size - new_width) // 2
    paste_y = (target_size - new_height) // 2
    final_image.paste(resized, (paste_x, paste_y), resized)
    
    return final_image

def enhance_image(image):
    """
    Migliora la qualità dell'immagine
    """
    from PIL import ImageEnhance
    
    # Aumenta leggermente la nitidezza
    enhancer_sharpness = ImageEnhance.Sharpness(image)
    image = enhancer_sharpness.enhance(1.2)
    
    # Aumenta leggermente il contrasto
    enhancer_contrast = ImageEnhance.Contrast(image)
    image = enhancer_contrast.enhance(1.1)
    
    return image

def process_single_image(input_path, output_path, target_size=200):
    """
    Processa una singola immagine
    """
    try:
        print(f"Processando: {os.path.basename(input_path)}")
        
        # Carica immagine
        image = Image.open(input_path)
        
        # Rimuovi sfondo bianco
        image_no_bg = remove_white_background_simple(image)
        
        # Ritaglia al contenuto
        image_cropped = crop_to_content(image_no_bg)
        
        # Ridimensiona con padding
        image_resized = resize_with_padding(image_cropped, target_size)
        
        # Migliora qualità
        image_enhanced = enhance_image(image_resized)
        
        # Salva
        image_enhanced.save(output_path, 'PNG')
        print(f"✅ Salvato: {os.path.basename(output_path)}")
        
        return True
        
    except Exception as e:
        print(f"❌ Errore processando {input_path}: {e}")
        return False

def generate_dinosaur_database():
    """
    Genera un database di nomi di dinosauri per l'etichettatura
    """
    return [
        "tyrannosaurus", "triceratops", "stegosaurus", "brontosaurus", 
        "velociraptor", "ankylosaurus", "diplodocus", "allosaurus",
        "parasaurolophus", "spinosaurus", "carnotaurus", "dilophosaurus",
        "brachiosaurus", "compsognathus", "gallimimus", "iguanodon",
        "kentrosaurus", "lambeosaurus", "maiasaura", "nodosaurus",
        "ouranosaurus", "plateosaurus", "quetzalcoatlus", "rhabdodon",
        "saltasaurus", "therizinosaurus", "utahraptor", "wuerhosaurus",
        "xenoceratops", "yangchuanosaurus", "zuniceratops", "albertosaurus",
        "ceratosaurus", "dracorex", "edmontosaurus", "fabrosaurus",
        "giganotosaurus", "herrerasaurus", "irritator", "jobaria"
    ]

def process_all_composite_images():
    """
    Processa tutte le immagini composite e le prepara per uso singolo
    """
    input_dir = r"c:\Development\KidsPlay_Web_Arcade-\src\frontend\games\adventure\dino-explorer\assets\dinosaurs"
    output_dir = os.path.join(input_dir, "processed")
    
    # Crea directory di output
    os.makedirs(output_dir, exist_ok=True)
    
    # Lista file PNG
    image_files = [f for f in os.listdir(input_dir) if f.lower().endswith('.png')]
    
    if not image_files:
        print("❌ Nessuna immagine PNG trovata!")
        return
    
    print(f"🦕 Trovate {len(image_files)} immagini da processare")
    
    dinosaur_names = generate_dinosaur_database()
    name_index = 0
    
    processed_count = 0
    
    for image_file in image_files:
        input_path = os.path.join(input_dir, image_file)
        
        # Genera nome output
        if name_index < len(dinosaur_names):
            base_name = dinosaur_names[name_index]
        else:
            base_name = f"dinosaur_{name_index}"
        
        output_filename = f"{base_name}.png"
        output_path = os.path.join(output_dir, output_filename)
        
        # Evita sovrascritture
        counter = 1
        while os.path.exists(output_path):
            output_filename = f"{base_name}_{counter}.png"
            output_path = os.path.join(output_dir, output_filename)
            counter += 1
        
        # Processa immagine
        if process_single_image(input_path, output_path):
            processed_count += 1
            name_index += 1
    
    print(f"🎉 Processamento completato!")
    print(f"📊 {processed_count}/{len(image_files)} immagini processate con successo")
    print(f"📁 Output salvato in: {output_dir}")
    
    return output_dir

if __name__ == "__main__":
    print("🦕 Simple Dino Image Processor")
    print("=" * 50)
    
    # Controlla se PIL/Pillow è installato
    try:
        import PIL
        print(f"✅ PIL/Pillow version: {PIL.__version__}")
    except ImportError:
        print("❌ PIL/Pillow non installato!")
        print("Installa con: pip install Pillow")
        exit(1)
    
    # Controlla se numpy è installato
    try:
        import numpy
        print(f"✅ NumPy version: {numpy.__version__}")
    except ImportError:
        print("❌ NumPy non installato!")
        print("Installa con: pip install numpy")
        exit(1)
    
    # Processa le immagini
    try:
        output_directory = process_all_composite_images()
        print("\n🎯 Prossimi passi:")
        print("1. Controlla le immagini processate")
        print("2. Rinomina manualmente se necessario")
        print("3. Integra nel gioco Dino Explorer")
        
    except Exception as e:
        print(f"💥 Errore durante l'esecuzione: {e}")
        import traceback
        traceback.print_exc()
