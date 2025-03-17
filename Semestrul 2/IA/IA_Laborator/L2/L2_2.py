import numpy as np

training_data = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\train_images.txt')
training_labels = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\train_labels.txt')
testing_data = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\test_images.txt')
testing_labels = np.loadtxt(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L2\data\test_labels.txt')


def value_to_bins(data, parameter_bins):
	return np.digitize(data, parameter_bins)


num_bins = 10
bins = np.linspace(start=0, stop=255, num=num_bins + 1)
# print(bins)

discretized_training_data = value_to_bins(training_data, bins)
discretized_testing_data = value_to_bins(testing_data, bins)

print(f'Discretized training data: {discretized_training_data}')
print(f'Discretized testing data: {discretized_testing_data}')


