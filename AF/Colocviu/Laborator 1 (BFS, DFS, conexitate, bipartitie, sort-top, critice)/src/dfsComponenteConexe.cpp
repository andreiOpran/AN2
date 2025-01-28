/*

------------------------------------------------------------------------------------------

Se da un graf neorientat cu N noduri si M muchii.
Sa se determine numarul componentelor conexe ale grafului.
In plus, sa se afiseze arcele de avansare, de intoarcere si de traversare.

IN:
6 3
1 2
1 4
3 5

OUT:
3

------------------------------------------------------------------------------------------

*/

#include <iostream>
#include <vector>
#include <list>
#include <stack>

using namespace std;

// Functie pentru citirea grafului
void citireGraf(int n, int m, vector<list<int>>& liste) {
    liste.resize(n + 1); // Initializam listele de adiacenta pentru fiecare nod

    for (int i = 0; i < m; ++i) {
        int u, v;
        cin >> u >> v;
        liste[u].push_back(v); // Adaugam muchia (u, v) in lista de adiacenta a nodului u
        liste[v].push_back(u); // Adaugam muchia (v, u) in lista de adiacenta a nodului v pentru graf neorientat
    }
}

// Functie DFS pentru a parcurge graful si a determina tipurile de arce
void dfs(int u, const vector<list<int>>& liste, vector<bool>& vizitat, vector<int>& parinte, vector<int>& descoperit, vector<int>& terminat, int& timp, vector<pair<int, int>>& arceAvansare, vector<pair<int, int>>& arceIntoarcere, vector<pair<int, int>>& arceTraversare) {
    vizitat[u] = true; // Marcam nodul ca vizitat
    descoperit[u] = ++timp; // Salvam timpul de descoperire al nodului curent

    for (int v : liste[u]) {
        if (!vizitat[v]) {
            parinte[v] = u; // Salvam parintele nodului curent
            arceAvansare.push_back({u, v}); // Adaugam arcul de avansare (u, v)
            dfs(v, liste, vizitat, parinte, descoperit, terminat, timp, arceAvansare, arceIntoarcere, arceTraversare); // Apelam recursiv DFS pentru nodul v
        } else if (v != parinte[u]) { // Daca nodul v a fost vizitat si nu este parintele nodului u
            if (descoperit[v] < descoperit[u]) {
                arceIntoarcere.push_back({u, v}); // Adaugam arcul de intoarcere (u, v)
            } else {
                arceTraversare.push_back({u, v}); // Adaugam arcul de traversare (u, v)
            }
        }
    }

    terminat[u] = ++timp; // Salvam timpul de terminare al nodului curent
}

int main() {
    vector<list<int>> liste; // Liste de adiacenta pentru reprezentarea grafului
    int n, m;

    cout << "Introduceti numarul de noduri si numarul de muchii: ";
    cin >> n >> m;

    cout << "Introduceti muchiile (cate doua numere pentru fiecare muchie):" << endl;
    citireGraf(n, m, liste); // Citim graful

    vector<bool> vizitat(n + 1, false); // Vector pentru a marca nodurile vizitate
    vector<int> parinte(n + 1, -1); // Vector pentru a tine evidenta parintilor nodurilor
    vector<int> descoperit(n + 1, 0); // Vector pentru a tine evidenta timpului de descoperire
    vector<int> terminat(n + 1, 0); // Vector pentru a tine evidenta timpului de terminare
    int timp = 0; // Variabila pentru a tine evidenta timpului
    int componenteConexe = 0; // Variabila pentru a tine evidenta numarului de componente conexe

    vector<pair<int, int>> arceAvansare; // Vector pentru a stoca arcele de avansare
    vector<pair<int, int>> arceIntoarcere; // Vector pentru a stoca arcele de intoarcere
    vector<pair<int, int>> arceTraversare; // Vector pentru a stoca arcele de traversare

    // Parcurgem toate nodurile pentru a identifica componentele conexe
    for (int i = 1; i <= n; ++i) {
        if (!vizitat[i]) {
            dfs(i, liste, vizitat, parinte, descoperit, terminat, timp, arceAvansare, arceIntoarcere, arceTraversare);
            componenteConexe++; // Incrementam numarul de componente conexe
        }
    }

    cout << "Numarul componentelor conexe este: " << componenteConexe << endl;

    // Afisam arcele de avansare
    cout << "Arce de avansare:" << endl;
    for (const auto& arc : arceAvansare) {
        cout << arc.first << " -> " << arc.second << endl;
    }

    // Afisam arcele de intoarcere
    cout << "Arce de intoarcere:" << endl;
    for (const auto& arc : arceIntoarcere) {
        cout << arc.first << " -> " << arc.second << endl;
    }

    // Afisam arcele de traversare
    cout << "Arce de traversare:" << endl;
    for (const auto& arc : arceTraversare) {
        cout << arc.first << " -> " << arc.second << endl;
    }

    return 0;
}