#include <iostream>
#include <vector>
#include <set>
#include <limits>
#include <algorithm>

using namespace std;

// Constanta pentru a reprezenta infinitul
const int INF = 1000000000;

// Reprezentare graf prin lista de adiacenta
// Pentru fiecare nod retinem perechi (destinatie, costMuchie)
vector<vector<pair<int, int>>> Adj;

/*
  Algoritmul lui Dijkstra pentru aflarea celor mai scurte distante
  de la un nod sursa S la toate celelalte noduri.
*/
void Dijkstra(int Start, vector<int> &Distante, vector<int> &Predecesori)
{
    int N = Adj.size() - 1;
    Distante.assign(N + 1, INF);
    Predecesori.assign(N + 1, -1);

    // Distanta pana la start este 0
    Distante[Start] = 0;

    // Folosim un set pentru a prelua mereu nodul cu distanta minima nesolutionat
    set<pair<int, int>> Q;
    Q.insert({0, Start});

    // Cat timp mai exista noduri de procesat in set
    while(!Q.empty())
    {
        // Extragem nodul cu distanta minima
        int V = Q.begin()->second;
        Q.erase(Q.begin());

        // Verificam muchiile care pleaca din V
        for(auto &Edge : Adj[V])
        {
            int To = Edge.first;
            int Cost = Edge.second;

            // Daca am gasit o distanta mai buna, o actualizam
            if(Distante[V] + Cost < Distante[To])
            {
                // Stergem vechea pereche din set, daca exista
                auto It = Q.find({Distante[To], To});
                if(It != Q.end())
                {
                    Q.erase(It);
                }

                // Actualizam distanta si predecesorul
                Distante[To] = Distante[V] + Cost;
                Predecesori[To] = V;

                // Inseram noua distanta in set
                Q.insert({Distante[To], To});
            }
        }
    }
}

int main()
{
    // Citim daca graful este orientat sau neorientat
    cout << "Este graful orientat? (1 - Da, 0 - Nu): " << endl;
    bool Oriented;
    cin >> Oriented;

    // Citim numarul de noduri si numarul de muchii
    cout << "Introduceti numarul de noduri si numarul de muchii: " << endl;
    int N, M;
    cin >> N >> M;

    // Citim nodul de start
    cout << "Introduceti nodul de start: " << endl;
    int Start;
    cin >> Start;

    // Redimensionam lista de adiacenta
    Adj.resize(N + 1);

    // Citim muchiile si construim graful
    // Daca graful este neorientat, adaugam si inserarea inversa
    cout << "Introduceti muchiile: (u, v, cost)" << endl;
    for(int i = 0; i < M; i++)
    {
        int U, V, Cost;
        cin >> U >> V >> Cost;
        Adj[U].push_back({V, Cost});
        if(!Oriented)
        {
            Adj[V].push_back({U, Cost});
        }
    }

    // Declaram vectorii pentru distante si predecesori
    vector<int> Distante;
    vector<int> Predecesori;

    // Apelam Dijkstra
    Dijkstra(Start, Distante, Predecesori);

    // Afisam distantele si drumurile minimale
    for(int i = 1; i <= N; i++)
    {
        cout << "Distanta de la " << Start << " la " << i << " este: ";
        if(Distante[i] == INF)
        {
            cout << "INF\n";
            cout << "Nu exista drum de la " << Start << " la " << i << ".\n";
        }
        else
        {
            cout << Distante[i] << "\n";
            // Reconstruim drumul minim
            vector<int> Path;
            int Cur = i;
            while(Cur != -1)
            {
                Path.push_back(Cur);
                Cur = Predecesori[Cur];
            }
            reverse(Path.begin(), Path.end());

            cout << "Drumul minim este: ";
            for(int Nod : Path)
            {
                cout << Nod << " ";
            }
            cout << "\n";
        }
    }

    return 0;
}