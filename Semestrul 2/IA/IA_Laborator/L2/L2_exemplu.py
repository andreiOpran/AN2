import numpy as np
import matplotlib.pyplot as plt
import matplotlib
import warnings

# Ignore DeprecationWarning
warnings.filterwarnings("ignore", category=DeprecationWarning)
matplotlib.use('TkAgg')  # nu ruleaza fara asta

train_images = np.loadtxt('data/train_images.txt')  # incarcam imaginile
train_labels = np.loadtxt('data/train_labels.txt', 'int')  # incarcam etichetele avand tipul de date int

image = train_images[0, :]  # prima imagine
image = np.reshape(image, (28, 28))

plt.imshow(image.astype(np.uint8), cmap='gray')
plt.show()

num_bins = 10
bins = np.linspace(start=0, stop=255, num=num_bins)  # returneaza intervalele
x_to_bins = np.digitize(image, bins)  # returneaza pentru fiecare element intervalul corespunzator
										# Atentie! In cazul nostru indexarea elementelor va
										# incepe de la 1, intrucat nu avem valori < 0

# print(x_to_bins)

