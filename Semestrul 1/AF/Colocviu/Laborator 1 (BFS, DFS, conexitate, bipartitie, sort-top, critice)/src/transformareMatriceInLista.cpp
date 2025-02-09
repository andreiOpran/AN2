#include <iostream>
#include <vector>
#include <list>

using namespace std;

// Citeste graful si il reprezinta sub forma de liste de adiacenta
void citireGrafListe(int n, int m, vector<list<int>>& liste, bool orientat) {
    liste.resize(n); // Initializam listele de adiacenta

    for (int i = 0; i < m; ++i) {
        int u, v;
        cin >> u >> v;
        liste[u - 1].push_back(v - 1); // Adaugam muchia (u, v)
        if (!orientat) {
            liste[v - 1].push_back(u - 1); // Daca graful nu este orientat, adaugam si muchia (v, u)
        }
    }
}

// Afiseaza listele de adiacenta
void afisareListe(const vector<list<int>>& liste) {
    for (int i = 0; i < liste.size(); ++i) {
        cout << i + 1 << ": "; // Nodurile sunt numerotate de la 1
        for (int v : liste[i]) {
            cout << v + 1 << " "; // Nodurile sunt numerotate de la 1
        }
        cout << endl;
    }
}

// Citeste graful si il reprezinta sub forma de matrice de adiacenta
void citireGrafMatrice(int n, int m, vector<vector<int>>& matrice, bool orientat) {
    matrice.resize(n, vector<int>(n, 0)); // Initializam matricea de adiacenta cu 0

    for (int i = 0; i < m; ++i) {
        int u, v;
        cin >> u >> v;
        matrice[u - 1][v - 1] = 1; // Adaugam muchia (u, v)
        if (!orientat) {
            matrice[v - 1][u - 1] = 1; // Daca graful nu este orientat, adaugam si muchia (v, u)
        }
    }
}

// Afiseaza matricea de adiacenta
void afisareMatrice(const vector<vector<int>>& matrice) {
    int n = matrice.size();

    // Afisam header-ul cu numerele nodurilor
    cout << "  ";
    for (int i = 0; i < n; ++i) {
        cout << i + 1 << " "; // Nodurile sunt numerotate de la 1
    }
    cout << endl;

    // Afisam matricea de adiacenta cu numerele nodurilor pe randuri
    for (int i = 0; i < n; ++i) {
        cout << i + 1 << " "; // Nodurile sunt numerotate de la 1
        for (int j = 0; j < n; ++j) {
            cout << matrice[i][j] << " ";
        }
        cout << endl;
    }
}

// Transforma listele de adiacenta in matrice de adiacenta
vector<vector<int>> listeToMatrice(const vector<list<int>>& liste) {
    int n = liste.size();
    vector<vector<int>> matrice(n, vector<int>(n, 0));

    for (int i = 0; i < n; ++i) {
        for (int v : liste[i]) {
            matrice[i][v] = 1;
        }
    }

    return matrice;
}

// Transforma matricea de adiacenta in liste de adiacenta
vector<list<int>> matriceToListe(const vector<vector<int>>& matrice) {
    int n = matrice.size();
    vector<list<int>> liste(n);

    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            if (matrice[i][j] == 1) {
                liste[i].push_back(j);
            }
        }
    }

    return liste;
}

int main() {
    vector<list<int>> liste;
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
    citireGrafListe(n, m, liste, orientat);

    // Afisam listele de adiacenta
    cout << "Listele de adiacenta sunt:" << endl;
    afisareListe(liste);

    // Convertim listele de adiacenta in matrice de adiacenta
    matrice = listeToMatrice(liste);
    cout << "Matricea de adiacenta este:" << endl;
    afisareMatrice(matrice);

    // Convertim matricea de adiacenta inapoi in liste de adiacenta
    vector<list<int>> listeConvertite = matriceToListe(matrice);
    cout << "Listele de adiacenta convertite din matrice sunt:" << endl;
    afisareListe(listeConvertite);

    return 0;
}