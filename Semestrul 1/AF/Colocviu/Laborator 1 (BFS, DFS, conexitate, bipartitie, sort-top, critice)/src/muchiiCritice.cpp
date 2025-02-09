#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int numarNoduri, numarMuchii;
vector<int> parinte, dsu2ecc, dsuCc, dsuCcSize;
int numarPoduri;
int lcaIteratie;
vector<int> ultimaVizita;

// Functie pentru initializarea structurilor de date
void initializeaza(int n) {
    parinte.resize(n + 1); // +1 pentru a incepe de la 1
    dsu2ecc.resize(n + 1); // +1 pentru a incepe de la 1
    dsuCc.resize(n + 1);   // +1 pentru a incepe de la 1
    dsuCcSize.resize(n + 1); // +1 pentru a incepe de la 1
    lcaIteratie = 0;
    ultimaVizita.assign(n + 1, 0); // +1 pentru a incepe de la 1
    for (int i = 1; i <= n; ++i) {
        dsu2ecc[i] = i;
        dsuCc[i] = i;
        dsuCcSize[i] = 1;
        parinte[i] = -1;
    }
    numarPoduri = 0;
}

// Functie pentru gasirea reprezentantului componentei tare conexe
int gaseste2ecc(int v) {
    if (v == -1)
        return -1;
    return dsu2ecc[v] == v ? v : dsu2ecc[v] = gaseste2ecc(dsu2ecc[v]);
}

// Functie pentru gasirea reprezentantului componentei conexe
int gasesteCc(int v) {
    v = gaseste2ecc(v);
    return dsuCc[v] == v ? v : dsuCc[v] = gasesteCc(dsuCc[v]);
}

// Functie pentru a transforma un nod in radacina arborelui DFS
void faRadacina(int v) {
    int radacina = v;
    int copil = -1;
    while (v != -1) {
        int p = gaseste2ecc(parinte[v]);
        parinte[v] = copil;
        dsuCc[v] = radacina;
        copil = v;
        v = p;
    }
    dsuCcSize[radacina] = dsuCcSize[copil];
}

// Functie pentru a fuziona drumurile de la doua noduri pana la cel mai mic stramos comun (LCA)
void fuzioneazaDrum(int a, int b) {
    ++lcaIteratie;
    vector<int> drumA, drumB;
    int lca = -1;
    while (lca == -1) {
        if (a != -1) {
            a = gaseste2ecc(a);
            drumA.push_back(a);
            if (ultimaVizita[a] == lcaIteratie) {
                lca = a;
                break;
            }
            ultimaVizita[a] = lcaIteratie;
            a = parinte[a];
        }
        if (b != -1) {
            b = gaseste2ecc(b);
            drumB.push_back(b);
            if (ultimaVizita[b] == lcaIteratie) {
                lca = b;
                break;
            }
            ultimaVizita[b] = lcaIteratie;
            b = parinte[b];
        }
    }

    for (int v : drumA) {
        dsu2ecc[v] = lca;
        if (v == lca)
            break;
        --numarPoduri;
    }
    for (int v : drumB) {
        dsu2ecc[v] = lca;
        if (v == lca)
            break;
        --numarPoduri;
    }
}

// Functie pentru a adauga o muchie intre doua noduri
void adaugaMuchie(int a, int b) {
    a = gaseste2ecc(a);
    b = gaseste2ecc(b);
    if (a == b)
        return;

    int ca = gasesteCc(a);
    int cb = gasesteCc(b);

    if (ca != cb) {
        ++numarPoduri;
        if (dsuCcSize[ca] > dsuCcSize[cb]) {
            swap(a, b);
            swap(ca, cb);
        }
        faRadacina(a);
        parinte[a] = dsuCc[a] = b;
        dsuCcSize[cb] += dsuCcSize[a];
    } else {
        fuzioneazaDrum(a, b);
    }
}

int main() {
    cout << "Introduceti numarul de noduri si numarul de muchii: ";
    cin >> numarNoduri >> numarMuchii;

    initializeaza(numarNoduri);

    cout << "Introduceti muchiile (cate doua numere pentru fiecare muchie):" << endl;
    for (int i = 0; i < numarMuchii; ++i) {
        int nod1, nod2;
        cin >> nod1 >> nod2;
        adaugaMuchie(nod1, nod2); // Nodurile sunt deja numerotate de la 1
    }

    cout << "Numarul de poduri (muchii critice) este: " << numarPoduri << endl;

    return 0;
}