#include <iostream>
#include <vector>
#include <queue>

using namespace std;

int numarNoduri, numarMuchii;
vector<vector<int>> graf;
vector<int> gradIn;
vector<int> rezultat;
queue<int> coada;

// Funcție pentru citirea grafului
void citireGraf(int numarNoduri, int numarMuchii, vector<vector<int>>& graf) {
    graf.resize(numarNoduri + 1); // Redimensionăm graful pentru a include toate nodurile
    gradIn.resize(numarNoduri + 1, 0); // Inițializăm gradul de intrare pentru fiecare nod

    // Citim fiecare muchie și actualizăm graful și gradul de intrare
    for (int i = 0; i < numarMuchii; ++i) {
        int nod1, nod2;
        cin >> nod1 >> nod2;
        graf[nod1].push_back(nod2); // Adăugăm muchia (nod1, nod2)
        gradIn[nod2]++; // Incrementăm gradul de intrare al nodului nod2
    }
}

// Funcție pentru sortarea topologică folosind algoritmul Kahn (BFS)
bool sortareTopologica(const vector<vector<int>>& graf, int numarNoduri) {
    // Adăugăm în coadă toate nodurile cu gradul de intrare 0
    for (int i = 1; i <= numarNoduri; ++i) {
        if (gradIn[i] == 0) {
            coada.push(i);
        }
    }

    int contor = 0; // Contor pentru numărul de noduri procesate
    while (!coada.empty()) {
        int nodCurent = coada.front(); // Extragem nodul din fața cozii
        coada.pop();
        rezultat.push_back(nodCurent); // Adăugăm nodul la rezultatul sortării
        contor++;

        // Reducem gradul de intrare pentru toți vecinii nodului curent
        for (int vecin : graf[nodCurent]) {
            gradIn[vecin]--;
            if (gradIn[vecin] == 0) {
                coada.push(vecin); // Adăugăm vecinul în coadă dacă gradul de intrare devine 0
            }
        }
    }

    // Verificăm dacă am procesat toate nodurile
    return (contor == numarNoduri);
}

int main() {
    cout << "Introduceti numarul de noduri si numarul de muchii: ";
    cin >> numarNoduri >> numarMuchii;

    cout << "Introduceti muchiile (cate doua numere pentru fiecare muchie):" << endl;
    citireGraf(numarNoduri, numarMuchii, graf);

    // Verificăm dacă sortarea topologică este posibilă
    if (!sortareTopologica(graf, numarNoduri)) {
        cout << "IMPOSSIBLE" << endl; // Afișăm "IMPOSSIBLE" dacă graful are cicluri
    } else {
        cout << "Sortarea topologica a grafului este: ";
        for (int nod : rezultat) {
            cout << nod << " "; // Afișăm nodurile în ordinea sortării topologice
        }
        cout << endl;
    }

    return 0;
}