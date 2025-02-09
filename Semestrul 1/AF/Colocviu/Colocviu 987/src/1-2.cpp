/*

Fie G un graf neorientat cu n noduri, numerotate de la 1 la n, si m muchii. 
Sa se determine daca G are cel putin doi arbori partiali distincti (= care difera prin cel putin o muchie). 
In caz afirmativ, sa se afiseze doi arbori partiali distincti ai G lui .

Complexitate ceruta: O(n + m)

Input Format

Programul citeste de la tastatura valorile n, m si apoi m perechi reprezentand muchiile grafului.


Output Format

Programul va afisa pe ecran un mesaj (Da/Nu). 
In cazul in care mesajul este "Da" se vor afisa doi arbori partiali sub forma de liste de adiacenta 
(cate o linie pentru lista vecinilor fiecarui nod 1,..,n; pe o linie vecinii sunt separati cu spatiu, 
ca in exemplu; nu conteaza ordinea in care sunt afisati vecinii unui nod). 
Daca exista mai multi arbori partiali se pot afisa oricare doi.

Sample Input 0
10 5
1 9
2 9
4 8
7 9
8 9
Sample Output 0
Nu

Sample Input 1
10 10
1 6
1 8
1 10
2 5
2 9
3 5
3 6
4 5
7 9
9 10
Sample Output 1
Da
6 8 
5 9 
6 5 
5 
3 2 4 
1 3 
9 
1 
2 7 10 
9 
6 8 10 
9 
6 5 
5 
3 4 
1 3 
9 
1 
10 2 7 
1 9 

*/

#include <iostream>
#include <vector>
#include <set>
using namespace std;

// Constante si structuri de date
const int MAXN = 100005;  // Numarul maxim de noduri
vector<int> adj[MAXN];    // Lista de adiacenta pentru graful original
vector<int> tree1[MAXN], tree2[MAXN];  // Liste de adiacenta pentru cei doi arbori partiali
bool visited[MAXN];       // Vector pentru marcarea nodurilor vizitate in DFS
set<pair<int, int>> usedEdges1, usedEdges2;  // Multimi pentru stocarea muchiilor din fiecare arbore

// Functie pentru adaugarea unei muchii neorientate in graf
void addEdge(int u, int v) {
    adj[u].push_back(v);
    adj[v].push_back(u);
}

// DFS pentru construirea primului arbore partial
// Proceseaza muchiile in ordinea normala
void dfs1(int node) {
    visited[node] = true;
    for (int next : adj[node]) {
        if (!visited[next]) {
            // Adauga muchia in primul arbore partial
            tree1[node].push_back(next);
            tree1[next].push_back(node);
            // Stocheaza muchia in forma normalizata (nodul mai mic primul)
            usedEdges1.insert({ min(node,next), max(node,next) });
            dfs1(next);
        }
    }
}

// DFS pentru construirea celui de-al doilea arbore partial
// Proceseaza muchiile in ordine inversa pentru a obtine un arbore diferit
void dfs2(int node) {
    visited[node] = true;
    for (int i = (int)adj[node].size() - 1; i >= 0; i--) {
        int next = adj[node][i];
        if (!visited[next]) {
            // Adauga muchia in al doilea arbore partial
            tree2[node].push_back(next);
            tree2[next].push_back(node);
            // Stocheaza muchia in forma normalizata (nodul mai mic primul)
            usedEdges2.insert({ min(node,next), max(node,next) });
            dfs2(next);
        }
    }
}

int main() {
    // Citirea datelor de intrare
    int n, m;
    cin >> n >> m;

    // Construirea grafului
    for (int i = 0; i < m; i++) {
        int u, v;
        cin >> u >> v;
        addEdge(u, v);
    }

    // Construieste primul arbore partial
    fill(visited, visited + n + 1, false);
    dfs1(1);

    // Construieste al doilea arbore partial
    fill(visited, visited + n + 1, false);
    dfs2(1);

    // Compara cei doi arbori si afiseaza rezultatul
    if (usedEdges1 != usedEdges2) {
        cout << "Da\n";
        // Afiseaza primul arbore partial
        for (int i = 1; i <= n; i++) {
            for (int j : tree1[i]) {
                cout << j << " ";
            }
            cout << "\n";
        }
        // Afiseaza al doilea arbore partial
        for (int i = 1; i <= n; i++) {
            for (int j : tree2[i]) {
                cout << j << " ";
            }
            cout << "\n";
        }
    }
    else {
        cout << "Nu\n";
    }

    return 0;
}