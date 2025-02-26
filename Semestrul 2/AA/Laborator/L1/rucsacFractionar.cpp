#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

bool ComparatorProblemaRucsac(pair<double, double> a, pair<double, double> b)
{
	return (double)a.second / a.first > (double)b.second / b.first;
}

int main()
{
	int nrObiecte, capacitateRucsac;
	double valoareRucsac = 0; // rezultat
	double greutate, valoare; // variabile auxiliare pentru citire
	cin >> nrObiecte >> capacitateRucsac;
	vector<pair<double, double>> obiecte; // greutate, valoare
	while(nrObiecte--)
	{
		cin >> valoare;
		obiecte.push_back({0, valoare});
	}
	for(auto &obiect : obiecte)
	{
		cin >> greutate;
		obiect.first = greutate;
	}
	sort(obiecte.begin(), obiecte.end(), ComparatorProblemaRucsac); // sortam descrescator dupa valoare/greutate
	for(auto obiect : obiecte)
	{
		if(capacitateRucsac == 0)
			break;
		if(obiect.first <= capacitateRucsac)
		{
			valoareRucsac += obiect.second;
			capacitateRucsac -= obiect.first;
		}
		else
		{
			valoareRucsac += obiect.second * (capacitateRucsac / obiect.first);
			capacitateRucsac = 0;
		}
	}
	cout << valoareRucsac;
	return 0;
}