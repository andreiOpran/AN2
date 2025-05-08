import numpy as np
import matplotlib.pyplot as plt
# from skimage import io

plt.switch_backend('TkAgg')

# Exercitiul 1

# a. citire imagini din fisiere si salvare in np.array
images = np.zeros((9, 400, 600))

for i in range(0, 9):
	image = np.load(f'L1_images/car_{i}.npy')
	images[i] = image

# b. suma valorilor pixelilor tuturor imaginilor
print()
print('b.')
result = np.sum(images)
print(f'Suma valorilor pixelilor tuturor imaginilor: {result}')

# c. suma valorilor pixelilor pentru fiecare imagine
print()
print('c.')
for i in range(0, 9):
	result = np.sum(images[i])
	print(f'Suma valorilor pixelilor pentru imaginea {i}: {result}')

# d. afisati indexul imaginii cu suma maxima
print()
print('d.')
max_sum = 0
max_index = 0
for i in range(0, 9):
	result = np.sum(images[i])
	if result > max_sum:
		max_sum = result
		max_index = i
print(f'Indexul imaginii cu suma maxima: {max_index}')

# e. calculati imaginea medie si afisati-o
mean_image = np.mean(images, axis=0)
plt.imshow(mean_image.astype(np.uint8), cmap='gray')
plt.show()

# f. deviatia standard a imaginilor
print()
print('f.')
standard_deviation = np.std(images)
print(f'Deviatia standard a imaginilor: {standard_deviation}')

# g. normalizarea imaginilor (se scade imaginea medie si se imparte la deviatia standard)
normalized_images = np.zeros((9, 400, 600))
print()
print('g.')
for i in range(0, 9):
	normalized_images[i] = np.subtract(images[i], mean_image)
	normalized_images[i] = np.divide(normalized_images[i], standard_deviation)
	print(f'Suma imaginii normalizate {i}: {np.sum(normalized_images[i])}')

# h. decupati imaginile afisand numai liniile  cuprinse intre 200 si 300 si coloanele cuprinse intre 280 si 400
print()
print('h.')
cropped_images = np.zeros((9, 100, 120))
for i in range(0, 9):
	cropped_images[i] = images[i][200:300, 280:400]
	print(f'Suma imaginii decupate {i}: {np.sum(cropped_images[i])}')
