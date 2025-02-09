/*

Există n elevi în clasa lui Uolevi și m prietenii între ei. Sarcina ta este să împarți elevii în două echipe astfel încât nici doi elevi din aceeași echipă să nu fie prieteni. Poți alege liber dimensiunile echipelor.

Intrare:
Prima linie de intrare conține două numere întregi n și m: numărul de elevi și numărul de prietenii. Elevii sunt numerotați de la 1 la n.

Apoi, urmează m linii care descriu prieteniile. Fiecare linie conține două numere întregi a și b: elevii a și b sunt prieteni.

Fiecare prietenie este între doi elevi diferiți. Poți presupune că există cel mult o prietenie între oricare doi elevi.

Ieșire:
Afișează un exemplu de cum să construiești echipele. Pentru fiecare elev, afișează "1" sau "2" în funcție de echipa în care va fi repartizat. Poți afișa orice echipă validă.

Dacă nu există soluții, afișează "IMPOSSIBLE".

*/

// VARIANTA CU POVESTE
/*

#include <iostream>
#include <vector>
#include <queue>

using namespace std;

// Funcție pentru citirea grafului
void citireGraf(int n, int m, vector<vector<int>>& graf) {
    graf.resize(n); // Inițializăm listele de adiacență

    for (int i = 0; i < m; ++i) {
        int a, b;
        cin >> a >> b;
        graf[a - 1].push_back(b - 1); // Adăugăm muchia (a, b)
        graf[b - 1].push_back(a - 1); // Adăugăm muchia (b, a) pentru graf neorientat
    }
}

// Funcție BFS pentru a verifica dacă graful este bipartit și pentru a colora nodurile
bool bfs(const vector<vector<int>>& graf, vector<int>& echipe, int start) {
    queue<int> coada;
    coada.push(start);
    echipe[start] = 1; // Începem cu echipa 1

    while (!coada.empty()) {
        int u = coada.front();
        coada.pop();

        for (int v : graf[u]) {
            if (echipe[v] == -1) {
                // Dacă nodul v nu a fost colorat, îl colorăm cu culoarea opusă
                echipe[v] = 3 - echipe[u];
                coada.push(v);
            } else if (echipe[v] == echipe[u]) {
                // Dacă nodul v are aceeași culoare ca nodul u, graful nu este bipartit
                return false;
            }
        }
    }

    return true;
}

int main() {
    int n, m;
    cout << "Introduceti numarul de elevi si numarul de prietenii: ";
    cin >> n >> m;

    vector<vector<int>> graf;
    cout << "Introduceti prieteniile (cate doua numere pentru fiecare prietenie):" << endl;
    citireGraf(n, m, graf);

    vector<int> echipe(n, -1); // Inițializăm echipele cu -1 (necolorat)

    for (int i = 0; i < n; ++i) {
        if (echipe[i] == -1) {
            if (!bfs(graf, echipe, i)) {
                cout << "IMPOSSIBLE" << endl;
                return 0;
            }
        }
    }

    for (int i = 0; i < n; ++i) {
        cout << echipe[i] << " ";
    }
    cout << endl;

    return 0;
}

*/

// VARIANTA SIMPLIFICATA

#include <iostream>
#include <vector>
#include <queue>

using namespace std;

// Funcție pentru citirea grafului
void citireGraf(int numarNoduri, int numarMuchii, vector<vector<int>>& graf) {
    graf.resize(numarNoduri + 1); // Inițializăm listele de adiacență

    for (int i = 0; i < numarMuchii; ++i) {
        int nod1, nod2;
        cin >> nod1 >> nod2;
        graf[nod1].push_back(nod2); // Adăugăm muchia (nod1, nod2)
        graf[nod2].push_back(nod1); // Adăugăm muchia (nod2, nod1) pentru graf neorientat
    }
}

// Funcție BFS pentru a verifica dacă graful este bipartit și pentru a colora nodurile
bool bfs(const vector<vector<int>>& graf, vector<int>& culori, int start) {
    queue<int> coada;
    coada.push(start);
    culori[start] = 1; // Începem cu culoarea 1

    while (!coada.empty()) {
        int nodCurent = coada.front();
        coada.pop();

        for (int vecin : graf[nodCurent]) {
            if (culori[vecin] == -1) {
                // Dacă nodul vecin nu a fost colorat, îl colorăm cu culoarea opusă
                culori[vecin] = 1 - culori[nodCurent];
                coada.push(vecin);
            } else if (culori[vecin] == culori[nodCurent]) {
                // Dacă nodul vecin are aceeași culoare ca nodul curent, graful nu este bipartit
                return false;
            }
        }
    }

    return true;
}

int main() {
    int numarNoduri, numarMuchii;
    cout << "Introduceti numarul de noduri si numarul de muchii: ";
    cin >> numarNoduri >> numarMuchii;

    vector<vector<int>> graf;
    cout << "Introduceti muchiile (cate doua numere pentru fiecare muchie):" << endl;
    citireGraf(numarNoduri, numarMuchii, graf);

    vector<int> culori(numarNoduri + 1, -1); // Inițializăm culorile cu -1 (necolorat)

    for (int i = 1; i <= numarNoduri; ++i) {
        if (culori[i] == -1) {
            if (!bfs(graf, culori, i)) {
                cout << "IMPOSSIBLE" << endl;
                return 0;
            }
        }
    }

    for (int i = 1; i <= numarNoduri; ++i) {
        cout << culori[i] + 1 << " "; // Afișăm culorile nodurilor (1 sau 2)
    }
    cout << endl;

    return 0;
}