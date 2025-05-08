import numpy as np
import matplotlib.pyplot as plt
import matplotlib
import warnings
from sklearn.naive_bayes import MultinomialNB

# Load the data
training_data = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\train_images.txt')
training_labels = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\train_labels.txt')
testing_data = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\test_images.txt')
testing_labels = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\test_labels.txt')


def values_to_bins(data, parameter_bins):
    return np.digitize(data, parameter_bins) - 1


def confusion_matrix(y_true, y_pred):
    # Convert labels to integers and find max class
    num_classes = int(max(max(y_true), max(y_pred))) + 1
    matrix = np.zeros((num_classes, num_classes), dtype=int)

    for true, pred in zip(y_true, y_pred):
        matrix[int(true), int(pred)] += 1

    return matrix


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

conf_mat = confusion_matrix(testing_labels, predictions)

print(conf_mat)
