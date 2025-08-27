from PIL import Image, ImageDraw

# Crea un'icona 192x192 con design semplice e colorato
img = Image.new('RGBA', (192, 192), color=(76, 175, 80, 255))  # Verde KidsPlay
draw = ImageDraw.Draw(img)

# Cerchio bianco di sfondo
draw.ellipse([32, 32, 160, 160], fill='white')

# Controller stilizzato al centro
# Corpo principale
draw.rounded_rectangle([64, 80, 128, 112], radius=8, fill='#2E7D32')

# D-pad (sinistra)
draw.rectangle([72, 88, 84, 92], fill='white')
draw.rectangle([76, 84, 80, 96], fill='white')

# Bottoni (destra) 
draw.ellipse([100, 84, 108, 92], fill='white')
draw.ellipse([112, 88, 120, 96], fill='white')

# Salva l'icona
img.save('assets/images/icon-192.png', 'PNG')

# Crea versione 512x512
img_512 = img.resize((512, 512), Image.Resampling.LANCZOS)
img_512.save('assets/images/icon-512.png', 'PNG')

print("Nuove icone PNG create!")
