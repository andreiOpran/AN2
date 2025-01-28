// KOSARAJU

#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int numarNoduri, numarMuchii;
vector<vector<int>> graf;
vector<bool> vizitat;
vector<int> ordine;
vector<vector<int>> componente;
vector<vector<int>> grafCondensat;

// Functie pentru citirea grafului
// Citim numarul de noduri si muchii, apoi citim fiecare muchie si o adaugam in lista de adiacenta
void citireGraf(int numarNoduri, int numarMuchii, vector<vector<int>>& graf) {
    graf.resize(numarNoduri + 1); // Adjust size to accommodate 1-based indexing

    for (int i = 0; i < numarMuchii; ++i) {
        int nod1, nod2;
        cin >> nod1 >> nod2;
        graf[nod1].push_back(nod2); // Adaugam muchia (nod1, nod2)
    }
}

// Functie DFS pentru a umple vectorul de ordine in ordinea terminarii
// Parcurgem graful si adaugam nodurile in vectorul de ordine in momentul in care terminam explorarea lor
void dfs(int nodCurent, const vector<vector<int>>& graf, vector<int>& output) {
    vizitat[nodCurent] = true;
    for (int vecin : graf[nodCurent]) {
        if (!vizitat[vecin]) {
            dfs(vecin, graf, output);
        }
    }
    output.push_back(nodCurent);
}

// Functie pentru a gasi si afisa componentele tare conexe
// Folosim algoritmul Kosaraju pentru a gasi componentele tare conexe
void componenteTareConexe(const vector<vector<int>>& graf, vector<vector<int>>& componente, vector<vector<int>>& grafCondensat) {
    int n = graf.size();
    componente.clear();
    grafCondensat.clear();

    vector<int> ordine; // va fi o lista sortata a nodurilor grafului dupa timpul de iesire

    vizitat.assign(n, false);

    // Prima serie de parcurgeri DFS pentru a determina ordinea de terminare a nodurilor
    for (int i = 1; i < n; i++) { // Start from 1
        if (!vizitat[i]) {
            dfs(i, graf, ordine);
        }
    }

    // Cream lista de adiacenta a grafului transpus
    // Inversam directia fiecarei muchii
    vector<vector<int>> grafTranspus(n);
    for (int v = 1; v < n; v++) { // Start from 1
        for (int u : graf[v]) {
            grafTranspus[u].push_back(v);
        }
    }

    vizitat.assign(n, false);
    reverse(ordine.begin(), ordine.end()); // Inversam ordinea pentru a parcurge in ordinea corecta

    vector<int> radacini(n, 0); // da nodul radacina al SCC-ului unui nod

    // A doua serie de parcurgeri DFS pentru a gasi componentele tare conexe
    for (auto v : ordine) {
        if (!vizitat[v]) {
            vector<int> componenta;
            dfs(v, grafTranspus, componenta);
            componente.push_back(componenta);
            int radacina = *min_element(begin(componenta), end(componenta));
            for (auto u : componenta) {
                radacini[u] = radacina;
            }
        }
    }

    // Adaugam muchii la graful condensat
    // Cream un nou graf unde fiecare componenta tare conexa este un nod
    for (int v = 1; v < n; v++) { // Start from 1
        for (auto u : graf[v]) {
            if (radacini[v] != radacini[u]) {
                grafCondensat[radacini[v]].push_back(radacini[u]);
            }
        }
    }
}

int main() {
    cout << "Introduceti numarul de noduri si numarul de muchii: ";
    cin >> numarNoduri >> numarMuchii;

    cout << "Introduceti muchiile (cate doua numere pentru fiecare muchie):" << endl;
    citireGraf(numarNoduri, numarMuchii, graf);

    componenteTareConexe(graf, componente, grafCondensat);

    cout << "Componentele tare conexe ale grafului sunt:" << endl;
    for (const auto& componenta : componente) {
        for (int nod : componenta) {
            cout << nod << " "; // No need to adjust as nodes are already 1-based
        }
        cout << endl;
    }

    return 0;
}