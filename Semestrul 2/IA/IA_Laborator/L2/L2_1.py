import numpy as np

# calculati probabilitatea genului unei persoane cu inaltimea 178 cm

train = [
	(160, 'F'),
	(165, 'F'),
	(155, 'F'),
	(172, 'F'),
	(175, 'B'),
	(180, 'B'),
	(177, 'B'),
	(190, 'B')
]

# impartim in 4 intervale
bins = np.linspace(start=150, stop=190, num=5)  # returneaza intervalele
print(bins)

x_to_bins = np.digitize(178, bins)  # va fi egal cu 3

# calculam probabilitatea sa fie baiat
count = 0
for i in range(len(train)):
	if x_to_bins == np.digitize(train[i][0], bins):
		if train[i][1] == 'B':
			count += 1

print('Inaltimea este 178.')
print(f'Probabilitatea sa fie baiat este {count / len(train)}')
print(f'Probabilitatea sa fie fata este {1 - count / len(train)}')
