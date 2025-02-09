#include <iostream>
#include <vector>
#include <queue>

using namespace std;

// Declarații globale pentru numărul de noduri, nodul sursă și dacă graful este orientat
int numarNoduri, nodSursa;
bool esteOrientat;

// Declarații globale pentru graf, vectorul de vizitare, distanțe și părinți
vector<vector<int>> graf;
vector<bool> vizitat;
vector<int> distanta, parinte;

// Funcție pentru citirea grafului de la utilizator
void citireGraf(int numarNoduri, vector<vector<int>>& graf, bool esteOrientat) {
    cout << "Introduceti muchiile (cate doua numere pentru fiecare muchie, terminati cu -1 -1):" << endl;
    while (true) {
        int nod1, nod2;
        cin >> nod1 >> nod2;
        if (nod1 == -1 && nod2 == -1) break;
        graf[nod1].push_back(nod2);
        if (!esteOrientat) {
            graf[nod2].push_back(nod1);
        }
    }
}

// Funcție BFS pentru parcurgerea în lățime a grafului
void bfs(int nodSursa) {
    queue<int> coada;
    coada.push(nodSursa);
    vizitat[nodSursa] = true;
    parinte[nodSursa] = -1;
    while (!coada.empty()) {
        int nodCurent = coada.front();
        coada.pop();
        for (int vecin : graf[nodCurent]) {
            if (!vizitat[vecin]) {
                vizitat[vecin] = true;
                coada.push(vecin);
                distanta[vecin] = distanta[nodCurent] + 1;
                parinte[vecin] = nodCurent;
            }
        }
    }
}

int main() {
    // Citirea numărului de noduri și a nodului sursă de la utilizator
    cout << "Introduceti numarul de noduri: ";
    cin >> numarNoduri;
    cout << "Introduceti nodul sursa: ";
    cin >> nodSursa;

    // Citirea dacă graful este orientat sau nu
    cout << "Graful este orientat? (1 pentru Da, 0 pentru Nu): ";
    cin >> esteOrientat;

    // Redimensionarea și inițializarea vectorilor globali
    graf.resize(numarNoduri + 1);
    vizitat.assign(numarNoduri + 1, false);
    distanta.assign(numarNoduri + 1, 0);
    parinte.assign(numarNoduri + 1, -1);

    // Citirea grafului de la utilizator
    citireGraf(numarNoduri, graf, esteOrientat);

    // Apelarea funcției BFS pentru parcurgerea grafului
    bfs(nodSursa);

    // Afișarea distanțelor de la nodul sursă la toate celelalte noduri
    cout << "Distantele de la nodul sursa sunt:" << endl;
    for (int i = 1; i <= numarNoduri; ++i) {
        cout << "Nodul " << i << ": " << distanta[i] << endl;
    }

    // Afișarea părinților fiecărui nod
    cout << "Parintii nodurilor sunt:" << endl;
    for (int i = 1; i <= numarNoduri; ++i) {
        cout << "Nodul " << i << ": " << parinte[i] << endl;
    }

    return 0;
}