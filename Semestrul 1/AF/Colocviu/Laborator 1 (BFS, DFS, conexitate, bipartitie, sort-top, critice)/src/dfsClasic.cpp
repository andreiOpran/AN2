#include <iostream>
#include <vector>

using namespace std;

int numarNoduri, numarMuchii;
bool esteOrientat;
vector<vector<int>> graf;
vector<int> culoare;
vector<int> timpIntrare, timpIesire;
vector<int> parinte;
int dfsTimer = 0;

// Functie pentru citirea grafului
// Citim numarul de noduri si muchii, apoi citim fiecare muchie si o adaugam in lista de adiacenta
void citireGraf(int numarNoduri, int numarMuchii, vector<vector<int>>& graf, bool esteOrientat) {
    graf.resize(numarNoduri + 1); // Adjust for 1-based indexing

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

// Functie DFS pentru parcurgerea in adancime
// Parcurgem graful in adancime, setam timpii de intrare si iesire si parintii nodurilor
void dfs(int nodCurent) {
    timpIntrare[nodCurent] = dfsTimer++;
    culoare[nodCurent] = 1; // Nodul este in curs de vizitare
    for (int vecin : graf[nodCurent]) {
        if (culoare[vecin] == 0) { // Daca vecinul nu a fost vizitat
            parinte[vecin] = nodCurent; // Setam parintele vecinului
            dfs(vecin);
        }
    }
    culoare[nodCurent] = 2; // Nodul a fost vizitat complet
    timpIesire[nodCurent] = dfsTimer++;
}

int main() {
    cout << "Introduceti numarul de noduri: ";
    cin >> numarNoduri;
    cout << "Introduceti numarul de muchii: ";
    cin >> numarMuchii;

    cout << "Graful este orientat? (1 pentru Da, 0 pentru Nu): ";
    cin >> esteOrientat;

    citireGraf(numarNoduri, numarMuchii, graf, esteOrientat);

    // Initializam vectorii pentru DFS
    culoare.assign(numarNoduri + 1, 0); // 0 - nevizitat, 1 - in curs de vizitare, 2 - vizitat complet
    timpIntrare.assign(numarNoduri + 1, -1); // Timpul de intrare in DFS
    timpIesire.assign(numarNoduri + 1, -1); // Timpul de iesire din DFS
    parinte.assign(numarNoduri + 1, -1); // Parintele fiecarui nod in arborele DFS

    // Parcurgem fiecare nod si aplicam DFS daca nodul nu a fost vizitat
    for (int i = 1; i <= numarNoduri; ++i) { // Adjust for 1-based indexing
        if (culoare[i] == 0) {
            dfs(i);
        }
    }

    // Afisam timpii de intrare si iesire pentru fiecare nod
    cout << "Timpii de intrare si iesire pentru fiecare nod sunt:" << endl;
    for (int i = 1; i <= numarNoduri; ++i) { // Adjust for 1-based indexing
        cout << "Nodul " << i << ": intrare = " << timpIntrare[i] << ", iesire = " << timpIesire[i] << endl;
    }

    // Afisam arborele DFS (parintii nodurilor)
    cout << "Arborele DFS (parintii nodurilor) este:" << endl;
    for (int i = 1; i <= numarNoduri; ++i) { // Adjust for 1-based indexing
        if (parinte[i] != -1) {
            cout << "Nodul " << i << " are parintele " << parinte[i] << endl;
        } else {
            cout << "Nodul " << i << " este radacina" << endl;
        }
    }

    return 0;
}