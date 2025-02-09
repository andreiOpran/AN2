#include <iostream>
#include <vector>
#include <algorithm>
#include <iomanip> // Pentru setarea lățimii câmpurilor

using namespace std;

// Constanta pentru a reprezenta infinitul
const int INF = 1000000000;

/*
  Functie pentru a initializa matricea de distante si matricea de urmatorii noduri
*/
void InitializeMatrices(int N, vector<vector<int>> &Distante, vector<vector<int>> &Urmatorii)
{
    Distante.assign(N + 1, vector<int>(N + 1, INF));
    Urmatorii.assign(N + 1, vector<int>(N + 1, -1));

    for(int i = 1; i <= N; i++)
    {
        Distante[i][i] = 0;
        Urmatorii[i][i] = i;
    }
}

/*
  Functie pentru a citi muchiile grafului
  Daca graful este neorientat, adauga muchia in ambele directii
*/
void CitesteMuchii(int M, bool Oriented, vector<vector<int>> &Distante, vector<vector<int>> &Urmatorii)
{
    cout << "Introduceti muchiile (u, v, cost):" << endl;
    for(int i = 0; i < M; i++)
    {
        int u, v, cost;
        cin >> u >> v >> cost;
        // Actualizam daca este mai mic costul gasit
        if(cost < Distante[u][v])
        {
            Distante[u][v] = cost;
            Urmatorii[u][v] = v;
        }
        if(!Oriented)
        {
            if(cost < Distante[v][u])
            {
                Distante[v][u] = cost;
                Urmatorii[v][u] = u;
            }
        }
    }
}

/*
  Algoritmul Floyd-Warshall pentru determinarea distantelor minime
  si detectarea circuitelor negative
*/
bool FloydWarshall(int N, vector<vector<int>> &Distante, vector<vector<int>> &Urmatorii)
{
    for(int k = 1; k <= N; k++)
    {
        for(int i = 1; i <= N; i++)
        {
            for(int j = 1; j <= N; j++)
            {
                if(Distante[i][k] < INF && Distante[k][j] < INF && Distante[i][k] + Distante[k][j] < Distante[i][j])
                {
                    Distante[i][j] = Distante[i][k] + Distante[k][j];
                    Urmatorii[i][j] = Urmatorii[i][k];
                }
            }
        }
    }

    // Verificam daca exista circuite negative
    for(int i = 1; i <= N; i++)
    {
        if(Distante[i][i] < 0)
        {
            return true; // Exista un circuit de cost negativ
        }
    }
    return false; // Nu exista circuite negative
}

/*
  Functie pentru a reconstrui si afisa un circuit negativ
*/
void AfiseazaCircuitNegativ(int N, const vector<vector<int>> &Urmatorii, const vector<vector<int>> &Distante)
{
    // Gaseste primul nod care face parte intr-un circuit negativ
    int nod = -1;
    for(int i = 1; i <= N; i++)
    {
        if(Distante[i][i] < 0)
        {
            nod = i;
            break;
        }
    }

    if(nod == -1)
    {
        cout << "Nu a fost gasit niciun circuit negativ." << endl;
        return;
    }

    // Reconstruim circuitul care include nodul 'nod'
    // Pentru a evita buclele infinite, folosim un vector de vizitare
    vector<bool> vizitat(N + 1, false);
    vector<int> circuit;
    int current = nod;

    while(!vizitat[current])
    {
        vizitat[current] = true;
        circuit.push_back(current);
        current = Urmatorii[current][nod];
        if(current == -1)
            break; // Nu se poate reconstrui circuitul
    }

    // Daca current este din nou nodul initial, avem un circuit
    if(current == nod)
    {
        // Gasim pozitia in circuit unde se repeta nodul
        auto it = find(circuit.begin(), circuit.end(), nod);
        if(it != circuit.end())
        {
            vector<int> ciclu(it, circuit.end());
            cout << "Un circuit negativ este: ";
            for(auto &n : ciclu)
            {
                cout << n << " ";
            }
            cout << nod << endl; // Pentru a incheia circuitul
        }
        else
        {
            cout << "Graful contine circuite negative, dar nu s-a putut reconstrui unul." << endl;
        }
    }
    else
    {
        cout << "Graful contine circuite negative, dar nu s-a putut reconstrui unul." << endl;
    }
}

/*
  Functie pentru a afisa matricea de distante
  Modificata pentru aliniere corespunzatoare a valorilor
*/
void AfiseazaMatriceaDistante(int N, const vector<vector<int>> &Distante)
{
    cout << "Matricea distantelor minime:\n    ";
    // Afișăm antetul coloanelor
    for(int j = 1; j <= N; j++)
    {
        cout << setw(6) << j;
    }
    cout << endl;

    for(int i = 1; i <= N; i++)
    {
        cout << setw(4) << i << " ";
        for(int j = 1; j <= N; j++)
        {
            if(Distante[i][j] == INF)
                cout << setw(6) << "INF";
            else
                cout << setw(6) << Distante[i][j];
        }
        cout << endl;
    }
}

int main()
{
    int N, M;
    bool Oriented;

    // Intrebam daca graful este orientat sau nu
    cout << "Este graful orientat? (1 - Da, 0 - Nu): ";
    cin >> Oriented;

    // Citim numarul de noduri si numarul de muchii
    cout << "Introduceti numarul de noduri si numarul de muchii: ";
    cin >> N >> M;

    vector<vector<int>> Distante;
    vector<vector<int>> Urmatorii;

    InitializeMatrices(N, Distante, Urmatorii);
    CitesteMuchii(M, Oriented, Distante, Urmatorii);

    bool existaCircuitNegativ = FloydWarshall(N, Distante, Urmatorii);

    if(existaCircuitNegativ)
    {
        AfiseazaCircuitNegativ(N, Urmatorii, Distante);
    }
    else
    {
        AfiseazaMatriceaDistante(N, Distante);
    }

    return 0;
}