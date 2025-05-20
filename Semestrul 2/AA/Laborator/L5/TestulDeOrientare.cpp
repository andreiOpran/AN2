#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

double calculeazaDeterminantTestOrientare(double px, double py, double qx, double qy, double rx, double ry) {
	return  qx * ry + px * qy + rx * py - py * qx - rx * qy - px * ry;
}

int main() {
	double px, py, qx, qy, rx, ry;
	int numarTeste;
	
	cin >> numarTeste;

	while (numarTeste--) {
		cin >> px >> py >> qx >> qy >> rx >> ry;
		double determinant = calculeazaDeterminantTestOrientare(px, py, qx, qy, rx, ry);
		if (determinant == 0) {
			cout << "TOUCH" << '\n';
		} else if (determinant > 0) {
			cout << "LEFT" << '\n';
		} else {
			cout << "RIGHT" << '\n';
		}
	}

	return 0;
}