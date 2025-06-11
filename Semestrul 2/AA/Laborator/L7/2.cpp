#include <iostream>
using namespace std;

long long determinantCercCircumscris(long long ax, long long ay, long long bx, long long by, long long cx, long long cy, long long px, long long py) {    
	return
		ax * (by * ((cx*cx + cy*cy) * 1 - 1 * (px*px + py*py)) - (bx*bx + by*by) * (cy * 1 - 1 * py) + 1 * (cy * (px*px + py*py) - (cx*cx + cy*cy) * py)) -
		ay * (bx * ((cx*cx + cy*cy) * 1 - 1 * (px*px + py*py)) - (bx*bx + by*by) * (cx * 1 - 1 * px) + 1 * (cx * (px*px + py*py) - (cx*cx + cy*cy) * px)) +
		(ax*ax + ay*ay) * (bx * (cy * 1 - 1 * py) - by * (cx * 1 - 1 * px) + 1 * (cx * py - cy * px)) - 1 * (bx * (cy * (px*px + py*py) - (cx*cx + cy*cy) * py) - by * (cx * (px*px + py*py) - (cx*cx + cy*cy) * px) + (bx*bx + by*by) * (cx * py - cy * px));
}

int main() {
	long long ax, ay, bx, by, cx, cy, dx, dy;
	cin >> ax >> ay >> bx >> by >> cx >> cy >> dx >> dy;

	long long determinantAC = determinantCercCircumscris(ax, ay, bx, by, cx, cy, dx, dy);
	long long determinantBD = determinantCercCircumscris(bx, by, cx, cy, dx, dy, ax, ay);

	cout << "AC: ";
	if (determinantAC > 0) {
		cout << "ILLEGAL\n";
	}
	else {
		cout << "LEGAL\n";
	}
	cout << "BD: ";
	if (determinantBD > 0) {
		cout << "ILLEGAL\n";
	}
	else {
		cout << "LEGAL\n";
	}
	return 0;
}
