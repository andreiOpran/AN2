#include <iostream>
#include <vector>
#include <list>

using namespace std;

// Functie pentru citirea grafului
void citireGraf(int n, int m, vector<list<int>>& liste, bool orientat) {
    liste.resize(n + 1); // Initializam listele de adiacenta, numerotarea incepe de la 1

    for (int i = 0; i < m; ++i) {
        int u, v;
        cin >> u >> v;
        liste[u].push_back(v); // Adaugam muchia (u, v)
        if (!orientat) {
            liste[v].push_back(u); // Daca graful nu este orientat, adaugam si muchia (v, u)
        }
    }
}

// Functie pentru afisarea listelor de adiacenta
void afisareListe(const vector<list<int>>& liste) {
    for (int i = 1; i < liste.size(); ++i) { // Incepem de la 1
        cout << i << ": ";
        for (int v : liste[i]) {
            cout << v << " ";
        }
        cout << endl;
    }
}

int main() {
    vector<list<int>> liste;
    bool orientat;
    int n, m;

    // Citim daca graful este orientat sau nu
    cout << "Graful este orientat? (1 pentru Da, 0 pentru Nu): ";
    cin >> orientat;

    // Citim numarul de noduri si numarul de muchii
    cout << "Introduceti numarul de noduri si numarul de muchii: ";
    cin >> n >> m;

    // Citim muchiile grafului
    cout << "Introduceti muchiile (cate doua numere pentru fiecare muchie):" << endl;
    citireGraf(n, m, liste, orientat);

    // Afisam listele de adiacenta
    cout << "Listele de adiacenta sunt:" << endl;
    afisareListe(liste);

    return 0;
}