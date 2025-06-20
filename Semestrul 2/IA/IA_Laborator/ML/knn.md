# Machine Learning Cheatsheet

## K-Nearest Neighbors (KNN)

```python
# Basic KNN implementation
class KNNClassifier:
    def __init__(self, train_data, train_labels):
        self.train_data = train_data
        self.train_labels = train_labels
    
    def classify(self, test_sample, k=3, metric='l2'):
        # Calculate distances
        if metric == 'l2':  # Euclidean distance
            distances = np.sqrt(np.sum((self.train_data - test_sample) ** 2, axis=1))
        elif metric == 'l1':  # Manhattan distance
            distances = np.sum(np.abs(self.train_data - test_sample), axis=1)
        
        # Find k nearest neighbors
        nearest_indices = np.argsort(distances)[:k]
        nearest_labels = self.train_labels[nearest_indices]
        
        # Return most common class
        return np.argmax(np.bincount(nearest_labels.astype(int)))
    
    def accuracy(self, test_data, test_labels, k=3, metric='l2'):
        correct = 0
        for i in range(len(test_data)):
            prediction = self.classify(test_data[i], k, metric)
            if prediction == test_labels[i]:
                correct += 1
        return correct / len(test_data)
```

### Distance Metrics

```python
# Euclidean distance (L2)
def euclidean_distance(a, b):
    return np.sqrt(np.sum((a - b) ** 2))

# Manhattan distance (L1)
def manhattan_distance(a, b):
    return np.sum(np.abs(a - b))

# Vectorized distance calculations
def batch_euclidean(train_data, test_sample):
    return np.sqrt(np.sum((train_data - test_sample) ** 2, axis=1))

def batch_manhattan(train_data, test_sample):
    return np.sum(np.abs(train_data - test_sample), axis=1)

# Cosine similarity
def cosine_similarity(a, b):
    return np.dot(a, b) / (np.linalg.norm(a) * np.linalg.norm(b))
```

### Using scikit-learn's KNN

```python
from sklearn.neighbors import KNeighborsClassifier

# Initialize the classifier
knn = KNeighborsClassifier(n_neighbors=3, metric='euclidean')

# Train the model
knn.fit(X_train, y_train)

# Make predictions
y_pred = knn.predict(X_test)

# Get accuracy
accuracy = knn.score(X_test, y_test)
```

## Data Preprocessing

```python
# Normalize data (scale to [0, 1])
def normalize(data):
    return (data - np.min(data)) / (np.max(data) - np.min(data))

# Standardize data (mean=0, std=1)
def standardize(data):
    return (data - np.mean(data)) / np.std(data)

# Split data into training and testing sets
def train_test_split(data, labels, test_size=0.2, random_seed=None):
    if random_seed is not None:
        np.random.seed(random_seed)
    indices = np.random.permutation(len(data))
    test_count = int(len(data) * test_size)
    test_indices = indices[:test_count]
    train_indices = indices[test_count:]
    return data[train_indices], data[test_indices], labels[train_indices], labels[test_indices]

# One-hot encoding
def one_hot_encode(labels, num_classes):
    encoded = np.zeros((len(labels), num_classes))
    for i, label in enumerate(labels):
        encoded[i, int(label)] = 1
    return encoded
```

## Model Evaluation

```python
# Confusion matrix
def confusion_matrix(y_true, y_pred, num_classes=None):
    if num_classes is None:
        num_classes = max(max(y_true), max(y_pred)) + 1
    matrix = np.zeros((num_classes, num_classes), dtype=int)
    for true, pred in zip(y_true, y_pred):
        matrix[int(true), int(pred)] += 1
    return matrix

# Accuracy
def accuracy(y_true, y_pred):
    return np.sum(y_true == y_pred) / len(y_true)

# Precision (for binary classification)
def precision(y_true, y_pred):
    true_positives = np.sum((y_true == 1) & (y_pred == 1))
    predicted_positives = np.sum(y_pred == 1)
    return true_positives / predicted_positives if predicted_positives > 0 else 0

# Recall (for binary classification)
def recall(y_true, y_pred):
    true_positives = np.sum((y_true == 1) & (y_pred == 1))
    actual_positives = np.sum(y_true == 1)
    return true_positives / actual_positives if actual_positives > 0 else 0

# F1 score
def f1_score(y_true, y_pred):
    prec = precision(y_true, y_pred)
    rec = recall(y_true, y_pred)
    return 2 * (prec * rec) / (prec + rec) if (prec + rec) > 0 else 0

# K-fold cross-validation
def k_fold_cross_validation(data, labels, k=5, classifier_fn=None):
    fold_size = len(data) // k
    accuracies = []
    
    for i in range(k):
        # Create validation set for this fold
        val_indices = list(range(i * fold_size, (i + 1) * fold_size))
        train_indices = [j for j in range(len(data)) if j not in val_indices]
        
        X_train, X_val = data[train_indices], data[val_indices]
        y_train, y_val = labels[train_indices], labels[val_indices]
        
        # Train and evaluate model
        model = classifier_fn(X_train, y_train)
        accuracies.append(model.accuracy(X_val, y_val))
    
    return np.mean(accuracies), np.std(accuracies)
```

## Hyperparameter Tuning

```python
# Simple grid search for KNN
def grid_search_knn(X_train, y_train, X_test, y_test, k_values, metrics):
    best_accuracy = 0
    best_params = {}
    results = {}
    
    for k in k_values:
        for metric in metrics:
            knn = KNNClassifier(X_train, y_train)
            accuracy = knn.accuracy(X_test, y_test, k, metric)
            results[(k, metric)] = accuracy
            
            if accuracy > best_accuracy:
                best_accuracy = accuracy
                best_params = {'k': k, 'metric': metric}
    
    return best_params, best_accuracy, results

# Example usage
k_values = [1, 3, 5, 7, 9]
metrics = ['l1', 'l2']
best_params, best_accuracy, all_results = grid_search_knn(
    training_data, training_labels, testing_data, testing_labels, k_values, metrics
)
```

## Visualization

```python
# Plot accuracy vs k
def plot_accuracy_vs_k(k_values, accuracies, metric='l2'):
    plt.figure(figsize=(10, 6))
    plt.plot(k_values, accuracies, marker='o', linestyle='-')
    plt.title(f'Accuracy vs. Number of Neighbors ({metric} distance)')
    plt.xlabel('Number of Neighbors (k)')
    plt.ylabel('Accuracy')
    plt.grid(True)
    plt.xticks(k_values)
    plt.show()

# Compare multiple metrics
def plot_accuracy_comparison(k_values, accuracies_dict):
    plt.figure(figsize=(10, 6))
    for metric, accuracies in accuracies_dict.items():
        plt.plot(k_values, accuracies, marker='o', linestyle='-', label=metric)
    plt.title('Accuracy vs. Number of Neighbors (Comparison)')
    plt.xlabel('Number of Neighbors (k)')
    plt.ylabel('Accuracy')
    plt.grid(True)
    plt.xticks(k_values)
    plt.legend()
    plt.show()

# Visualize confusion matrix
def plot_confusion_matrix(conf_matrix, class_names=None):
    plt.figure(figsize=(10, 8))
    plt.imshow(conf_matrix, interpolation='nearest', cmap=plt.cm.Blues)
    plt.colorbar()
    
    num_classes = conf_matrix.shape[0]
    if class_names is None:
        class_names = [str(i) for i in range(num_classes)]
    
    tick_marks = np.arange(num_classes)
    plt.xticks(tick_marks, class_names)
    plt.yticks(tick_marks, class_names)
    plt.xlabel('Predicted Label')
    plt.ylabel('True Label')
    
    # Add text annotations
    thresh = conf_matrix.max() / 2
    for i in range(num_classes):
        for j in range(num_classes):
            plt.text(j, i, format(conf_matrix[i, j], 'd'),
                     ha="center", va="center",
                     color="white" if conf_matrix[i, j] > thresh else "black")
    
    plt.tight_layout()
    plt.show()

# Display misclassified examples
def plot_misclassified(X_test, y_test, y_pred, num_examples=5, figsize=(15, 3)):
    misclassified = np.where(y_test != y_pred)[0]
    if len(misclassified) == 0:
        print("No misclassified examples found.")
        return
    
    num_to_show = min(num_examples, len(misclassified))
    fig, axes = plt.subplots(1, num_to_show, figsize=figsize)
    
    for i in range(num_to_show):
        idx = misclassified[i]
        image = X_test[idx].reshape(28, 28)  # Assuming 28x28 MNIST images
        axes[i].imshow(image, cmap='gray')
        axes[i].set_title(f'True: {int(y_test[idx])}\nPred: {int(y_pred[idx])}')
        axes[i].axis('off')
    
    plt.tight_layout()
    plt.show()
```

## I/O Operations

```python
# Load data from text files
def load_data(image_path, label_path):
    images = np.loadtxt(image_path)
    labels = np.loadtxt(label_path)
    return images, labels

# Save predictions to file
def save_predictions(predictions, true_labels, filename):
    with open(filename, 'w') as f:
        for pred, true in zip(predictions, true_labels):
            f.write(f"Prediction: {pred}, True: {true}\n")

# Save model parameters
def save_results(results_dict, filename):
    with open(filename, 'w') as f:
        for params, accuracy in results_dict.items():
            k, metric = params
            f.write(f"k={k}, metric={metric}, accuracy={accuracy:.4f}\n")
```

## Ensemble Methods

```python
# Voting classifier
def voting_classifier(classifiers, X, k_values, metric='l2'):
    predictions = []
    
    for k in k_values:
        pred = classifiers.classify(X, k, metric)
        predictions.append(pred)
    
    # Majority vote
    return np.argmax(np.bincount(predictions))

# Bagging
def bagging_knn(X_train, y_train, X_test, n_estimators=5, sample_ratio=0.8, k=3, metric='l2'):
    predictions = np.zeros((len(X_test), n_estimators), dtype=int)
    
    for i in range(n_estimators):
        # Bootstrap sampling
        n_samples = int(len(X_train) * sample_ratio)
        indices = np.random.choice(len(X_train), n_samples, replace=True)
        
        # Train classifier on bootstrap sample
        knn = KNNClassifier(X_train[indices], y_train[indices])
        
        # Make predictions
        for j in range(len(X_test)):
            predictions[j, i] = knn.classify(X_test[j], k, metric)
    
    # Majority vote
    final_predictions = [np.argmax(np.bincount(row)) for row in predictions]
    return np.array(final_predictions)
```

## Performance Optimization

```python
# Use smaller subset of data for hyperparameter tuning
def quick_tune(X_train, y_train, k_values, metrics, subset_size=1000):
    indices = np.random.choice(len(X_train), subset_size, replace=False)
    X_subset = X_train[indices]
    y_subset = y_train[indices]
    
    # Split subset into train and validation
    subset_train_size = int(subset_size * 0.8)
    X_train_subset = X_subset[:subset_train_size]
    y_train_subset = y_subset[:subset_train_size]
    X_val_subset = X_subset[subset_train_size:]
    y_val_subset = y_subset[subset_train_size:]
    
    return grid_search_knn(X_train_subset, y_train_subset, 
                           X_val_subset, y_val_subset, 
                           k_values, metrics)

# Optimize KNN with pre-computed distances
class OptimizedKNN:
    def __init__(self, train_data, train_labels):
        self.train_data = train_data
        self.train_labels = train_labels
        self.l2_distances = None
        self.l1_distances = None
    
    def precompute_distances(self, test_data):
        # Precompute all distances for faster prediction
        n_train = len(self.train_data)
        n_test = len(test_data)
        
        self.l2_distances = np.zeros((n_test, n_train))
        self.l1_distances = np.zeros((n_test, n_train))
        
        for i in range(n_test):
            self.l2_distances[i] = np.sqrt(np.sum((self.train_data - test_data[i]) ** 2, axis=1))
            self.l1_distances[i] = np.sum(np.abs(self.train_data - test_data[i]), axis=1)
    
    def predict(self, test_idx, k=3, metric='l2'):
        if metric == 'l2':
            distances = self.l2_distances[test_idx]
        else:
            distances = self.l1_distances[test_idx]
        
        nearest_indices = np.argsort(distances)[:k]
        nearest_labels = self.train_labels[nearest_indices]
        
        return np.argmax(np.bincount(nearest_labels.astype(int)))
```

## Common Pitfalls & Tips

```python
# 1. Curse of dimensionality: KNN performance degrades with high dimensions
# Solution: Dimensionality reduction
from sklearn.decomposition import PCA

def apply_pca(data, n_components=50):
    pca = PCA(n_components=n_components)
    return pca.fit_transform(data)

# 2. Imbalanced classes
def balance_dataset(X, y):
    classes, counts = np.unique(y, return_counts=True)
    min_count = np.min(counts)
    balanced_X = []
    balanced_y = []
    
    for cls in classes:
        indices = np.where(y == cls)[0]
        selected_indices = np.random.choice(indices, min_count, replace=False)
        balanced_X.extend(X[selected_indices])
        balanced_y.extend(y[selected_indices])
    
    return np.array(balanced_X), np.array(balanced_y)

# 3. Feature scaling is important for KNN
# Already covered with normalize() and standardize() functions above

# 4. Memory issues with large datasets
def use_subset(X, y, max_size=10000):
    if len(X) <= max_size:
        return X, y
    
    indices = np.random.choice(len(X), max_size, replace=False)
    return X[indices], y[indices]
```

## Quick Reference: NumPy Functions for ML

```python
# Array manipulation
array = np.array([1, 2, 3, 4, 5])
matrix = np.array([[1, 2, 3], [4, 5, 6]])
shape = matrix.shape          # Get dimensions (2, 3)
size = matrix.size            # Total elements (6)
reshaped = matrix.reshape(3, 2)  # Reshape to 3x2

# Math operations
mean = np.mean(array)         # Calculate mean
std = np.std(array)           # Standard deviation
sum_val = np.sum(array)       # Sum of elements
min_val = np.min(array)       # Minimum value
max_val = np.max(array)       # Maximum value
argmin = np.argmin(array)     # Index of minimum value
argmax = np.argmax(array)     # Index of maximum value

# Comparison and Boolean operations
mask = array > 3              # Create boolean mask
filtered = array[mask]        # Filter with mask [4, 5]
count = np.count_nonzero(mask) # Count True values

# Sorting and ranking
sorted_arr = np.sort(array)   # Sort array
indices = np.argsort(array)   # Get indices of sorted array
```

## Data Visualization Quick Guide

```python
# Basic line plot
plt.figure(figsize=(10, 6))
plt.plot(x_values, y_values, marker='o', linestyle='-', label='Data')
plt.title('Title')
plt.xlabel('X-axis')
plt.ylabel('Y-axis')
plt.legend()
plt.grid(True)
plt.show()

# Multiple lines
plt.figure(figsize=(10, 6))
plt.plot(x1, y1, label='Line 1')
plt.plot(x2, y2, label='Line 2')
plt.legend()
plt.show()

# Scatter plot
plt.scatter(x, y, c=colors, alpha=0.5)
plt.colorbar()
plt.show()

# Histogram
plt.hist(data, bins=20, alpha=0.7)
plt.show()

# Subplots
fig, axes = plt.subplots(2, 2, figsize=(12, 10))
axes[0, 0].plot(x1, y1)
axes[0, 1].scatter(x2, y2)
axes[1, 0].hist(data)
fig.tight_layout()
plt.show()

# 3D plot
from mpl_toolkits.mplot3d import Axes3D
fig = plt.figure(figsize=(10, 8))
ax = fig.add_subplot(111, projection='3d')
ax.scatter(x, y, z)
plt.show()

# Save figure
plt.savefig('figure.png', dpi=300, bbox_inches='tight')
```

## Matplotlib Configuration

```python
# Fix common display issues
import matplotlib
matplotlib.use('TkAgg')  # Use TkAgg backend for interactive mode

# Ignore deprecation warnings
import warnings
warnings.filterwarnings("ignore", category=DeprecationWarning)

# Set style
plt.style.use('ggplot')  # Other options: 'seaborn', 'default', 'classic'

# Increase default figure size
plt.rcParams['figure.figsize'] = (12, 8)

# Increase font size
plt.rcParams['font.size'] = 12
plt.rcParams['axes.labelsize'] = 14
plt.rcParams['axes.titlesize'] = 16
plt.rcParams['xtick.labelsize'] = 12
plt.rcParams['ytick.labelsize'] = 12
plt.rcParams['legend.fontsize'] = 12

# Better colors for colorblind-friendly plots
import seaborn as sns
sns.set_palette('colorblind')
```