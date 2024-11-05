#include <iostream>
#include <vector>
#include <algorithm> 
using namespace std;

vector<int> tata, rang;

void MakeSet(int n)
{
	tata[n] = n;
	rang[n] = 0;
}
int Find(int n)
{
	if (n == tata[n])
		return n;
	return tata[n] = Find(tata[n]);
}
void Union(int a, int b)
{
	a = Find(a);
	b = Find(b);
	if (a != b) // aplatizare arbore
	{
		if (rang[a] < rang[b])
			swap(a, b);
		tata[b] = a;
		if (rang[a] == rang[b])
			rang[a]++;
	}
}
class Muchie
{

public:

	int u, v, c;
	bool operator <(Muchie const& obj)
	{
		return this->c < obj.c;
	}
};

int main()
{
	int n, cost = 0;
	vector<Muchie> muchii, rezultat;

	cout << "Numarul de muchii: ";
	cin >> n;
	
	for (int i = 0; i < n; i++)
	{
		Muchie m;
		cout << "Muchia " << i + 1 << ": ";
		cin >> m.u >> m.v >> m.c;
		m.u--;
		m.v--;
		muchii.push_back(m);
	}

	tata.resize(n);
	rang.resize(n);
	for (int i = 0; i < n; i++)
		MakeSet(i);

	sort(muchii.begin(), muchii.end());

	for (Muchie m : muchii)
	{
		if (Find(m.u) != Find(m.v))
		{
			cost += m.c;
			rezultat.push_back(m);
			Union(m.u, m.v);
		}
	}

	cout << "Costul minim: " << cost << endl;
	for (Muchie m : rezultat)
		cout << m.u + 1 << " " << m.v + 1 << " " << m.c << endl;


	return 0;
}
