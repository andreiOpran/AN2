
//----- Construire de graph
//#include <iostream>
//#include <vector>
//#include <algorithm>
//#include <queue>
//
//bool havelHakimi(std::vector<int>& sequence) {
//    if (std::accumulate(sequence.begin(), sequence.end(), 0) % 2 != 0) {
//        return false;
//    }
//
//    std::sort(sequence.begin(), sequence.end(), std::greater<int>());
//
//    while (!sequence.empty() && sequence[0] > 0) {
//        int degree = sequence[0];
//        sequence.erase(sequence.begin());
//
//        if (degree > sequence.size()) {
//            return false;
//        }
//
//        for (int i = 0; i < degree; ++i) {
//            sequence[i]--;
//        }
//
//        std::sort(sequence.begin(), sequence.end(), std::greater<int>());
//    }
//
//    return std::all_of(sequence.begin(), sequence.end(), [](int x) { return x == 0; });
//}
//
//std::vector<std::pair<int, int>> constructMultigraph(std::vector<int>& sequence) {
//    if (!havelHakimi(sequence)) {
//        throw std::invalid_argument("Nu se poate construi graful.");
//    }
//
//    std::vector<std::pair<int, int>> edges;
//    int n = sequence.size();
//    std::vector<int> nodes(n);
//    std::iota(nodes.begin(), nodes.end(), 0);
//
//    std::priority_queue<std::pair<int, int>> pq;
//    for (int i = 0; i < n; ++i) {
//        pq.push({sequence[i], i});
//    }
//
//    while (!pq.empty()) {
//        auto node = pq.top();
//        pq.pop();
//
//        int degree = node.first;
//        if (degree == 0) continue;
//
//        std::vector<int> temp;
//        for (int i = 0; i < degree; ++i) {
//            auto targetNode = pq.top();
//            pq.pop();
//            edges.push_back({node.second, targetNode.second});
//            temp.push_back(targetNode.second);
//        }
//
//        for (auto& item : temp) {
//            pq.push({sequence[item] - 1, item});
//        }
//    }
//
//    return edges;
//}
//
//int main() {
//    std::vector<int> degreeSequence = {3, 3, 2, 2, 2};
//    try {
//        auto multigraph = constructMultigraph(degreeSequence);
//        for (const auto& edge : multigraph) {
//            std::cout << "(" << edge.first << ", " << edge.second << ")" << std::endl;
//        }
//    } catch (const std::invalid_argument& e) {
//        std::cout << e.what() << std::endl;
//    }
//
//    return 0;
//}


//  --------------------------------------------------------
// BFS

//#include <iostream>
//#include <fstream>
//
//#include <vector>
//#include <queue>
//
//using namespace std;
//
//
//ifstream f("bfs.in");
//ofstream g("bfs.out");
//vector<vector<int>> lista;
//queue<int> q;
//vector<int> distanta;
//
//int main()
//{
//    int n,m,s;
//    f >> n >> m >> s;
//    int x,y ;
//    lista.resize(n+1);
//    distanta.resize(n+1,-1);
//    q.push(s);
//    distanta[s] = 0;
//    while(f >> x >> y)
//    {
//        lista[x].push_back(y);
//    }
//    while(!q.empty())
//    {
//        int curr = q.front();
//        q.pop();
//        for(auto vecin : lista[curr]){
//            if(distanta[vecin] == -1){
//                distanta[vecin] = distanta[curr] + 1;
//                q.push(vecin);
//            }
//        }
//    }
//
//    for(int i = 1; i<=n ;i++)
//        g << distanta[i] << ' ' ;
//
//    return 0;
//}

// -----------------------------------------------------------------------------
// DFS
//
//#include <iostream>
//#include <fstream>
//#include <vector>
//
//using namespace std;
//
//int n,m;
//
//ifstream f("dfs.in");
//ofstream g("dfs.out");
//
//vector<vector<int>> lista;
//vector<bool> verif;
//
//void dfs(int nod)
//{
//    if(verif[nod])return;
//    verif[nod] = true;
//    for(auto vecin: lista[nod])
//    {
//        dfs(vecin);
//    }
//}
//
//int main()
//{
//    int x,y;
//    f >> n >> m;
//    lista.resize(n+1,{});
//    verif.resize(n+1, false);
//    while(f >> x >> y)
//    {
//        lista[x].push_back(y);
//        lista[y].push_back(x);
//    }
//
//    int nrComp = 0;
//    for(int i = 1; i<=n; i++)
//    {
//        if(!verif[i])
//        {
//            nrComp++;
//            dfs(i);
//        }
//    }
//
//    g << nrComp;
//
//    f.close();
//    g.close();
//
//    return 0;
//}

// ----------------------------------------
// Bipartit

//
//#include <iostream>
//#include <vector>
//#include <queue>
//
//using namespace std;
//
//int n,m;
//vector<vector<int>> lista ;
//vector<int> bipartit;
//queue<int> q;
//
//int main()
//{
//    int x, y;
//    cin >> n >> m;
//    lista.resize(n+1,{});
//    for(int i=1; i<=m ; i++){
//        cin >> x >> y;
//        lista[x].push_back(y);
//        lista[y].push_back(x);
//    }
//    bipartit.resize(n+1, 0);
//    bool turn = true;
//
//    for(int i = 1; i<=n ; i++)
//    {
//        if(bipartit[i] == 0)
//        {
//            turn = true;
//            q.push(i);
//            while(!q.empty())
//            {
//                int size = q.size();
//                while(size)
//                {
//                    int curr = q.front();
//                    q.pop();
//                    if(turn)
//                        bipartit[curr] = 1;
//                    else{
//                        bipartit[curr] = 2;
//                    }
//                    for(auto vec : lista[curr])
//                        if(bipartit[vec] == bipartit[curr])
//                        {
//                            cout << "IMPOSSIBLE";
//                            return 0;
//                        }
//                        else if(bipartit[vec] == 0){
//                            q.push(vec);
//                        }
//                        size--;
//                }
//                turn = !turn;
//
//            }
//        }
//    }
//
//    for (int i = 1; i<=n ;i++)
//        cout << bipartit[i] << ' ';
//
//    return 0;
//}

// --------------------------------------------------------------------------------------
// Sortare topologica
//#include <iostream>
//#include <vector>
//#include <queue>
//using namespace std;
//int n,m;
//vector<vector<int>> lista;
//vector<int> verif;
//vector<int> raspuns;
//vector<int> gradIn;
//queue<int> q;
//
//int main()
//{
//    int x,y;
//    int contor = 0;
//    cin >> n >> m;
//    lista.resize(n+1, {});
//    verif.resize(n+1,0);
//    gradIn.resize(n+1,0);
//    for(int i = 1 ; i<=m ; i++){
//        cin >> x >> y;
//        lista[x].push_back(y);
//        gradIn[y]++;
//    }
//    for(int i = 1 ; i<=n; i++)
//        if(gradIn[i] == 0)
//            q.push(i);
//
//    while (!q.empty())
//    {
//        int curr = q.front();
//        q.pop();
//        raspuns.push_back(curr);
//        verif[curr] = 1;
//        contor++;
//        for(auto vec : lista[curr])
//        {gradIn[vec]--; if (gradIn[vec] == 0)q.push(vec);}
//    }
//    if(contor != n)
//    {
//        cout << "IMPOSSIBLE";
//    }
//    else
//        for(auto el : raspuns)
//            cout << el << ' ';
//
//    return  0;
//}
//// FILL
//#include <iostream>
//#include <vector>
//
//using namespace std;
//
//char mat[1001][1001];
//bool visited[1001][1001];
//int n, m;
//
//int counter;
//
//void fill(int i, int j)
//{
//    if(mat[i][j] != '.')return;
//    if(visited[i][j]) return;
//    if(i<1 || i > n)return;
//    if(j<1 || j >m)return;
//
//    visited[i][j] = true;
//
//    fill(i+1,j);
//    fill(i,j+1);
//    fill(i,j-1);
//    fill(i-1,j);
//}
//
//int main()
//{
//    cin >> n >> m;
//    for(int i = 1; i<= n ; i++)
//    {
//        for(int j = 1; j <= m; j++)
//        {
//            cin >> mat[i][j];
//        }
//    }
//
//    for(int i = 1; i<=n; i++)
//    {
//        for(int j = 1; j<=m ; j++)
//        {
//            if(!visited[i][j] && mat[i][j] == '.')
//            {
//                counter++;
//                fill(i,j);
//            }
//        }
//    }
//
//    cout << counter;
//
//    return 0;
//}
// Tarjan / Submerge
//#include <iostream>
//#include <vector>
//#include <queue>
//#include <cstring>
//using namespace std;
//
//int n, m;
//int x, y;
//int discovery[10005], low[10005], parent[10005];
//int visited[10005];
//int timer = 0;
//
//bool articulation[10005];
//vector<int> lista[10005];
//
//void dfs(int node) {
//    visited[node] = 1;
//    discovery[node] = low[node] = ++timer;
//    int children = 0;
//
//    for (int neighbor : lista[node]) {
//        if (!visited[neighbor]) {
//            children++;
//            parent[neighbor] = node;
//
//            dfs(neighbor);
//
//            low[node] = min(low[node], low[neighbor]);
//
//            // Check if node is an articulation point
//            if (parent[node] == -1 && children > 1) {
//                articulation[node] = true;
//            }
//            if (parent[node] != -1 && low[neighbor] >= discovery[node]) {
//                articulation[node] = true;
//            }
//        } else if (neighbor != parent[node]) {
//            low[node] = min(low[node], discovery[neighbor]);
//        }
//    }
//}
//
//void solveSubmerge() {
//    timer = 0;
//    memset(discovery, 0, sizeof(discovery));
//    memset(low, 0, sizeof(low));
//    memset(parent, -1, sizeof(parent));
//    memset(articulation, false, sizeof(articulation));
//    memset(visited, 0, sizeof(visited));
//
//    for (int i = 1; i <= m; i++) {
//        cin >> x >> y;
//        lista[x].push_back(y);
//        lista[y].push_back(x);
//    }
//
//    // Perform DFS for all nodes to handle disconnected graphs
//    for (int i = 1; i <= n; i++) {
//        if (!visited[i]) {
//            dfs(i);
//        }
//    }
//
//    int answer = 0;
//    for (int i = 1; i <= n; i++) {
//        if (articulation[i]) {
//            answer++;
//        }
//    }
//
//    cout << answer << '\n';
//
//    // Clear graph for next test case
//    for (int i = 1; i <= n; i++) {
//        lista[i].clear();
//    }
//}
//
//int main() {
//    cin >> n >> m;
//    while (n != 0 && m != 0) {
//        solveSubmerge();
//        cin >> n >> m;
//    }
//    return 0;
//}
//// Padure/ Lee
//#include <bits/stdc++.h>
//
//using namespace std;
//
//ifstream fin("padure.in");
//ofstream fout("padure.out");
//
//const int N = 1005;
//int n, m, a[N][N], b[N][N], xs, ys, xf, yf;
//
//pair<int, int> dir[4] = {{0, 1}, {0, -1}, {-1, 0}, {1, 0}};
//deque<pair<int, int>> Q;
//
//bool inmat(int, int);
//void lee(int, int);
//
//int main()
//{
//    fin >> n >> m;
//    fin >> xs >> ys >> xf >> yf;
//    for(int i = 1; i <= n; ++i)
//        for(int j = 1; j <= m; ++j)
//            fin >> a[i][j], b[i][j] = INT_MAX;
//    lee(xs, ys);
//    fout << b[xf][yf];
//    return 0;
//}
//
//bool inmat(int i, int j)
//{
//    return i >= 1 && i <= n && j <= m && j >= 1;
//}
//
//void lee(int xs, int ys)
//{
//    b[xs][ys] = 0;
//    Q.push_front({xs, ys});
//    while(!Q.empty())
//    {
//        int x = Q.front().first;
//        int y = Q.front().second;
//        Q.pop_front();
//        for(int d = 0; d < 4; ++d)
//        {
//            int i = x + dir[d].first;
//            int j = y + dir[d].second;
//            if(inmat(i, j))
//            {
//                int pret = b[x][y] + (a[i][j] != a[x][y] ? 1 : 0);
//                if(pret < b[i][j])
//                {
//                    b[i][j] = pret;
//                    if(!Q.empty() && b[i][j] <= b[Q.front().first][Q.front().second])
//                        Q.push_front({i, j});
//                    else
//                        Q.push_back({i, j});
//                }
//            }
//        }
//    }
//}

// Kruskal
//#include <fstream>
//#include <iostream>
//#include <vector>
//#include <queue>
//using namespace std;
//
//ifstream f("apm.in");
//ofstream g("apm.out");
//
//int n, m;
//priority_queue<pair<int, pair<int, int>>> muchii;
//
//int x, y, z;
//vector<int> parents;
//
//vector<pair<int, int>> apm;
//int cost = 0;
//
//int whoParent(int x) {
//    if (parents[x] != x)
//        parents[x] = whoParent(parents[x]);  // Path compression
//    return parents[x];
//}
//
//bool Union(int x, int y) {
//    int parentX = whoParent(x);
//    int parentY = whoParent(y);
//
//    if (parentX == parentY)  // Already in the same set
//        return false;
//
//    parents[parentY] = parentX;  // Union by rank can be added here
//    return true;
//}
//
//int main() {
//    f >> n >> m;
//
//    parents.resize(n + 1);
//    for (int i = 1; i <= n; i++)
//        parents[i] = i;
//
//    for (int i = 1; i <= m; i++) {
//        f >> x >> y >> z;
//        muchii.push({-z, {x, y}});  // Cost negativ pentru sortare crescătoare
//    }
//
//    while (!muchii.empty()) {
//        pair<int, pair<int, int>> curr = muchii.top();
//        muchii.pop();
//
//        if (Union(curr.second.first, curr.second.second)) {
//            cost += -curr.first;  // Reversăm semnul pentru costul real
//            apm.push_back(curr.second);
//        }
//
//        if (apm.size() == n - 1)  // Gata când avem n-1 muchii
//            break;
//    }
//
//    g << cost << '\n';
//    g << apm.size() << '\n';
//    for (auto elem : apm) {
//        g << elem.first << ' ' << elem.second << '\n';
//    }
//
//    return 0;
//}


//// Prim
//#include <iostream>
//#include <fstream>
//#include <vector>
//#include <queue>
//
//using namespace std;
//
//ifstream f("apm.in");
//ofstream g("apm.out");
//
//int n, m;
//vector<pair<int, int>> lista[200005]; // adjacency list
//priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<>> muchii; // min-heap
//vector<pair<int, int>> apm; // MST edges
//vector<bool> visited; // visited nodes
//int cost = 0; // total MST cost
//
//int main() {
//    f >> n >> m;
//    visited.resize(n + 1, false);
//
//    // Read the graph
//    for (int i = 1; i <= m; i++) {
//        int x, y, z;
//        f >> x >> y >> z;
//        lista[x].push_back({z, y});
//        lista[y].push_back({z, x});
//    }
//
//    // Initialize the priority queue with edges from node 1
//    visited[1] = true;
//    for (auto vecini : lista[1]) {
//        muchii.push({vecini.first, {1, vecini.second}});
//    }
//
//    // Prim's Algorithm
//    while (!muchii.empty() && apm.size() < n - 1) {
//        auto curr = muchii.top();
//        muchii.pop();
//
//        int weight = curr.first;
//        int from = curr.second.first;
//        int to = curr.second.second;
//
//        if (visited[to]) continue;
//
//        visited[to] = true;
//        cost += weight;
//        apm.push_back({from, to});
//
//        for (auto vec : lista[to]) {
//            if (!visited[vec.second]) {
//                muchii.push({vec.first, {to, vec.second}});
//            }
//        }
//    }
//
//    // Output the result
//    g << cost << '\n';
//    g << apm.size() << '\n';
//    for (auto elem : apm) {
//        g << elem.first << ' ' << elem.second << '\n';
//    }
//
//    return 0;
//}

//#include <iostream>
//#include <fstream>
//#include <vector>
//
//using namespace std;
//
//ifstream f("retea2.in");
//ofstream g("retea2.out");
//
//int m,n,x,y;
//
//int main()
//{
//    f >> n >> m;
//    vector<pair<int,pair<int,int>>> centrale;
//    for(int i = 1; i<= n; i++ )
//    {
//        cin >> x >> y;
//        centrale.push_back({i, {x,y}});
//    }
//
//    return 0;
//}
//
//#include <cmath>
//#include <cstdio>
//#include <vector>
//#include <iostream>
//#include <algorithm>
//#include <queue>
//using namespace std;
//
//
//vector<int> graph[100005];
//vector<int> reverseGraph[10005];
//
//int x,y,m,n, k ;
//vector<int> kNodes;
//queue<int> q;
//vector<int> parents;
//vector<int> distances;
//
//int main() {
//    cin >> n >> m >> k ;
//    parents.resize(n+5,0);
//    distances.resize(n+5,0);
//    for(int i = 1; i<=k; i++)
//    {
//        cin >> x;
//        kNodes.push_back(x);
//    }
//    for(int i =1 ; i <= m ; i++)
//    {
//        cin >> x >> y;
//        graph[x].push_back(y);
//        reverseGraph[y].push_back(x);
//    }
//    for(int i = 1; i<=n; i++)
//    {
//        parents[i] = i;
//        if(graph[i].size() == 0)
//        {
//            q.push(i);
//            distances[i] = 0;
//        }
//    }
//
//    while(!q.empty())
//    {
//        int curr = q.front();
//        q.pop();
//        for(auto vec : reverseGraph[curr])
//        {
//            if(distances[vec] < distances[curr]+1)
//            {
//                parents[vec] = curr;
//                distances[vec] = distances[curr] + 1;
//                q.push(vec);
//            }
//        }
//    }
//
//    int nodeAnswer = kNodes[0];
//    for(auto node: kNodes)
//    {
//        if(distances[nodeAnswer] < distances[node])
//            nodeAnswer = node;
//    }
//    cout <<distances[nodeAnswer] << '\n';
//
//    while(parents[nodeAnswer] != nodeAnswer)
//    {
//        cout << nodeAnswer << ' ' ;
//        nodeAnswer = parents[nodeAnswer];
//    }
//    cout << nodeAnswer;
//
//    return 0;
//}
//
//#include <cmath>
//#include <cstdio>
//#include <vector>
//#include <iostream>
//#include <algorithm>
//#include <queue>
//#include <set>
//
//using namespace std;
//
//vector<int> graph[100005];
//vector<pair<int,int>> answerDfs;
//vector<pair<int,int>> answerBfs;
//
//set<pair<int,int>> dfsK;
//set<pair<int,int>> bfsK;
//
//int n,m,x,y;
//
//vector<bool> verif1;
//vector<bool> verif2;
//
//void dfs(int node){
//    if(verif1[node])
//        return;
//    verif1[node] = true;
//    for(auto vec : graph[node])
//    {
//        if(!verif1[vec]){
//            answerDfs.push_back({min(node,vec),max(node,vec)});
//            dfsK.insert({min(node,vec),max(node,vec)});
//            dfs(vec);
//        }
//    }
//}
//
//void bfs(int node){
//    queue<int> q;
//    q.push(node);
//    verif2[node] = true;
//    while(!q.empty())
//    {
//        int curr = q.front();
//        q.pop();
////        cout << "Processing " << curr << ' ' << verif2[curr] << '\n';
////        cout << "I am here\n";
//        for(auto vec : graph[curr]){
//            if(!verif2[vec]){
////                cout << "Curr "<< curr << ' ' << vec << '\n';
//                verif2[vec]  = true;
//
//                bfsK.insert({min(curr,vec), max(curr,vec)});
//                answerBfs.push_back({min(vec,curr), max(curr,vec)});
//                q.push(vec);
//            }
//        }
//    }
//}
//
//int main() {
//    cin >> n >> m ;
//    for(int i = 1; i<= m ; i++)
//    {
//        cin >> x >> y;
//        graph[x].push_back(y);
//        graph[y].push_back(x);
//    }
//    verif1.resize(n+5,false);
//    dfs(1);
//
//    verif2.resize(n+5,false);
//    bfs(1);
//
//    for(int i = 1; i<=n ; i++)
//    {
//        if(!verif1[i]){
//            cout << "Nu";
//            return 0;
//        }
//    }
//
//    for(int i = 0; i < answerDfs.size(); i++)
//        if(!bfsK.contains(answerDfs[i])){
////            cout << answerDfs[i].first << ' '<< answerDfs[i].second<<'\n';
//            cout << "DA\n";
//            for(auto p : answerDfs)
//                cout << p.first << ' ' << p.second << '\n';
//            cout << "----\n";
//            for(auto p : answerBfs)
//                cout << p.first << ' ' << p.second << '\n';
//            return 0;
//        }
//    cout << "NU";
//    return 0;
//}
//
//#include <cmath>
//#include <cstdio>
//#include <vector>
//#include <iostream>
//#include <algorithm>
//#include <queue>
//using namespace std;
//
//vector<int> graph[100005];
//vector<int> arbore[100005];
//vector<int> reverseArbore[100005];
//vector<bool> verif;
//vector<bool> verif2;
//int n, r , c;
//int x, y;
//
//vector<int> ascendenti;
//vector<int> descendenti;
//
//bool dfs(int node){
//
//    if(node == c)
//        return true;
//    verif[node] = true;
//    for(auto vec : graph[node])
//        if(!verif[vec] && dfs(vec))
//
//        {
////            cout << node << '\n';
//            ascendenti.push_back(node);
//            return true;}
//    return false;
//}
//int startAdding = 0;
//void dfs2(int node){
//    verif2[node] = true;
//    if(node == c)
//        startAdding = 1;
//    for(auto vec : graph[node])
//    {
//
//        if(!verif2[vec])
//        {
////            cout << node << ' ' << vec << '\n';
//            if (startAdding)
//                descendenti.push_back(vec);
//            dfs2(vec);
//        }
//    }
//    if(node == c)
//        startAdding = 0;
//}
//
//
//int main() {
//    cin >> n >> r >> c;
//    verif.resize(n+5, false);
//    verif2.resize(n+5, false);
//    for(int i = 1; i<= n-1; i++)
//    {
//        cin >> x >> y;
//        graph[x].push_back(y);
//        graph[y].push_back(x);
//    }
//    dfs(r);
//
//    dfs2(r);
////    cout << "Ascendenti ";
//    if(ascendenti.size()){
//        for(auto asc : ascendenti)
//            cout << asc << ' ';
//    }
//    else
//        cout << '0';
//    cout << "\n";
//
//    if(descendenti.size()){
//        for(auto desc: descendenti)
//            cout << desc << ' ';
//    }
//    else
//        cout << '0';
//    // queue<int> q;
//    // q.push(r);
//    // while(!q.empty())
//    // {
//    //  int curr = q.front();
//    //  q.pop();
//    //  for(auto vec : graph[curr])
//    //  {
//    //      if(!arbore[vec].size())
//    //          continue;
//    //      arbore[curr].puhs_back(vec);
//    //      q.push(vec);
//    //  }
//    // }
//    return 0;
//}

//#include <cmath>
//#include <cstdio>
//#include <vector>
//#include <iostream>
//#include <algorithm>
//#include <queue>
//using namespace std;
//
//int n, m;
//priority_queue<pair<int, pair<int, int>>> muchii;
//vector<pair<int,pair<int,int>>> edges;
//int x, y, z;
//vector<int> parents;
//
//vector<pair<int, int>> apm;
//int cost = 0;
//int partialCost = 0;
//
//int whoParent(int x) {
//    if (parents[x] != x)
//        parents[x] = whoParent(parents[x]);  // Path compression
//    return parents[x];
//}
//
//bool Union(int x, int y) {
//    int parentX = whoParent(x);
//    int parentY = whoParent(y);
//
//    if (parentX == parentY)  // Already in the same set
//        return false;
//
//    parents[parentY] = parentX;  // Union by rank can be added here
//    return true;
//}
//
//void kruskal(int selectedEdge){
////    cout << "Sel " << selectedEdge << ' ' << edges[selectedEdge].second.first << ' ' << edges[selectedEdge].second.second << '\n';
//    for (int i = 1; i <= n; i++)
//        parents[i] = i;
//    while(!muchii.empty()){
//        muchii.pop();
//    }
//    for (int i = 0; i < m; i++) {
//        muchii.push(edges[i]);  // Cost negativ pentru sortare crescătoare
//    }
//    partialCost = 0;
//    if(selectedEdge != -1){
//        Union(edges[selectedEdge].second.first, edges[selectedEdge].second.second);
//        partialCost += -edges[selectedEdge].first;
//    }
//
//    while (!muchii.empty()) {
//        pair<int, pair<int, int>> curr = muchii.top();
//        muchii.pop();
////        cout << curr.second.first << ' ' << curr.second.second <<'\n';
//        if (Union(curr.second.first, curr.second.second)) {
//            if(selectedEdge == -1)
//            {cost += -curr.first;
//                apm.push_back(curr.second);
//
//            }  // Reversăm semnul pentru costul real
//            else
//                partialCost += -curr.first;
//        }
//
//        if (-1 == selectedEdge &&apm.size() == n - 1)  // Gata când avem n-1 muchii
//            break;
//    }
//
//}
//
//int main() {
//    cin >> n >> m;
//
//    parents.resize(n + 1);
//    for (int i = 1; i <= n; i++)
//        parents[i] = i;
//
//    for (int i = 1; i <= m; i++) {
//        cin >> x >> y >> z;
//        edges.push_back({-z,{x,y}});
//    }
//
//    kruskal(-1);
////    cout << "Cost" << cost << '\n';
//    int k;
//    cin >> k;
//
//    for(int i = 1; i<=k; i++){
//        int x1;
//        cin >> x1;
//        kruskal(x1-1);
////        cout << partialCost << " " << cost << '\n';
//        if(cost != partialCost){
//            cout << "Nu\n";
//        }
//        else{
//            cout << "Da\n";
//        }
//    }
//
//    return 0;
//}
//

//
//#include <cmath>
//#include <cstdio>
//#include <vector>
//#include <iostream>
//#include <algorithm>
//using namespace std;
//
//vector<pair<int,int>> graph[100005];
//int n,m,x,y,z;
//vector<bool> verif;
//int biggestDistance;
//vector<int> answer;
//void dfs(int node, int distance){
////    cout << node << ' ' << distance << '\n';
//    if(distance > biggestDistance){
//        answer.clear();
//        answer.push_back(node);
//        biggestDistance = distance;
//    }
//    else if(distance == biggestDistance){
//        answer.push_back(node);
//    }
//    verif[node] = true;
//    for(auto vec: graph[node]){
//        if(!verif[vec.first]){
//            dfs(vec.first, distance + vec.second);
//        }
//    }
//    verif[node] = false;
//}
//
//int main() {
//    cin >> n >> m;
//    for(int i = 1; i<=m ; i++){
//        cin >> x >> y >> z;
//        graph[x].push_back({y,z});
//
//    }
//    verif.resize(n+5,false);
//    dfs(1,0);
////    cout << biggestDistance << '\n';
//    for(auto ans : answer)
//        cout << ans << ' ';
//    return 0;
//}
//
//
//
//#include <cmath>
//#include <cstdio>
//#include <vector>
//#include <iostream>
//#include <algorithm>
//#include <queue>
//using namespace std;
//
//vector<int> graph[100005];
//vector<int> tree[100005];
//vector<int> descendenti;
//
//int n, r, c1, c2, x,y;
//
//void makeTree(int r){
//    queue<int> q;
//    vector<int> verif(n+5,0);
//    q.push(r);
//    verif[r] = 1;
//
//    while(!q.empty())
//    {
//        int curr = q.front();
//        q.pop();
//        for(auto vec : graph[curr])
//        {
//            if(!verif[vec]){
//                q.push(vec);
//                verif[vec] = 1;
//                tree[curr].push_back(vec);
//            }
//        }
//    }
//}
//
//void makeDescendenti(int c){
//    queue<int> q;
//    q.push(c);
//
//    while(!q.empty()){
//        int curr = q.front();
//        q.pop();
//
//        for(auto vec : tree[curr]){
//            descendenti[vec]+=1;
//            q.push(vec);
//        }
//
//    }
//}
//
//int main() {
//    cin >> n >> r >> c1 >> c2;
//    descendenti.resize(n+5,0);
//    for(int i = 1; i<n; i++)
//    {
//        cin >> x >> y;
//        graph[x].push_back(y);
//        graph[y].push_back(x);
//    }
//
//    makeTree(r);
//
//    makeDescendenti(c1);
//
//    makeDescendenti(c2);
//
//    int contor = 0;
//
//    for(int i = 1; i<= n ; i++)
//        if(descendenti[i] == 2){
//            cout << i << ' ';
//            contor +=1;
//        }
//
//    if(contor == 0)
//        cout << 0;
//
//    return 0;
//}

//
//
//#include <fstream>
//#include <iostream>
//#include <vector>
//#include <queue>
//#include <set>
//using namespace std;
//
//int n, m;
//priority_queue<pair<int, pair<int, int>>> muchii;
//vector<pair<int,pair<int,int>>> edges;
//
//set<pair<int,pair<int,int>>> usedInApm;
//
//int x, y, z;
//vector<int> parents;
//
//vector<pair<int,pair<int, int>>> apm;
//
//
//vector<pair<int,pair<int, int>>> apmCopy;
//
//int cost = 0;
//
//int whoParent(int x) {
//    if (parents[x] != x)
//        parents[x] = whoParent(parents[x]);  // Path compression
//    return parents[x];
//}
//
//bool Union(int x, int y) {
//    int parentX = whoParent(x);
//    int parentY = whoParent(y);
//
//    if (parentX == parentY)  // Already in the same set
//        return false;
//
//    parents[parentY] = parentX;  // Union by rank can be added here
//    return true;
//}
//
//void Kruskal(){
//
//    while (!muchii.empty()) {
//        pair<int, pair<int, int>> curr = muchii.top();
//        muchii.pop();
//
//        if (Union(curr.second.first, curr.second.second)) {
//            cost += -curr.first;  // Reversăm semnul pentru costul real
//            apm.push_back(curr);
//        }
//
//        if (apm.size() == n - 1)  // Gata când avem n-1 muchii
//            break;
//    }
//
//}
//
//int main() {
//    cin >> n >> m;
//
//    parents.resize(n + 1);
//    for (int i = 1; i <= n; i++)
//        parents[i] = i;
//
//    for (int i = 1; i <= m; i++) {
//        cin >> x >> y >> z;
//        edges.push_back({-z,{x,y}});
//        muchii.push({-z, {x, y}});  // Cost negativ pentru sortare crescătoare
//    }
//
//    Kruskal();
//
////    cout << cost << '\n';
////    cout << apm.size() << '\n';
//    for (auto elem : apm) {
//        apmCopy.push_back(elem);
//        usedInApm.insert(elem);
////        cout << elem.first << ' ' << elem.second.first << ' ' << elem.second.second <<  '\n';
//    }
//
//    int k,copyCost;
//    int answer = 0;
//
//    copyCost = cost;
//
//    cin >> k;
//
//    for(int i = 1; i<=k; i++){
//        cin >> x;
//        x-=1;
//        if(usedInApm.find(edges[x]) != usedInApm.end()){
//            continue;
//        }
//        while (!muchii.empty())
//        muchii.pop() ;
//
//        for (int i = 1; i <= n; i++)
//            parents[i] = i;
//        apm.clear();
//
//
//        Union(edges[x].second.first, edges[x].second.second);
//        cost = -edges[x].first;
//        apm.push_back(edges[x]);
//
//        for(auto edge : apmCopy)
//            muchii.push({edge.first,edge.second});
//
//
//        Kruskal();
//
////        cout << x << ' ' << " cost "<< cost <<
//        '\n';
//        if(cost != copyCost)
//            answer+=1;
//    }
//
//    cout << answer;
//    return 0;
//}

//
//#include <iostream>
//#include <vector>
//#include <algorithm>
//#include <queue>
//
//using namespace std;
//
//int n,m,x,y,z;
//
//vector<pair<int,int>> graph[100005];
//
//vector<bool> verif;
//
//vector<int> distances;
//
//
//void dfs(int curr){
//    verif[curr] = true;
//    for(auto vec : graph[curr])
//    {
//        if(!verif[vec.first])
//        {
//
//            if(distances[vec.first] > distances[curr] + vec.second){
//                distances[vec.first] = distances[curr] + vec.second;
//            }
//            dfs(vec.first);
//        }
//    }
//    verif[curr] = false;
//}
//
//int main(){
//    cin >> n >> m;
//    verif.resize(n+5,false);
//    distances.resize(n+5,999999999);
//    for(int i = 1; i<= m; i++){
//        cin >> x >> y >> z;
//        graph[x].push_back({y,z});
//    }
//    distances[1] = 0;
////    dfs(1);
//    queue<int> q;
//    q.push(1);
//    while(!q.empty()){
//        int curr = q.front();
//        verif[curr] = true;
//
//        q.pop();
//        for(auto vec : graph[curr]){
//            if(distances[vec.first] > distances[curr] + vec.second)
//                distances[vec.first]  = distances[curr] + vec.second;
//            if(!verif[vec.first])
//                q.push(vec.first);
//        }
//    }
//    int maxDistane = -1;
//    for(int i = 1;  i<=n; i++)
//        maxDistane = max(maxDistane, distances[i]);
//
////    cout << maxDistane;
//    for(int i = 1;  i<=n; i++)
//
//        if(distances[i] == maxDistane)
//            cout << i << ' ';
//    return 0;
//}
//
//#include <cmath>
//#include <cstdio>
//#include <vector>
//#include <iostream>
//#include <algorithm>
//using namespace std;
//
//vector<pair<int, int>> graph1;
//vector<pair<int, int>> graph0;
//
//vector<int> parents0;
//vector<int> parents1;
//
//int n, m, x, y, c;
//
//int whoIsParent(int curr, int c1) {
//    if (c1 == 0) {
//        if (parents0[curr] == curr)
//            return curr;
//        return parents0[curr] = whoIsParent(parents0[curr], c1);
//    } else if (c1 == 1) {
//        if (parents1[curr] == curr)
//            return curr;
//        return parents1[curr] = whoIsParent(parents1[curr], c1);
//    }
//    return -1;
//}
//
//void Union(int x1, int y1, int c1) {
//    int parentX = whoIsParent(x1, c1);
//    int parentY = whoIsParent(y1, c1);
//
//    if (parentX != parentY) {
//        if (c1 == 0) {
//            // Merge smaller component into larger for efficiency
//            if (parentX < parentY)
//                parents0[parentY] = parentX;
//            else
//                parents0[parentX] = parentY;
//        } else if (c1 == 1) {
//            if (parentX < parentY)
//                parents1[parentY] = parentX;
//            else
//                parents1[parentX] = parentY;
//        }
//    }
//}
//
//int main() {
//    cin >> n >> m;
//
//    for (int i = 1; i <= m; i++) {
//        cin >> x >> y >> c;
//        if (c == 0) {
//            graph0.push_back({x, y});
//        } else if (c == 1) {
//            graph1.push_back({x, y});
//        }
//    }
//
//    parents0.resize(n + 1);
//    parents1.resize(n + 1);
//    for (int i = 1; i <= n; i++) {
//        parents0[i] = i;
//        parents1[i] = i;
//    }
//
//    // Process edges for graph0 (c == 0)
//    for (auto edge : graph0) {
//        Union(edge.first, edge.second, 0);
//    }
//
//    // Process edges for graph1 (c == 1)
//    for (auto edge : graph1) {
//        Union(edge.first, edge.second, 1);
//    }
//
//    // Flatten the parent relationships
//    for (int i = 1; i <= n; i++) {
//        parents0[i] = whoIsParent(i, 0);
//        parents1[i] = whoIsParent(i, 1);
//    }
//
//    // Debugging output: print the connected components
//    cout << "Connected components for c == 0:\n";
//    for (int i = 1; i <= n; i++) {
//        cout << parents0[i] << ' ';
//    }
//    cout << '\n';
//
//    cout << "Connected components for c == 1:\n";
//    for (int i = 1; i <= n; i++) {
//        cout << parents1[i] << ' ';
//    }
//    cout << '\n';
//
//    // Answer queries
//    int q;
//    cin >> q;
//    for (int i = 1; i <= q; i++) {
//        cin >> x >> y >> c;
//        if (c == 0) {
//            if (parents0[x] == parents0[y])
//                cout << "DA\n";
//            else
//                cout << "NU\n";
//        } else if (c == 1) {
//            if (parents1[x] == parents1[y])
//                cout << "DA\n";
//            else
//                cout << "NU\n";
//        }
//    }
//
//    return 0;
//}

//
//#include <cmath>
//#include <cstdio>
//#include <vector>
//#include <iostream>
//#include <algorithm>
//#include <queue>
//#include <set>
//using namespace std;
//
//vector<int> graph[100005];
//vector<int> postGraph[100005];
//vector<int> inDegree;
//vector<int> verif;
//vector<int> distances;
//vector<int> destinations;
//int n,m, x, y, k;
//int main() {
//    cin >> n >> m;
//    cin >> k;
//    distances.resize(n+5,-1);
//    inDegree.resize(n+5,0);
//    queue<int> q;
//    for(int i = 1; i<=k ; i++){
//        cin >> x;
//        destinations.push_back(x);
//    }
//    verif.resize(n+5,0);
//    for(int i = 1; i<= m; i++){
//        cin >> x >>y ;
//        graph[x].push_back(y);
//        postGraph[y].push_back(x);
//        inDegree[y]++;
//    }
//    for(int i = 1; i<= n; i++){
//        if(inDegree[i] == 0){
//            q.push(i);
////            verif[i] = 1;
//            distances[i] = 0;
//        }
//    }
//
//    while(!q.empty()){
//        int curr = q.front();
//        q.pop();
//
//        for(auto vec: graph[curr])
//        {
//            if(distances[vec] < distances[curr]+1){
//                distances[vec] = max(distances[vec],distances[curr]+1);
//                q.push(vec);
////                verif[vec] = 1;
//            }
//
//        }
//    }
//    int maxDistance = destinations[0];
//    for(int i = 1; i<=destinations.size() ; i++)
//        if(distances[maxDistance] < distances[destinations[i]])
//            maxDistance = destinations[i];
//    vector<int> backtrack;
//    backtrack.push_back(maxDistance);
//    while(distances[maxDistance] != 0){
//        for(auto vec : postGraph[maxDistance]){
//            if(distances[vec] == distances[maxDistance] - 1){
//                backtrack.push_back(vec);
//                maxDistance = vec;
//                break;
//            }
//        }
//    }
//    cout << distances[backtrack[0]];
//    cout << '\n';
//    for(int item = backtrack.size()-1 ; item >= 0; item--)
//        cout << backtrack[item] << ' ' ;
//    return 0;
//}

//
//#include <iostream>
//#include <vector>
//#include <queue>
//#include <set>
//using namespace std;
//
//vector<int> graph[100005];
//vector<int> dfsTree[100005];
//vector<int> bfsTree[100005];
//
//set<pair<int, int>> dfsK;
//set<pair<int, int>> bfsK;
//
//int n, m, x, y;
//vector<bool> visitedDFS;
//vector<bool> visitedBFS;
//
//void dfs(int node) {
//    if (visitedDFS[node]) return;
//    visitedDFS[node] = true;
//
//    for (auto vec : graph[node]) {
//        if (!visitedDFS[vec]) {
//            dfsTree[node].push_back(vec);
//            dfsTree[vec].push_back(node);
//            dfsK.insert({min(node, vec), max(node, vec)});
//            dfs(vec);
//        }
//    }
//}
//
//void bfs(int start) {
//    queue<int> q;
//    q.push(start);
//    visitedBFS[start] = true;
//
//    while (!q.empty()) {
//        int curr = q.front();
//        q.pop();
//
//        for (auto vec : graph[curr]) {
//            if (!visitedBFS[vec]) {
//                visitedBFS[vec] = true;
//
//                bfsTree[curr].push_back(vec);
//                bfsTree[vec].push_back(curr);
//                bfsK.insert({min(curr, vec), max(curr, vec)});
//                q.push(vec);
//            }
//        }
//    }
//}
//
//void printAdjacencyList(const vector<int> tree[], int nodes) {
//    for (int i = 1; i <= nodes; ++i) {
//        if (!tree[i].empty()) {
//            for (auto neighbor : tree[i]) {
//                cout << neighbor << " ";
//            }
//            cout << endl;
//        }
//    }
//}
//
//int main() {
//    cin >> n >> m;
//
//    for (int i = 1; i <= m; i++) {
//        cin >> x >> y;
//        graph[x].push_back(y);
//        graph[y].push_back(x);
//    }
//
//    visitedDFS.resize(n + 5, false);
//    visitedBFS.resize(n + 5, false);
//
//    dfs(1);
//    bfs(1);
//
//    for(int i = 1; i<=n; i++)
//        if(visitedBFS[i] == 0){
//            cout << "Nu";
//            return 0;
//        }
//
//    if (dfsK != bfsK) {
//        cout << "Da" << endl;
//
//        printAdjacencyList(dfsTree, n);
//
//        printAdjacencyList(bfsTree, n);
//    } else {
//        cout << "Nu" << endl;
//    }
//
//    return 0;
//}


//#include <iostream>
//#include <vector>
//#include <queue>
//#include <unordered_set>
//#include <algorithm>
//using namespace std;
//
//// Graph representation
//vector<vector<int>> adjList;
//vector<bool> visited;
//vector<int> parent;
//vector<int> color;
//
//// Cycle storage
//vector<int> cycle1; // Odd-length cycle
//vector<int> cycle2; // Any other cycle
//
//// Function to reconstruct a cycle
//vector<int> reconstructCycle(int start, int end, vector<int>& parent) {
//    vector<int> cycle;
//    cycle.push_back(end);
//    while (start != end) {
//        cycle.push_back(start);
//        start = parent[start];
//    }
//    cycle.push_back(end); // Close the cycle
//    reverse(cycle.begin(), cycle.end());
//    return cycle;
//}
//
//// DFS function to find cycles
//bool dfs(int node, int par, bool& foundOddCycle) {
//    visited[node] = true;
//    color[node] = 1 - color[par]; // Alternate color
//
//    for (int neighbor : adjList[node]) {
//        if (!visited[neighbor]) {
//            parent[neighbor] = node;
//            if (dfs(neighbor, node, foundOddCycle)) return true;
//        } else if (neighbor != par) { // Cycle detected
//            // Reconstruct the cycle
//            vector<int> cycle = reconstructCycle(node, neighbor, parent);
//
//            if (cycle1.empty() && cycle.size() % 2 == 0) {
//                // First odd-length cycle
////                cout << cycle.size() <<  " HERE\n";
//                for(auto i : cycle) cout << i << ' ' ;
//                cout << '\n';
//                cycle1 = cycle;
//                foundOddCycle = true;
//            } else if (cycle2.empty()) {
//                // Another cycle
//                cycle2 = cycle;
//            }
//
//            if (foundOddCycle && !cycle2.empty()) return true;
//        }
//    }
//
//    return false;
//}
//
//int main() {
//    // Read graph input
//    int n, m;
//    cin >> n >> m;
//
//    adjList.resize(n + 1);
//    visited.resize(n + 1, false);
//    parent.resize(n + 1, -1);
//    color.resize(n + 1, 0);
//
//    for (int i = 0; i < m; i++) {
//        int u, v;
//        cin >> u >> v;
//        adjList[u].push_back(v);
//        adjList[v].push_back(u);
//    }
//
//    // Find cycles using DFS
//    bool foundOddCycle = false;
//    for (int i = 1; i <= n; i++) {
//        if (!visited[i]) {
//            parent[i] = i; // Root of this DFS tree
//            if (dfs(i, 0, foundOddCycle)) break;
//        }
//    }
//
//    // Output results for part (a)
//    cout << "a)\n";
//    if (cycle1.empty()) {
//        cout << "Nu avem cicluri de lungime impara.\n";
//    } else {
//        for (size_t i = 0; i < cycle1.size() - 1; i++) {
//            cout << cycle1[i] << " " << cycle1[i + 1] << "\n";
//        }
//    }
//
//    // Output results for part (b)
//    cout << "b)\n";
//    if (cycle2.empty()) {
//        cout << "Nu exista alte cicluri.\n";
//    } else {
//        for (size_t i = 0; i < cycle2.size() - 1; i++) {
//            cout << cycle2[i] << " " << cycle2[i + 1] << "\n";
//        }
//    }
//
//    return 0;
//}



// Kruskal
//#include <fstream>
//#include <iostream>
//#include <vector>
//#include <queue>
//using namespace std;
//
//
//int n, m, k;
//priority_queue<pair<int, pair<int, int>>> muchii;
//vector<pair<int,int>> graph[1005];
//vector<int> minCosts;
//
//int x, y, z;
//vector<int> parents;
//vector<pair<int,pair<int,int>>> edges;
//
//vector<pair<int,pair<int, int>>> apm;
//int cost = 0;
//
//int whoParent(int x) {
//    if (parents[x] != x)
//        parents[x] = whoParent(parents[x]);  // Path compression
//    return parents[x];
//}
//
//bool Union(int x, int y) {
//    int parentX = whoParent(x);
//    int parentY = whoParent(y);
//
//    if (parentX == parentY)  // Already in the same set
//        return false;
//
//    parents[parentY] = parentX;  // Union by rank can be added here
//    return true;
//}
//
//
//
//int main() {
//    cin >> n >> m;
//
//    parents.resize(n + 1);
//    for (int i = 1; i <= n; i++)
//        parents[i] = i;
//
//    for (int i = 1; i <= m; i++) {
//        cin >> x >> y >> z;
//        edges.push_back({z,{x,y}});
//        muchii.push({-z, {x, y}});  // Cost negativ pentru sortare crescătoare
//    }
//
//    while (!muchii.empty()) {
//        pair<int, pair<int, int>> curr = muchii.top();
//        muchii.pop();
//
//        if (Union(curr.second.first, curr.second.second)) {
//            cost += -curr.first;  // Reversăm semnul pentru costul real
//            apm.push_back({-curr.first,curr.second});
//        }
//
//        if (apm.size() == n - 1)  // Gata când avem n-1 muchii
//            break;
//    }
//
//    cout << cost << '\n';
//    cout << apm.size() << '\n';
//    for (auto elem : apm) {
//        cout << elem.first << ' ' << elem.second.first << ' ' << elem.second.second << '\n';
//        graph[elem.second.first].push_back({elem.second.second, elem.first});
//        graph[elem.second.second].push_back({elem.second.first, elem.first});
//    }
//    minCosts.resize(n+5,0);
//    for(int i = 1; i<= n; i++){
//
//        int minCostEdge = graph[i][0].first;
//        for(auto edge : graph[i])
//            if(edge.first < minCostEdge)
//                minCostEdge = edge.first;
//
//        minCosts[i] = minCostEdge;
//    }
//
//    cin >> k;
//
//    for(int i = 1; i<= n ; i++)
//    {
//        cout << i<< ": " << minCosts[i] << '\n';
//    }
//
//    for(int i = 1; i <= k ; i++){
//        cin >> x;
//        x--;
//        if(min(minCosts[edges[x].second.first],minCosts[edges[x].second.second]) == minCosts[i])
//            cout << "Da\n";
//        else
//            cout << "Nu\n";
//    }
//
//    return 0;
//}

//
//#include <iostream>
//#include <vector>
//#include <tuple>
//#include <algorithm>
//#include <queue>
//#include <cmath>
//#include <climits>
//
//using namespace std;
//
//const int MAXN = 100005; // Maximum number of nodes
//const int LOG = 20;      // Maximum depth for binary lifting (log2(MAXN))
//
//struct Edge {
//    int u, v, cost;
//    bool operator<(const Edge &other) const {
//        return cost < other.cost; // Sort edges by cost
//    }
//};
//
//int n, m;                         // Number of nodes and edges
//vector<Edge> edges;               // List of edges
//vector<pair<int, int>> mst[MAXN]; // Adjacency list of the MST
//int parent[MAXN], depth[MAXN];    // Parent and depth arrays
//int maxEdge[MAXN][LOG];           // Max edge on paths
//int up[MAXN][LOG];                // Binary lifting table
//
//// Disjoint Set Union (DSU) for Kruskal
//struct DSU {
//    vector<int> parent, rank;
//    DSU(int n) : parent(n), rank(n, 0) {
//        for (int i = 0; i < n; ++i) parent[i] = i;
//    }
//    int find(int x) {
//        if (parent[x] != x) parent[x] = find(parent[x]);
//        return parent[x];
//    }
//    void unite(int x, int y) {
//        int rootX = find(x);
//        int rootY = find(y);
//        if (rootX != rootY) {
//            if (rank[rootX] > rank[rootY])
//                parent[rootY] = rootX;
//            else if (rank[rootX] < rank[rootY])
//                parent[rootX] = rootY;
//            else {
//                parent[rootY] = rootX;
//                rank[rootX]++;
//            }
//        }
//    }
//};
//
//// Kruskal's algorithm to build MST
//long long kruskal() {
//    sort(edges.begin(), edges.end());
//    DSU dsu(n);
//    long long mstCost = 0;
//
//    for (const auto &edge : edges) {
//        if (dsu.find(edge.u) != dsu.find(edge.v)) {
//            dsu.unite(edge.u, edge.v);
//            mst[edge.u].emplace_back(edge.v, edge.cost);
//            mst[edge.v].emplace_back(edge.u, edge.cost);
//            mstCost += edge.cost;
//        }
//    }
//
//    return mstCost;
//}

// Preprocessing LCA and max edge on paths using Binary Lifting
//void preprocessLCA(int node, int par, int dep) {
//    parent[node] = par;
//    depth[node] = dep;
//
//    for (int j = 1; j < LOG; ++j) {
//        if (up[node][j - 1] != -1) {
//            up[node][j] = up[up[node][j - 1]][j - 1];
//            maxEdge[node][j] = max(maxEdge[node][j - 1], maxEdge[up[node][j - 1]][j - 1]);
//        }
//    }
//
//    for (const auto &[neighbor, weight] : mst[node]) {
//        if (neighbor != par) {
//            up[neighbor][0] = node;
//            maxEdge[neighbor][0] = weight;
//            preprocessLCA(neighbor, node, dep + 1);
//        }
//    }
//}
//
//// Find maximum edge on the path between two nodes
//int findMaxEdge(int u, int v) {
//    if (depth[u] < depth[v]) swap(u, v);
//    int maxCost = 0;
//
//    // Lift u to the same level as v
//    for (int i = LOG - 1; i >= 0; --i) {
//        if (depth[u] - (1 << i) >= depth[v]) {
//            maxCost = max(maxCost, maxEdge[u][i]);
//            u = up[u][i];
//        }
//    }
//
//    if (u == v) return maxCost;
//
//    // Lift both u and v until they meet
//    for (int i = LOG - 1; i >= 0; --i) {
//        if (up[u][i] != up[v][i]) {
//            maxCost = max({maxCost, maxEdge[u][i], maxEdge[v][i]});
//            u = up[u][i];
//            v = up[v][i];
//        }
//    }
//
//    // Account for the last edge before the LCA
//    return max({maxCost, maxEdge[u][0], maxEdge[v][0]});
//}
//
//int main() {
//    // Input graph
//    cin >> n >> m;
//    edges.resize(m);
//
//    for (int i = 0; i < m; ++i) {
//        cin >> edges[i].u >> edges[i].v >> edges[i].cost;
//        edges[i].u--;
//        edges[i].v--;
//    }
//
//    // a) Build MST
//    long long mstCost = kruskal();
//    cout << "Costul MST inițial: " << mstCost << endl;
//
//    // Preprocess LCA and max edge on paths
//    fill(&up[0][0], &up[0][0] + MAXN * LOG, -1);
//    preprocessLCA(0, -1, 0);
//
//    // b) Evaluate new edges
//    Edge newEdge1, newEdge2;
//    cin >> newEdge1.u >> newEdge1.v >> newEdge1.cost;
//    cin >> newEdge2.u >> newEdge2.v >> newEdge2.cost;
//    newEdge1.u--, newEdge1.v--;
//    newEdge2.u--, newEdge2.v--;
//
//    auto computeNewCost = [&](const Edge &e) {
//        int maxCostInCycle = findMaxEdge(e.u, e.v);
//        return mstCost - maxCostInCycle + e.cost;
//    };
//
//    long long cost1 = computeNewCost(newEdge1);
//    long long cost2 = computeNewCost(newEdge2);
//
//    cout << cost1 << " " << cost2 << '\n';
//
//    if (cost1 < cost2) {
//        cout << "Alegem muchia (" << newEdge1.u + 1 << ", " << newEdge1.v + 1
//             << ") cu cost MST: " << cost1 << endl;
//    } else {
//        cout << "Alegem muchia (" << newEdge2.u + 1 << ", " << newEdge2.v + 1
//             << ") cu cost MST: " << cost2 << endl;
//    }
//
//    return 0;
//}
//

// #include <iostream>
// #include <cstring>
// #include <queue>
// #include <vector>

// using namespace std;

// #define N 128
// #define INF 0x3f3f3f3f // A large value representing infinity

// int cap[N][N];  // Capacity matrix
// int flux[N][N]; // Flow matrix
// int parent[N];  // Array to store the path
// int n, m;       // Number of nodes and edges

// // BFS function to find an augmenting path from source to sink
// bool bfs(int source, int sink) {
//     bool visited[N];
//     memset(visited, 0, sizeof(visited));
//     memset(parent, -1, sizeof(parent));

//     queue<int> q;
//     q.push(source);
//     visited[source] = true;

//     while (!q.empty()) {
//         int u = q.front();
//         q.pop();

//         for (int v = 1; v <= n; v++) { // Loop over all nodes
//             if (!visited[v] && cap[u][v] - flux[u][v] > 0) { // If there's residual capacity
//                 parent[v] = u;
//                 visited[v] = true;
//                 q.push(v);

//                 if (v == sink) // Stop when the sink is reached
//                     return true;
//             }
//         }
//     }
//     return false; // No augmenting path found
// }

// // Edmonds-Karp algorithm implementation
// int edmonds_karp(int source, int sink) {
//     int max_flow = 0;

//     // While there exists an augmenting path
//     while (bfs(source, sink)) {
//         // Find the minimum capacity in the path
//         int path_flow = INF;
//         for (int v = sink; v != source; v = parent[v]) {
//             int u = parent[v];
//             path_flow = min(path_flow, cap[u][v] - flux[u][v]);
//         }

//         // Update the flow values along the path
//         for (int v = sink; v != source; v = parent[v]) {
//             int u = parent[v];
//             flux[u][v] += path_flow; // Add flow to forward edge
//             flux[v][u] -= path_flow; // Subtract flow from reverse edge
//         }

//         max_flow += path_flow; // Add path flow to the total flow
//     }

//     return max_flow;
// }

// int main() {
//     // Initialize the capacity and flow matrices
//     memset(cap, 0, sizeof(cap));
//     memset(flux, 0, sizeof(flux));

//     int x, y, c;

//     // Input the number of nodes and edges
//     cout << "Enter the number of nodes and edges: ";
//     cin >> n >> m;

//     if (n <= 0 || n > N || m <= 0) {
//         cerr << "Invalid number of nodes or edges.\n";
//         return -1;
//     }

//     cout << "Enter the edges (start_node end_node capacity):\n";
//     for (int i = 0; i < m; i++) {
//         cin >> x >> y >> c;

//         if (x < 1 || x > n || y < 1 || y > n || c < 0) {
//             cerr << "Invalid edge input.\n";
//             return -1;
//         }

//         cap[x][y] += c; // Accumulate capacities for parallel edges
//     }

//     // Compute the maximum flow using Edmonds-Karp
//     int source = 1; // Assuming the source node is 1
//     int sink = n;   // Assuming the sink node is n
//     int max_flow = edmonds_karp(source, sink);

//     // Output the result
//     cout << "The maximum flow from source (" << source << ") to sink (" << sink << ") is: " << max_flow << endl;

//     return 0;
// }
