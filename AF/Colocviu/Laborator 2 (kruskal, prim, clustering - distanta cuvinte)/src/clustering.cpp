#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <tuple>
#include <unordered_map>
#include <limits>
#include <sstream>
using namespace std;

// Calculeaza distanta Levenshtein intre doua string-uri
int LevenshteinDistance(const string& a, const string& b) 
{
    int n = (int)a.size();
    int m = (int)b.size();
    vector<vector<int>> dp(n + 1, vector<int>(m + 1));

    // Initializeaza bordurile
    for(int i = 0; i <= n; ++i) {
        dp[i][0] = i;
    }
    for(int j = 0; j <= m; ++j) {
        dp[0][j] = j;
    }

    // Umplem matricea
    for(int i = 1; i <= n; ++i) {
        for(int j = 1; j <= m; ++j) {
            int cost = (a[i - 1] == b[j - 1]) ? 0 : 1;
            dp[i][j] = min({ dp[i - 1][j] + 1,    // ștergere
                             dp[i][j - 1] + 1,    // inserare
                             dp[i - 1][j - 1] + cost }); // înlocuire (cost 0 sau 1)
        }
    }
    return dp[n][m];
}

// Disjoint Set (Union-Find) pentru gestionarea clusterelor
struct DisjointSet
{
    vector<int> parent, rankDS;
    int n;

    DisjointSet(int n) : n(n), parent(n), rankDS(n, 0)
    {
        for(int i = 0; i < n; i++) {
            parent[i] = i;
        }
    }

    int Find(int x) 
    {
        if(parent[x] != x) {
            parent[x] = Find(parent[x]);
        }
        return parent[x];
    }

    bool Union(int x, int y) 
    {
        int rx = Find(x);
        int ry = Find(y);
        if(rx != ry) {
            if(rankDS[rx] < rankDS[ry]) {
                parent[rx] = ry;
            } else if(rankDS[rx] > rankDS[ry]) {
                parent[ry] = rx;
            } else {
                parent[ry] = rx;
                rankDS[rx]++;
            }
            return true;
        }
        return false;
    }
};

int main()
{
    // Citim cuvintele de la tastatura
    cout << "Introduceti cuvintele separate prin spatiu: ";
    string line;
    getline(cin, line);

    // Parse linia in vector de cuvinte
    vector<string> cuvinte;
    {
        stringstream ss(line);
        string token;
        while(ss >> token) {
            cuvinte.push_back(token);
        }
    }

    // Citim k
    int k;
    cout << "Introduceti numarul de clase (k): ";
    cin >> k;

    int n = (int)cuvinte.size();
    if(k <= 0 || k > n) {
        cout << "k invalid!" << endl;
        return 0;
    }
    if(n == 0) {
        cout << "Nu exista cuvinte!" << endl;
        return 0;
    }

    // Construieste toate muchiile (distantele Levenshtein) intre cuvinte
    // edges: (distanta, idx1, idx2), sortam crescator
    vector<tuple<int,int,int>> edges;
    edges.reserve((n*(n-1))/2);

    for(int i = 0; i < n; i++) {
        for(int j = i+1; j < n; j++) {
            int d = LevenshteinDistance(cuvinte[i], cuvinte[j]);
            edges.push_back({d, i, j});
        }
    }

    // Sortam crescator dupa distanta
    sort(edges.begin(), edges.end(), [](auto &a, auto &b) {
        return get<0>(a) < get<0>(b);
    });

    // Initializam Disjoint Set
    DisjointSet ds(n);
    int numClusters = n; // la inceput fiecare cuvant e in propriul cluster
    int spacing = 0;     // distanta dintre doua clustere distincte

    // Parcurgem muchiile de la mic la mare si unim atat timp cat avem mai mult de k clustere
    for(auto &e : edges) {
        int distanta, x, y;
        tie(distanta, x, y) = e;

        // daca x si y sunt in clustere diferite, uneste-le
        if(ds.Find(x) != ds.Find(y)) {
            // doar daca avem inca nevoie sa micsoram numarul de clustere
            if(numClusters > k) {
                ds.Union(x, y);
                numClusters--;
            }
            else {
                // Daca avem deja k clustere,
                // urmatoarea muchie care ar uni 2 clustere diferite
                // reprezinta "gradul de separare" (spatierea maxima)
                spacing = distanta;
                break;
            }
        }
    }

    // Construim listele de cuvinte din fiecare cluster
    unordered_map<int, vector<int>> clusterMap;
    clusterMap.reserve(n);

    for(int i = 0; i < n; i++) {
        clusterMap[ds.Find(i)].push_back(i);
    }

    // Afisam fiecare cluster pe un rand
    for(auto &kv : clusterMap) {
        for(auto &idx : kv.second) {
            cout << cuvinte[idx] << " ";
        }
        cout << endl;
    }

    // Afisam gradul de separare
    cout << spacing << endl;

    return 0;
}