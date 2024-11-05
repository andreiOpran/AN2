#include <iostream>
#include <fstream>
#include <vector>
#include <queue>
#include <stack>
using namespace std;

static void MatriceAdiacenta(vector<vector<int>>& ma, const string& numeFisier, bool orientat)
{
	ifstream fin(numeFisier);
	int nrNoduri, nrMuchii, x, y;
	fin >> nrNoduri >> nrMuchii;
	ma.resize(nrNoduri + 1, vector<int>(nrNoduri + 1, 0));
	while (fin >> x >> y)
	{
		if (x != y)
		{
			ma[x][y] = 1;
			if (!orientat)
				ma[y][x] = 1;
		}
	}
}
static void AfisareMatriceAdiacenta(vector<vector<int>> ma)
{
	for (int i = 1; i < ma.size(); i++)
	{
		for (int j = 1; j < ma[i].size(); j++)
			cout << ma[i][j] << ' ';
		cout << endl;
	}
}

static void ListaAdiacenta(vector<vector<int>>& la, const string& numeFisier, bool orientat)
{
	ifstream fin(numeFisier);
	int nrNoduri, nrMuchii, x, y;
	fin >> nrNoduri >> nrMuchii;
	la.resize(nrNoduri + 1);
	while (fin >> x >> y)
	{
		if (x != y)
		{
			la[x].push_back(y);
			if (!orientat)
				la[y].push_back(x);
		}
	}
}
static void AfisareListaAdiacenta(vector<vector<int>> la)
{
	for (int i = 1; i < la.size(); i++)
	{
		cout << i << ": ";
		for (int j = 0; j < la[i].size(); j++)
			cout << la[i][j] << ' ';
		cout << endl;
	}
}

static void TransformareMatriceAdiacentaInListaAdiacenta(const vector<vector<int>>& ma, vector<vector<int>>& la)
{
	la.resize(ma.size());
	for (int i = 1; i < ma.size(); i++)
	{
		for (int j = 1; j < ma[i].size(); j++)
			if (ma[i][j] == 1)
				la[i].push_back(j);
	}
}
static void TransformareListaAdiacentaInMatriceAdiacenta(const vector<vector<int>>& la, vector<vector<int>>& ma)
{
	ma.resize(la.size(), vector<int>(la.size(), 0));
	for (int i = 1; i < la.size(); i++)
		for (int j = 0; j < la[i].size(); j++)
			ma[i][la[i][j]] = 1;
}

/* A. MEMORAREA UNUI GRAF (1, 2, 3, 4)

int main()
{
	string numeFisier = "graf.in";
	bool orientat = false;

	vector<vector<int>> ma;
	MatriceAdiacenta(ma, numeFisier, orientat);
	AfisareMatriceAdiacenta(ma);

	cout << '\n';

	vector<vector<int>> la;
	ListaAdiacenta(la, numeFisier, orientat);
	AfisareListaAdiacenta(la);

	cout << '\n';

	la.clear();
	TransformareMatriceAdiacentaInListaAdiacenta(ma, la);
	AfisareListaAdiacenta(la);

	cout << '\n';

	ma.clear();
	TransformareListaAdiacentaInMatriceAdiacenta(la, ma);
	AfisareMatriceAdiacenta(ma);

	return 0;
}

*/




// BFS
vector<int> BFS(string numeFisier, bool orientat) // va afisa pentru fiecare nod, numarul minim de arce necesare pentru a ajunge la acesta din nodul de start
{
	vector<vector<int>> la;
	int nrNoduri, nrMuchii, nodStart, x, y;
	ifstream fin(numeFisier);
	fin >> nrNoduri >> nrMuchii >> nodStart;

	// creeare lista adiacenta
	la.resize(nrNoduri + 1);
	while (fin >> x >> y)
	{
		if (x != y)
		{
			la[x].push_back(y);
			if (!orientat)
				la[y].push_back(x);
		}
	}

	// initalizare coada si vector de distante
	queue<int> q;
	vector<int> dist(nrNoduri + 1, -1);
	dist[nodStart] = 0;
	q.push(nodStart);

	// parcurgere BFS
	while (!q.empty())
	{
		int nodCurent = q.front();
		q.pop();
		for (int i = 0; i < la[nodCurent].size(); i++)
		{
			int vecin = la[nodCurent][i];
			if (dist[vecin] == -1)
			{
				dist[vecin] = dist[nodCurent] + 1;
				q.push(vecin);
			}
		}
	}

	return dist;

	/*

	bfs.in
	5 7 2
	1 2
	2 1
	2 2
	3 2
	2 5
	5 3
	4 5

	bfs.out
	-1 0 1 2 1

	*/
}

int BFS2(string numeFisier, bool orientat, int X) // in plus fata de BFS(), avem nodul X -> vom afisa numarul minim de arce de la nodul de start la nodul x
{
	vector<vector<int>> la;
	int nrNoduri, nrMuchii, nodStart, x, y;
	ifstream fin(numeFisier);
	fin >> nrNoduri >> nrMuchii >> nodStart;

	// creeare lista adiacenta
	la.resize(nrNoduri + 1);
	while (fin >> x >> y)
	{
		if (x != y)
		{
			la[x].push_back(y);
			if (!orientat)
				la[y].push_back(x);
		}
	}

	// initalizare coada si vector de distante
	queue<int> q;
	vector<int> dist(nrNoduri + 1, -1);
	dist[nodStart] = 0;
	q.push(nodStart);

	// parcurgere BFS
	while (!q.empty())
	{
		int nodCurent = q.front();
		q.pop();
		for (int i = 0; i < la[nodCurent].size(); i++)
		{
			int vecin = la[nodCurent][i];
			if (dist[vecin] == -1)
			{
				dist[vecin] = dist[nodCurent] + 1;
				q.push(vecin);
			}
		}
	}

	return dist[X];
}




/* KOSARAJU

void DFS1(int v, const vector<vector<int>>& G, vector<bool>& viz, stack<int>& S) {
	viz[v] = true; // Marcam nodul curent ca vizitat
	for (int i : G[v]) {
		if (!viz[i]) {
			DFS1(i, G, viz, S); // Continuam DFS pentru nodurile adiacente nevizitate
		}
	}
	S.push(v); // Adaugam nodul curent in stiva dupa ce toate nodurile adiacente au fost vizitate
}

void DFS2(int v, const vector<vector<int>>& GT, vector<bool>& viz) {
	cout << v << " "; // Afisam nodul curent
	viz[v] = true; // Marcam nodul curent ca vizitat
	for (int i : GT[v]) {
		if (!viz[i]) {
			DFS2(i, GT, viz); // Continuam DFS pentru nodurile adiacente nevizitate
		}
	}
}

void Kosaraju(const string& numeFisier) {
	ifstream fin(numeFisier);
	int nrNoduri, nrMuchii, x, y;
	fin >> nrNoduri >> nrMuchii;

	// Initializam graful original si graful transpus
	vector<vector<int>> G(nrNoduri + 1);
	vector<vector<int>> GT(nrNoduri + 1);

	// Citim muchiile din fisier si construim graful original si graful transpus
	while (fin >> x >> y) {
		G[x].push_back(y);
		GT[y].push_back(x); // graful transpus
	}

	stack<int> S;
	vector<bool> viz(nrNoduri + 1, false);

	// Pasul 1: Parcurgem DFS pentru a stoca ordinea de finalizare a nodurilor
	for (int i = 1; i <= nrNoduri; ++i) {
		if (!viz[i]) {
			DFS1(i, G, viz, S);
		}
	}

	// Resetam vectorul de vizitare pentru a-l folosi in pasul 2
	fill(viz.begin(), viz.end(), false); // Marcam toate varfurile ca fiind nevizitate

	// Pasul 2: Parcurgem DFS pe graful transpus in ordinea stocata in stiva
	while (!S.empty()) {
		int v = S.top();
		S.pop();
		if (!viz[v]) {
			cout << "Componenta tare conexa: ";
			DFS2(v, GT, viz);
			cout << endl;
		}
	}
}

*/




// DFS CARE RETURNEAZA NUMARUL DE COMPONENTE CONEXE
void DFSNumarComponenteAux(int vf, const vector<vector<int>>& la, vector<bool>& vizitat)
{
	vizitat[vf] = true;
	for (int i : la[vf])
		if (!vizitat[i])
			DFSNumarComponenteAux(i, la, vizitat);
}
int DFSNumarComponenteConexe(string numeFisier, bool orientat = false)
{
	vector<vector<int>> la;
	int nrNoduri = 0;
	ifstream fin(numeFisier);
	ListaAdiacenta(la, numeFisier, orientat);

	// atentie la nrNoduri/nrMuchii atunci cand citim cu ListaAdiacenta()/MatriceAdiacenta(), pentru ca vor fi NEINITIALIZATE
	nrNoduri = la.size() - 1;
	vector<bool> vizitat(nrNoduri + 1, false);
	int nrComponenteConexe = 0;

	for (int i = 1; i <= nrNoduri; i++) // parcurgem toate nodurile
	{
		if (!vizitat[i])
		{
			DFSNumarComponenteAux(i, la, vizitat);
			nrComponenteConexe++;
		}
	}
	return nrComponenteConexe;
}


// INCORECT
// DFS CARE AFISEAZA ARCELE DE INTOARCERE, DE TRAVERSARE, DE AVANSARE SI DE AVANSARE DIRECTA(DE ARBORE DF)
void DFSArceAux(int vf, const vector<vector<int>>& la, vector<bool>& vizitat, vector<int>& tata, vector<int>& timpInitial, vector<int>& timpFinal, int& timp)
{
	vizitat[vf] = true;
	timpInitial[vf] = ++timp;
	for (int vecin : la[vf])
	{
		if (!vizitat[vecin])
		{
			tata[vecin] = vf;
			cout << "                                                                           Arc de avansare directa: " << vf << " -> " << vecin << '\n';
			DFSArceAux(vecin, la, vizitat, tata, timpInitial, timpFinal, timp);
		}
		else if (timpInitial[vecin] < timpInitial[vf] && tata[vf] != vecin)
			cout << "Arc de intoarcere: " << vf << " -> " << vecin << '\n';
		else if (timpInitial[vecin] > timpInitial[vf])
			cout << "Arc de traversare: " << vf << " -> " << vecin << '\n';
		else if (timpInitial[vecin] < timpInitial[vf] && tata[vf] == vecin)
			cout << "Arc de avansare: " << vf << " -> " << vecin << '\n';
	}
	timpFinal[vf] = ++timp;
}
void DFSArce(string numeFisier, bool orientat = false, int nodStart = 1)
{
	vector<vector<int>> la;
	int nrNoduri = 0;
	ifstream fin(numeFisier);
	ListaAdiacenta(la, numeFisier, orientat);
	nrNoduri = la.size() - 1;

	AfisareListaAdiacenta(la);

	vector<bool> vizitat(nrNoduri + 1, false);
	vector<int> tata(nrNoduri + 1, 0);
	vector<int> timpInitial(nrNoduri + 1, 0);
	vector<int> timpFinal(nrNoduri + 1, 0);
	int timp = 0;

	DFSArceAux(nodStart, la, vizitat, tata, timpInitial, timpFinal, timp);

	/*

	graf orientat curs DF

	11 14
	1 5
	1 3
	1 9
	2 5
	3 2
	3 1
	3 6
	4 9
	4 8
	7 4
	9 7
	9 8
	10 11
	11 8

	*/
}


// INCORECT
// PENTRU UN GRAF NEORIENTAT, SE VERIFICA DACA EXISTA SI SE AFISEAZA UN CICLU ELEMENTAR 
void DFSCicluri(int x, const vector<vector<int>>& la, vector<int>& viz, vector<int>& tata, vector<int>& ciclu, bool& cicluGasit) {
	viz[x] = 1;

	// Parcurgem toti vecinii nodului curent
	for (int y : la[x]) {
		if (viz[y] == 0) {
			// Daca vecinul nu a fost vizitat, il marcam si continuam DFS
			tata[y] = x;
			DFSCicluri(y, la, viz, tata, ciclu, cicluGasit);
			if (cicluGasit) return; // Daca am gasit un ciclu, ne oprim
		}
		else if (tata[x] != y && !cicluGasit) {
			// Daca vecinul a fost vizitat si nu este parintele nodului curent, am gasit un ciclu
			cicluGasit = true;
			int v = x;
			// Reconstruim ciclul gasit
			while (v != y) {
				ciclu.push_back(v);
				v = tata[v];
			}
			ciclu.push_back(y);
			ciclu.push_back(x);
			return;
		}
	}
}
void DetectAndPrintCycle(string numeFisier) {
	vector<vector<int>> la;
	int nrNoduri, nrMuchii, x, y;
	ifstream fin(numeFisier);
	fin >> nrNoduri >> nrMuchii;

	// Creeare lista adiacenta
	la.resize(nrNoduri + 1);
	while (fin >> x >> y) {
		if (x != y) {
			la[x].push_back(y);
			la[y].push_back(x);
		}
	}

	vector<int> viz(nrNoduri + 1, 0);
	vector<int> tata(nrNoduri + 1, -1);
	vector<int> ciclu;
	bool cicluGasit = false;

	// Parcurgem toate nodurile pentru a detecta cicluri
	for (int i = 1; i <= nrNoduri; ++i) {
		if (viz[i] == 0) {
			DFSCicluri(i, la, viz, tata, ciclu, cicluGasit);
			if (cicluGasit) break;
		}
	}

	// Afisam ciclul daca a fost gasit
	if (cicluGasit) {
		cout << "Ciclu detectat: ";
		for (int nod : ciclu) {
			cout << nod << " ";
		}
		cout << endl;
	}
	else {
		cout << "Graful nu contine cicluri." << endl;
	}
}



int main()
{
	string numeFisier = "graf.in";
	bool orientat = false;

	DetectAndPrintCycle(numeFisier);

	return 0;
}


// DE CORECTAT DFSArce() si DetectAndPrintCycle()

// test