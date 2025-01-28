#include <iostream>
#include <vector>

using namespace std;

// Functie pentru citirea grafului si construirea matricei de adiacenta
void citireGraf(int n, int m, vector<vector<int>>& matrice, bool orientat) {
    matrice.resize(n + 1, vector<int>(n + 1, 0)); // Initializam matricea de adiacenta cu 0, numerotarea incepe de la 1

    for (int i = 0; i < m; ++i) {
        int u, v;
        cin >> u >> v;
        matrice[u][v] = 1; // Adaugam muchia (u, v)
        if (!orientat) {
            matrice[v][u] = 1; // Daca graful nu este orientat, adaugam si muchia (v, u)
        }
    }
}

// Functie pentru afisarea matricei de adiacenta
void afisareMatrice(const vector<vector<int>>& matrice) {
    int n = matrice.size() - 1; // Dimensiunea matricei, ignoram indexul 0

    // Afisam header-ul cu numerele nodurilor
    cout << "  ";
    for (int i = 1; i <= n; ++i) {
        cout << i << " ";
    }
    cout << endl;

    // Afisam matricea de adiacenta cu numerele nodurilor pe randuri
    for (int i = 1; i <= n; ++i) {
        cout << i << " ";
        for (int j = 1; j <= n; ++j) {
            cout << matrice[i][j] << " ";
        }
        cout << endl;
    }
}

int main() {
    vector<vector<int>> matrice;
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
    citireGraf(n, m, matrice, orientat);

    // Afisam matricea de adiacenta
    cout << "Matricea de adiacenta este:" << endl;
    afisareMatrice(matrice);

    return 0;
}