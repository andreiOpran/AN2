#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

const int INF = 1000000000; // greutate INF inseamna ca nu exista muchie

struct Muchie 
{
    int w = INF, to = -1; // w este greutatea muchiei, to este nodul destinatie
};

int n; // numarul de noduri
vector<vector<int>> adj; // matricea de adiacenta a grafului

// Algoritmul lui Prim pentru gasirea MST
void Prim() 
{
    int totalWeight = 0; // greutatea totala a MST
    vector<bool> selected(n + 1, false); // vector pentru a marca nodurile selectate
    vector<Muchie> minE(n + 1); // vector pentru a retine muchia minima pentru fiecare nod
    minE[1].w = 0; // initializam nodul de start cu greutatea 0

    for (int i = 1; i <= n; ++i) 
    {
        int v = -1;
        // Cautam nodul cu cea mai mica greutate care nu a fost selectat
        for (int j = 1; j <= n; ++j) 
        {
            if (!selected[j] && (v == -1 || minE[j].w < minE[v].w)) 
            {
                v = j;
            }
        }

        if (minE[v].w == INF) 
        {
            cout << "Nu exista MST!" << endl;
            exit(0);
        }

        selected[v] = true; // marcam nodul ca selectat
        totalWeight += minE[v].w; // adaugam greutatea muchiei la greutatea totala
        if (minE[v].to != -1) 
        {
            cout << v << " - " << minE[v].to << endl; // afisam muchia selectata
        }

        // Actualizam muchiile minime pentru nodurile adiacente
        for (int to = 1; to <= n; ++to) 
        {
            if (adj[v][to] < minE[to].w) 
            {
                minE[to] = {adj[v][to], v};
            }
        }
    }

    cout << "Greutatea totala a MST este: " << totalWeight << endl;
}

int main() 
{
    int numarMuchii;
    bool esteOrientat;
    cout << "Graful este orientat? (1 pentru Da, 0 pentru Nu): ";
    cin >> esteOrientat;

    cout << "Introduceti numarul de noduri si numarul de muchii: ";
    cin >> n >> numarMuchii;

    adj.assign(n + 1, vector<int>(n + 1, INF)); // initializam matricea de adiacenta cu INF

    cout << "Introduceti muchiile (nod1 nod2 cost):" << endl;
    for (int i = 0; i < numarMuchii; i++) 
    {
        int u, v, cost;
        cin >> u >> v >> cost;
        adj[u][v] = cost; // ajustam pentru indexare de la 1
        if (!esteOrientat) 
        {
            adj[v][u] = cost; // graful este neorientat
        }
    }

    Prim(); // apelam algoritmul lui Prim pentru a gasi MST

    return 0;
}