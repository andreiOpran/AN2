#include <iostream>
#include <vector>
#include <algorithm>
#include <limits>
#include <sstream>

using namespace std;

// Constanta pentru a reprezenta infinitul
const int INF = 1000000000;

/*
  Structura pentru a retine o muchie:
  A = nod sursa
  B = nod destinatie
  Cost = ponderea muchiei
*/
struct Edge
{
    int A;
    int B;
    int Cost;
};

/*
  Functie care reconstruieste drumul de la nodul start la nodul cur
  folosind vectorul de predecesori.
*/
vector<int> ReconstructPath(int Cur, const vector<int> &Predecessors)
{
    vector<int> Path;
    while(Cur != -1)
    {
        Path.push_back(Cur);
        Cur = Predecessors[Cur];
    }
    reverse(Path.begin(), Path.end());
    return Path;
}

/*
  Functie care ruleaza algoritmul Bellman-Ford.
  Distantele minime de la nodul start la toate nodurile sunt retinute in D,
  iar in P retinem predecesorii pentru a reconstrui drumurile.
*/
void BellmanFord(int N, int Start, const vector<Edge> &Edges, vector<int> &D, vector<int> &P)
{
    // Initializam distantele cu INF si predecesorii cu -1
    D.assign(N + 1, INF);
    P.assign(N + 1, -1);

    // Distanta pana la start este 0
    D[Start] = 0;

    // Relaxam fiecare muchie N-1 ori
    for(int i = 1; i <= N - 1; i++)
    {
        bool AnyUpdate = false;
        for(const auto &E : Edges)
        {
            if(D[E.A] < INF)
            {
                if(D[E.B] > D[E.A] + E.Cost)
                {
                    D[E.B] = D[E.A] + E.Cost;
                    P[E.B] = E.A;
                    AnyUpdate = true;
                }
            }
        }
        // Daca intr-o iteratie nu s-a mai imbunatatit nimic, oprim
        if(!AnyUpdate)
        {
            break;
        }
    }

    // Verificam pentru cicluri negative
    for(const auto &E : Edges)
    {
        if(D[E.A] < INF && D[E.B] > D[E.A] + E.Cost)
        {
            cout << "Graful contine cicluri negative.\n";
            return;
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

    // Citim muchiile
    cout << "Introduceti muchiile: (A, B, Cost)" << endl;
    vector<Edge> Edges;
    Edges.reserve(Oriented ? M : 2 * M);
    for(int i = 0; i < M; i++)
    {
        int A, B, Cost;
        cin >> A >> B >> Cost;
        Edges.push_back({A, B, Cost});
        if(!Oriented)
        {
            Edges.push_back({B, A, Cost});
        }
    }

    // Declaram vectorii pentru distante si predecesori
    vector<int> Distante;
    vector<int> Predecesori;

    // Apelam Bellman-Ford
    BellmanFord(N, Start, Edges, Distante, Predecesori);

    // Afisam distantele si drumurile minimale
    for(int i = 1; i <= N; i++)
    {
        if(Distante[i] == INF)
        {
            cout << "Distanta de la " << Start << " la " << i << " este: INF\n";
            cout << "Nu exista drum de la " << Start << " la " << i << ".\n";
        }
        else
        {
            cout << "Distanta de la " << Start << " la " << i << " este: " << Distante[i] << "\n";
            vector<int> Path = ReconstructPath(i, Predecesori);
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