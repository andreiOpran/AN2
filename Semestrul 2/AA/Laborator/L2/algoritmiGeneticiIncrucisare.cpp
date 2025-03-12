#include <iostream>
using namespace std;

int main()
{
	int l, ind; // l - lungimea cromozomilor, i - indicele de la care se face incrucisarea cromozomilor
	string a, b; // cromozomii
	cin >> l >> a >> b >> ind;

	string c = a.substr(0, ind) + b.substr(ind, l - ind);
	string d = b.substr(0, ind) + a.substr(ind, l - ind);

	cout << c << endl << d << endl;
	return 0;
}