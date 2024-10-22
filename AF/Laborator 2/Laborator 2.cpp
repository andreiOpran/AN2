#include <iostream>
#include <vector>
#include <queue>
#include <fstream>
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
		for(int j = 1; j < ma[i].size(); j++)
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





// DFS
int DFS(string numeFisier, bool orientat) // va return numarul de componente conexe
{
	vector<vector<int>> la;
	int nrNoduri, nrMuchii, x, y;
	ifstream fin(numeFisier);
	ListaAdiacenta(la, numeFisier, orientat);
	
	vector<bool> vizitat(nrNoduri + 1, false);
	int nrComponenteConexe = 0;



	return 0;
}


int main()
{
	string numeFisier = "dfs.in";
	bool orientat = false;

	DFS(numeFisier, orientat);

	return 0;
}


// DE CONTINUAT DFS


