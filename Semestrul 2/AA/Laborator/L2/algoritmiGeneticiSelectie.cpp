#include <iostream>
#include <vector>
#include <iomanip>
using namespace std;

int main()
{
	int a, b, c; // coeficientii polinomului
	int n; // numarul de cromozomi
	cin >> a >> b >> c >> n; 

	vector<double> cromozomi(n); // fiecare element reprezinta valoare decodificata a unui cromozom din populatie
	for (int i = 0; i < n; ++i)
		cin >> cromozomi[i];

	vector<double> fitness(n); // fiecare element reprezinta valoarea functiei de fitness pentru un cromozom
	for (int i = 0; i < n; ++i)
		fitness[i] = (double)(a * cromozomi[i] * cromozomi[i] + b * cromozomi[i] + c);

	double sumaFitness = 0;
	for(double x : fitness)
		sumaFitness += x;

	double sumaPartiala = 0;
	double rez = 0;
	cout << fixed << setprecision(5) << rez << '\n';
	for(unsigned int i = 0; i < fitness.size(); ++i)
	{
		rez = 0;
		sumaPartiala += fitness[i];
		rez += (double)sumaPartiala / sumaFitness;
		cout << rez << '\n';
	}
	return 0;
}