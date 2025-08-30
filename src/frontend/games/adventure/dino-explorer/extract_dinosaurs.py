#!/usr/bin/env python3
"""
Dino Image Extractor
Estrae singoli dinosauri da immagini composite con sfondo bianco
"""

import os
import cv2
import numpy as np
from PIL import Image, ImageOps
import argparse

def extract_dinosaurs_from_image(image_path, output_dir, min_area=5000):
    """
    Estrae dinosauri individuali da un'immagine composita
    """
    print(f"Processando: {image_path}")
    
    # Carica l'immagine
    img = cv2.imread(image_path)
    if img is None:
        print(f"Errore: Impossibile caricare {image_path}")
        return []
    
    # Converti in RGB
    img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    img_pil = Image.fromarray(img_rgb)
    
    # Converti in scala di grigi per la detection
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    
    # Crea maschera per rimuovere sfondo bianco
    # Assuming white background (adjust threshold as needed)
    _, mask = cv2.threshold(gray, 240, 255, cv2.THRESH_BINARY_INV)
    
    # Trova contorni
    contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    
    extracted_dinosaurs = []
    
    for i, contour in enumerate(contours):
        # Filtra contorni troppo piccoli
        area = cv2.contourArea(contour)
        if area < min_area:
            continue
            
        # Ottieni bounding box
        x, y, w, h = cv2.boundingRect(contour)
        
        # Aggiungi un po' di padding
        padding = 20
        x = max(0, x - padding)
        y = max(0, y - padding)
        w = min(img.shape[1] - x, w + 2 * padding)
        h = min(img.shape[0] - y, h + 2 * padding)
        
        # Estrai la regione
        dinosaur_region = img_rgb[y:y+h, x:x+w]
        
        # Converti in PIL Image
        dino_pil = Image.fromarray(dinosaur_region)
        
        # Rimuovi sfondo bianco e rendi trasparente
        dino_transparent = remove_white_background(dino_pil)
        
        # Ridimensiona a dimensione standard mantenendo proporzioni
        dino_resized = resize_with_aspect_ratio(dino_transparent, 200, 200)
        
        extracted_dinosaurs.append((dino_resized, i))
        
    return extracted_dinosaurs

def remove_white_background(image, threshold=240):
    """
    Rimuove lo sfondo bianco e lo rende trasparente
    """
    # Converti in RGBA se necessario
    if image.mode != 'RGBA':
        image = image.convert('RGBA')
    
    # Converti in array numpy
    data = np.array(image)
    
    # Crea maschera per pixel bianchi
    white_mask = (data[:, :, 0] > threshold) & (data[:, :, 1] > threshold) & (data[:, :, 2] > threshold)
    
    # Rendi trasparenti i pixel bianchi
    data[white_mask] = [255, 255, 255, 0]
    
    return Image.fromarray(data, 'RGBA')

def resize_with_aspect_ratio(image, max_width, max_height):
    """
    Ridimensiona l'immagine mantenendo le proporzioni
    """
    # Calcola il rapporto di ridimensionamento
    width, height = image.size
    ratio = min(max_width / width, max_height / height)
    
    new_width = int(width * ratio)
    new_height = int(height * ratio)
    
    # Ridimensiona
    resized = image.resize((new_width, new_height), Image.Resampling.LANCZOS)
    
    # Crea una nuova immagine con le dimensioni target e sfondo trasparente
    final_image = Image.new('RGBA', (max_width, max_height), (255, 255, 255, 0))
    
    # Centra l'immagine ridimensionata
    paste_x = (max_width - new_width) // 2
    paste_y = (max_height - new_height) // 2
    final_image.paste(resized, (paste_x, paste_y), resized)
    
    return final_image

def generate_dinosaur_names():
    """
    Genera nomi per i dinosauri estratti
    """
    dinosaur_types = [
        "trex", "triceratops", "stegosaurus", "brontosaurus", "raptor", 
        "ankylosaurus", "diplodocus", "allosaurus", "parasaurolophus", 
        "spinosaurus", "carnotaurus", "dilophosaurus", "brachiosaurus",
        "compsognathus", "gallimimus", "iguanodon", "kentrosaurus",
        "lambeosaurus", "maiasaura", "nodosaurus", "ouranosaurus",
        "plateosaurus", "quetzalcoatlus", "rhabdodon", "saltasaurus",
        "therizinosaurus", "utahraptor", "velociraptor", "wuerhosaurus",
        "xenoceratops", "yangchuanosaurus", "zuniceratops"
    ]
    
    return dinosaur_types

def process_all_images(input_dir, output_dir):
    """
    Processa tutte le immagini nella directory di input
    """
    os.makedirs(output_dir, exist_ok=True)
    
    dinosaur_names = generate_dinosaur_names()
    name_index = 0
    
    # Lista tutti i file PNG nella directory
    image_files = [f for f in os.listdir(input_dir) if f.lower().endswith('.png')]
    
    print(f"Trovate {len(image_files)} immagini da processare...")
    
    for image_file in image_files:
        image_path = os.path.join(input_dir, image_file)
        
        # Estrai dinosauri dall'immagine
        dinosaurs = extract_dinosaurs_from_image(image_path)
        
        print(f"Estratti {len(dinosaurs)} dinosauri da {image_file}")
        
        # Salva ogni dinosauro estratto
        for dino_image, dino_index in dinosaurs:
            if name_index < len(dinosaur_names):
                dino_name = dinosaur_names[name_index]
            else:
                dino_name = f"dinosaur_{name_index}"
            
            output_filename = f"{dino_name}.png"
            output_path = os.path.join(output_dir, output_filename)
            
            # Evita sovrascritture
            counter = 1
            while os.path.exists(output_path):
                output_filename = f"{dino_name}_{counter}.png"
                output_path = os.path.join(output_dir, output_filename)
                counter += 1
            
            dino_image.save(output_path)
            print(f"Salvato: {output_filename}")
            
            name_index += 1

if __name__ == "__main__":
    # Directory di input e output
    input_directory = r"c:\Development\KidsPlay_Web_Arcade-\src\frontend\games\adventure\dino-explorer\assets\dinosaurs"
    output_directory = r"c:\Development\KidsPlay_Web_Arcade-\src\frontend\games\adventure\dino-explorer\assets\dinosaurs\extracted"
    
    print("🦕 Dino Image Extractor Starting...")
    print(f"Input: {input_directory}")
    print(f"Output: {output_directory}")
    
    try:
        process_all_images(input_directory, output_directory)
        print("✅ Estrazione completata!")
        print(f"Controlla la cartella: {output_directory}")
    except Exception as e:
        print(f"❌ Errore durante l'estrazione: {e}")
        import traceback
        traceback.print_exc()
