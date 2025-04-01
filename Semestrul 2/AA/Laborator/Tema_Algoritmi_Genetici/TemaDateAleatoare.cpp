/*

Indicatii:
==========

- generare (doar ?) etichete
- populatia este generata aleator
- cautare binara la selectie
- functia de fitness are valori strict pozitive


Cerinta:
========

	Implementati un algortim genetic pentru determinarea maximului unei functii
pozitive pe un domeniu dat. Functia va fi un polinom de gradul 2, cu coeficienti
dati.
	Algoritmul trebuie sa cuprinda etapele de selectie, incrucisare (crossover)
si mutatie.
	Precizari: incrucisarea se face cu un singur punct de taietura; se va tine
cont de selectia de tip elitist (individul cu fitness-ul cel mai mare va trece
automat in generatia urmatoare)

IN:
===

- dimensiunea populatiei (numarul de cromozomi)
- domeniul de definiție al funcției (capetele unui interval închis)
- parametrii pentru funcția de maximizat (coeficienții polinomului de grad 2)
- precizia cu care se lucrează (cu care se discretizează intervalul)
- probabilitatea de recombinare (crossover, încrucișare)
- probabilitatea de mutație
- numărul de etape al algoritmului

OUT:
====

- exemplu: Evolutie.txt
- prezentare detaliata a operatiilor efectuate in fiecare etapa
- apoi un rezumat al evolutiei populatiei pentur celelalte etape

*/

#include <iostream>
#include <vector>
#include <random>
#include <algorithm>
#include <iomanip>
#include <ostream>
using namespace std;

#pragma region codificare si decodificare

string Codificare(const double a, const double b, const double p, const double x) {
	/*
		codificam un numar double in binar

		capetele intervalului [a, b]
		precizia -> p

		avem nevoie de l = log2((b - a)10^p) biti ca sa codificam numerele reale din intervalul dat
		discretizarea d = (b - a)/2^l
	*/

	// calculam discretizarea
	const int l = ceil(log2((b - a) * pow(10, p))); // numarul de biti pentru codificare
	const double d = (b - a) / pow(2, l); // pasul de discretizare

	int i = floor((x - a) / d); // x = a + i * d, rezulta ca i = (x - a) / d
	if(i < 0) i = 0;

	string rezultat;
	for(int ind = l - 1; ind >= 0; --ind) {
		if(i & (1 << ind))
			rezultat += '1';
		else
			rezultat += '0';
	}
	return rezultat;
}

int Decodificare(const double a, const double b, const int p, const string& codificat) {
	/*
		decodificam un numar double din binar

		capetele intervalului [a, b]
		precizia -> p
	*/

	// calculam discretizarea
	const int l = ceil(log2((b - a) * pow(10, p))); // numarul de biti pentru codificare
	double d = (b - a) / pow(2, l); // pasul de discretizare

	int x = 0;
	for(unsigned int ind = 0; ind < codificat.length(); ind++) {
		if(codificat[ind] == '1')
			x += pow(2, codificat.length() - ind - 1);
	}
	return x;
}

#pragma endregion

int selectie(const double u, const int dimPop, const vector<double> &intervaleProbabilitateSelectie) {
	int left = 1, right = dimPop;
	while (left < right) {
		int mid = left + (right - left) / 2;
		if (u < intervaleProbabilitateSelectie[mid]) {
			right = mid;
		} else {
			left = mid + 1;
		}
	}
	return left;
}

pair<string, string> incrucisare(const string &a, const string &b, const int punctIncrucisare) {
	const int l = a.length();
	string c = a.substr(0, punctIncrucisare) + b.substr(punctIncrucisare, l - punctIncrucisare);
	string d = b.substr(0, punctIncrucisare) + a.substr(punctIncrucisare, l - punctIncrucisare);
	return {c, d};
}

bool mutatie(string &cromozom, const double probMutatie) {
	bool mutatie = false;
	random_device rd;
	mt19937 gen(rd());
	uniform_real_distribution<> dis(0, 1);
	for (unsigned int i = 0; i < cromozom.length(); ++i) {
		if (const double u = dis(gen); u < probMutatie) {
			cromozom[i] ^= 1; // inversare bit
			mutatie = true;
		}
	}
	return mutatie;
}

struct Cromozom {
    string codificat;
    double valoare;
    double fitness;

    friend std::ostream& operator<<(std::ostream& os, const Cromozom& obj)
    {
	    return os
		    << "codificat: " << obj.codificat
		    << " valoare: " << obj.valoare
		    << " fitness: " << obj.fitness;
    }
};

int main() {

#pragma region input

	double domDefStart, domDefEnd, coefA, coefB, coefC, precizie, probRecombinare, probMutatie;
	int dimPop, nrEtape;
	// cin >> dimPop >> domDefStart >> domDefEnd >> coefA >> coefB >> coefC >> precizie >>
	// 	probRecombinare >> probMutatie >> nrEtape;
	dimPop = 20;
	domDefStart = -1;
	domDefEnd = 2;
	coefA = -1;
	coefB = 1;
	coefC = 2;
	precizie = 6;
	probRecombinare = 0.25;
	probMutatie = 0.01;
	nrEtape = 50;

#pragma endregion

#pragma region generare populatie (cromozomi, valori, fitness, probabilitate selectie, intervale probabilitate selectie)

	random_device rd;
	int seed = rd();
	// seed = 1234; // set seed = 24
	mt19937 gen(seed); // set random seed
	cout << "\nSeed = " << seed << "\n\n";

	uniform_real_distribution<> dis01(0, 1);
	uniform_real_distribution<> disDomDef(domDefStart, domDefEnd);

	vector<Cromozom> populatie;

	// generare populatie (cromozomi si valori)
	for (int i = 0; i < dimPop; i++) {
		double x = disDomDef(gen);
		string cromozom = Codificare(domDefStart, domDefEnd, precizie, x);
		double fitness = coefA * x * x + coefB * x + coefC;
		populatie.push_back({cromozom, x, fitness});
	}

	// Afisare populatie initiala
	int cont = 0;
	cout << "Populatia initiala\n";
	for (const auto& [codificat, valoare, fitness] : populatie) {
		cout << setw(3) << cont + 1 << ": " << codificat
			 << "; x =" << setw(10) << fixed << setprecision(6) << valoare
			 << "; f =" << setw(9) << fixed << setprecision(12) << fitness << '\n';
		cont++;
	}

#pragma endregion

#pragma region selectie cu afisare detaliata

	vector<double> probabilitateSelectie;
	vector<double> intervaleProbabilitateSelectie;

	// calculare probabilitate de selectie (fitness[i] / sumaFitness)
	double sumaFitness = 0;
	for (const auto& cromozom : populatie)
		sumaFitness += cromozom.fitness;
	for (const auto& cromozom : populatie)
		probabilitateSelectie.push_back(cromozom.fitness / sumaFitness);

	cout << "\nProbabilitati selectie \n";
	cont = 1;
	for (auto prob : probabilitateSelectie) {
		cout << "cromozom" << setw(4) << cont++
			 << " probabilitate " << fixed << setprecision(12) << prob << '\n';
	}

	// calculare intervale probabilitate selectie
	intervaleProbabilitateSelectie.push_back(0);
	for (double i1 : probabilitateSelectie) {
		intervaleProbabilitateSelectie.push_back(intervaleProbabilitateSelectie.back() + i1);
	}
	cout << "\nIntervale probabilitati selectie \n";
	for (double i1 : intervaleProbabilitateSelectie) {
		cout << i1 << '\n';
	}
	cout << '\n';

	// selectie
	int nrCromozomSelectat = 0;
	vector<Cromozom> populatieSelectata;
	for (int i = 0; i < dimPop; i++) {
        double u = dis01(gen);
		nrCromozomSelectat = selectie(u, dimPop, intervaleProbabilitateSelectie);
		populatieSelectata.push_back(populatie[nrCromozomSelectat - 1]);
		cout << fixed << setprecision(17);
		cout << "u = " << u << " => selectam cromozomul " << nrCromozomSelectat << '\n';
	}
	populatie = populatieSelectata;

	cout << "\nDupa selectie:\n";
	cont = 1;
	for (const auto& [codificat, valoare, fitness] : populatie) {
		cout << setw(3) << cont << ": " << codificat
			 << "; x =" << setw(10) << fixed << setprecision(6) << valoare
			 << "; f = " << setw(9) << fixed << setprecision(12) << fitness << '\n';
		++cont;
	}

	cout << "\nProbabilitate de incrusisare " << setprecision(2) << probRecombinare << '\n';
	vector<int> indiciCromozomiSelectatiIncrucisare;
	for (int i = 0; i < dimPop; i++) {
        double u = dis01(gen);
		cout << fixed << setprecision(17);
		cout << setw(3) << i + 1 << ": " << populatie[i].codificat << " u = " << u;
		if (u < probRecombinare) {
			cout << " < " << setprecision(2) << probRecombinare << " => participa";
			indiciCromozomiSelectatiIncrucisare.push_back(i);
		}
		cout << '\n';
	}

	// incrucisare
	if (indiciCromozomiSelectatiIncrucisare.size() % 2 != 0) { // daca numarul de cromozomi selectati pentru incrucisare este impar, eliminam ultimul cromozom
		indiciCromozomiSelectatiIncrucisare.pop_back();
	}
	for (unsigned int i = 0; i < indiciCromozomiSelectatiIncrucisare.size(); i += 2) {
		int index1 = indiciCromozomiSelectatiIncrucisare[i];
		int index2 = indiciCromozomiSelectatiIncrucisare[i + 1];
		string cromozom1 = populatie[index1].codificat;
		string cromozom2 = populatie[index2].codificat;
		int punct = rand() % cromozom1.length();
		pair<string, string> rezultat = incrucisare(cromozom1, cromozom2, punct);
		cout << "\nRecombinare dintre cromozomul " << index1 + 1 << " cu cromozomul " << index2 + 1 << ":\n";
		cout << cromozom1 << " " << cromozom2 << " punct " << punct << '\n';
		cout << "Rezultat " << rezultat.first << " " << rezultat.second << '\n';

		populatie[index1].codificat = rezultat.first;
		populatie[index2].codificat = rezultat.second;
	}

	cout << "\nDupa recombinare:\n";
	cont = 1;
	for (const auto& cromozom : populatie) {
		cout << setw(3) << cont++ << ": " << cromozom.codificat
			 << "; x =" << setw(10) << fixed << setprecision(6) << cromozom.valoare
			 << "; f = " << setw(9) << fixed << setprecision(12) << cromozom.fitness << '\n';
	}

	cout << "\nProbabilitate de mutatie pentru fiecare gena " << setprecision(2) << probMutatie << '\n';
	cout << "Au fost modificati cromozomii:\n";
	int indexCromozomMutat = 0;
	for (Cromozom &c : populatie) {
		++indexCromozomMutat;
		if (mutatie(c.codificat, probMutatie)) {
			cout << indexCromozomMutat << '\n';
		}
	}

	cout << "\nDupa mutatie:\n";
	cont = 1;
	for (const auto& cromozom : populatie) {
		cout << setw(3) << cont++ << ": " << cromozom.codificat
			 << "; x =" << setw(10) << fixed << setprecision(6) << cromozom.valoare
			 << "; f = " << setw(9) << fixed << setprecision(12) << cromozom.fitness << '\n';
	}

#pragma endregion

#pragma region afisare evolutia maximului

	cout << "\nEvolutia maximului:\n";
	for (int etapa = 1; etapa < nrEtape; ++etapa) {

		// recalculare valoare si fitness
		for (auto& [codificat, valoare, fitness] : populatie) {
			int x = Decodificare(domDefStart, domDefEnd, precizie, codificat); // decodificam binarul pentru a obtine valoarea
			const int l = ceil(log2((domDefEnd - domDefStart) * pow(10, precizie))); // numarul de biti pentru codificare
			double d = (domDefEnd - domDefStart) / pow(2, l); // pasul de discretizare
			valoare = domDefStart + x * d;
			fitness = coefA * valoare * valoare + coefB * valoare + coefC;
		}

		// recalculare probabilitate de selectie
		probabilitateSelectie.clear();
		intervaleProbabilitateSelectie.clear();

		sumaFitness = 0;
		for (const auto& cromozom : populatie)
			sumaFitness += cromozom.fitness;

		for (const auto& cromozom : populatie)
			probabilitateSelectie.push_back(cromozom.fitness / sumaFitness);

		intervaleProbabilitateSelectie.push_back(0);
		for (unsigned int i1 = 0; i1 < probabilitateSelectie.size(); ++i1) {
			intervaleProbabilitateSelectie.push_back(intervaleProbabilitateSelectie.back() + probabilitateSelectie[i1]);
		}

		// selectie
		nrCromozomSelectat = 0;
		populatieSelectata.clear();
		for (int i = 0; i < dimPop; i++) {
			double u = dis01(gen);
			nrCromozomSelectat = selectie(u, dimPop, intervaleProbabilitateSelectie);
			populatieSelectata.push_back(populatie[nrCromozomSelectat - 1]);
		}
		populatie = populatieSelectata;

		// incrucisare
		indiciCromozomiSelectatiIncrucisare.clear();
		for (int i = 0; i < dimPop; i++) {
			double u = dis01(gen);
			if (u < probRecombinare)
				indiciCromozomiSelectatiIncrucisare.push_back(i);
		}
		if (indiciCromozomiSelectatiIncrucisare.size() % 2 != 0) {
			indiciCromozomiSelectatiIncrucisare.pop_back();
		}
		for (unsigned int i = 0; i < indiciCromozomiSelectatiIncrucisare.size(); i += 2) {
			int index1 = indiciCromozomiSelectatiIncrucisare[i];
			int index2 = indiciCromozomiSelectatiIncrucisare[i + 1];
			string cromozom1 = populatie[index1].codificat;
			string cromozom2 = populatie[index2].codificat;
			int punct = rand() % cromozom1.length();
			auto rezultat = incrucisare(cromozom1, cromozom2, punct);
			// reintegrare in populatie
			populatie[index1].codificat = rezultat.first;
			populatie[index2].codificat = rezultat.second;
		}

		// mutatie
		for (Cromozom &c : populatie) mutatie(c.codificat, probMutatie);

		// calculare fitness maxim
		double maxFitness = 0;
		int indexMaxFitness = 0;
		for (int j = 0; j < populatie.size(); ++j) {
			if (populatie[j].fitness > maxFitness) {
				maxFitness = populatie[j].fitness;
				indexMaxFitness = j;
			}
		}
		cout << "Etapa " << setw(4) << etapa + 1 << ": " << setw(9) << fixed << setprecision(12) << populatie[indexMaxFitness].fitness << '\n';
	}


#pragma endregion

	return 0;
}

