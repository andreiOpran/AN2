# Text Classification with Bag of Words & SVM Cheatsheet

## Loading Text Data

```python
# Load text data from numpy files
train_data = np.load('path/to/training_sentences.npy', allow_pickle=True)
train_labels = np.load('path/to/training_labels.npy', allow_pickle=True)
test_data = np.load('path/to/test_sentences.npy', allow_pickle=True)
test_labels = np.load('path/to/test_labels.npy', allow_pickle=True)

# Note: allow_pickle=True is required for loading arrays of Python objects (like lists of words)
```

## Bag of Words Implementation

```python
class bag_of_words:
    def __init__(self):
        self.vocabulary = {}  # Word to index mapping
        self.word_list = []   # List of all words in vocabulary
    
    def build_vocabulary(self, data):
        """Build vocabulary from a list of sentences"""
        for sentence in data:
            for word in sentence:
                if word not in self.vocabulary:
                    self.vocabulary[word] = len(self.vocabulary)
                    self.word_list.append(word)
    
    def get_vocabulary_size(self):
        """Return size of vocabulary"""
        return len(self.vocabulary)
    
    def get_features(self, data):
        """Convert list of sentences to bag-of-words feature matrix"""
        features = np.zeros((len(data), self.get_vocabulary_size()))
        for i, sentence in enumerate(data):
            for word in sentence:
                if word in self.vocabulary:
                    features[i][self.vocabulary[word]] += 1
        return features
    
    # Additional useful methods
    def get_most_common_words(self, top_n=10):
        """Return the most common words in the training data"""
        word_counts = {}
        for word in self.word_list:
            word_counts[word] = 0
            
        for sentence in data:
            for word in sentence:
                if word in word_counts:
                    word_counts[word] += 1
                    
        return sorted(word_counts.items(), key=lambda x: x[1], reverse=True)[:top_n]
    
    def filter_vocabulary(self, min_count=2):
        """Remove words that appear less than min_count times"""
        word_counts = {}
        for word in self.word_list:
            word_counts[word] = 0
            
        for sentence in data:
            for word in sentence:
                if word in word_counts:
                    word_counts[word] += 1
        
        new_vocab = {}
        new_word_list = []
        for word, count in word_counts.items():
            if count >= min_count:
                new_vocab[word] = len(new_vocab)
                new_word_list.append(word)
        
        self.vocabulary = new_vocab
        self.word_list = new_word_list
```

## Data Normalization

```python
def normalize_data(train_data, test_data, type=None):
    """Normalize features using different methods"""
    if type == 'l2':
        # L2 normalization (unit norm)
        scaler = preprocessing.Normalizer(norm='l2')
        train_data = scaler.fit_transform(train_data)
        test_data = scaler.transform(test_data)
    elif type == 'l1':
        # L1 normalization (sum of absolute values = 1)
        scaler = preprocessing.Normalizer(norm='l1')
        train_data = scaler.fit_transform(train_data)
        test_data = scaler.transform(test_data)
    elif type == 'standard':
        # Standardization (mean=0, std=1)
        scaler = preprocessing.StandardScaler()
        train_data = scaler.fit_transform(train_data)
        test_data = scaler.transform(test_data)
    elif type == 'minmax':
        # MinMax scaling (range [0, 1])
        scaler = preprocessing.MinMaxScaler()
        train_data = scaler.fit_transform(train_data)
        test_data = scaler.transform(test_data)
    
    return train_data, test_data
```

## SVM Classification

```python
from sklearn.svm import SVC
from sklearn.metrics import accuracy_score, f1_score, precision_score, recall_score

# Train SVM classifier
def train_svm(train_features, train_labels, kernel='linear', C=1.0, gamma='scale'):
    """Train SVM classifier with specified parameters"""
    model = SVC(C=C, kernel=kernel, gamma=gamma)
    model.fit(train_features, train_labels)
    return model

# Evaluate model
def evaluate_model(model, test_features, test_labels):
    """Evaluate model performance"""
    predictions = model.predict(test_features)
    
    accuracy = accuracy_score(test_labels, predictions)
    f1 = f1_score(test_labels, predictions)
    precision = precision_score(test_labels, predictions)
    recall = recall_score(test_labels, predictions)
    
    print(f"Accuracy: {accuracy:.4f}")
    print(f"F1 Score: {f1:.4f}")
    print(f"Precision: {precision:.4f}")
    print(f"Recall: {recall:.4f}")
    
    return predictions

# SVM Hyperparameter tuning example
def tune_svm_hyperparameters(train_features, train_labels, test_features, test_labels):
    """Test different hyperparameter combinations"""
    results = []
    
    for kernel in ['linear', 'rbf', 'poly']:
        for C in [0.1, 1.0, 10.0]:
            model = SVC(C=C, kernel=kernel)
            model.fit(train_features, train_labels)
            
            predictions = model.predict(test_features)
            accuracy = accuracy_score(test_labels, predictions)
            f1 = f1_score(test_labels, predictions)
            
            results.append({
                'kernel': kernel,
                'C': C,
                'accuracy': accuracy,
                'f1': f1
            })
            
            print(f"Kernel: {kernel}, C: {C}, Accuracy: {accuracy:.4f}, F1: {f1:.4f}")
    
    # Find best configuration
    best_result = max(results, key=lambda x: x['f1'])
    print(f"Best configuration: {best_result}")
```

## Text Preprocessing Techniques

```python
import re
import string
from nltk.corpus import stopwords
from nltk.stem import PorterStemmer, WordNetLemmatizer

def preprocess_text(sentences, lowercase=True, remove_punctuation=True, 
                   remove_stopwords=False, stemming=False, lemmatization=False):
    """Preprocess text data with various techniques"""
    processed_sentences = []
    
    # Initialize stemmer/lemmatizer if needed
    stemmer = PorterStemmer() if stemming else None
    lemmatizer = WordNetLemmatizer() if lemmatization else None
    
    # Get stopwords if needed
    stop_words = set(stopwords.words('english')) if remove_stopwords else None
    
    for sentence in sentences:
        processed_words = []
        
        for word in sentence:
            # Convert to lowercase
            if lowercase:
                word = word.lower()
            
            # Remove punctuation
            if remove_punctuation:
                word = word.translate(str.maketrans('', '', string.punctuation))
            
            # Skip empty words and stopwords
            if not word or (remove_stopwords and word in stop_words):
                continue
            
            # Apply stemming
            if stemming:
                word = stemmer.stem(word)
            
            # Apply lemmatization
            if lemmatization:
                word = lemmatizer.lemmatize(word)
            
            processed_words.append(word)
        
        processed_sentences.append(processed_words)
    
    return processed_sentences
```

## Advanced Bag of Words Features

```python
def compute_tf_idf_features(data, vocabulary):
    """Compute TF-IDF features instead of raw counts"""
    from sklearn.feature_extraction.text import TfidfTransformer
    
    # First get BOW features
    bow = bag_of_words()
    bow.vocabulary = vocabulary  # Use existing vocabulary
    bow.word_list = list(vocabulary.keys())
    bow_features = bow.get_features(data)
    
    # Apply TF-IDF transformation
    transformer = TfidfTransformer()
    tfidf_features = transformer.fit_transform(bow_features).toarray()
    
    return tfidf_features

def compute_ngram_features(data, n=2):
    """Create features from word n-grams"""
    # Create n-gram vocabulary
    vocabulary = {}
    
    for sentence in data:
        for i in range(len(sentence) - n + 1):
            ngram = tuple(sentence[i:i+n])
            if ngram not in vocabulary:
                vocabulary[ngram] = len(vocabulary)
    
    # Create n-gram features
    features = np.zeros((len(data), len(vocabulary)))
    
    for i, sentence in enumerate(data):
        for j in range(len(sentence) - n + 1):
            ngram = tuple(sentence[j:j+n])
            if ngram in vocabulary:
                features[i][vocabulary[ngram]] += 1
    
    return features, vocabulary
```

## Evaluation and Visualization

```python
import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix, classification_report

def plot_confusion_matrix(y_true, y_pred, classes=['Negative', 'Positive']):
    """Plot confusion matrix"""
    cm = confusion_matrix(y_true, y_pred)
    
    plt.figure(figsize=(8, 6))
    plt.imshow(cm, interpolation='nearest', cmap=plt.cm.Blues)
    plt.title('Confusion Matrix')
    plt.colorbar()
    
    tick_marks = np.arange(len(classes))
    plt.xticks(tick_marks, classes)
    plt.yticks(tick_marks, classes)
    
    # Add text annotations
    thresh = cm.max() / 2.
    for i in range(cm.shape[0]):
        for j in range(cm.shape[1]):
            plt.text(j, i, format(cm[i, j], 'd'),
                    horizontalalignment="center",
                    color="white" if cm[i, j] > thresh else "black")
    
    plt.tight_layout()
    plt.ylabel('True label')
    plt.xlabel('Predicted label')
    plt.show()

def print_detailed_report(y_true, y_pred, classes=['Negative', 'Positive']):
    """Print detailed classification report"""
    report = classification_report(y_true, y_pred, target_names=classes)
    print(report)
```

## Tips and Tricks for Text Classification

### Improving Model Performance

1. **Feature Engineering**:
   - Try TF-IDF weighting instead of raw counts
   - Experiment with character n-grams for handling misspellings
   - Add features for text length, punctuation counts, etc.

2. **Preprocessing**:
   - Remove stopwords to reduce noise
   - Apply stemming/lemmatization to normalize word forms
   - Handle negations specially ("not good" has different sentiment than "good")

3. **Model Selection and Tuning**:
   - Try different kernels: linear for text is often good, but RBF might work better
   - Adjust regularization parameter C (smaller C = stronger regularization)
   - For imbalanced classes, use `class_weight='balanced'` in SVC constructor

### Common Pitfalls to Avoid

1. **Data Leakage**: Always apply preprocessing steps separately to train and test data
2. **Sparse Features**: Text data creates sparse feature vectors, be careful with normalization
3. **Out-of-Vocabulary Words**: Words in test data may not appear in training data
4. **Class Imbalance**: May need to handle imbalanced classes for better results

### One-liners for Common Tasks

```python
# Quick text cleaning
clean_text = [[word.lower() for word in sentence if word.isalpha()] for sentence in data]

# Find class distribution
class_distribution = np.bincount(labels)

# Get most informative features (for linear SVM)
if model.kernel == 'linear':
    feature_importance = np.abs(model.coef_[0])
    most_important = np.argsort(feature_importance)[-10:]  # Top 10 features
    important_words = [bow.word_list[i] for i in most_important]
    print("Most important words:", important_words)

# Save model for later use
from joblib import dump, load
dump(model, 'text_classifier.joblib')
# Later: model = load('text_classifier.joblib')
```

## Quick Reference: sklearn Functions

```python
# Cross-validation
from sklearn.model_selection import cross_val_score
scores = cross_val_score(model, features, labels, cv=5)
print(f"Cross-validation accuracy: {np.mean(scores):.4f} ± {np.std(scores):.4f}")

# Grid search for hyperparameter tuning
from sklearn.model_selection import GridSearchCV
param_grid = {'C': [0.1, 1, 10], 'kernel': ['linear', 'rbf']}
grid_search = GridSearchCV(SVC(), param_grid, cv=5)
grid_search.fit(train_features, train_labels)
print(f"Best parameters: {grid_search.best_params_}")

# Pipeline for preprocessing and classification
from sklearn.pipeline import Pipeline
from sklearn.feature_extraction.text import CountVectorizer, TfidfTransformer
pipeline = Pipeline([
    ('vect', CountVectorizer()),
    ('tfidf', TfidfTransformer()),
    ('clf', SVC(kernel='linear'))
])

# ROC curve for binary classification
from sklearn.metrics import roc_curve, auc
fpr, tpr, _ = roc_curve(test_labels, model.decision_function(test_features))
roc_auc = auc(fpr, tpr)
plt.plot(fpr, tpr, label=f'ROC curve (area = {roc_auc:.2f})')
plt.plot([0, 1], [0, 1], 'k--')
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('ROC Curve')
plt.legend(loc='lower right')
plt.show()
```