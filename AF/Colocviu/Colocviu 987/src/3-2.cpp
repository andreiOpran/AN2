/*

Tara AF a fost lovita de o pandemie numita RESTANTA. 
Astfel, cercetatorii au descoperit un vaccin care sa rezolve aceasta problema si l-au distribuit in m centre de vaccinare 
(numerotate de la 1 la m). Cele n persoane din tara (numerotate de la 1 la n) vor sa se vaccineze, doar ca acestea nu pot merge la orice centru, 
ci fiecare are o lista de centre la care poate ajunge. Totodata, pentru fiecare dintre cele m centre se cunoaste numarul de doze de vaccin 
(adica numarul maxim de persoane care se pot vaccina la acel centru). 
Sa se determine numarul minim de persoane care nu se pot vaccina, folosind un algoritm bazat pe algoritmul Ford-Fulkerson / Edmonds Karp.

Input Format

Programul citeste de la tastatura n si m, reprezentand numarul de persoane si numarul de centre. 
Urmatoarea linie contine m valori reprezentand numarul de doze de vaccin din fiecare centru. 
Urmatoarele n linii contin centrele la care se poate vaccina fiecare dintre persoane in urmatorul mod. 
A i-a dintre cele  linii corespunde persoanei i: prima valoare de pe linie reprezinta numarul de centre la care poate 
ajunge persoana i si apoi urmeaza indicii acestor centre (care sunt numere de la 1 la m).

Output Format

Programul afiseaza o singura valoare, reprezentand numarul minim de persoane care nu se pot vaccina.

Sample Input 0
3 2
1 2
1 1
1 1
1 2
Sample Output 0
1

Sample Input 1
5 3
1 4 1 
3 1 2 3 
2 1 2 
2 2 3 
1 1 
2 1 2
Sample Output 1
0

Sample Input 2
10 5
2 1 2 1 2 
1 1 
0 
1 5 
0 
0 
1 1 
1 5 
0 
0 
1 1 
Sample Output 2
6

*/

#include <iostream>
#include <vector>
#include <stack>
#include <queue>
#include <algorithm>
using namespace std;

// Structura pentru rețeaua de flux
const int INF = 1e9;
const int N = 205; // Numărul maxim de noduri în rețeaua de flux

// Vectori și matrice pentru stocarea grafului
vector<int> adj[N]; // Lista de adiacență pentru graf
int capacity[N][N]; // Matricea capacităților pentru rețeaua de flux
int parent[N]; // Vector pentru părinți folosit la găsirea drumurilor de augmentare

// Implementarea BFS pentru găsirea unui drum de augmentare în rețeaua reziduală
bool bfs(int source, int sink) 
{
    fill(parent, parent + N, -1);
    queue<pair<int, int>> q;
    q.push({source, INF});

    while (!q.empty()) 
    {
        int cur = q.front().first;
        int flow = q.front().second;
        q.pop();

        for (int next : adj[cur]) 
        {
            if (parent[next] == -1 && capacity[cur][next] > 0) 
            {
                parent[next] = cur;
                int new_flow = min(flow, capacity[cur][next]);
                if (next == sink)
                    return true;
                q.push({next, new_flow});
            }
        }
    }
    return false;
}

// Implementarea algoritmului Edmonds-Karp pentru găsirea fluxului maxim
int maxFlow(int source, int sink) 
{
    int flow = 0;

    while (bfs(source, sink)) 
    {
        int cur = sink;
        int path_flow = INF;

        // Găsirea capacității minime în drum
        while (cur != source) 
        {
            int prev = parent[cur];
            path_flow = min(path_flow, capacity[prev][cur]);
            cur = prev;
        }

        // Actualizarea capacităților în drum
        cur = sink;
        while (cur != source) 
        {
            int prev = parent[cur];
            capacity[prev][cur] -= path_flow;
            capacity[cur][prev] += path_flow;
            cur = prev;
        }

        flow += path_flow;
    }

    return flow;
}

int main() 
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    // Citirea numărului de persoane (n) și centre de vaccinare (m)
    int n, m;
    cin >> n >> m;

    // Definirea nodurilor sursă și destinație
    int source = 0, sink = n + m + 1;

    // Citirea numărului de doze pentru fiecare centru și construirea muchiilor către sink
    for (int i = 1; i <= m; ++i) 
    {
        int doses;
        cin >> doses;
        adj[i + n].push_back(sink);
        adj[sink].push_back(i + n);
        capacity[i + n][sink] = doses;
    }

    // Citirea centrelor disponibile pentru fiecare persoană și construirea muchiilor corespunzătoare
    for (int i = 1; i <= n; ++i) 
    {
        int k;
        cin >> k;
        for (int j = 0; j < k; ++j) 
        {
            int center;
            cin >> center;
            adj[i].push_back(center + n);
            adj[center + n].push_back(i);
            capacity[i][center + n] = 1; // Fiecare persoană poate folosi cel mult o doză
        }
        adj[source].push_back(i);
        adj[i].push_back(source);
        capacity[source][i] = 1; // Sursa se conectează la fiecare persoană
    }

    // Calcularea fluxului maxim reprezentând numărul maxim de persoane care se pot vaccina
    int max_flow = maxFlow(source, sink);

    // Calcularea numărului de persoane care nu se pot vaccina
    int not_vaccinated = n - max_flow;

    cout << not_vaccinated << "\n";

    return 0;
}