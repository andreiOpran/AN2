#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;


struct Punct {
	long long x;
	long long y;

	Punct() {}
	Punct(long long x, long long y) : x(x), y(y) {}
};

bool esteXMonoton(vector<Punct>& puncte) {
	int n = puncte.size();

	long long ind_minX = 0, ind_maxX = 0;

	for (int i = 1; i < n; i++) {
		if (puncte[i].x < puncte[ind_minX].x) {
			ind_minX = i;
		}
		if (puncte[i].x > puncte[ind_maxX].x) {
			ind_maxX = i;
		}
	}

	// primul lant de la minX la maxX in sens opus celui trigonometric
	int i = ind_minX;
	while (i != ind_maxX) {
		int j = (i + 1) % n;
		if (puncte[i].x > puncte[j].x) // verificare daca x devine mai mic pentru urmatorul punct
			return false;
		i = j;
	}

	// al doilea lant de la minX la maxX in sens trigonometric
	i = ind_minX;
	while (i != ind_maxX) {
		int j = (i - 1 + n) % n;
		if (puncte[i].x > puncte[j].x) // verificare daca x devine mai mic pentru urmatorul punct
			return false;
		i = j;
	}

	return true;
}

bool esteYMonoton(vector<Punct>& puncte) {
	int n = puncte.size();

	long long ind_minY = 0, ind_maxY = 0;

	for (int i = 1; i < n; i++) {
		if (puncte[i].y < puncte[ind_minY].y) {
			ind_minY = i;
		}
		if (puncte[i].y > puncte[ind_maxY].y) {
			ind_maxY = i;
		}
	}

	// primul lant de la minY la maxY in sens opus celui trigonometric
	int i = ind_minY;
	while (i != ind_maxY) {
		int j = (i + 1) % n;
		if (puncte[i].y > puncte[j].y) // verificare daca y devine mai mic pentru urmatorul punct
			return false;
		i = j;
	}

	// al doilea lant de la minY la maxY in sens trigonometric
	i = ind_minY;
	while (i != ind_maxY) {
		int j = (i - 1 + n) % n;
		if (puncte[i].y > puncte[j].y) //verificare daca y devine mai mic pentru urmatorul punct
			return false;
		i = j;
	}

	return true;
}

int main() {

	int n;
	cin >> n;

	vector<Punct> puncte;
	for (int i = 0; i < n; i++) {
		long long x, y;
		cin >> x >> y;
		puncte.push_back(Punct(x, y));
	}

	if (esteXMonoton(puncte)) {
		cout << "YES" << endl;
	}
	else {
		cout << "NO" << endl;
	}

	if (esteYMonoton(puncte)) {
		cout << "YES" << endl;
	}
	else {
		cout << "NO" << endl;
	}

	return 0;
}