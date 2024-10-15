#include <iostream>
#include <vector>
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
		ma[x][y] = 1;
		if (!orientat)
			ma[y][x] = 1;
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
		la[x].push_back(y);
		if (!orientat)
			la[y].push_back(x);
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