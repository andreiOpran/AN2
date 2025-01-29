#include <bits/stdc++.h>
using namespace std;

//=====================================================================================
// 1. graf simplu cu bfs, dfs (neorientat sau orientat)
//-------------------------------------------------------------------------------------
// usage example (1-based input):
//   int n = 5; // numar de noduri
//   graf g(n, false); // false => neorientat, indexare interna 0..n-1
//   // daca citesti muchiile (u,v) 1-based, faci: g.adauga_muchie(u-1, v-1);
//   g.adauga_muchie(0,1);
//   g.adauga_muchie(1,2);
//   vector<int> bfs_result = g.bfs(0);
//   vector<int> dfs_result = g.dfs(0);
//   // atentie: bfs_result[i] e in 0-based
//=====================================================================================
class graf {
public:
    int n;
    bool orientat;
    vector<vector<int>> lista_adiacenta;

    graf(int n, bool orientat = false) : n(n), orientat(orientat) {
        lista_adiacenta.resize(n);
    }

    void adauga_muchie(int u, int v) {
        // u, v trebuie sa fie deja in 0..n-1
        lista_adiacenta[u].push_back(v);
        if(!orientat) {
            lista_adiacenta[v].push_back(u);
        }
    }

    // bfs
    vector<int> bfs(int start) {
        vector<int> vizitat(n, 0), rezultat;
        queue<int> coada;
        vizitat[start] = 1;
        coada.push(start);

        while(!coada.empty()) {
            int nod = coada.front();
            coada.pop();
            rezultat.push_back(nod);
            for(int vecin : lista_adiacenta[nod]) {
                if(!vizitat[vecin]) {
                    vizitat[vecin] = 1;
                    coada.push(vecin);
                }
            }
        }
        return rezultat;
    }

    // dfs recursiv
    void dfs_util(int nod, vector<int> &vizitat, vector<int> &rezultat) {
        vizitat[nod] = 1;
        rezultat.push_back(nod);
        for(int vecin : lista_adiacenta[nod]) {
            if(!vizitat[vecin]) {
                dfs_util(vecin, vizitat, rezultat);
            }
        }
    }

    vector<int> dfs(int start) {
        vector<int> vizitat(n, 0), rezultat;
        dfs_util(start, vizitat, rezultat);
        return rezultat;
    }

    const vector<vector<int>>& get_lista_adiacenta() const {
        return lista_adiacenta;
    }
};

//=====================================================================================
// 2. graf critic (articulation points & muchii critice) - doar neorientat
//-------------------------------------------------------------------------------------
// usage example (1-based input):
//   graf_critic gc(n);
//   // cand citesti u,v => gc.adauga_muchie(u-1, v-1);
//   gc.adauga_muchie(0,1);
//   gc.gaseste_ap_si_muchii_critice();
//   // in gc.articulatii si gc.muchii_critice ai rezultatele
//=====================================================================================
class graf_critic {
public:
    int n;
    vector<vector<int>> adj;
    vector<int> disc, low, parinte;
    vector<bool> articulatii;
    int timp;
    vector<pair<int,int>> muchii_critice;

    graf_critic(int n) : n(n) {
        adj.resize(n);
        disc.resize(n, -1);
        low.resize(n, -1);
        parinte.resize(n, -1);
        articulatii.resize(n, false);
        timp = 0;
    }

    void adauga_muchie(int u, int v) {
        adj[u].push_back(v);
        adj[v].push_back(u);
    }

    void dfs_ap(int u) {
        disc[u] = low[u] = timp++;
        int copii = 0;
        for(int v : adj[u]) {
            if(disc[v] == -1) {
                parinte[v] = u;
                copii++;
                dfs_ap(v);
                low[u] = min(low[u], low[v]);

                // caz radacina
                if(parinte[u] == -1 && copii > 1) {
                    articulatii[u] = true;
                }
                // caz non-radacina
                if(parinte[u] != -1 && low[v] >= disc[u]) {
                    articulatii[u] = true;
                }
                // muchie critica
                if(low[v] > disc[u]) {
                    muchii_critice.push_back({u, v});
                }
            }
            else if(v != parinte[u]) {
                low[u] = min(low[u], disc[v]);
            }
        }
    }

    void gaseste_ap_si_muchii_critice() {
        for(int i = 0; i < n; i++) {
            if(disc[i] == -1) {
                dfs_ap(i);
            }
        }
    }
};

//=====================================================================================
// 3. tarjan pentru componente tare conectate (graf orientat)
//-------------------------------------------------------------------------------------
// usage example (1-based input):
//   graf_tarjan gt(n);
//   // cand citesti u,v => gt.adauga_muchie(u-1, v-1);
//   gt.adauga_muchie(0,1);
//   gt.construieste_ctc();
//   // in gt.ctc ai vectorul de componente tare conectate
//=====================================================================================
class graf_tarjan {
public:
    int n;
    vector<vector<int>> adj;
    vector<int> disc, low, stiva;
    vector<bool> in_stiva;
    int timp;
    vector<vector<int>> ctc; // componente tare conectate

    graf_tarjan(int n) : n(n) {
        adj.resize(n);
        disc.resize(n, -1);
        low.resize(n, -1);
        in_stiva.resize(n, false);
        timp = 0;
    }

    void adauga_muchie(int u, int v) {
        adj[u].push_back(v);
    }

    void tarjan_dfs(int u) {
        disc[u] = low[u] = timp++;
        stiva.push_back(u);
        in_stiva[u] = true;

        for(int v : adj[u]) {
            if(disc[v] == -1) {
                tarjan_dfs(v);
                low[u] = min(low[u], low[v]);
            } else if(in_stiva[v]) {
                low[u] = min(low[u], disc[v]);
            }
        }

        if(low[u] == disc[u]) {
            vector<int> comp;
            while(true) {
                int nod = stiva.back();
                stiva.pop_back();
                in_stiva[nod] = false;
                comp.push_back(nod);
                if(nod == u) break;
            }
            ctc.push_back(comp);
        }
    }

    void construieste_ctc() {
        for(int i = 0; i < n; i++) {
            if(disc[i] == -1) {
                tarjan_dfs(i);
            }
        }
    }
};

//=====================================================================================
// 4. verificare bipartit (graf neorientat)
//-------------------------------------------------------------------------------------
// usage example (1-based input):
//   vector<vector<int>> adj(n);
//   // adaugi edge (u-1, v-1) in adj[u-1], adj[v-1]
//   bool bip = este_bipartit(adj);
//=====================================================================================
bool este_bipartit(const vector<vector<int>> &adj) {
    int n = (int)adj.size();
    vector<int> culoare(n, -1);

    for(int start = 0; start < n; start++) {
        if(culoare[start] == -1) {
            queue<int> coada;
            culoare[start] = 0;
            coada.push(start);
            while(!coada.empty()) {
                int u = coada.front();
                coada.pop();
                for(int v : adj[u]) {
                    if(culoare[v] == -1) {
                        culoare[v] = 1 - culoare[u];
                        coada.push(v);
                    } else if(culoare[v] == culoare[u]) {
                        return false;
                    }
                }
            }
        }
    }
    return true;
}

//=====================================================================================
// 5. euler path/circuit (hierholzer) - graf neorientat
//-------------------------------------------------------------------------------------
// usage example (1-based input):
//   vector<vector<int>> adj(n);
//   // cand citesti u,v => adj[u-1].push_back(v-1), adj[v-1].push_back(u-1)
//   vector<int> ciclu = circuit_eulerian(adj);
//   // ciclu va contine un traseu eulerian in ordinea nodurilor 0-based
//=====================================================================================
vector<int> circuit_eulerian(vector<vector<int>> &adj) {
    vector<int> circuit;
    stack<int> st;
    st.push(0); // presupunem ca plecam de la nodul 0
    while(!st.empty()) {
        int u = st.top();
        if(!adj[u].empty()) {
            int v = adj[u].back();
            adj[u].pop_back();
            st.push(v);
        } else {
            circuit.push_back(u);
            st.pop();
        }
    }
    return circuit;
}

//=====================================================================================
// 6. edmond-karp (max flow) - O(V * E^2)
//-------------------------------------------------------------------------------------
// usage example:
//   vector<vector<int>> capacity(n, vector<int>(n,0));
//   // capacity[u][v] = capacitate pe muchia (u,v)
//   int flux_max = edmond_karp(capacity, source, sink);
//=====================================================================================
int edmond_karp(vector<vector<int>> capacity, int sursa, int destinatie) {
    int n = capacity.size();
    vector<vector<int>> flux(n, vector<int>(n, 0));
    int flux_maxim = 0;

    while(true) {
        vector<int> parinte(n, -1);
        parinte[sursa] = sursa;
        queue<int> coada;
        coada.push(sursa);

        while(!coada.empty() && parinte[destinatie] == -1) {
            int u = coada.front();
            coada.pop();
            for(int v = 0; v < n; v++) {
                if(capacity[u][v] - flux[u][v] > 0 && parinte[v] == -1) {
                    parinte[v] = u;
                    coada.push(v);
                }
            }
        }

        if(parinte[destinatie] == -1) break;

        int augment = INT_MAX;
        int v = destinatie;
        while(v != sursa) {
            int u = parinte[v];
            augment = min(augment, capacity[u][v] - flux[u][v]);
            v = u;
        }

        v = destinatie;
        while(v != sursa) {
            int u = parinte[v];
            flux[u][v] += augment;
            flux[v][u] -= augment;
            v = u;
        }
        flux_maxim += augment;
    }

    return flux_maxim;
}

//=====================================================================================
// 7. graf neorientat cu costuri + prim si kruskal
//-------------------------------------------------------------------------------------
// usage example (1-based input):
//   graf_neorientat_cu_cost g(n);
//   g.adauga_muchie(u-1, v-1, cost);
//   int cost_prim = g.prim(0);
//   int cost_kruskal = g.kruskal();
//=====================================================================================
class graf_neorientat_cu_cost {
private:
    int n;
    vector<vector<pair<int,int>>> adj;
public:
    graf_neorientat_cu_cost(int n) : n(n) {
        adj.resize(n);
    }

    void adauga_muchie(int u, int v, int cost) {
        adj[u].push_back({v, cost});
        adj[v].push_back({u, cost});
    }

    // prim
    int prim(int start = 0) {
        vector<int> viz(n, 0);
        priority_queue<pair<int,int>, vector<pair<int,int>>, greater<pair<int,int>>> pq;
        pq.push({0, start});
        int cost_total = 0;

        while(!pq.empty()) {
            auto [c, nod] = pq.top();
            pq.pop();
            if(viz[nod]) continue;
            viz[nod] = 1;
            cost_total += c;
            for(auto &ed : adj[nod]) {
                if(!viz[ed.first]) {
                    pq.push({ed.second, ed.first});
                }
            }
        }
        return cost_total;
    }

    // kruskal
    struct dsu {
        vector<int> parinte, rang;
        dsu(int n) : parinte(n), rang(n, 0) {
            for(int i = 0; i < n; i++) parinte[i] = i;
        }
        int findx(int x) {
            if(parinte[x] == x) return x;
            return parinte[x] = findx(parinte[x]);
        }
        bool uneste(int a, int b) {
            a = findx(a);
            b = findx(b);
            if(a == b) return false;
            if(rang[a] < rang[b]) swap(a, b);
            parinte[b] = a;
            if(rang[a] == rang[b]) rang[a]++;
            return true;
        }
    };

    int kruskal() {
        vector<tuple<int,int,int>> muchii;
        for(int u = 0; u < n; u++) {
            for(auto &p : adj[u]) {
                int v = p.first;
                int c = p.second;
                if(u < v) {
                    muchii.push_back({c, u, v});
                }
            }
        }
        sort(muchii.begin(), muchii.end(),
            [](auto &a, auto &b) { return get<0>(a) < get<0>(b); });
        dsu d(n);
        int cost_total = 0;
        for(auto &e : muchii) {
            int c, uu, vv;
            tie(c, uu, vv) = e;
            if(d.uneste(uu, vv)) {
                cost_total += c;
            }
        }
        return cost_total;
    }

    // distanta intre doua noduri (bfs) in sens de nr de muchii
    unsigned distanta_dintre_noduri(unsigned nod1, unsigned nod2) {
        unsigned dist = 0;
        vector<int> viz(n, 0);
        queue<pair<int, int>> coada;
        coada.push({nod1, 0});
        viz[nod1] = 1;
        while(!coada.empty()) {
            auto [nod, d] = coada.front();
            coada.pop();
            if(nod == (int)nod2) {
                dist = d;
                break;
            }
            for(auto &vecin : adj[nod]) {
                if(!viz[vecin.first]) {
                    viz[vecin.first] = 1;
                    coada.push({vecin.first, d + 1});
                }
            }
        }
        return dist;
    }

    const vector<vector<pair<int,int>>> &get_lista_adiacenta() const {
        return adj;
    }
};

//=====================================================================================
// 8. dijkstra - O(E log V)
//-------------------------------------------------------------------------------------
// usage example (1-based input):
//   vector<vector<pair<int,int>>> adj(n); // adj[u] = {{v, cost}, ...}
//   // cand citesti: adj[u-1].push_back({v-1, cost});
//   vector<int> dist = dijkstra(adj, 0); // de la nodul 0
//=====================================================================================
vector<int> dijkstra(const vector<vector<pair<int,int>>> &adj, int start) {
    int n = adj.size();
    vector<int> dist(n, INT_MAX);
    dist[start] = 0;
    priority_queue<pair<int,int>, vector<pair<int,int>>, greater<pair<int,int>>> pq;
    pq.push({0, start});

    while(!pq.empty()) {
        auto [cd, nod] = pq.top();
        pq.pop();
        if(cd > dist[nod]) continue;
        for(auto &edge : adj[nod]) {
            int vecin = edge.first;
            int cost = edge.second;
            if(dist[nod] + cost < dist[vecin]) {
                dist[vecin] = dist[nod] + cost;
                pq.push({dist[vecin], vecin});
            }
        }
    }
    return dist;
}

//=====================================================================================
// 9. bellman-ford - O(V*E)
//-------------------------------------------------------------------------------------
// usage example:
//   vector<tuple<int,int,int>> edges; // (u,v,cost)
//   // cand citesti => edges.push_back({u-1, v-1, cost});
//   vector<int> dist = bellman_ford(n, 0, edges);
//=====================================================================================
vector<int> bellman_ford(int n, int start, vector<tuple<int,int,int>> &muchii) {
    vector<int> dist(n, INT_MAX);
    dist[start] = 0;
    for(int i = 0; i < n - 1; i++) {
        for(auto &e : muchii) {
            int u, v, c;
            tie(u, v, c) = e;
            if(dist[u] != INT_MAX && dist[u] + c < dist[v]) {
                dist[v] = dist[u] + c;
            }
        }
    }
    return dist;
}

//=====================================================================================
// 10. floyd-warshall - O(V^3)
//-------------------------------------------------------------------------------------
// usage example:
//   vector<vector<int>> mat(n, vector<int>(n,999999));
//   // mat[u][v] = cost intre u si v; mat[u][u]=0
//   floyd_warshall(mat);
//=====================================================================================
void floyd_warshall(vector<vector<int>> &mat) {
    int n = mat.size();
    for(int k = 0; k < n; k++) {
        for(int i = 0; i < n; i++) {
            for(int j = 0; j < n; j++) {
                if(mat[i][k] < INT_MAX && mat[k][j] < INT_MAX) {
                    mat[i][j] = min(mat[i][j], mat[i][k] + mat[k][j]);
                }
            }
        }
    }
}

//=====================================================================================
// 11. levenshtein distance (edit distance)
//-------------------------------------------------------------------------------------
// usage example:
//   int d = levenshtein_distance("bai","ratoi");
//=====================================================================================
int levenshtein_distance(const string &s1, const string &s2) {
    int n = s1.size(), m = s2.size();
    vector<vector<int>> dp(n + 1, vector<int>(m + 1, 0));
    for(int i = 0; i <= n; i++) dp[i][0] = i;
    for(int j = 0; j <= m; j++) dp[0][j] = j;

    for(int i = 1; i <= n; i++) {
        for(int j = 1; j <= m; j++) {
            if(s1[i - 1] == s2[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1];
            } else {
                dp[i][j] = 1 + min({dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]});
            }
        }
    }
    return dp[n][m];
}

//=====================================================================================
// 12. sortari (mergesort, quicksort) si cautare binara
//-------------------------------------------------------------------------------------
// usage example:
//   vector<int> arr = {5,3,8,2,1};
//   merge_sort(arr,0,arr.size()-1);
//   quicksort(arr,0,arr.size()-1);
//   int pos = cautare_binara(arr,8);
//=====================================================================================
void merge_sort(vector<int> &arr, int st, int dr) {
    if(st >= dr) return;
    int m = (st + dr) / 2;
    merge_sort(arr, st, m);
    merge_sort(arr, m + 1, dr);

    vector<int> temp;
    int i = st, j = m + 1;
    while(i <= m && j <= dr) {
        if(arr[i] < arr[j]) temp.push_back(arr[i++]);
        else temp.push_back(arr[j++]);
    }
    while(i <= m) temp.push_back(arr[i++]);
    while(j <= dr) temp.push_back(arr[j++]);

    for(int k = st; k <= dr; k++) {
        arr[k] = temp[k - st];
    }
}

int partition_qs(vector<int> &arr, int low, int high) {
    int pivot = arr[high];
    int i = low - 1;
    for(int j = low; j < high; j++) {
        if(arr[j] < pivot) {
            i++;
            swap(arr[i], arr[j]);
        }
    }
    swap(arr[i + 1], arr[high]);
    return i + 1;
}

void quicksort(vector<int> &arr, int low, int high) {
    if(low < high) {
        int pi = partition_qs(arr, low, high);
        quicksort(arr, low, pi - 1);
        quicksort(arr, pi + 1, high);
    }
}

int cautare_binara(const vector<int> &arr, int val) {
    int st = 0, dr = (int)arr.size() - 1;
    while(st <= dr) {
        int mid = (st + dr) / 2;
        if(arr[mid] == val) return mid;
        else if(arr[mid] < val) st = mid + 1;
        else dr = mid - 1;
    }
    return -1;
}

//=====================================================================================
// 13. verificare drum hamiltonian
//-------------------------------------------------------------------------------------
// usage example (matrice de adiacenta 0/1):
//   vector<vector<int>> adj(n, vector<int>(n,0));
//   // adj[u][v] = 1 daca muchie intre u,v
//   bool ham = exista_drum_hamiltonian(adj);
//=====================================================================================
bool exista_drum_hamiltonian(const vector<vector<int>> &adj) {
    int n = (int)adj.size();
    vector<vector<bool>> dp(1 << n, vector<bool>(n, false));

    for(int v = 0; v < n; v++){
        dp[1 << v][v] = true;
    }

    for(int mask = 0; mask < (1 << n); mask++){
        for(int v = 0; v < n; v++){
            if(!dp[mask][v]) continue;
            for(int next = 0; next < n; next++){
                if(!(mask & (1 << next)) && adj[v][next] == 1) {
                    int next_mask = mask | (1 << next);
                    dp[next_mask][next] = true;
                }
            }
        }
    }

    int full_mask = (1 << n) - 1;
    for(int v = 0; v < n; v++){
        if(dp[full_mask][v]) {
            return true;
        }
    }
    return false;
}

//=====================================================================================
// 14. verificare daca e arbore (graf neorientat conex fara cicluri)
//-------------------------------------------------------------------------------------
// usage example:
//   graf g(n,false);
//   // adauga_muchie(u-1,v-1)
//   bool e_arb = este_arbore(g);
//=====================================================================================
bool este_arbore(const graf &g) {
    int n = g.n;
    const auto &adj = g.get_lista_adiacenta();
    vector<int> viz(n, 0);

    function<bool(int,int)> dfs = [&](int nod, int parinte) {
        viz[nod] = 1;
        for(int vecin : adj[nod]) {
            if(!viz[vecin]) {
                if(!dfs(vecin, nod)) return false;
            } else if(vecin != parinte) {
                // am dat de un ciclu
                return false;
            }
        }
        return true;
    };

    // verificam daca e conex si fara cicluri
    if(!dfs(0, -1)) return false;
    for(int i = 0; i < n; i++) {
        if(!viz[i]) return false; // nu e conex
    }
    return true;
}

//=====================================================================================
// 15. lowest common ancestor (lca) - implementare simpla
//-------------------------------------------------------------------------------------
// usage example:
//   vector<vector<int>> adj(n);
//   // adauga edges
//   lca L(n, adj, 0); // radacina = 0
//   int an = L.get_lca(u, v);
//=====================================================================================
class lca {
public:
    int n, LOG;
    vector<vector<int>> up;
    vector<int> depth;

    lca(int n, vector<vector<int>> &adj, int rad = 0) : n(n) {
        LOG = floor(log2(n)) + 1;
        up.assign(n, vector<int>(LOG, -1));
        depth.assign(n, 0);
        dfs(rad, -1, adj);
    }

    void dfs(int nod, int parinte, vector<vector<int>> &adj) {
        up[nod][0] = parinte;
        for(int i = 1; i < LOG; i++) {
            if(up[nod][i - 1] != -1) {
                up[nod][i] = up[ up[nod][i - 1] ][i - 1];
            }
        }
        for(int vecin : adj[nod]) {
            if(vecin == parinte) continue;
            depth[vecin] = depth[nod] + 1;
            dfs(vecin, nod, adj);
        }
    }

    int get_lca(int u, int v) {
        if(depth[u] < depth[v]) swap(u, v);
        for(int i = LOG - 1; i >= 0; i--) {
            if(up[u][i] != -1 && depth[ up[u][i] ] >= depth[v]) {
                u = up[u][i];
            }
        }
        if(u == v) return u;
        for(int i = LOG - 1; i >= 0; i--) {
            if(up[u][i] != up[v][i]) {
                u = up[u][i];
                v = up[v][i];
            }
        }
        return up[u][0];
    }
};

//=====================================================================================
// 16. centroid decomposition
//-------------------------------------------------------------------------------------
// usage example:
//   vector<vector<int>> adj(n);
//   centroid_decomposition cd(n, adj);
//   // cd.cd_tree va contine ierarhia centroidelor
//=====================================================================================
class centroid_decomposition {
public:
    int n;
    vector<vector<int>> adj, cd_tree;
    vector<int> sub;
    vector<bool> eliminat;

    centroid_decomposition(int n, vector<vector<int>> &adj) : n(n), adj(adj) {
        cd_tree.resize(n);
        eliminat.assign(n, false);
        sub.assign(n, 0);
        build(0, -1);
    }

    void calc_sub(int nod, int parinte) {
        sub[nod] = 1;
        for(int vecin : adj[nod]) {
            if(vecin != parinte && !eliminat[vecin]) {
                calc_sub(vecin, nod);
                sub[nod] += sub[vecin];
            }
        }
    }

    int gaseste_centroid(int nod, int parinte, int marime) {
        for(int vecin : adj[nod]) {
            if(vecin != parinte && !eliminat[vecin] && sub[vecin] > marime / 2) {
                return gaseste_centroid(vecin, nod, marime);
            }
        }
        return nod;
    }

    void build(int start, int parinte) {
        calc_sub(start, -1);
        int c = gaseste_centroid(start, -1, sub[start]);
        eliminat[c] = true;

        if(parinte != -1) {
            cd_tree[parinte].push_back(c);
        }

        for(int vecin : adj[c]) {
            if(!eliminat[vecin]) {
                build(vecin, c);
            }
        }
        eliminat[c] = false;
    }
};

//=====================================================================================
// 17. heavy-light decomposition (hld) - implementare simpla
//-------------------------------------------------------------------------------------
// usage example:
//   heavy_light_decomposition hld(n);
//   // hld.adauga_muchie(u-1, v-1);
//   hld.init(0);
//   hld.construieste_segment_tree();
//   hld.update(u, val);
//   int ans = hld.query(u, v);
//=====================================================================================
struct segtree_hld {
    int n;
    vector<int> st;
    segtree_hld(int n) : n(n) {
        st.resize(4*n, 0);
    }
    void build(vector<int> &vals, int idx, int left, int right) {
        if(left == right) {
            st[idx] = vals[left];
            return;
        }
        int mid = (left+right)/2;
        build(vals, idx*2, left, mid);
        build(vals, idx*2+1, mid+1, right);
        st[idx] = st[idx*2] + st[idx*2+1];
    }
    void update(int idx, int left, int right, int pos, int val) {
        if(left == right) {
            st[idx] = val;
            return;
        }
        int mid = (left+right)/2;
        if(pos <= mid) update(idx*2,left,mid,pos,val);
        else update(idx*2+1,mid+1,right,pos,val);
        st[idx] = st[idx*2] + st[idx*2+1];
    }
    int query(int idx, int left, int right, int ql, int qr) {
        if(ql>qr || ql>right || qr<left) return 0;
        if(ql<=left && right<=qr) return st[idx];
        int mid=(left+right)/2;
        return query(idx*2,left,mid,ql,qr) + query(idx*2+1,mid+1,right,ql,qr);
    }
};

class heavy_light_decomposition {
public:
    int n;
    vector<vector<int>> adj;
    vector<int> parinte, nivel, heavy, dim_sub, head, poz;
    vector<int> base_array;
    segtree_hld *seg;
    int curPos;

    heavy_light_decomposition(int n) : n(n) {
        adj.resize(n);
        parinte.resize(n);
        nivel.resize(n);
        heavy.resize(n, -1);
        dim_sub.resize(n, 0);
        head.resize(n);
        poz.resize(n);
        curPos = 0;
        seg = nullptr;
    }

    void adauga_muchie(int u, int v) {
        adj[u].push_back(v);
        adj[v].push_back(u);
    }

    int dfs(int u, int p) {
        parinte[u] = p;
        dim_sub[u] = 1;
        int mx = -1;
        for(int v : adj[u]) {
            if(v == p) continue;
            nivel[v] = nivel[u] + 1;
            int sz = dfs(v, u);
            if(sz > mx) {
                mx = sz;
                heavy[u] = v;
            }
            dim_sub[u] += sz;
        }
        return dim_sub[u];
    }

    void decompose(int u, int h) {
        head[u] = h;
        poz[u] = curPos++;
        base_array[poz[u]] = 0; 
        if(heavy[u] != -1) {
            decompose(heavy[u], h);
        }
        for(int v : adj[u]) {
            if(v == parinte[u] || v == heavy[u]) continue;
            decompose(v, v);
        }
    }

    void init(int rad = 0) {
        dfs(rad, -1);
        base_array.resize(n, 0);
        decompose(rad, rad);
    }

    void construieste_segment_tree() {
        seg = new segtree_hld(n);
        seg->build(base_array, 1, 0, n-1);
    }

    void update(int u, int val) {
        int idx = poz[u];
        seg->update(1, 0, n-1, idx, val);
    }

    int query_path(int u, int v) {
        int rez = 0;
        while(head[u] != head[v]) {
            if(nivel[head[u]] > nivel[head[v]]) swap(u, v);
            rez += seg->query(1, 0, n-1, poz[head[v]], poz[v]);
            v = parinte[head[v]];
        }
        if(nivel[u] > nivel[v]) swap(u, v);
        rez += seg->query(1, 0, n-1, poz[u], poz[v]);
        return rez;
    }

    int query(int u, int v) {
        return query_path(u, v);
    }
};

//=====================================================================================
// 18. fenwick tree (bit)
//-------------------------------------------------------------------------------------
// usage example:
//   fenwick fw(n);
//   fw.update(1,5); // mare grija la indexare 1-based la fenwick
//   int s = fw.range_sum(1,3);
//=====================================================================================
class fenwick {
    vector<int> bit;
    int n;
public:
    fenwick(int n) : n(n) {
        bit.assign(n + 1, 0);
    }

    void update(int idx, int delta) {
        for(; idx <= n; idx += idx & -idx)
            bit[idx] += delta;
    }

    int sum(int idx) {
        int s = 0;
        for(; idx > 0; idx -= idx & -idx)
            s += bit[idx];
        return s;
    }

    int range_sum(int l, int r) {
        return sum(r) - sum(l - 1);
    }
};

//=====================================================================================
// 19. segment tree
//-------------------------------------------------------------------------------------
// usage example:
//   segment_tree st(n);
//   vector<int> arr = {1,3,5,7,9,11};
//   st.build(arr,1,0,n-1);
//   st.update(1,0,n-1, idx, val);
//   int rez = st.query(1,0,n-1, left, right);
//=====================================================================================
class segment_tree {
public:
    int n;
    vector<int> tree;
    segment_tree(int n) : n(n) {
        tree.resize(4*n, 0);
    }

    void build(vector<int> &arr, int idx, int start, int end) {
        if(start == end) {
            tree[idx] = arr[start];
            return;
        }
        int mid = (start+end)/2;
        build(arr, idx*2, start, mid);
        build(arr, idx*2+1, mid+1, end);
        tree[idx] = tree[idx*2] + tree[idx*2+1];
    }

    void update(int idx, int start, int end, int pos, int val) {
        if(start == end) {
            tree[idx] = val;
            return;
        }
        int mid = (start+end)/2;
        if(pos <= mid) update(idx*2, start, mid, pos, val);
        else update(idx*2+1, mid+1, end, pos, val);
        tree[idx] = tree[idx*2] + tree[idx*2+1];
    }

    int query(int idx, int start, int end, int left, int right) {
        if(left>right || left> end || right<start) return 0;
        if(left<=start && end<=right) {
            return tree[idx];
        }
        int mid = (start+end)/2;
        int q1 = query(idx*2, start, mid, left, right);
        int q2 = query(idx*2+1, mid+1, end, left, right);
        return q1 + q2;
    }
};

//=====================================================================================
// 20. treap / avl / splay
//-------------------------------------------------------------------------------------
// usage example (treap):
//   treap tr;
//   tr.insert_key(10);
//   tr.insert_key(5);
//   bool gasit = tr.cauta_key(5);
//
// la fel pentru avl si splay_tree
//=====================================================================================

//-------------------------------------------------------------------------------------
// treap
//-------------------------------------------------------------------------------------
struct nod_treap {
    int cheie, prioritate;
    nod_treap* st;
    nod_treap* dr;
    nod_treap(int key) : cheie(key), prioritate(rand()), st(nullptr), dr(nullptr) {}
};

class treap {
public:
    nod_treap* rad;
    treap() : rad(nullptr) {}

    nod_treap* rotate_right(nod_treap* y) {
        nod_treap* x = y->st;
        nod_treap* t2 = x->dr;
        x->dr = y;
        y->st = t2;
        return x;
    }

    nod_treap* rotate_left(nod_treap* x) {
        nod_treap* y = x->dr;
        nod_treap* t2 = y->st;
        y->st = x;
        x->dr = t2;
        return y;
    }

    nod_treap* insert_nod(nod_treap* rad, int key) {
        if(!rad) return new nod_treap(key);
        if(key < rad->cheie) {
            rad->st = insert_nod(rad->st, key);
            if(rad->st->prioritate > rad->prioritate) {
                rad = rotate_right(rad);
            }
        } else {
            rad->dr = insert_nod(rad->dr, key);
            if(rad->dr && rad->dr->prioritate > rad->prioritate) {
                rad = rotate_left(rad);
            }
        }
        return rad;
    }

    void insert_key(int key) {
        rad = insert_nod(rad, key);
    }

    bool cauta_nod(nod_treap* rad, int key) {
        if(!rad) return false;
        if(rad->cheie == key) return true;
        if(key < rad->cheie) return cauta_nod(rad->st, key);
        return cauta_nod(rad->dr, key);
    }

    bool cauta_key(int key) {
        return cauta_nod(rad, key);
    }
};

//-------------------------------------------------------------------------------------
// avl
//-------------------------------------------------------------------------------------
struct nod_avl {
    int cheie;
    nod_avl* st;
    nod_avl* dr;
    int inaltime;
    nod_avl(int key) : cheie(key), st(nullptr), dr(nullptr), inaltime(1) {}
};

class avl {
public:
    nod_avl* rad;
    avl() : rad(nullptr) {}

    int get_height(nod_avl* nod) {
        return nod ? nod->inaltime : 0;
    }

    int get_balance(nod_avl* nod) {
        if(!nod) return 0;
        return get_height(nod->st) - get_height(nod->dr);
    }

    nod_avl* rotate_right(nod_avl* y) {
        nod_avl* x = y->st;
        nod_avl* t2 = x->dr;
        x->dr = y;
        y->st = t2;
        y->inaltime = max(get_height(y->st), get_height(y->dr)) + 1;
        x->inaltime = max(get_height(x->st), get_height(x->dr)) + 1;
        return x;
    }

    nod_avl* rotate_left(nod_avl* x) {
        nod_avl* y = x->dr;
        nod_avl* t2 = y->st;
        y->st = x;
        x->dr = t2;
        x->inaltime = max(get_height(x->st), get_height(x->dr)) + 1;
        y->inaltime = max(get_height(y->st), get_height(y->dr)) + 1;
        return y;
    }

    nod_avl* insert_nod(nod_avl* rad, int key) {
        if(!rad) return new nod_avl(key);
        if(key < rad->cheie) {
            rad->st = insert_nod(rad->st, key);
        } else {
            rad->dr = insert_nod(rad->dr, key);
        }
        rad->inaltime = 1 + max(get_height(rad->st), get_height(rad->dr));
        int bal = get_balance(rad);

        // left left
        if(bal > 1 && key < rad->st->cheie) {
            return rotate_right(rad);
        }
        // right right
        if(bal < -1 && key > rad->dr->cheie) {
            return rotate_left(rad);
        }
        // left right
        if(bal > 1 && key > rad->st->cheie) {
            rad->st = rotate_left(rad->st);
            return rotate_right(rad);
        }
        // right left
        if(bal < -1 && key < rad->dr->cheie) {
            rad->dr = rotate_right(rad->dr);
            return rotate_left(rad);
        }
        return rad;
    }

    void insert_key(int key) {
        rad = insert_nod(rad, key);
    }

    bool cauta_nod(nod_avl* nod, int key) {
        if(!nod) return false;
        if(nod->cheie == key) return true;
        if(key < nod->cheie) return cauta_nod(nod->st, key);
        return cauta_nod(nod->dr, key);
    }

    bool cauta_key(int key) {
        return cauta_nod(rad, key);
    }
};

//-------------------------------------------------------------------------------------
// splay
//-------------------------------------------------------------------------------------
struct nod_splay {
    int cheie;
    nod_splay* st;
    nod_splay* dr;
    nod_splay(int key) : cheie(key), st(nullptr), dr(nullptr) {}
};

class splay_tree {
public:
    nod_splay* rad;
    splay_tree() : rad(nullptr) {}

    nod_splay* rotate_right(nod_splay* x) {
        nod_splay* y = x->st;
        x->st = y->dr;
        y->dr = x;
        return y;
    }

    nod_splay* rotate_left(nod_splay* x) {
        nod_splay* y = x->dr;
        x->dr = y->st;
        y->st = x;
        return y;
    }

    // splay - aduce cheia in radacina
    nod_splay* splay(nod_splay* rad, int key) {
        if(!rad || rad->cheie == key) return rad;

        if(key < rad->cheie) {
            if(!rad->st) return rad;
            if(key < rad->st->cheie) {
                rad->st->st = splay(rad->st->st, key);
                rad = rotate_right(rad);
            }
            else if(key > rad->st->cheie) {
                rad->st->dr = splay(rad->st->dr, key);
                if(rad->st->dr) {
                    rad->st = rotate_left(rad->st);
                }
            }
            return (!rad->st) ? rad : rotate_right(rad);
        }
        else {
            if(!rad->dr) return rad;
            if(key > rad->dr->cheie) {
                rad->dr->dr = splay(rad->dr->dr, key);
                rad = rotate_left(rad);
            }
            else if(key < rad->dr->cheie) {
                rad->dr->st = splay(rad->dr->st, key);
                if(rad->dr->st) {
                    rad->dr = rotate_right(rad->dr);
                }
            }
            return (!rad->dr) ? rad : rotate_left(rad);
        }
    }

    nod_splay* insert_nod(nod_splay* rad, int key) {
        if(!rad) return new nod_splay(key);
        rad = splay(rad, key);
        if(rad->cheie == key) return rad; 
        nod_splay* nou = new nod_splay(key);
        if(key < rad->cheie) {
            nou->dr = rad;
            nou->st = rad->st;
            rad->st = nullptr;
        } else {
            nou->st = rad;
            nou->dr = rad->dr;
            rad->dr = nullptr;
        }
        return nou;
    }

    void insert_key(int key) {
        rad = insert_nod(rad, key);
    }

    bool cauta_key(int key) {
        rad = splay(rad, key);
        return (rad && rad->cheie == key);
    }
};

int main() {

    return 0;
}
