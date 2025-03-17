import sklearn as sk
import numpy as np
from sklearn.naive_bayes import MultinomialNB

# Template
# naive_bayes_model = MultinomialNB()
# naive_bayes_model.fit(training_data, training_labels)
# naive_bayes_model.predict(testing_data)
# naive_bayes_model.score(testing_data, testing_labels)

# Load the data
training_data = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\train_images.txt')
training_labels = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\train_labels.txt')
testing_data = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\test_images.txt')
testing_labels = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\test_labels.txt')


# Discretize function
def values_to_bins(data, parameter_bins):
    return np.digitize(data, parameter_bins) - 1  # substract 1 to get 0-based indices


# Create 4 bins for pixel values [0, 255]
num_bins = 4
bins = np.linspace(start=0, stop=255, num=num_bins + 1)

# Discretize the data
discretized_training_data = values_to_bins(training_data, bins)
discretized_testing_data = values_to_bins(testing_data, bins)

# Train and evaluate the model
model = MultinomialNB()
model.fit(discretized_training_data, training_labels)
accuracy = model.score(discretized_testing_data, testing_labels)

print(f'Accuracy: {accuracy:.4f}')
