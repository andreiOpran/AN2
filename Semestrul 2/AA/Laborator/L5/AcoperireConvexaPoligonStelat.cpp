#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

string testOrientare(long long px, long long py, long long qx, long long qy, long long rx, long long ry) {
	long long determinant = qx * ry + px * qy + rx * py - py * qx - rx * qy - px * ry;
	if (determinant == 0) {
		return "TOUCH";
	} else if (determinant > 0) {
		return "LEFT";
	} else {
		return "RIGHT";
	}
}

bool compararePuncte(pair<long long, long long> a, pair<long long, long long> b) {
	if (a.first == b.first) {
		return a.second < b.second;
	}
	return a.first < b.first;
}

vector<pair<long long, long long>> AcoperireConvexa(vector<pair<long long, long long>>& varfuri) {
	vector<pair<long long, long long>> rezultat;

	if (varfuri.size() <= 2) {
		return varfuri;
	}

	sort(varfuri.begin(), varfuri.end(), compararePuncte);

	// acoperire inferioara
	int n = varfuri.size();
	for (int i = 0; i < n; i++) {
		while (rezultat.size() >= 2 && testOrientare(
				rezultat[rezultat.size() - 2].first, rezultat[rezultat.size() - 2].second,
				rezultat[rezultat.size() - 1].first, rezultat[rezultat.size() - 1].second,
				varfuri[i].first, varfuri[i].second) != "LEFT") {
			rezultat.pop_back();
		}
		rezultat.push_back(varfuri[i]);
	}

	// acoperire superioara
	int m = rezultat.size();
	for (int i = n - 2; i >= 0; i--) {
		while (rezultat.size() > m && testOrientare(
				rezultat[rezultat.size() - 2].first, rezultat[rezultat.size() - 2].second,
				rezultat[rezultat.size() - 1].first, rezultat[rezultat.size() - 1].second,
				varfuri[i].first, varfuri[i].second) != "LEFT") {
			rezultat.pop_back();
		}
		rezultat.push_back(varfuri[i]);
	}

	rezultat.pop_back(); // ultimul este acelasi cu primul

	return rezultat;
}

int main() {

	int nrVarfuri;
	vector<pair<long long, long long>> varfuri;

	cin >> nrVarfuri;
	for (int i = 0; i < nrVarfuri; i++) {
		long long x, y;
		cin >> x >> y;
		varfuri.push_back(make_pair(x, y));
	}

	vector<pair<long long, long long>> acoperireConvexa = AcoperireConvexa(varfuri);

	cout << acoperireConvexa.size() << endl;
	for (const auto& varf : acoperireConvexa) {
		cout << varf.first << ' ' << varf.second << endl;
	}
	return 0;
}