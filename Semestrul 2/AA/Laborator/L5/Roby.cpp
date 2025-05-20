#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

string testOrientare(double px, double py, double qx, double qy, double rx, double ry) {
	double determinant = qx * ry + px * qy + rx * py - py * qx - rx * qy - px * ry;
	if (determinant == 0) {
		return "TOUCH";
	} else if (determinant > 0) {
		return "LEFT";
	} else {
		return "RIGHT";
	}
}

int main() {

	int nrPuncte, viraje[3] = { 0 };
	vector<pair<double, double>> puncte;
	cin >> nrPuncte;
	for (int i = 0; i < nrPuncte; i++) {
		double x, y;
		cin >> x >> y;
		puncte.push_back(make_pair(x, y));
	}
	puncte.push_back(puncte[0]); // ultimul punct coincide cu primul

	for (int i = 0; i < nrPuncte - 1; i++) {
		string viraj = testOrientare(puncte[i].first, puncte[i].second, puncte[i + 1].first, puncte[i + 1].second, puncte[i + 2].first, puncte[i + 2].second);
		cout << viraj << ' ' << puncte[i].first << ' ' << puncte[i].second << ' ' << puncte[i + 1].first << ' ' << puncte[i + 1].second << ' ' << puncte[i + 2].first << ' ' << puncte[i + 2].second << '\n';
		if (viraj == "LEFT") {
			++viraje[0];
		} else if (viraj == "RIGHT") {
			++viraje[1];
		} else {
			++viraje[2];
		}
	}
	cout << viraje[0] << " " << viraje[1] << " " << viraje[2] << '\n';
	return 0;
}