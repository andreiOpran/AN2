import networkx as nx

# Definim graful cu lista de muchii
# edges = [
#     (0, 3), (0, 5), (0, 6), (0, 8),
#     (1, 4), (1, 5), (1, 7), (1, 8),
#     (3, 6), (3, 7), (3, 8), (4, 8),
#     (5, 6), (5, 7), (6, 8), (7, 8)
# ]

edges = [
    (1, 5), (1, 2), (1, 4), (1, 9),
    (1, 7), (1, 8), (2, 5), (2, 8),
    (2, 7), (3, 4), (3, 5), (3, 9),
    (4, 5), (4, 9), (5, 7), (5, 8),
    (6, 7), (6, 8), (7, 9), (7, 8)
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