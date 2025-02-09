class Graph:
    def __init__(self, vertices):
        self.graph = [[] for _ in range(vertices)]
        self.V = vertices

    def add_edge(self, u, v, w):
        self.graph[u - 1].append((v - 1, w))
        self.graph[v - 1].append((u - 1, 0))

    def bfs(self, s, t, parent):
        visited = [False] * self.V
        queue = [s]
        visited[s] = True

        while queue:
            u = queue.pop(0)

            for v, w in self.graph[u]:
                if visited[v] == False and w > 0:
                    queue.append(v)
                    visited[v] = True
                    parent[v] = u

                    if v == t:
                        return True

        return False

    def ford_fulkerson(self, source, sink):
        parent = [-1] * self.V
        max_flow = 0

        while self.bfs(source - 1, sink - 1, parent):
            path_flow = float('Inf')
            s = sink - 1

            while s != source - 1:
                for v, w in self.graph[parent[s]]:
                    if v == s:
                        path_flow = min(path_flow, w)
                        break
                s = parent[s]

            v = sink - 1
            while v != source - 1:
                u = parent[v]
                for i, (node, weight) in enumerate(self.graph[u]):
                    if node == v:
                        self.graph[u][i] = (node, weight - path_flow)
                for i, (node, weight) in enumerate(self.graph[v]):
                    if node == u:
                        self.graph[v][i] = (node, weight + path_flow)
                v = parent[v]

            max_flow += path_flow

        return max_flow

# Crearea grafului și adăugarea muchiilor
g = Graph(8)
g.add_edge(1, 6, 7)
g.add_edge(1, 2, 12)
g.add_edge(1, 4, 8)
g.add_edge(2, 5, 6)
g.add_edge(2, 7, 4)
g.add_edge(3, 8, 11)
g.add_edge(4, 3, 9)
g.add_edge(5, 4, 3)
g.add_edge(5, 3, 4)
g.add_edge(5, 7, 2)
g.add_edge(6, 4, 3)
g.add_edge(8, 7, 12)
g.add_edge(8, 5, 3)

source = 1  # Sursa
sink = 7    # Destinația

print(f"Fluxul maxim este {g.ford_fulkerson(source, sink)}")