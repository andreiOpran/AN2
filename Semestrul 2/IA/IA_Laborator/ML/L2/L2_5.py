import numpy as np
import matplotlib.pyplot as plt
import matplotlib
import warnings
from sklearn.naive_bayes import MultinomialNB

# Setup matplotlib
warnings.filterwarnings("ignore", category=DeprecationWarning)
matplotlib.use('TkAgg')

# Load the data
training_data = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\train_images.txt')
training_labels = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\train_labels.txt')
testing_data = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\test_images.txt')
testing_labels = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\test_labels.txt')


def values_to_bins(data, parameter_bins):
    return np.digitize(data, parameter_bins) - 1


# Use 7 bins as it gave the best accuracy
num_bins = 7
bins = np.linspace(start=0, stop=255, num=num_bins + 1)

# Discretize the data
discretized_training_data = values_to_bins(training_data, bins)
discretized_testing_data = values_to_bins(testing_data, bins)

# Train the model
model = MultinomialNB()
model.fit(discretized_training_data, training_labels)

# Get predictions
predictions = model.predict(discretized_testing_data)

# Find misclassified samples
misclassified_indices = np.where(predictions != testing_labels)[0]

# Show first 10 misclassified images
plt.figure(figsize=(20, 8))
for idx, i in enumerate(misclassified_indices[:10]):
    plt.subplot(2, 5, idx + 1)
    image = testing_data[i].reshape(28, 28)
    plt.imshow(image.astype(np.uint8), cmap='gray')
    plt.title(f'Predicted: {predictions[i]}\nActual: {testing_labels[i]}')

plt.show()


# Print fara imagini

# # Print first 10 misclassified examples
# print("Misclassified examples:")
# for i in misclassified_indices[:10]:
#     print(f"Index: {i}")
#     print(f"Predicted: {predictions[i]}")
#     print(f"Actual: {testing_labels[i]}")
#     print("-" * 20)

