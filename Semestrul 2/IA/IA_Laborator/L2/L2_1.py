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


height = 178

# impartim in 4 intervale
bins = np.linspace(start=150, stop=190, num=5)  # returneaza intervalele
print(f'Intervalele sunt: {bins}')

x_to_bins = np.digitize(height, bins)  # va fi egal cu 3
print(f'Inaltimea {height} cm se afla in intervalul {x_to_bins}\n')

# P(B), P(F)
total_B = 0
total_F = 0
for _, gender in train:
	if gender == 'B':
		total_B += 1
	else:
		total_F += 1
p_B = total_B / len(train)
p_F = total_F / len(train)

# P(H|B), P(H|F)
count_B = 0
count_F = 0
for h, gender in train:
	if gender == 'B' and np.digitize(h, bins) == x_to_bins:
		count_B += 1
	if gender == 'F' and np.digitize(h, bins) == x_to_bins:
		count_F += 1
p_h_given_b = count_B / total_B
p_h_given_f = count_F / total_F

# aplicam Bayes pentru baieti: P(B|H) = P(H|B) * P(B) / (P(H|B) * P(B) + P(H|F) * P(F)) -> probabilitatea sa fie baiat stiind ca are inaltimea 178
p_b_given_h = p_h_given_b * p_B / (p_h_given_b * p_B + p_h_given_f * p_F)
p_f_given_h = 1 - p_b_given_h

print(f'Pentru inaltimea {height}:')
print(f'Probabilitatea sa fie baiat, stiind ca are inaltimea {height}: {p_b_given_h:.2f}')
print(f'Probabilitatea sa fie fata, stiind ca are inaltimea {height}: {p_f_given_h:.2f}')
