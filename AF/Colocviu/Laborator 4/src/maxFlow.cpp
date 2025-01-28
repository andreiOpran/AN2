// Maximum flow - Ford-Fulkerson si Edmonds-Karp 
// CORECT

/*

Este graful orientat? (1 - Da, 0 - Nu): 
1
Introdu numarul de noduri si muchii: 
6 9
Introdu nodurile si capacitatea pentru muchia 1: 
1 2 7
Introdu nodurile si capacitatea pentru muchia 2: 
1 5 4
Introdu nodurile si capacitatea pentru muchia 3: 
2 3 5
Introdu nodurile si capacitatea pentru muchia 4: 
2 4 3
Introdu nodurile si capacitatea pentru muchia 5: 
3 6 8
Introdu nodurile si capacitatea pentru muchia 6: 
4 3 1
Introdu nodurile si capacitatea pentru muchia 7: 
4 6 5
Introdu nodurile si capacitatea pentru muchia 8: 
5 2 3
Introdu nodurile si capacitatea pentru muchia 9: 
5 4 2
Introdu sursa: 
1
Introdu destinatia: 
6
Fluxul maxim este: 10

*/

#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>
#include <iomanip>
using namespace std;

const int INF = 1e9;

// Declararea variabilelor globale
int N;
vector<vector<int>> Capacity;
vector<vector<int>> Adj;

// Functia BFS pentru a gasi un lant de augmentare
int BFS(int S, int T, vector<int>& Parent) 
{
    fill(Parent.begin(), Parent.end(), -1);
    Parent[S] = -2;
    queue<pair<int, int>> Q;
    Q.push({S, INF});

    while (!Q.empty()) 
    {
        int Current = Q.front().first;
        int Flow = Q.front().second;
        Q.pop();

        for (int Next : Adj[Current]) 
        {
            if (Parent[Next] == -1 && Capacity[Current][Next] > 0) 
            {
                Parent[Next] = Current;
                int NewFlow = min(Flow, Capacity[Current][Next]);
                if (Next == T)
                    return NewFlow;
                Q.push({Next, NewFlow});
            }
        }
    }

    return 0;
}

// Functia pentru a calcula fluxul maxim folosind algoritmul Ford-Fulkerson cu BFS
int MaxFlow(int S, int T) 
{
    int Flow = 0;
    vector<int> Parent(N + 1);
    int NewFlow;

    while (NewFlow = BFS(S, T, Parent)) 
    {
        Flow += NewFlow;
        int Current = T;
        while (Current != S) 
        {
            int Previous = Parent[Current];
            Capacity[Previous][Current] -= NewFlow;
            Capacity[Current][Previous] += NewFlow;
            Current = Previous;
        }
    }

    return Flow;
}

// Functia main minimal
int main()
{
    // Intreaba daca graful este orientat
    cout << "Este graful orientat? (1 - Da, 0 - Nu): " << endl;
    int IsDirected;
    cin >> IsDirected;

    // Citeste numarul de noduri si muchii
    cout << "Introdu numarul de noduri si muchii: " << endl;
    int M;
    cin >> N >> M;

    Capacity.assign(N + 1, vector<int>(N + 1, 0));
    Adj.assign(N + 1, vector<int>());

    // Citeste fiecare muchie si capacitatea ei
    for(int i = 1; i <= M; ++i)
    {
        cout << "Introdu nodurile si capacitatea pentru muchia " << i << ": " << endl;
        int U, V, Cap;
        cin >> U >> V >> Cap;
        Capacity[U][V] = Cap;
        Adj[U].push_back(V);
        if(!IsDirected)
        {
            Capacity[V][U] = Cap;
            Adj[V].push_back(U);
        }
    }

    // Citeste sursa si destinatia
    int S, T;
    cout << "Introdu sursa: " << endl;
    cin >> S;
    cout << "Introdu destinatia: " << endl;
    cin >> T;

    // Calculeaza fluxul maxim si afiseaza rezultatul
    cout << "Fluxul maxim este: " << MaxFlow(S, T) << endl;
    
    return 0;
}