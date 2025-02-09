
#include <iostream>
#include <cstring>
#include <queue>
#include <vector>

using namespace std;

#define N 128
#define INF 0x3f3f3f3f // A large value representing infinity

int cap[N][N];  // Capacity matrix
int flux[N][N]; // Flow matrix
int parent[N];  // Array to store the path
int n, m;       // Number of nodes and edges

// BFS function to find an augmenting path from source to sink
bool bfs(int source, int sink) {
    bool visited[N];
    memset(visited, 0, sizeof(visited));
    memset(parent, -1, sizeof(parent));

    queue<int> q;
    q.push(source);
    visited[source] = true;

    while (!q.empty()) {
        int u = q.front();
        q.pop();

        for (int v = 1; v <= n; v++) { // Loop over all nodes
            if (!visited[v] && cap[u][v] - flux[u][v] > 0) { // If there's residual capacity
                parent[v] = u;
                visited[v] = true;
                q.push(v);

                if (v == sink) // Stop when the sink is reached
                    return true;
            }
        }
    }
    return false; // No augmenting path found
}

// Edmonds-Karp algorithm implementation
int edmonds_karp(int source, int sink) {
    int max_flow = 0;

    // While there exists an augmenting path
    while (bfs(source, sink)) {
        // Find the minimum capacity in the path
        int path_flow = INF;
        for (int v = sink; v != source; v = parent[v]) {
            int u = parent[v];
            path_flow = min(path_flow, cap[u][v] - flux[u][v]);
        }

        // Update the flow values along the path
        for (int v = sink; v != source; v = parent[v]) {
            int u = parent[v];
            flux[u][v] += path_flow; // Add flow to forward edge
            flux[v][u] -= path_flow; // Subtract flow from reverse edge
        }

        max_flow += path_flow; // Add path flow to the total flow
    }

    return max_flow;
}

int main() {
    // Initialize the capacity and flow matrices
    memset(cap, 0, sizeof(cap));
    memset(flux, 0, sizeof(flux));

    int x, y, c;

    // Input the number of nodes and edges
    cout << "Enter the number of nodes and edges: ";
    cin >> n >> m;

    if (n <= 0 || n > N || m <= 0) {
        cerr << "Invalid number of nodes or edges.\n";
        return -1;
    }

    cout << "Enter the edges (start_node end_node capacity):\n";
    for (int i = 0; i < m; i++) {
        cin >> x >> y >> c;

        if (x < 1 || x > n || y < 1 || y > n || c < 0) {
            cerr << "Invalid edge input.\n";
            return -1;
        }

        cap[x][y] += c; // Accumulate capacities for parallel edges
    }

    // Compute the maximum flow using Edmonds-Karp
    int source = 1; // Assuming the source node is 1
    int sink = 6;   // Assuming the sink node is n
    int max_flow = edmonds_karp(source, sink);

    // Output the result
    cout << "The maximum flow from source (" << source << ") to sink (" << sink << ") is: " << max_flow << endl;

    return 0;

}
