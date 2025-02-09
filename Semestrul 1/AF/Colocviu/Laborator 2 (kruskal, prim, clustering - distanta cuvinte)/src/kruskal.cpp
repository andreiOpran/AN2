#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

// Structura pentru o muchie
struct Muchie 
{
    int nod1, nod2, cost;
};

// Comparator pentru sortarea muchiilor dupa cost
bool ComparatorMuchii(Muchie a, Muchie b) 
{
    return a.cost < b.cost;
}

// Gaseste radacina setului din care face parte nodul
int GasesteSet(vector<int>& parinte, int nod) 
{
    if (parinte[nod] != nod) 
    {
        parinte[nod] = GasesteSet(parinte, parinte[nod]);
    }
    return parinte[nod];
}

// Uneste doua seturi
void UnesteSeturi(vector<int>& parinte, vector<int>& rang, int set1, int set2) 
{
    int radacina1 = GasesteSet(parinte, set1);
    int radacina2 = GasesteSet(parinte, set2);

    if (rang[radacina1] < rang[radacina2]) 
    {
        parinte[radacina1] = radacina2;
    } 
    else if (rang[radacina1] > rang[radacina2]) 
    {
        parinte[radacina2] = radacina1;
    } 
    else 
    {
        parinte[radacina2] = radacina1;
        rang[radacina1]++;
    }
}

// Algoritmul lui Kruskal
vector<Muchie> Kruskal(int numarNoduri, vector<Muchie>& muchii) 
{
    // Sortam muchiile dupa cost
    sort(muchii.begin(), muchii.end(), ComparatorMuchii);

    // Initializam parintele si rangul pentru fiecare nod
    vector<int> parinte(numarNoduri + 1);
    vector<int> rang(numarNoduri + 1, 0);

    // Setam fiecare nod ca propriul sau parinte (initializare pentru union-find)
    for (int i = 1; i <= numarNoduri; i++) 
    {
        parinte[i] = i;
    }

    vector<Muchie> rezultat;
    // Iteram prin toate muchiile sortate
    for (auto& muchie : muchii) 
    {
        int set1 = GasesteSet(parinte, muchie.nod1);
        int set2 = GasesteSet(parinte, muchie.nod2);

        // Daca nodurile nu sunt in acelasi set, adaugam muchia la rezultat si unim seturile
        if (set1 != set2) 
        {
            rezultat.push_back(muchie);
            UnesteSeturi(parinte, rang, set1, set2);
        }
    }

    return rezultat;
}

int main() 
{
    int numarNoduri, numarMuchii;
    cout << "Introduceti numarul de noduri si numarul de muchii: ";
    cin >> numarNoduri >> numarMuchii;

    vector<Muchie> muchii(numarMuchii);
    cout << "Introduceti muchiile (nod1 nod2 cost):" << endl;
    // Citim muchiile de la utilizator
    for (int i = 0; i < numarMuchii; i++) 
    {
        cin >> muchii[i].nod1 >> muchii[i].nod2 >> muchii[i].cost;
    }

    // Apelam algoritmul lui Kruskal pentru a gasi arborele partial de cost minim
    vector<Muchie> rezultat = Kruskal(numarNoduri, muchii);

    // Afisam muchiile din arborele partial de cost minim
    cout << "Muchiile din arborele partial de cost minim sunt:" << endl;
    for (auto& muchie : rezultat) 
    {
        cout << muchie.nod1 << " - " << muchie.nod2 << " : " << muchie.cost << endl;
    }

    return 0;
}