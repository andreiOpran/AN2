from sklearn import preprocessing
import numpy as np
from sklearn.svm import SVC
from sklearn.metrics import accuracy_score, f1_score

train_data = np.load(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L4\data\training_sentences.npy', allow_pickle=True)
train_labels = np.load(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L4\data\training_labels.npy', allow_pickle=True)
test_data = np.load(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L4\data\test_sentences.npy', allow_pickle=True)
test_labels = np.load(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L4\data\test_labels.npy', allow_pickle=True)


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
    """
    Rulare exercitiul 3
    """
    print('Exercitiul 3')
    my_bag_of_words = bag_of_words()
    my_bag_of_words.build_vocabulary(train_data)
    print(my_bag_of_words.get_vocabulary_size())

    """
    Exercitiul 5
    """
    print('Exercitiul 5')
    bag_of_words_ex5 = bag_of_words()
    bag_of_words_ex5.build_vocabulary(train_data)
    train_features = bag_of_words_ex5.get_features(train_data)
    test_features = bag_of_words_ex5.get_features(test_data)
    train_features_normalized, test_features_normalized = normalize_data(train_features, test_features, 'l2')
    print(train_features_normalized)
    print(test_features_normalized)

    """
    Exercitiul 6
    """
    print('Exercitiul 6')
    model = SVC(C=1.0, kernel='linear')
    model.fit(train_features_normalized, train_labels)

    predictions = model.predict(test_features_normalized)
    accuracy = accuracy_score(test_labels, predictions)
    f1 = f1_score(test_labels, predictions)

    print(f"Accuracy: {accuracy}")
    print(f"F1: {f1}")


if __name__ == '__main__':
    main()
