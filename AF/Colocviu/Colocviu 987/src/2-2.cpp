/*

Fie G un graf orientat aciclic (fara circuite) cu n noduri (numerotate de la 1 la n) si m arce.
Se considera un sir s de valori naturale de lungime k cu elementele 1 <= si <= n, numit sir de destinatii.
Sa se determine un drum de lungime maxima in G care se termina in una dintre cele k destinatii.

Complexitate ceruta: O(n + m)

Input Format

Programul citeste de la tastatura valorile n, m, k, apoi k valori reprezentand destinatiile. In continuare, se citesc m perechi reprezentand arcele grafului.

Output Format

Programul afiseaza lungimea drumului maxim cerut si un astfel de drum. Daca exista mai multe raspunsuri se poate afisa oricare din ele.

Sample Input 0
5 5 2
4 5
1 3
1 4
1 2
4 5
2 4
Sample Output 0
3
1 2 4 5

*/

#include <iostream>
#include <vector>
#include <stack>
#include <queue>
#include <algorithm>
using namespace std;

// Numărul maxim de noduri
const int N = 1e5 + 5;
// Listă de adiacență pentru reprezentarea grafului
vector<int> adj[N];
// n = numărul de noduri, m = numărul de arce, k = numărul de destinații
int n, m, k;
// Vector ce conține nodurile destinație
vector<int> destinations;
// dp[i] = lungimea maximă a unui drum care ajunge în nodul i
// parent[i] = părintele nodului i în drumul maxim
int dp[N], parent[N];

// Funcție care determină sortarea topologică a grafului
vector<int> topological_sort() 
{
    // Calculăm gradele interioare pentru fiecare nod
    vector<int> in_degree(n + 1, 0);
    for (int u = 1; u <= n; ++u) 
    {
        for (int v : adj[u]) 
        {
            in_degree[v]++;
        }
    }

    // Folosim o coadă pentru nodurile cu grad interior 0
    queue<int> q;
    // Vector pentru stocarea ordinii topologice
    vector<int> order;
    
    // Adăugăm în coadă toate nodurile cu grad interior 0
    for (int i = 1; i <= n; ++i) 
    {
        if (in_degree[i] == 0) 
        {
            q.push(i);
        }
    }

    // Procesăm nodurile și construim ordinea topologică
    while (!q.empty()) 
    {
        int u = q.front(); q.pop();
        order.push_back(u);
        for (int v : adj[u]) 
        {
            if (--in_degree[v] == 0) 
            {
                q.push(v);
            }
        }
    }
    return order;
}

// Funcție care găsește drumul cel mai lung către una din destinații
pair<int, vector<int>> longest_path() 
{
    // Obținem ordinea topologică a nodurilor
    vector<int> order = topological_sort();

    // Inițializăm distanțele cu -1
    fill(dp, dp + N, -1);

    // Calculăm lungimile maxime pentru fiecare nod în ordine topologică
    for (int node : order) 
    {
        if (dp[node] == -1) dp[node] = 0;
        for (int v : adj[node]) 
        {
            if (dp[v] < dp[node] + 1) 
            {
                dp[v] = dp[node] + 1;
                parent[v] = node;
            }
        }
    }

    // Găsim destinația cu drumul cel mai lung
    int max_length = 0, last_node = -1;
    for (int d : destinations) 
    {
        if (dp[d] > max_length) 
        {
            max_length = dp[d];
            last_node = d;
        }
    }

    // Reconstruim drumul folosind vectorul de părinți
    vector<int> path;
    while (last_node) 
    {
        path.push_back(last_node);
        last_node = parent[last_node];
    }
    reverse(path.begin(), path.end());
    return { max_length, path };
}

int main() 
{
    // Optimizări pentru I/O
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    // Citim datele de intrare
    cin >> n >> m >> k;
    destinations.resize(k);
    for (int i = 0; i < k; ++i) 
    {
        cin >> destinations[i];
    }

    // Citim arcele grafului
    for (int i = 0; i < m; ++i) 
    {
        int u, v;
        cin >> u >> v;
        adj[u].push_back(v);
    }

    // Găsim și afișăm soluția
    auto [length, path] = longest_path();

    cout << length << '\n';
    for (int node : path) 
    {
        cout << node << ' ';
    }
    cout << '\n';

    return 0;
}