import sklearn as sk
import numpy as np
from sklearn.naive_bayes import MultinomialNB

# Template
# naive_bayes_model = MultinomialNB()
# naive_bayes_model.fit(training_data, training_labels)
# naive_bayes_model.predict(testing_data)
# naive_bayes_model.score(testing_data, testing_labels)

# Load data from files with correct paths
training_data = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\train_images.txt')
training_labels = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\train_labels.txt')
testing_data = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\test_images.txt')
testing_labels = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\test_labels.txt')

# Ensure data is 2D
if training_data.ndim == 1:
    training_data = training_data.reshape(-1, 1)
if testing_data.ndim == 1:
    testing_data = testing_data.reshape(-1, 1)

# Create and train the model
naive_bayes_model = MultinomialNB()
naive_bayes_model.fit(training_data, training_labels)

# Make predictions and evaluate
predictions = naive_bayes_model.predict(testing_data)
score = naive_bayes_model.score(testing_data, testing_labels)
print(f"Model accuracy: {score}")
