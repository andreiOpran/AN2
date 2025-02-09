#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int numarNoduri, numarMuchii;
vector<vector<int>> graf;
vector<bool> vizitat;
vector<int> timpIntrare, low;
int timer;
vector<bool> estePunctArticulatie;

// Functie pentru citirea grafului
void citireGraf(int numarNoduri, int numarMuchii, vector<vector<int>>& graf, bool esteOrientat) {
    graf.resize(numarNoduri + 1); // Numerotarea incepe de la 1, deci avem nevoie de un nod suplimentar

    cout << "Introduceti muchiile (cate doua numere pentru fiecare muchie):" << endl;
    for (int i = 0; i < numarMuchii; ++i) {
        int nod1, nod2;
        cin >> nod1 >> nod2;
        graf[nod1].push_back(nod2); // Adaugam muchia (nod1, nod2)
        if (!esteOrientat) {
            graf[nod2].push_back(nod1); // Adaugam muchia inversa pentru graf neorientat
        }
    }
}

// Functie DFS pentru a gasi punctele de articulatie
void dfs(int nodCurent, int parinte = -1) {
    vizitat[nodCurent] = true;
    timpIntrare[nodCurent] = low[nodCurent] = timer++;
    int copii = 0;
    for (int vecin : graf[nodCurent]) {
        if (vecin == parinte) continue; // Ignoram muchia inapoi catre parinte
        if (vizitat[vecin]) {
            // Nodul vecin a fost deja vizitat, actualizam valoarea low
            low[nodCurent] = min(low[nodCurent], timpIntrare[vecin]);
        } else {
            // Nodul vecin nu a fost vizitat, continuam DFS
            dfs(vecin, nodCurent);
            low[nodCurent] = min(low[nodCurent], low[vecin]);
            if (low[vecin] >= timpIntrare[nodCurent] && parinte != -1)
                estePunctArticulatie[nodCurent] = true;
            ++copii;
        }
    }
    if (parinte == -1 && copii > 1)
        estePunctArticulatie[nodCurent] = true;
}

// Functie pentru a gasi toate punctele de articulatie din graf
void gasestePuncteArticulatie() {
    timer = 0;
    vizitat.assign(numarNoduri + 1, false); // Numerotarea incepe de la 1
    timpIntrare.assign(numarNoduri + 1, -1);
    low.assign(numarNoduri + 1, -1);
    estePunctArticulatie.assign(numarNoduri + 1, false);
    for (int i = 1; i <= numarNoduri; ++i) {
        if (!vizitat[i])
            dfs(i);
    }
}

int main() {
    cout << "Introduceti numarul de noduri si numarul de muchii: ";
    cin >> numarNoduri >> numarMuchii;

    char orientat;
    cout << "Graful este orientat? (y/n): ";
    cin >> orientat;
    bool esteOrientat = (orientat == 'y' || orientat == 'Y');

    citireGraf(numarNoduri, numarMuchii, graf, esteOrientat);

    gasestePuncteArticulatie();

    cout << "Punctele de articulatie ale grafului sunt:" << endl;
    for (int i = 1; i <= numarNoduri; ++i) {
        if (estePunctArticulatie[i])
            cout << i << " "; // Afisam nodurile de la 1 la numarNoduri
    }
    cout << endl;

    return 0;
}