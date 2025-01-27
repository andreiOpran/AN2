import networkx as nx

# Definim graful cu lista de muchii
edges = [
    (0, 3), (0, 5), (0, 6), (0, 8),
    (1, 4), (1, 5), (1, 7), (1, 8),
    (3, 6), (3, 7), (3, 8), (4, 8),
    (5, 6), (5, 7), (6, 8), (7, 8)
]

# Creăm graful folosind NetworkX
G = nx.Graph()
G.add_edges_from(edges)

# Verificăm planitatea grafului
is_planar, _ = nx.check_planarity(G)

if is_planar:
    print("Graful este planar.")
else:
    print("Graful nu este planar.")