#include <bits/stdc++.h>
using namespace std;

class Graf
{
public:
    // nested class for weighted edges
    class muchieCost
    {
    public:
        int x, y;
        int cost;
        muchieCost() : x(0), y(0), cost(0) {}
        muchieCost(int xx, int yy, int cc) : x(xx), y(yy), cost(cc) {}
        muchieCost(const muchieCost &m) : x(m.x), y(m.y), cost(m.cost) {}
        ~muchieCost() {}
        friend ostream &operator<<(ostream &os, const muchieCost &m)
        {
            os << "(" << m.x << ", " << m.y << ", cost " << m.cost << ")";
            return os;
        }
    };

    int n, m;      // number of nodes and edges
    bool orientat; // false => undirected, true => directed

    // three ways to store a graph:
    vector<vector<int>> matrice;        // adjacency matrix
    vector<vector<int>> listaAdiacenta; // adjacency list
    vector<pair<int, int>> listaMuchii; // edge list

    // utility vectors
    vector<int> grad;       // for degrees
    vector<int> vizitat;    // visited array
    vector<int> tati;       // parents
    vector<int> distanta;   // distances
    vector<int> descoperit; // discovery time
    vector<int> finalizat;  // finishing time

    Graf() : n(0), m(0), orientat(false) {}
    Graf(int nn, int mm) : n(nn), m(mm), orientat(false) {}
    Graf(int nn, int mm, bool orint) : n(nn), m(mm), orientat(orint) {}
    Graf(const Graf &g) : n(g.n), m(g.m), orientat(g.orientat) {}

    // big destructor clearing everything
    ~Graf()
    {
        matrice.clear();
        listaAdiacenta.clear();
        listaMuchii.clear();
        grad.clear();
        vizitat.clear();
        tati.clear();
        distanta.clear();
        descoperit.clear();
        finalizat.clear();
        matriceCost.clear();
        listaMuchiiCost.clear();
        solutieBFS.clear();
        solutieDFS.clear();
        muchiiIntoarcere.clear();
        muchiiTraversare.clear();
        muchiiAvansare.clear();
        componentaBipartitie.clear();
        gradIntern.clear();
        sortTopologica.clear();
        compTareConexe.clear();
        muchiileCritice.clear();
        nivel.clear();
        nivelMinim.clear();
        arborePartialCostMinim.clear();
        reprezentant.clear();
        distantaPrim.clear();
        tataPrim.clear();
        solutieDijkstra.clear();
        solutieBellmanFord.clear();
        matriceCostMinim.clear();
    }

    //--------------------------------------------------------------------------------
    // reading the graph from input in different ways

    // adjacency matrix
    void citireMatriceAdiacenta()
    {
        cin >> n >> m;
        matrice = vector<vector<int>>(n, vector<int>(n, 0));
        for (int i = 0; i < m; i++)
        {
            int x, y;
            cin >> x >> y;
            x--;
            y--;
            matrice[x][y] = 1;
            if (!orientat)
                matrice[y][x] = 1;
        }
    }

    // adjacency list
    void citireListaAdiacenta()
    {
        cin >> n >> m;
        listaAdiacenta = vector<vector<int>>(n);
        for (int i = 0; i < m; i++)
        {
            int x, y;
            cin >> x >> y;
            x--;
            y--;
            listaAdiacenta[x].push_back(y);
            if (!orientat)
                listaAdiacenta[y].push_back(x);
        }
    }

    // edge list
    void citireListaMuchii()
    {
        cin >> n >> m;
        for (int i = 0; i < m; i++)
        {
            int x, y;
            cin >> x >> y;
            x--;
            y--;
            listaMuchii.push_back({x, y});
        }
    }

    // reading with weights (costs)
    vector<vector<int>> matriceCost;                 // adjacency matrix with costs
    vector<muchieCost> listaMuchiiCost;              // edges with costs
    vector<list<pair<int, int>>> listaAdiacentaCost; // adjacency list with (cost, node)

    void citireMatriceAdiacentaCost()
    {
        cin >> n >> m;
        matriceCost = vector<vector<int>>(n, vector<int>(n, 0));
        for (int i = 0; i < m; i++)
        {
            int x, y, cost;
            cin >> x >> y >> cost;
            x--;
            y--;
            matriceCost[x][y] = cost;
            if (!orientat)
                matriceCost[y][x] = cost;
        }
    }

    void citireListaMuchiiCost()
    {
        cin >> n >> m;
        for (int i = 0; i < m; i++)
        {
            int x, y, cost;
            cin >> x >> y >> cost;
            x--;
            y--;
            listaMuchiiCost.push_back(muchieCost(x, y, cost));
        }
    }

    void citireListaAdiacentaCost()
    {
        cin >> n >> m;
        listaAdiacentaCost = vector<list<pair<int, int>>>(n);
        for (int i = 0; i < m; i++)
        {
            int x, y, cost;
            cin >> x >> y >> cost;
            x--;
            y--;
            listaAdiacentaCost[x].push_back({cost, y});
            if (!orientat)
                listaAdiacentaCost[y].push_back({cost, x});
        }
    }

    //--------------------------------------------------------------------------------
    // printing methods

    void afisareMatriceAdiacenta()
    {
        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
                cout << matrice[i][j] << " ";
            cout << "\n";
        }
    }

    void afisareListaAdiacenta()
    {
        for (int i = 0; i < n; i++)
        {
            cout << i + 1 << ": ";
            for (int j : listaAdiacenta[i])
                cout << j + 1 << " ";
            cout << "\n";
        }
    }

    void afisareListaMuchii()
    {
        for (int i = 0; i < m; i++)
            cout << listaMuchii[i].first + 1 << " " << listaMuchii[i].second + 1 << "\n";
    }

    void afisareMatriceAdiacentaCost()
    {
        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
                cout << matriceCost[i][j] << " ";
            cout << "\n";
        }
    }

    //--------------------------------------------------------------------------------
    // conversions between representations (examples)

    void convertesteMatriceLaListaAdiacenta()
    {
        listaAdiacenta = vector<vector<int>>(n);
        for (int i = 0; i < n; i++)
            for (int j = 0; j < n; j++)
                if (matrice[i][j] == 1)
                    listaAdiacenta[i].push_back(j);
    }

    void convertesteListaAdiacentaLaMatrice()
    {
        matrice = vector<vector<int>>(n, vector<int>(n, 0));
        for (int i = 0; i < n; i++)
            for (int j : listaAdiacenta[i])
                matrice[i][j] = 1;
    }

    // etc. for other conversions as needed ...
    //--------------------------------------------------------------------------------

    // BFS-related
    vector<int> solutieBFS; // order of BFS

    // standard BFS from adjacency matrix
    void matriceBFS(int start)
    {
        queue<int> Q;
        Q.push(start);
        vizitat[start] = 1;
        while (!Q.empty())
        {
            int nod = Q.front();
            Q.pop();
            solutieBFS.push_back(nod);
            for (int i = 0; i < n; i++)
            {
                if (matrice[nod][i] == 1 && !vizitat[i])
                {
                    vizitat[i] = 1;
                    tati[i] = nod;
                    Q.push(i);
                }
            }
        }
    }

    // BFS for shortest path from s to x (assuming adjacency matrix)
    // we store parents in tati[], distances in distanta[]
    void drumMinimBFS(int s, int x)
    {
        // we assume: distanta resized, vizitat resized, tati resized, etc. from outside
        queue<int> Q;
        Q.push(s);
        vizitat[s] = 1;
        distanta[s] = 0;
        tati[s] = -1;

        while (!Q.empty())
        {
            int nod = Q.front();
            Q.pop();

            for (int i = 0; i < n; i++)
            {
                if (matrice[nod][i] == 1 && !vizitat[i])
                {
                    vizitat[i] = 1;
                    tati[i] = nod;
                    distanta[i] = distanta[nod] + 1;
                    Q.push(i);
                }
            }
        }

        // if x not visited => no path
        if (!vizitat[x])
        {
            cout << "No path from " << s + 1 << " to " << x + 1 << "\n";
            return;
        }

        // reconstruct the path
        vector<int> drum;
        for (int cur = x; cur != -1; cur = tati[cur])
            drum.push_back(cur);
        reverse(drum.begin(), drum.end());

        cout << "Shortest path from " << s + 1 << " to " << x + 1 << ": ";
        for (int d : drum)
            cout << d + 1 << " ";
        cout << "\nDistance: " << distanta[x] << "\n";
    }

    //--------------------------------------------------------------------------------
    // DFS-related
    int timpDfs = 0;        // time counter for discovery/finishing
    vector<int> solutieDFS; // order of DFS

    void matriceDFS(int start)
    {
        vizitat[start] = 1;
        solutieDFS.push_back(start);

        for (int i = 0; i < n; i++)
        {
            if (matrice[start][i] == 1 && !vizitat[i])
            {
                tati[i] = start;
                matriceDFS(i);
            }
        }
    }

    // detect cycles with DFS
    vector<vector<int>> cicliDfs; // store all cycles if any
    void cicluDFSRecursiv(int nod, int parinte, vector<int> &cicluCurent)
    {
        vizitat[nod] = 1;
        cicluCurent.push_back(nod);

        for (int i = 0; i < n; i++)
        {
            if (matrice[nod][i] == 1 && !vizitat[i])
            {
                tati[i] = nod;
                cicluDFSRecursiv(i, nod, cicluCurent);
            }
            else if (matrice[nod][i] == 1 && i != parinte)
            {
                // found cycle
                vector<int> cycle;
                int nodCiclu = nod;
                cycle.push_back(nodCiclu);
                while (nodCiclu != i && nodCiclu != -1)
                {
                    nodCiclu = tati[nodCiclu];
                    cycle.push_back(nodCiclu);
                }
                if (nodCiclu == i)
                {
                    cicliDfs.push_back(cycle);
                    cout << "Ciclu: ";
                    for (auto c : cycle)
                        cout << c + 1 << " ";
                    cout << "\n";
                }
            }
        }
        cicluCurent.pop_back();
    }

    // edges classification in DFS (tree edges, back edges, etc.)
    vector<pair<int, int>> muchiiIntoarcere;
    vector<pair<int, int>> muchiiTraversare;
    vector<pair<int, int>> muchiiAvansare;

    void tipuriMuchiiDFS(int nod)
    {
        vizitat[nod] = 1;
        descoperit[nod] = timpDfs++;
        for (int i = 0; i < n; i++)
        {
            if (matrice[nod][i] == 1)
            {
                if (!vizitat[i])
                {
                    tati[i] = nod;
                    tipuriMuchiiDFS(i);
                }
                else if (i != tati[nod])
                {
                    // check discovered/finished times
                    if (descoperit[i] < descoperit[nod] && finalizat[i] == -1)
                    {
                        // back edge
                        muchiiIntoarcere.push_back({nod, i});
                        cout << "intoarcere: " << nod + 1 << " " << i + 1 << "\n";
                    }
                    else if (descoperit[nod] < descoperit[i] && finalizat[i] != -1)
                    {
                        // forward edge
                        muchiiAvansare.push_back({nod, i});
                        cout << "avansare: " << nod + 1 << " " << i + 1 << "\n";
                    }
                    else if (!orientat)
                    {
                        // possible cross edge
                        muchiiTraversare.push_back({nod, i});
                        cout << "traversare: " << nod + 1 << " " << i + 1 << "\n";
                    }
                }
            }
        }
        finalizat[nod] = timpDfs++;
    }

    //--------------------------------------------------------------------------------
    // bipartite check from adjacency list
    vector<int> componentaBipartitie; // 0 => uncolored, 1 => color1, 2 => color2

    bool bipartit()
    {
        componentaBipartitie.assign(n, 0);
        queue<int> Q;

        for (int nod = 0; nod < n; nod++)
        {
            if (componentaBipartitie[nod] == 0)
            {
                componentaBipartitie[nod] = 1;
                Q.push(nod);
                while (!Q.empty())
                {
                    int cur = Q.front();
                    Q.pop();
                    for (int vecin : listaAdiacenta[cur])
                    {
                        if (componentaBipartitie[vecin] == 0)
                        {
                            componentaBipartitie[vecin] = (componentaBipartitie[cur] == 1 ? 2 : 1);
                            Q.push(vecin);
                        }
                        else if (componentaBipartitie[vecin] == componentaBipartitie[cur])
                        {
                            return false;
                        }
                    }
                }
            }
        }
        return true;
    }

    //--------------------------------------------------------------------------------
    // topological sort using Kahn's algorithm (for directed acyclic graphs)
    vector<int> gradIntern;     // in-degree
    vector<int> sortTopologica; // the result

    bool sortareTopologica()
    {
        // compute in-degree
        gradIntern.assign(n, 0);
        for (int i = 0; i < n; i++)
            for (int v : listaAdiacenta[i])
                gradIntern[v]++;

        queue<int> Q;
        for (int i = 0; i < n; i++)
            if (gradIntern[i] == 0)
                Q.push(i);

        while (!Q.empty())
        {
            int nod = Q.front();
            Q.pop();
            sortTopologica.push_back(nod);

            for (int vecin : listaAdiacenta[nod])
            {
                gradIntern[vecin]--;
                if (gradIntern[vecin] == 0)
                    Q.push(vecin);
            }
        }

        return (sortTopologica.size() == (size_t)n);
    }

    //--------------------------------------------------------------------------------
    // strongly connected components with Kosaraju (directed)
    // compTareConexe[i] = the index of the scc for node i
    int indexComponentaTareConexa = 0;
    vector<int> compTareConexe;

    void componenteTareConexeComponenta(const vector<vector<int>> &transpus, int start)
    {
        vizitat[start] = true;
        compTareConexe[start] = indexComponentaTareConexa;
        for (int vecin : transpus[start])
            if (!vizitat[vecin])
                componenteTareConexeComponenta(transpus, vecin);
    }

    void componenteTareConexeOrdine(int start, stack<int> &stiva)
    {
        vizitat[start] = true;
        for (int vecin : listaAdiacenta[start])
            if (!vizitat[vecin])
                componenteTareConexeOrdine(vecin, stiva);
        stiva.push(start);
    }

    void componenteTareConexe(int /*start or whatever you want*/)
    {
        // build transposed graph
        vector<vector<int>> listaTranspusa(n);
        for (int i = 0; i < n; i++)
            for (int vecin : listaAdiacenta[i])
                listaTranspusa[vecin].push_back(i);

        stack<int> stiva;
        vizitat.assign(n, 0);
        compTareConexe.assign(n, -1);

        // fill stack in finishing order
        for (int i = 0; i < n; i++)
            if (!vizitat[i])
                componenteTareConexeOrdine(i, stiva);

        // pop from stack to get scc
        vizitat.assign(n, 0);
        indexComponentaTareConexa = 0;
        while (!stiva.empty())
        {
            int x = stiva.top();
            stiva.pop();
            if (!vizitat[x])
            {
                componenteTareConexeComponenta(listaTranspusa, x);
                indexComponentaTareConexa++;
            }
        }
    }

    //--------------------------------------------------------------------------------
    // bridges (critical edges) in an undirected graph (using adjacency list)
    vector<pair<int, int>> muchiileCritice;
    vector<int> nivel, nivelMinim;

    void muchiiCriticeDFS(int nod, int parinte)
    {
        vizitat[nod] = 1;
        nivel[nod] = (parinte == -1 ? 0 : nivel[parinte] + 1);
        nivelMinim[nod] = nivel[nod];

        for (int vecin : listaAdiacenta[nod])
        {
            if (!vizitat[vecin])
            {
                muchiiCriticeDFS(vecin, nod);
                nivelMinim[nod] = min(nivelMinim[nod], nivelMinim[vecin]);
                if (nivelMinim[vecin] > nivel[nod])
                {
                    muchiileCritice.push_back({nod, vecin});
                }
            }
            else if (vecin != parinte)
            {
                nivelMinim[nod] = min(nivelMinim[nod], nivel[vecin]);
            }
        }
    }

    //--------------------------------------------------------------------------------
    // minimum spanning tree - Kruskal (using edge list with costs)
    vector<muchieCost> arborePartialCostMinim;
    vector<int> reprezentant, h;

    void sortareCost()
    {
        sort(listaMuchiiCost.begin(), listaMuchiiCost.end(),
             [](muchieCost a, muchieCost b)
             {
                 return a.cost < b.cost;
             });
    }

    void initializareKruskal(int nod)
    {
        reprezentant[nod] = 0;
        h[nod] = 0;
    }

    int reprezentantKruskal(int nod)
    {
        if (reprezentant[nod] == 0)
            return nod;
        reprezentant[nod] = reprezentantKruskal(reprezentant[nod]);
        return reprezentant[nod];
    }

    void reunesteKruskal(int u, int v)
    {
        int repU = reprezentantKruskal(u);
        int repV = reprezentantKruskal(v);
        if (h[repU] > h[repV])
            reprezentant[repV] = repU;
        else
        {
            reprezentant[repU] = repV;
            if (h[repU] == h[repV])
                h[repV]++;
        }
    }

    void kruskal()
    {
        int nrmsel = 0;
        sortareCost();
        reprezentant.resize(n + 1, 0);
        h.resize(n + 1, 0);
        for (int i = 1; i <= n; i++)
            initializareKruskal(i);

        for (auto &muchie : listaMuchiiCost)
        {
            int u = muchie.x, v = muchie.y, cc = muchie.cost;
            if (reprezentantKruskal(u) != reprezentantKruskal(v))
            {
                arborePartialCostMinim.push_back(muchie);
                reunesteKruskal(u, v);
                nrmsel++;
                if (nrmsel == n - 1)
                    break;
            }
        }
    }

    //--------------------------------------------------------------------------------
    // MST - Prim (using adjacency matrix with costs)
    // store the result in arborePartialCostMinim
    vector<int> distantaPrim;
    vector<int> tataPrim;

    void prim()
    {
        distanta.assign(n, INT_MAX);
        tati.assign(n, -1);
        vizitat.assign(n, 0);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        distanta[0] = 0;
        pq.push({0, 0});

        while (!pq.empty())
        {
            int nod = pq.top().second;
            pq.pop();
            if (vizitat[nod])
                continue;
            vizitat[nod] = 1;
            if (tati[nod] != -1)
                arborePartialCostMinim.push_back(muchieCost(tati[nod], nod, distanta[nod]));

            for (int j = 0; j < n; j++)
            {
                // if there's a cost edge and not visited
                if (!vizitat[j] && matriceCost[nod][j] > 0 && matriceCost[nod][j] < distanta[j])
                {
                    distanta[j] = matriceCost[nod][j];
                    tati[j] = nod;
                    pq.push({distanta[j], j});
                }
            }
        }
    }

    //--------------------------------------------------------------------------------
    // Dijkstra for cost >= 0, using adjacency list of (cost, node)
    vector<int> solutieDijkstra;

    void Dijkstra(int start)
    {
        solutieDijkstra.assign(n, 0);
        distanta.assign(n, INT_MAX);
        tati.assign(n, 0);
        set<pair<int, int>> Q;
        distanta[start] = 0;
        Q.insert({0, start});

        while (!Q.empty())
        {
            auto topVal = *Q.begin();
            Q.erase(Q.begin());
            int nod = topVal.second;
            for (auto &p : listaAdiacentaCost[nod])
            {
                int cost = p.first;
                int x = p.second;
                if (distanta[x] > distanta[nod] + cost)
                {
                    if (distanta[x] != INT_MAX)
                        Q.erase({distanta[x], x});
                    distanta[x] = distanta[nod] + cost;
                    tati[x] = nod;
                    Q.insert({distanta[x], x});
                }
            }
        }

        for (int i = 0; i < n; i++)
        {
            if (distanta[i] < INT_MAX)
                solutieDijkstra[i] = distanta[i];
            else
                solutieDijkstra[i] = 0;
        }
    }

    //--------------------------------------------------------------------------------
    // Bellman-Ford for edges with possible negative costs, but no negative cycles
    // adjacency matrix with costs used
    vector<int> solutieBellmanFord;

    bool BellmanFord(int start)
    {
        solutieBellmanFord.assign(n, INT_MAX);
        solutieBellmanFord[start] = 0;
        tati.assign(n, -1);
        vizitat.assign(n, false);

        vector<bool> inQueue(n, false);
        vector<int> proceseaza(n, 0);
        queue<int> Q;
        Q.push(start);
        inQueue[start] = true;

        while (!Q.empty())
        {
            int u = Q.front();
            Q.pop();
            inQueue[u] = false;
            proceseaza[u]++;
            if (proceseaza[u] > n - 1)
                return true; // negative cycle

            for (int v = 0; v < n; v++)
            {
                if (matriceCost[u][v] != 0 && matriceCost[u][v] != INT_MAX)
                {
                    long long attempt = (long long)solutieBellmanFord[u] + matriceCost[u][v];
                    if (attempt < solutieBellmanFord[v])
                    {
                        solutieBellmanFord[v] = (int)attempt;
                        tati[v] = u;
                        if (!inQueue[v])
                        {
                            inQueue[v] = true;
                            Q.push(v);
                        }
                    }
                }
            }
        }

        return false; // no negative cycle
    }

    //--------------------------------------------------------------------------------
    // Floyd-Warshall (matrixCost). for negative or positive costs, no negative cycles
    vector<vector<int>> matriceCostMinim;
    vector<vector<int>> parinteFloydWarshall;

    bool FloydWarshall()
    {
        matriceCostMinim = matriceCost;
        // init
        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
            {
                if (i == j)
                    matriceCostMinim[i][j] = 0;
                else if (matriceCostMinim[i][j] == 0)
                    matriceCostMinim[i][j] = INT_MAX;
            }
        }

        parinteFloydWarshall = vector<vector<int>>(n, vector<int>(n, -1));
        for (int i = 0; i < n; i++)
            for (int j = 0; j < n; j++)
                if (matriceCostMinim[i][j] != INT_MAX && i != j)
                    parinteFloydWarshall[i][j] = i;

        // run FW
        for (int k = 0; k < n; k++)
        {
            for (int i = 0; i < n; i++)
            {
                if (matriceCostMinim[i][k] == INT_MAX)
                    continue;
                for (int j = 0; j < n; j++)
                {
                    if (matriceCostMinim[k][j] == INT_MAX)
                        continue;
                    long long potential = (long long)matriceCostMinim[i][k] + matriceCostMinim[k][j];
                    if (potential < matriceCostMinim[i][j])
                    {
                        matriceCostMinim[i][j] = (int)potential;
                        parinteFloydWarshall[i][j] = parinteFloydWarshall[k][j];
                    }
                }
            }
        }

        // check negative cycles
        for (int i = 0; i < n; i++)
            if (matriceCostMinim[i][i] < 0)
                return true;
        return false;
    }

    void drumFloydWarshall(int x, int y)
    {
        if (x != y)
            drumFloydWarshall(x, parinteFloydWarshall[x][y]);
        cout << y << " ";
    }

    //--------------------------------------------------------------------------------
    // example usage of edmond-karp is omitted, but you can add if needed...
    // ...
    // all done
    //--------------------------------------------------------------------------------

    // for demonstration, some placeholders:
    void apelareDFS()
    {
        orientat = false;
        citireMatriceAdiacenta(); // read from "cin"
        vizitat.resize(n, 0);
        tati.resize(n, -1);
        timpDfs = 0;
        matriceDFS(0); // start from node 0
        // show dfs order
        cout << "dfs order: ";
        for (int v : solutieDFS)
            cout << v + 1 << " ";
        cout << "\nparents: ";
        for (int p : tati)
            cout << p + 1 << " "; // +1 if p!=-1
        cout << "\n";
    }
};

int main()
{
    // example: we call the DFS usage
    Graf g;
    g.apelareDFS();
    return 0;
}

/*

==================== instructiuni de utilizare / tutorial ====================

1. cum se citeste un graf:

   - citirematriceadiacenta():
       citeste 'n' si 'm' de la tastatura, initializeaza matrice de dimensiune n x n cu 0,
       apoi pentru fiecare muchie citita (x,y), seteaza matrice[x][y] = 1 (si, daca e neorientat, matrice[y][x] = 1).

   - citirelistaadiacenta():
       citeste 'n' si 'm' de la tastatura, initializeaza vectorul listaadiacenta ca n vectori de int,
       apoi pentru fiecare muchie citita (x,y), face push_back(y) in listaadiacenta[x],
       iar daca e neorientat, push_back(x) in listaadiacenta[y].

   - citirelistamuchii():
       citeste 'n' si 'm' de la tastatura, apoi pentru fiecare muchie (x,y) citita, o adauga in 'listamuchii' ca un pair(x,y).

   - citirematriceadiacentacost(), citirelistamuchiicost(), citirelistaadiacentacost():
       la fel ca mai sus, dar retin valorile de cost in 'matricecost' (matrice 2d) sau in 'listamuchiicost' (vector de 'muchiecost'),
       sau in 'listaadiacentacost' (vector de liste de perechi(cost,nod)).

2. cum se afiseaza un graf:

   - afisarematriceadiacenta():
       parcurge matricea 'matrice' si afiseaza la ecran valorile 0 sau 1 (sau costuri) pe fiecare linie.

   - afisarelistaadiacenta():
       pentru fiecare i, afiseaza "i+1: " urmat de lista nodurilor adiacente la i (plus 1, pentru 1-based output).

   - afisarelistamuchii():
       parcurge vectorul 'listamuchii' si afiseaza fiecare pereche, adaugand 1 la index (pentru output 1-based).

   - afisarematriceadiacentacost():
       parcurge 'matricecost' si afiseaza valorile costului.

3. cum convertim intre reprezentari:

   - convertestematricelalistaadiacenta():
       porneste de la 'matrice' si construieste 'listaadiacenta' cautand elemente 1 in matrice[i][j].

   - convertestelistaadiacentalamatrice():
       porneste de la 'listaadiacenta' si construieste 'matrice' prin setari la 1 pentru fiecare muchie (i->j).

   [exista si alte variante posibile, la fel cu costuri etc.]

4. parcurgeri:

   - matricebfs(int start):
       face un bfs din nodul 'start' folosind 'matrice' ca reprezentare. foloseste 'queue<int> q' si vectorul 'vizitat'
       pentru a marca nodurile vizitate. rezulta in 'solutiebfs' (ordine de parcurgere), iar 'tati[i]' retine parintele.

   - drumminimbfs(int s, int x):
       tot pe 'matrice', calculeaza distanta minima intre nodurile 's' si 'x' cu BFS. salveaza si reconstructia drumului in 'tati'.

   - matricedfs(int start):
       face dfs pornind din 'start' pe 'matrice'; actualizeaza 'solutiedfs' cu ordinea nodurilor parcurse, precum si 'tati'.

   - cicludfsrecursiv():
       cauta cicluri intr-un DFS, salvand un ciclu in vectorul 'ciclidfs' daca descopera back-edge.

   - tipurimuchiidfs():
       folosind 'descoperit[]' si 'finalizat[]', clasifica muchiile in: intoarcere (back edge), avansare (forward edge), traversare (cross edge).

5. bipartit():
   - verifica daca graful neorientat, stocat in 'listaadiacenta', se poate colora cu 2 culori (1 si 2) astfel incat nodurile adiacente
     sa aiba culori diferite. daca gasim conflict => nu e bipartit => return false, altfel true.
   - rezulta colorarea finala in 'componentabipartitie'.

6. sortaretopologica():
   - pentru graf orientat, foloseste algoritmul Kahn (in-degree) pentru a obtine o sortare topologica. 'gradintern' e vectorul de in-degree,
     iar 'sorttopologica' e rezultatul final. returneaza true daca se obtine o sortare valida (graful e aciclic), altfel false.

7. componentetareconexe (kosaraju):
   - pentru graf orientat, se folosesc 2 pasi: se construieste graful 'transpus', se face DFS pentru ordinea de finalizare,
     apoi DFS pe graful transpus pentru a stabili componentele. 'comptareconexe[i]' retine indicele componentei in care se afla nodul i.

8. muchiicriticedfs():
   - in graf neorientat (listaadiacenta), gaseste 'bridges' (muchii care, daca se scot, cresc nr. de componente). foloseste notiunile de 'nivel[]'
     si 'nivelminim[]', apoi daca 'nivelminim[vecin] > nivel[nod]', (nod,vecin) e muchie critica.

9. kruskal():
   - foloseste 'listamuchiicost' (vector de muchiecost), le sorteaza dupa cost ('sortarecost()'),
     apoi formeaza un MST unind componente disjuncte (reprezentantkru... + reunestekruskal). retine muchiile MST in 'arborepartialcostminim'.

10. prim():
   - foloseste 'matricecost' si un min-heap (priority_queue) pentru a construi MST. totul incepe din nodul 0, distanta[0] = 0.
     la fiecare pas, extragem nodul cu distanta minima si punem in MST muchia catre parintele. retinem in 'arborepartialcostminim'.

11. dijkstra():
   - pe 'listaadiacentacost', computeaza distanta minima de la 'start' la toate nodurile (cost >= 0). foloseste un 'set<pair<cost,nod>>'.
     rezulta vectorul 'solutiedijkstra'. 'tati[x]' retine parintele, 'distanta[x]' retine costul.

12. bellmanford():
   - pe 'matricecost' (costuri pozitive/negative, dar fara ciclu negativ). returneaza true daca se detecteaza ciclu negativ. in caz contrar,
     'solutiebellmanford[v]' contine costul minim de la 'start' la 'v'.

13. floydwarshall():
   - calculeaza drumul minim intre toate perechile de noduri, punand in 'matricecostminim[i][j]' costul minim i->j.
     daca descopera 'matricecostminim[i][i] < 0' => ciclu negativ => return true. altfel false.
   - 'parintefloydwarshall[i][j]' retine un nod intermediar pt reconstructie.

14. apelaredfs() / alte exemple:
   - functii demonstrative ce arata cum se poate apela un anume algoritm. exemplu: apelaredfs() citeste un graf cu 'citirematriceadiacenta()',
     redimensioneaza 'vizitat' si 'tati', apeleaza 'matricedfs(0)', apoi afiseaza ordinea DFS si parintii.

==================== sfarsit instructiuni ====================

*/
