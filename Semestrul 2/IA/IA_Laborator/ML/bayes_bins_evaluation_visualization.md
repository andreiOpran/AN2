# Probability and Classification Cheatsheet

## Probability & Bayesian Statistics

```python
# Basic probability calculation
probability = favorable_outcomes / total_outcomes

# Conditional Probability
P_A_given_B = (P_B_given_A * P_A) / P_B

# Bayes' Theorem
P_B_given_A = (P_A_given_B * P_B) / (P_A_given_B * P_B + P_A_given_not_B * P_not_B)

# Example: Calculating P(B|H) - probability of being boy given height
p_b_given_h = (p_h_given_b * p_b) / (p_h_given_b * p_b + p_h_given_f * p_f)
```

## Data Binning and Discretization

```python
# Create equally spaced bins
bins = np.linspace(start=150, stop=190, num=5)  # [150, 160, 170, 180, 190]

# Assign values to bins (returns bin indices starting at 1)
bin_indices = np.digitize(values, bins)  # Returns bin indices

# Zero-based bin indices (for use with scikit-learn)
zero_based_indices = np.digitize(values, bins) - 1

# Example: Create N bins from 0 to 255 (for image data)
num_bins = 7
bins = np.linspace(start=0, stop=255, num=num_bins + 1)
discretized_data = np.digitize(data, bins) - 1
```

## Naive Bayes Classification

```python
from sklearn.naive_bayes import MultinomialNB

# Initialize the classifier
model = MultinomialNB()

# Training the model
model.fit(training_data, training_labels)

# Making predictions
predictions = model.predict(testing_data)

# Get prediction probabilities
probabilities = model.predict_proba(testing_data)

# Evaluate model accuracy
accuracy = model.score(testing_data, testing_labels)
print(f'Accuracy: {accuracy:.4f}')  # e.g., 0.9123
```

## Data Loading and Preprocessing

```python
# Load data from text files
training_data = np.loadtxt('path/to/train_images.txt')
training_labels = np.loadtxt('path/to/train_labels.txt')

# Reshape image data (e.g., from 1D to 2D for visualization)
image = data[index].reshape(28, 28)  # For 28x28 MNIST images

# Data normalization
normalized_data = (data - np.mean(data)) / np.std(data)

# Data discretization function
def values_to_bins(data, parameter_bins):
    return np.digitize(data, parameter_bins) - 1  # Subtract 1 for 0-based indices
```

## Model Evaluation

```python
# Identifying misclassified examples
misclassified_indices = np.where(predictions != true_labels)[0]

# Manual confusion matrix calculation
def confusion_matrix(y_true, y_pred):
    num_classes = int(max(max(y_true), max(y_pred))) + 1
    matrix = np.zeros((num_classes, num_classes), dtype=int)
    
    for true, pred in zip(y_true, y_pred):
        matrix[int(true), int(pred)] += 1
    
    return matrix

# Using scikit-learn's confusion matrix
from sklearn.metrics import confusion_matrix
conf_mat = confusion_matrix(y_true, y_pred)

# Calculating precision, recall, and F1 score
from sklearn.metrics import precision_score, recall_score, f1_score

precision = precision_score(y_true, y_pred, average='weighted')
recall = recall_score(y_true, y_pred, average='weighted')
f1 = f1_score(y_true, y_pred, average='weighted')
```

## Visualization

```python
import matplotlib.pyplot as plt

# Setup for interactive plotting
plt.switch_backend('TkAgg')  # Or 'Agg' for non-interactive
matplotlib.use('TkAgg')

# Suppress deprecation warnings
import warnings
warnings.filterwarnings("ignore", category=DeprecationWarning)

# Create figure with multiple subplots
plt.figure(figsize=(20, 8))
for idx, i in enumerate(indices[:10]):
    plt.subplot(2, 5, idx + 1)  # 2 rows, 5 columns, current index
    image = data[i].reshape(28, 28)
    plt.imshow(image.astype(np.uint8), cmap='gray')
    plt.title(f'Predicted: {predictions[i]}\nActual: {true_labels[i]}')

plt.show()  # Display the plot

# Visualizing confusion matrix
plt.figure(figsize=(10, 8))
plt.imshow(conf_mat, interpolation='nearest', cmap=plt.cm.Blues)
plt.title('Confusion Matrix')
plt.colorbar()
tick_marks = np.arange(num_classes)
plt.xticks(tick_marks, range(num_classes))
plt.yticks(tick_marks, range(num_classes))
plt.xlabel('Predicted Label')
plt.ylabel('True Label')
plt.show()
```

## Hyperparameter Tuning

```python
# Manual hyperparameter tuning with loop
for num_bins in [3, 5, 7, 9, 11]:
    bins = np.linspace(start=0, stop=255, num=num_bins + 1)
    discretized_training_data = values_to_bins(training_data, bins)
    discretized_testing_data = values_to_bins(testing_data, bins)
    
    model = MultinomialNB()
    model.fit(discretized_training_data, training_labels)
    accuracy = model.score(discretized_testing_data, testing_labels)
    
    print(f'For {num_bins} bins, accuracy: {accuracy:.4f}')

# Using scikit-learn's GridSearchCV
from sklearn.model_selection import GridSearchCV

param_grid = {
    'alpha': [0.1, 0.5, 1.0, 2.0],
    'fit_prior': [True, False]
}

grid_search = GridSearchCV(MultinomialNB(), param_grid, cv=5, scoring='accuracy')
grid_search.fit(discretized_training_data, training_labels)

print(f"Best parameters: {grid_search.best_params_}")
print(f"Best accuracy: {grid_search.best_score_:.4f}")
```

## Data Exploration and Analysis

```python
# Basic statistics on data
data_mean = np.mean(data)
data_std = np.std(data)
data_min = np.min(data)
data_max = np.max(data)

# Class distribution
unique_classes, class_counts = np.unique(labels, return_counts=True)
for cls, count in zip(unique_classes, class_counts):
    print(f"Class {cls}: {count} samples")

# Feature importance for Naive Bayes
feature_log_prob = model.feature_log_prob_
# Higher values indicate features more indicative of a particular class
```

## Common Machine Learning Workflow

```python
# 1. Data Loading
X_train = np.loadtxt('train_data.txt')
y_train = np.loadtxt('train_labels.txt')
X_test = np.loadtxt('test_data.txt')
y_test = np.loadtxt('test_labels.txt')

# 2. Data Preprocessing (e.g., discretization)
bins = np.linspace(start=min_value, stop=max_value, num=num_bins + 1)
X_train_processed = np.digitize(X_train, bins) - 1
X_test_processed = np.digitize(X_test, bins) - 1

# 3. Model Selection and Training
model = MultinomialNB()  # Or other classifiers
model.fit(X_train_processed, y_train)

# 4. Prediction
y_pred = model.predict(X_test_processed)

# 5. Evaluation
accuracy = model.score(X_test_processed, y_test)
conf_mat = confusion_matrix(y_test, y_pred)

# 6. Visualization and Analysis
plt.figure(figsize=(10, 8))
plt.imshow(conf_mat, cmap='Blues')
plt.colorbar()
plt.title(f'Confusion Matrix (Accuracy: {accuracy:.4f})')
plt.xlabel('Predicted Label')
plt.ylabel('True Label')
plt.show()
```

## Probability Tips and Tricks

```python
# Avoid division by zero in probability calculations
epsilon = 1e-10
safe_probability = (count + epsilon) / (total + epsilon)

# Log probabilities for numerical stability
log_prob_a = np.log(prob_a)
log_prob_b = np.log(prob_b)
log_prob_sum = np.logaddexp(log_prob_a, log_prob_b)  # log(exp(a) + exp(b))

# Convert log probabilities back to probabilities
prob = np.exp(log_prob)

# Laplace smoothing (used internally by MultinomialNB)
smoothed_probability = (count + alpha) / (total + alpha * n_categories)
```

## Common Errors to Watch Out For

1. **Index Out of Range**: Ensure your bin indices make sense for your data
2. **Division by Zero**: When calculating probabilities with empty bins
3. **Data Type Mismatch**: Make sure labels are integers for classification
4. **Shape Mismatch**: Ensure your data is properly reshaped for models
5. **Memory Issues**: Be careful with large datasets and many bins
6. **Missing Values**: Handle NaN or missing values before classification