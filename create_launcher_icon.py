from PIL import Image, ImageDraw, ImageFont
import os

def create_kidsplay_icon():
    """
    Creates a colorful, kid-friendly icon for KidsPlay Web Arcade
    with a game controller and playful colors
    """
    # Create a large image for high quality (256x256)
    size = 256
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Background - Rounded square with gradient effect
    # Outer glow
    for i in range(10):
        alpha = int(50 - i * 5)
        offset = i * 2
        draw.rounded_rectangle(
            [offset, offset, size - offset, size - offset],
            radius=40 - i,
            fill=(100, 149, 237, alpha)  # Cornflower blue
        )
    
    # Main background - vibrant gradient
    draw.rounded_rectangle(
        [20, 20, size - 20, size - 20],
        radius=35,
        fill=(65, 105, 225)  # Royal blue
    )
    
    # Add a lighter inner glow
    draw.rounded_rectangle(
        [30, 30, size - 30, size - 30],
        radius=30,
        fill=(100, 149, 237)  # Lighter blue
    )
    
    # Draw a game controller shape
    controller_color = (255, 255, 255)  # White
    shadow_color = (50, 50, 100, 100)
    
    # Controller body (shadow first)
    draw.rounded_rectangle(
        [62, 102, 194, 162],
        radius=15,
        fill=shadow_color
    )
    # Controller body (main)
    draw.rounded_rectangle(
        [60, 100, 192, 160],
        radius=15,
        fill=controller_color
    )
    
    # Left grip
    draw.ellipse([45, 140, 75, 180], fill=shadow_color)
    draw.ellipse([43, 138, 73, 178], fill=controller_color)
    
    # Right grip
    draw.ellipse([177, 140, 207, 180], fill=shadow_color)
    draw.ellipse([175, 138, 205, 178], fill=controller_color)
    
    # D-pad (left side) - colorful
    dpad_color = (255, 107, 107)  # Coral red
    dpad_x = 85
    dpad_y = 125
    dpad_size = 8
    
    # D-pad center
    draw.rectangle(
        [dpad_x - dpad_size, dpad_y - dpad_size//2, 
         dpad_x + dpad_size, dpad_y + dpad_size//2],
        fill=dpad_color
    )
    draw.rectangle(
        [dpad_x - dpad_size//2, dpad_y - dpad_size, 
         dpad_x + dpad_size//2, dpad_y + dpad_size],
        fill=dpad_color
    )
    
    # Action buttons (right side) - colorful
    button_y = 125
    
    # A button (green)
    draw.ellipse([150, button_y - 8, 166, button_y + 8], fill=(78, 205, 196))
    
    # B button (red)
    draw.ellipse([165, button_y - 8, 181, button_y + 8], fill=(255, 107, 107))
    
    # Add a playful star
    star_color = (255, 215, 0)  # Gold
    star_x, star_y = 128, 65
    star_size = 15
    
    # Simple star shape
    star_points = []
    for i in range(10):
        angle = i * 36  # 360/10
        radius = star_size if i % 2 == 0 else star_size // 2
        import math
        x = star_x + radius * math.cos(math.radians(angle - 90))
        y = star_y + radius * math.sin(math.radians(angle - 90))
        star_points.append((x, y))
    
    draw.polygon(star_points, fill=star_color)
    
    # Add small decorative circles (like confetti)
    confetti_colors = [(255, 107, 107), (78, 205, 196), (255, 215, 0), (186, 104, 200)]
    confetti_positions = [(50, 60), (200, 70), (45, 200), (210, 195)]
    
    for pos, color in zip(confetti_positions, confetti_colors):
        draw.ellipse([pos[0], pos[1], pos[0] + 12, pos[1] + 12], fill=color)
    
    # Save in multiple sizes for Windows icon
    icon_sizes = [(256, 256), (128, 128), (64, 64), (48, 48), (32, 32), (16, 16)]
    images = []
    
    for icon_size in icon_sizes:
        resized = img.resize(icon_size, Image.Resampling.LANCZOS)
        images.append(resized)
    
    # Save as ICO file
    output_path = 'KidsPlay.ico'
    images[0].save(
        output_path,
        format='ICO',
        sizes=icon_sizes,
        append_images=images[1:]
    )
    
    # Also save as PNG for reference
    img.save('KidsPlay_Icon.png', 'PNG')
    
    print(f"✅ Icon created successfully!")
    print(f"   - ICO file: {os.path.abspath(output_path)}")
    print(f"   - PNG file: {os.path.abspath('KidsPlay_Icon.png')}")
    
    return output_path

if __name__ == "__main__":
    try:
        create_kidsplay_icon()
    except Exception as e:
        print(f"❌ Error creating icon: {e}")
        print("   Make sure Pillow is installed: pip install Pillow")
