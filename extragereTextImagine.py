import pytesseract
from PIL import Image
import os

# Use raw string for Windows path
image_path = r"C:\Users\andre\Desktop\AN2-SEM1\image.png"

try:
    # Verify if file exists
    if not os.path.exists(image_path):
        raise FileNotFoundError(f"Image file not found at {image_path}")
        
    # Open and process image
    image = Image.open(image_path)
    
    # Extract text
    extracted_text = pytesseract.image_to_string(image)
    
    # Print results
    print("Extracted text:")
    print(extracted_text)
    
except FileNotFoundError as e:
    print(f"Error: {e}")
except Exception as e:
    print(f"An error occurred: {e}")