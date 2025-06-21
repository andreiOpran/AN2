# Exercitiul 1

### Cod

```python
import numpy as np
from sklearn import preprocessing
from sklearn.metrics import accuracy_score, f1_score
from sklearn.naive_bayes import MultinomialNB
import matplotlib.pyplot as plt

plt.switch_backend('TkAgg')

train_sentences = []
with open('/home/andrei/Desktop/AN2/Semestrul 2/IA/IA_Laborator/ML/V1/train_sentences.txt', 'r') as file:
    for word in file:
        train_sentences.append(word)

train_labels = np.load('/home/andrei/Desktop/AN2/Semestrul 2/IA/IA_Laborator/ML/V1/train_labels.npy')

test_sentences = []
with open('/home/andrei/Desktop/AN2/Semestrul 2/IA/IA_Laborator/ML/V1/test_sentences.txt', 'r') as file:
    for word in file:
        test_sentences.append(word)


class bag_of_words:
    def __init__(self):
        self.vocabulary = {}
        self.word_list = []

    def build_vocabulary(self, data):
        for sentence in data:
            for word in sentence:
                if word not in self.vocabulary:
                    self.vocabulary[word] = len(self.vocabulary)
                    self.word_list.append(word)

    def get_vocabulary_size(self):
        return len(self.vocabulary)

    def get_features(self, data):
        features = np.zeros((len(data), self.get_vocabulary_size()))
        i = 0  # index for the current sentence
        for sentence in data:
            for word in sentence:
                if word in self.vocabulary:
                    features[i][self.vocabulary[word]] += 1
            i += 1
        return features


def normalize_data(train_data_param, test_data_param, type_param=None):
    if type_param == 'l2':
        scaler = preprocessing.Normalizer(norm='l2')
        train_data_param = scaler.fit_transform(train_data_param)
        test_data_param = scaler.transform(test_data_param)
    elif type_param == 'l1':
        scaler = preprocessing.Normalizer(norm='l1')
        train_data_param = scaler.fit_transform(train_data_param)
        test_data_param = scaler.transform(test_data_param)
    elif type_param == 'standard':
        scaler = preprocessing.StandardScaler()
        train_data_param = scaler.fit_transform(train_data_param)
        test_data_param = scaler.transform(test_data_param)
    return train_data_param, test_data_param


def main():
    normalization_type = 'l2'

    bow = bag_of_words()
    bow.build_vocabulary(train_sentences)
    train_features = bow.get_features(train_sentences)
    test_features = bow.get_features(test_sentences)
    train_features_normalized, test_features_normalized = normalize_data(
        train_features, test_features, normalization_type
    )

    model = MultinomialNB()
    model = model.fit(train_features_normalized, train_labels)

    test_predictions = model.predict(test_features_normalized)
    np.save('Opran_Andrei_242_subiect1_solutia_1', test_predictions)
    train_predictions = model.predict(train_features_normalized)
    train_accuracy = accuracy_score(train_labels, train_predictions)

    print(f'Accuracy with {normalization_type} is {train_accuracy}')


if __name__ == '__main__':
    main()
```

#### Output cu normalizare L1:
```
/usr/bin/python3 /home/andrei/Desktop/AN2/Semestrul 2/IA/IA_Laborator/ML/colocviu.py 
Accuracy with l1 is 0.5209756097560976

Process finished with exit code 0
```

#### Output cu normalizare L2 (best):
```
/usr/bin/python3 /home/andrei/Desktop/AN2/Semestrul 2/IA/IA_Laborator/ML/colocviu.py 
Accuracy with l2 is 0.6751219512195122

Process finished with exit code 0
```

#### Output cu normalizare standard:

Nu a functionat pentru ca modelul Bayes naiv nu poate primi valori negative.

```
/usr/bin/python3 /home/andrei/Desktop/AN2/Semestrul 2/IA/IA_Laborator/ML/colocviu.py 
Traceback (most recent call last):
  File "/home/andrei/Desktop/AN2/Semestrul 2/IA/IA_Laborator/ML/colocviu.py", line 96, in <module>
    main()
  File "/home/andrei/Desktop/AN2/Semestrul 2/IA/IA_Laborator/ML/colocviu.py", line 85, in main
    model = model.fit(train_features_normalized, train_labels)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/sklearn/base.py", line 1474, in wrapper
    return fit_method(estimator, *args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/sklearn/naive_bayes.py", line 759, in fit
    self._count(X, Y)
  File "/usr/lib/python3/dist-packages/sklearn/naive_bayes.py", line 881, in _count
    check_non_negative(X, "MultinomialNB (input X)")
  File "/usr/lib/python3/dist-packages/sklearn/utils/validation.py", line 1650, in check_non_negative
    raise ValueError("Negative values in data passed to %s" % whom)
ValueError: Negative values in data passed to MultinomialNB (input X)

Process finished with exit code 1
```

### Concluzie:
Pentru exercitiul 1, bag of words cu normalizare L2 a avut cel mai bun rezultat.