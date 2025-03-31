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
		if (double u = dis(gen); u < probMutatie) {
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

	vector<double> xsDinExemplu = {
		-0.914592, -0.516787, -0.246207, 1.480791, 0.835307, 
		1.229633, 0.133068, -0.897179, 0.100578, -0.311975, 
		1.411980, 0.404924, 1.954865, 0.359503, 1.255452, 
		1.124764, 1.527482, 1.573845, -0.562311, 1.191435
	};

	vector<double> usDinExempluSelectie = {
		0.6034720442729782, 0.17892824175281696, 0.6867737986711382, 0.7176059630936646, 
		0.5619562065293205, 0.24081572433510423, 0.5408716518401836, 0.43771824679891214, 
		0.7390763060836184, 0.8447467542582436, 0.7683657918169965, 0.9907124915454842, 
		0.8395083889834671, 0.8113925195824372, 0.8789773676106979, 0.9658384924654928, 
		0.0756221139277069, 0.03335884865931882, 0.26608038821171887, 0.5492264660581757
	};

	vector<double> usDinExempluIncrucisare = {
		0.8672982503681332, 0.17618744553586774, 0.5623919628827635, 0.12595818897032773, 
		0.5494832939809089, 0.9988878068067887, 0.044918841352894145, 0.15024385267360985, 
		0.5809198972137714, 0.30819031632516913, 0.9073062085201059, 0.6421334753559018, 
		0.46721859789040554, 0.6320007810666798, 0.20308557877487043, 0.6311055118179946, 
		0.11241241610234687, 0.8000743582190735, 0.529921293680138, 0.3600402029299934
	};
	

#pragma endregion

#pragma region generare populatie (cromozomi, valori, fitness, probabilitate selectie, intervale probabilitate selectie)

	random_device rd;
	mt19937 gen(rd());
	// mt19937 gen(24); // set seed = 24
	uniform_real_distribution<> dis01(0, 1);
	uniform_real_distribution<> disDomDef(domDefStart, domDefEnd);

	vector<Cromozom> populatie;

	// generare populatie (cromozomi si valori)
	for (int i = 0; i < dimPop; i++) {
		double x = xsDinExemplu[i]; // generare din exemplu
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
	for (unsigned int i1 = 0; i1 < probabilitateSelectie.size(); ++i1) {
		intervaleProbabilitateSelectie.push_back(intervaleProbabilitateSelectie.back() + probabilitateSelectie[i1]);
	}
	cout << "\nIntervale probabilitati selectie \n";
	for (unsigned int i1 = 0; i1 < intervaleProbabilitateSelectie.size(); ++i1) {
		cout << intervaleProbabilitateSelectie[i1] << '\n';
	}
	cout << '\n';

	// selectie
	int nrCromozomSelectat = 0;
	vector<Cromozom> populatieSelectata;
	for (double u : usDinExempluSelectie) {
		nrCromozomSelectat = selectie(u, dimPop, intervaleProbabilitateSelectie);
		populatieSelectata.push_back(populatie[nrCromozomSelectat - 1]);
		cout << fixed << setprecision(17);
		cout << "u=" << u << " selectam cromozomul " << nrCromozomSelectat << '\n';
	}
	populatie = populatieSelectata;

	cout << "\nDupa selectie:\n";
	cont = 1;
	for (const auto& [codificat, valoare, fitness] : populatie) {
		cout << setw(3) << cont << ": " << codificat
			 << "; x =" << setw(10) << fixed << setprecision(6) << valoare
			 << "; f = " << setw(9) << fixed << setprecision(12) << fitness << '\n';
	}

	cout << "\nProbabilitate de incrusisare " << setprecision(2) << probRecombinare << '\n';
	vector<int> indiciCromozomiSelectatiIncrucisare;
	for (int i = 0; i < dimPop; i++) {
		cout << fixed << setprecision(17);
		cout << setw(3) << i + 1 << ": " << populatie[i].codificat << " u = " << usDinExempluIncrucisare[i];
		if (usDinExempluIncrucisare[i] < probRecombinare) {
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

/*

Evolutie.txt

Populatia initiala
   1: 0000011101001001110001 x= -0,914592 f=0.24892945287918744
   2: 0010100100111011111100 x= -0,516787 f=1.2161433551687346
   3: 0100000001010010110111 x= -0,246207 f=1.69317538311855
   4: 1101001110110001101101 x=  1,480791 f=1.288048141479274
   5: 1001110010011100111001 x=  0,835307 f=2.1375690008662946
   6: 1011111001000011000100 x=  1,229633 f=1.7176358177971365
   7: 0110000010110000001111 x=  0,133068 f=2.115360642895274
   8: 0000100011000110001010 x= -0,897179 f=0.29789055630549277
   9: 0101110111101010011111 x=  0,100578 f=2.0904619502816644
  10: 0011101010110110001001 x= -0,311975 f=1.590697249227337
  11: 1100110111010010011111 x=  1,411980 f=1.4182933275624994
  12: 0111011111100011000001 x=  0,404924 f=2.240960465910953
  13: 1111110000100110000000 x=  1,954865 f=0.13336723106734194
  14: 0111010000000010110010 x=  0,359503 f=2.230260491735224
  15: 1100000001110111000101 x=  1,255452 f=1.6792930285557333
  16: 1011010101010000001011 x=  1,124764 f=1.8596696522000606
  17: 1101011110101101101011 x=  1,527482 f=1.1942809038290045
  18: 1101101110100010011111 x=  1,573845 f=1.0968573281925882
  19: 0010010101011001011110 x= -0,562311 f=1.1214962076226662
  20: 1011101100000000100111 x=  1,191435 f=1.771918100644858

Probabilitati selectie 
cromozom    1 probabilitate 0.0085418577836996
cromozom    2 probabilitate 0.041731195181167476
cromozom    3 probabilitate 0.058100249521212656
cromozom    4 probabilitate 0.044198562748676756
cromozom    5 probabilitate 0.07334933732050686
cromozom    6 probabilitate 0.05893959396975151
cromozom    7 probabilitate 0.07258727146930355
cromozom    8 probabilitate 0.010221927287582215
cromozom    9 probabilitate 0.07173288847506332
cromozom   10 probabilitate 0.05458377673941411
cromozom   11 probabilitate 0.048667844481579396
cromozom   12 probabilitate 0.07689715048702854
cromozom   13 probabilitate 0.004576412745083748
cromozom   14 probabilitate 0.07652998759552974
cromozom   15 probabilitate 0.05762388524608598
cromozom   16 probabilitate 0.06381339576343534
cromozom   17 probabilitate 0.0409809988986984
cromozom   18 probabilitate 0.037637970107847966
cromozom   19 probabilitate 0.03848343777592496
cromozom   20 probabilitate 0.06080225640240799
Intervale probabilitati selectie 
0 
0.0085418577836996 
0.050273052964867074 
0.10837330248607974 
0.1525718652347565 
0.22592120255526335 
0.28486079652501484 
0.3574480679943184 
0.3676699952819006 
0.4394028837569639 
0.493986660496378 
0.5426545049779574 
0.6195516554649859 
0.6241280682100697 
0.7006580558055995 
0.7582819410516854 
0.8220953368151208 
0.8630763357138193 
0.9007143058216672 
0.9391977435975922 
1.0

u=0.6034720442729782  selectam cromozomul 12 
u=0.17892824175281696  selectam cromozomul 5 
u=0.6867737986711382  selectam cromozomul 14 
u=0.7176059630936646  selectam cromozomul 15 
u=0.5619562065293205  selectam cromozomul 12 
u=0.24081572433510423  selectam cromozomul 6 
u=0.5408716518401836  selectam cromozomul 11 
u=0.43771824679891214  selectam cromozomul 9 
u=0.7390763060836184  selectam cromozomul 15 
u=0.8447467542582436  selectam cromozomul 17 
u=0.7683657918169965  selectam cromozomul 16 
u=0.9907124915454842  selectam cromozomul 20 
u=0.8395083889834671  selectam cromozomul 17 
u=0.8113925195824372  selectam cromozomul 16 
u=0.8789773676106979  selectam cromozomul 18 
u=0.9658384924654928  selectam cromozomul 20 
u=0.0756221139277069  selectam cromozomul 3 
u=0.03335884865931882  selectam cromozomul 2 
u=0.26608038821171887  selectam cromozomul 6 
u=0.5492264660581757  selectam cromozomul 12 
Dupa selectie:
   1: 0111011111100011000001 x=  0,404924 f=2.240960465910953
   2: 1001110010011100111001 x=  0,835307 f=2.1375690008662946
   3: 0111010000000010110010 x=  0,359503 f=2.230260491735224
   4: 1100000001110111000101 x=  1,255452 f=1.6792930285557333
   5: 0111011111100011000001 x=  0,404924 f=2.240960465910953
   6: 1011111001000011000100 x=  1,229633 f=1.7176358177971365
   7: 1100110111010010011111 x=  1,411980 f=1.4182933275624994
   8: 0101110111101010011111 x=  0,100578 f=2.0904619502816644
   9: 1100000001110111000101 x=  1,255452 f=1.6792930285557333
  10: 1101011110101101101011 x=  1,527482 f=1.1942809038290045
  11: 1011010101010000001011 x=  1,124764 f=1.8596696522000606
  12: 1011101100000000100111 x=  1,191435 f=1.771918100644858
  13: 1101011110101101101011 x=  1,527482 f=1.1942809038290045
  14: 1011010101010000001011 x=  1,124764 f=1.8596696522000606
  15: 1101101110100010011111 x=  1,573845 f=1.0968573281925882
  16: 1011101100000000100111 x=  1,191435 f=1.771918100644858
  17: 0100000001010010110111 x= -0,246207 f=1.69317538311855
  18: 0010100100111011111100 x= -0,516787 f=1.2161433551687346
  19: 1011111001000011000100 x=  1,229633 f=1.7176358177971365
  20: 0111011111100011000001 x=  0,404924 f=2.240960465910953

Probabilitatea de incrucisare 0.25
1: 0111011111100011000001 u=0.8672982503681332
2: 1001110010011100111001 u=0.17618744553586774<0.25 participa 
3: 0111010000000010110010 u=0.5623919628827635
4: 1100000001110111000101 u=0.12595818897032773<0.25 participa 
5: 0111011111100011000001 u=0.5494832939809089
6: 1011111001000011000100 u=0.9988878068067887
7: 1100110111010010011111 u=0.044918841352894145<0.25 participa 
8: 0101110111101010011111 u=0.15024385267360985<0.25 participa 
9: 1100000001110111000101 u=0.5809198972137714
10: 1101011110101101101011 u=0.30819031632516913
11: 1011010101010000001011 u=0.9073062085201059
12: 1011101100000000100111 u=0.6421334753559018
13: 1101011110101101101011 u=0.46721859789040554
14: 1011010101010000001011 u=0.6320007810666798
15: 1101101110100010011111 u=0.20308557877487043<0.25 participa 
16: 1011101100000000100111 u=0.6311055118179946
17: 0100000001010010110111 u=0.11241241610234687<0.25 participa 
18: 0010100100111011111100 u=0.8000743582190735
19: 1011111001000011000100 u=0.529921293680138
20: 0111011111100011000001 u=0.3600402029299934

Recombinare dintre cromozomul 2 cu cromozomul 8:
1001110010011100111001 0101110111101010011111 punct  0
Rezultat    1001110010011100111001 0101110111101010011111
Recombinare dintre cromozomul 17 cu cromozomul 4:
0100000001010010110111 1100000001110111000101 punct  17
Rezultat    1100000001110111010111 0100000001010010100101
Recombinare dintre cromozomul 7 cu cromozomul 15:
1100110111010010011111 1101101110100010011111 punct  0
Rezultat    1100110111010010011111 1101101110100010011111
Dupa recombinare:
   1: 0111011111100011000001 x=  0,404924 f=2.240960465910953
   2: 1001110010011100111001 x=  0,835307 f=2.1375690008662946
   3: 0111010000000010110010 x=  0,359503 f=2.230260491735224
   4: 0100000001010010100101 x= -0,246220 f=1.6931561687147045
   5: 0111011111100011000001 x=  0,404924 f=2.240960465910953
   6: 1011111001000011000100 x=  1,229633 f=1.7176358177971365
   7: 1100110111010010011111 x=  1,411980 f=1.4182933275624994
   8: 0101110111101010011111 x=  0,100578 f=2.0904619502816644
   9: 1100000001110111000101 x=  1,255452 f=1.6792930285557333
  10: 1101011110101101101011 x=  1,527482 f=1.1942809038290045
  11: 1011010101010000001011 x=  1,124764 f=1.8596696522000606
  12: 1011101100000000100111 x=  1,191435 f=1.771918100644858
  13: 1101011110101101101011 x=  1,527482 f=1.1942809038290045
  14: 1011010101010000001011 x=  1,124764 f=1.8596696522000606
  15: 1101101110100010011111 x=  1,573845 f=1.0968573281925882
  16: 1011101100000000100111 x=  1,191435 f=1.771918100644858
  17: 1100000001110111010111 x=  1,255464 f=1.679273576108589
  18: 0010100100111011111100 x= -0,516787 f=1.2161433551687346
  19: 1011111001000011000100 x=  1,229633 f=1.7176358177971365
  20: 0111011111100011000001 x=  0,404924 f=2.240960465910953

Probabilitate de mutatie pentru fiecare gena 0.01
Au fost modificati cromozomii:
3
13
14
16
Dupa mutatie:
   1: 0111011111100011000001 x=  0,404924 f=2.240960465910953
   2: 1001110010011100111001 x=  0,835307 f=2.1375690008662946
   3: 0111000000000010110010 x=  0,312628 f=2.2148915943894925
   4: 0100000001010010100101 x= -0,246220 f=1.6931561687147045
   5: 0111011111100011000001 x=  0,404924 f=2.240960465910953
   6: 1011111001000011000100 x=  1,229633 f=1.7176358177971365
   7: 1100110111010010011111 x=  1,411980 f=1.4182933275624994
   8: 0101110111101010011111 x=  0,100578 f=2.0904619502816644
   9: 1100000001110111000101 x=  1,255452 f=1.6792930285557333
  10: 1101011110101101101011 x=  1,527482 f=1.1942809038290045
  11: 1011010101010000001011 x=  1,124764 f=1.8596696522000606
  12: 1011101100000000100111 x=  1,191435 f=1.771918100644858
  13: 1101011110001101101011 x=  1,526017 f=1.1972889597163063
  14: 1011010101010100001011 x=  1,124947 f=1.859440823122117
  15: 1101101110100010011111 x=  1,573845 f=1.0968573281925882
  16: 1001101100000000100111 x=  0,816435 f=2.1498691578171627
  17: 1100000001110111010111 x=  1,255464 f=1.679273576108589
  18: 0010100100111011111100 x= -0,516787 f=1.2161433551687346
  19: 1011111001000011000100 x=  1,229633 f=1.7176358177971365
  20: 0111011111100011000001 x=  0,404924 f=2.240960465910953

Evolutia maximului 
2.240960465910953
2.240960465910953
2.240961009934791
2.240961009934791
2.2410299678993897
2.2410299678993897
2.2410299678993897
2.2410299678993897
2.2410299678993897
2.2410299678993897
2.2470135119363746
2.2470135119363746
2.2470135119363746
2.2470135119363746
2.2470135119363746
2.2470135119363746
2.2470135119363746
2.249998987949042
2.2470135119363746
2.247013824631034
2.247013824631034
2.247013824631034
2.247013824631034
2.247013824631034
2.247013824631034
2.247170709171197
2.2471717743374526
2.2490254104411807
2.249025678372649
2.249025678372649
2.2471755768655597
2.2471717743374526
2.249994372922319
2.2471717743374526
2.2471717743374526
2.2498015271856295
2.2471717743374526
2.249338579381251
2.249338579381251
2.2493387265332436
2.249338579381251
2.249338579381251
2.249338579381251
2.249338579381251
2.249338579381251
2.2494117796242903
2.2494117796242903
2.249338579381251
2.249921331421878
2.249921331421878

*/