import numpy as np
from sklearn import preprocessing
from sklearn.metrics import accuracy_score, f1_score
from sklearn.naive_bayes import MultinomialNB

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
