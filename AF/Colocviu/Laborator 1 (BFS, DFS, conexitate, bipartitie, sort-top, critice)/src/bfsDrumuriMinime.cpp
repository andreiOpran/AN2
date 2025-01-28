/*

------------------------------------------------------------------------------------------

Fiind dat un nod S, sa se determine, pentru fiecare nod X, numarul minim de arce ce trebuie parcurse 
pentru a ajunge din nodul sursa S la nodul X.

IN:
5 7
1 2
2 1
2 2
3 2
2 5
5 3
4 5
2

OUT:
1 0 2 -1 1

------------------------------------------------------------------------------------------

*/
#include <iostream>
#include <vector>
#include <list>
#include <queue>

using namespace std;

// Functie pentru citirea grafului si stocarea acestuia sub forma de liste de adiacenta
void citireGrafListe(int n, int m, vector<list<int>>& liste) {
    liste.resize(n + 1); // Initializam listele de adiacenta

    for (int i = 0; i < m; ++i) {
        int u, v;
        cin >> u >> v;
        liste[u].push_back(v); // Adaugam muchia (u, v)
    }
}

// Functie pentru afisarea listelor de adiacenta
void afisareListe(const vector<list<int>>& liste) {
    for (int i = 1; i < liste.size(); ++i) {
        cout << i << ": ";
        for (int v : liste[i]) {
            cout << v << " ";
        }
        cout << endl;
    }
}

// Functie BFS pentru calcularea distantei minime de la nodul sursa la toate celelalte noduri
bool bfs(const vector<list<int>>& liste, int s, vector<int>& distanta) {
    int n = liste.size();
    queue<int> coada;

    coada.push(s); // Adaugam nodul sursa in coada
    distanta[s] = 0; // Distanta de la sursa la sursa este 0

    while (!coada.empty()) {
        int u = coada.front();
        coada.pop();

        // Parcurgem toti vecinii nodului curent
        for (int v : liste[u]) {
            if (distanta[v] == -1) { // Daca nodul nu a fost vizitat
                distanta[v] = distanta[u] + 1; // Actualizam distanta
                coada.push(v); // Adaugam nodul in coada pentru a-i parcurge vecinii
            }
        }
    }

    return true;
}

int main() {
    vector<list<int>> liste;
    int n, m, s;

    cout << "Introduceti numarul de noduri si numarul de muchii: ";
    cin >> n >> m;

    cout << "Introduceti muchiile (cate doua numere pentru fiecare muchie):" << endl;
    citireGrafListe(n, m, liste);

    cout << "Listele de adiacenta sunt:" << endl;
    afisareListe(liste);

    cout << "Introduceti varful sursa s: ";
    cin >> s;

    vector<int> distanta(n + 1, -1); // Initializam distantele cu -1 (noduri nevizitate)
    bfs(liste, s, distanta);

    cout << "Numarul minim de arce de la nodul " << s << " la fiecare nod este:" << endl;
    for (int i = 1; i <= n; ++i) {
        cout << distanta[i] << " "; // Afisam distantele calculate
    }
    cout << endl;

    return 0;
}