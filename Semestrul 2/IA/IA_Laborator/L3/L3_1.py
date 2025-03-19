import warnings
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

warnings.filterwarnings("ignore", category=DeprecationWarning)
matplotlib.use('TkAgg')

training_data = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L3\data\train_images.txt')
training_labels = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L3\data\train_labels.txt')
testing_data = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L3\data\test_images.txt')
testing_labels = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L3\data\test_labels.txt')


class knn_classifier:
    def __init__(self, train_images=training_data, train_labels=training_labels):
        self.train_images = train_images
        self.train_labels = train_labels

    def classify_image(self, test_image, num_neighbors=3, metric='l2'):
        distances = []

        if metric == 'l2':
            distances = np.sqrt(np.sum((self.train_images - test_image) ** 2, axis=1))
        elif metric == 'l1':
            distances = np.sum(np.abs(self.train_images - test_image), axis=1)

        nearest_indices = np.argsort(distances)[:num_neighbors]
        nearest_labels = self.train_labels[nearest_indices]

        # most common label
        return np.argmax(np.bincount(nearest_labels.astype(int)))

    def accuracy_test(self, test_images, test_labels, num_neighbors=3, metric='l2'):
        correct = 0
        with open('predictii_3nn_l2_mnist.txt', 'w') as f:
            for i in range(len(test_images)):
                prediction = self.classify_image(test_images[i], num_neighbors, metric)
                f.write(f"Prediction is {prediction} and correct label is {test_labels[i].astype(int)}\n")
                if prediction == test_labels[i]:
                    correct += 1

        return correct / len(test_images)

    # ex 4.a
    def accuracy_plot(self, test_images, test_labels, num_neighbours, metric):
        accuracies = []
        with open('acuratete_l2.txt', 'w') as f:
            for k in num_neighbours:
                accuracies.append(self.accuracy_test(test_images, test_labels, k, metric))
                f.write(f"{accuracies[-1]:.4f} {k}\n")

        plt.plot(num_neighbours, accuracies)
        plt.xlabel('Number of neighbours')
        plt.ylabel('Accuracy')
        plt.show()

    # ex 4.b
    def accuracy_plot_2(self, test_images, test_labels, num_neighbours, metric):
        with open('acuratete_l2.txt', 'r') as f:
            lines = f.readlines()
            accuracies_l2 = [float(line.split()[0]) for line in lines]
            k_values = num_neighbours

        accuracies_l1 = []
        with open('acuratete_l1.txt', 'w') as f:
            for k in num_neighbours:
                accuracies_l1.append(self.accuracy_test(test_images, test_labels, k, 'l1'))
                f.write(f"{accuracies_l1[-1]:.4f} {k}\n")

        plt.plot(k_values, accuracies_l1, label='l1')
        plt.plot(k_values, accuracies_l2, label='l2')
        plt.xlabel('Number of neighbours')
        plt.ylabel('Accuracy')
        plt.legend()
        plt.show()


def main():
    classifier = knn_classifier()
    # print(classifier.accuracy_test(testing_data, testing_labels, 3, 'l2'))
    # classifier.accuracy_plot(testing_data, testing_labels, [1, 3, 5, 7, 9], 'l2')
    # classifier.accuracy_plot(testing_data, testing_labels, [1, 3, 5, 7, 9], 'l1')
    classifier.accuracy_plot_2(testing_data, testing_labels, [1, 3, 5, 7, 9], 'l2')


if __name__ == '__main__':
    main()
