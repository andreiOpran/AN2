#include <iostream>
#include <cmath>
#include <string>
#include <iomanip>
using namespace std;

int BinaryStringToInt(string s)
{
	int x = 0;
	for(unsigned int i = 0; i < s.length(); i++)
	{
		if(s[i] == '1')
			x += pow(2, s.length() - i - 1);
	}
	return x;
}

void CoutIntInBinary(int x, int l)
{
	for(int j = l - 1; j >= 0; --j)
	{
		if(x & (1 << j))
			cout << 1;
		else
			cout << 0;
	}
	cout << '\n';
}

int main()
{
	double a, b; // capetele intervalului [a, b]
	int p, m; // p - precizia, m - numarul de teste

	cin >> a >> b >> p >> m;

	// lucram cu intervalul [a, b] si precizia p
	// avem nevoie de l = log2((b - a)10^p) biti ca sa codificam numerele reale din intervalul dat
	// discretizarea d = (b - a)/2^l

	// calculam discretizarea
	int l = ceil(log2((b - a) * pow(10, p))); // numarul de biti pentru codificare
	double d = (b - a) / pow(2, l); // pasul de discretizare

	string tipTest; // tipTest - {TO, FROM}
	while(m--)
	{
		cin >> tipTest;
		if(tipTest == "TO")
		{
			double x;
			cin >> x;

			// varianta 1, prea incet
			// int i = 1;
			// while(i++) // verificam intervalul din care apartine x [a + id, a + (i + 1)d)
			// {
			// 	double st, dr;
			// 	st = a + i * d;
			// 	dr = a + (i + 1) * d;
			// 	if(x >= st && x < dr)
			// 	{
			// 		CoutIntInBinary(i, l);
			// 		break;
			// 	}
			// }

			// varianta 2
			int i = floor((x - a) / d); // x = a + i * d, rezulta ca i = (x - a) / d
			if(i < 0) i = 0;
			CoutIntInBinary(i, l);
		}
		else if (tipTest == "FROM")
		{
			string s;
			cin >> s;
			int x = BinaryStringToInt(s);
			
			// afisam capatul din stanga al intervalului din care face parte
			cout << fixed << setprecision(l) << a + x * d << '\n'; 
		}
	}
	return 0;
}