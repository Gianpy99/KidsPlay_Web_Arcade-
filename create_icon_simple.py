from PIL import Image, ImageDraw, ImageFont

# Crea un'icona 192x192 con sfondo verde e testo
img = Image.new('RGB', (192, 192), color='#4CAF50')
draw = ImageDraw.Draw(img)

# Disegna un cerchio bianco al centro
center = (96, 96)
radius = 60
draw.ellipse([center[0]-radius, center[1]-radius, center[0]+radius, center[1]+radius], fill='white')

# Disegna un controller stilizzato
# Corpo del controller
controller_rect = [56, 86, 136, 106]
draw.rounded_rectangle(controller_rect, radius=10, fill='#2E7D32')

# D-pad
draw.rectangle([66, 91, 78, 95], fill='white')
draw.rectangle([70, 87, 74, 99], fill='white')

# Bottoni
draw.ellipse([114, 87, 122, 95], fill='white')
draw.ellipse([106, 91, 114, 99], fill='white')

# Salva l'icona
img.save('assets/images/icon-192.png', 'PNG')
img.resize((512, 512)).save('assets/images/icon-512.png', 'PNG')

print("Icone PNG create con successo!")
