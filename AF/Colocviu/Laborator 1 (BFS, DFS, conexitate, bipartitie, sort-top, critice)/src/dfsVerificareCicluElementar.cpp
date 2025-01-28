/*

------------------------------------------------------------------------------------------

Dat un graf neorientat (nu neaparat conex), să se verifice dacă graful conține un ciclu
elementar (nu este aciclic). În caz afirmativ să se afișeze un astfel de ciclu.

IN: 
7 8 
1 3 
2 4 
3 4 
3 5 
3 6
5 6
6 7
3 7

OUT: 
3 5 6 3 
(nu neaparat in aceasta ordine; solutia nu este unica, un alt ciclu este de exemplu 3 6 7 3)

------------------------------------------------------------------------------------------

*/

#include <iostream>
#include <vector>
#include <list>
#include <stack>

using namespace std;

// Functie pentru citirea grafului
void citireGraf(int n, int m, vector<list<int>>& liste) {
    liste.resize(n + 1); // Initializam listele de adiacenta

    for (int i = 0; i < m; ++i) {
        int u, v;
        cin >> u >> v;
        liste[u].push_back(v); // Adaugam muchia (u, v) in lista de adiacenta a nodului u
        liste[v].push_back(u); // Adaugam muchia (v, u) in lista de adiacenta a nodului v pentru graf neorientat
    }
}

// Functie DFS pentru a verifica existenta unui ciclu
bool dfs(int u, int parinte, const vector<list<int>>& liste, vector<bool>& vizitat, vector<int>& parinti, vector<int>& ciclu) {
    vizitat[u] = true; // Marcam nodul ca vizitat
    parinti[u] = parinte; // Salvam parintele nodului curent

    for (int v : liste[u]) {
        if (!vizitat[v]) {
            // Daca nodul nu a fost vizitat, continuam DFS
            if (dfs(v, u, liste, vizitat, parinti, ciclu)) {
                return true; // Daca gasim un ciclu, returnam true
            }
        } else if (v != parinte) {
            // Am gasit un ciclu
            ciclu.push_back(v); // Adaugam nodul v in ciclu
            int current = u;
            while (current != v) {
                ciclu.push_back(current); // Adaugam nodurile din ciclu
                current = parinti[current]; // Mergem inapoi pe lantul de parinti
            }
            ciclu.push_back(v); // Inchidem ciclul
            return true;
        }
    }

    return false; // Nu am gasit niciun ciclu
}

int main() {
    vector<list<int>> liste; // Liste de adiacenta pentru reprezentarea grafului
    int n, m;

    cout << "Introduceti numarul de noduri si numarul de muchii: ";
    cin >> n >> m;

    cout << "Introduceti muchiile (cate doua numere pentru fiecare muchie):" << endl;
    citireGraf(n, m, liste); // Citim graful

    vector<bool> vizitat(n + 1, false); // Vector pentru a marca nodurile vizitate
    vector<int> parinti(n + 1, -1); // Vector pentru a tine evidenta parintilor nodurilor
    vector<int> ciclu; // Vector pentru a stoca ciclul gasit

    bool cicluGasit = false;
    for (int i = 1; i <= n; ++i) {
        if (!vizitat[i]) {
            // Daca nodul nu a fost vizitat, pornim DFS
            if (dfs(i, -1, liste, vizitat, parinti, ciclu)) {
                cicluGasit = true;
                break; // Oprim cautarea la gasirea primului ciclu
            }
        }
    }

    if (cicluGasit) {
        cout << "Graful contine un ciclu: ";
        for (int nod : ciclu) {
            cout << nod << " "; // Afisam nodurile ciclului
        }
        cout << endl;
    } else {
        cout << "Graful nu contine niciun ciclu." << endl;
    }

    return 0;
}