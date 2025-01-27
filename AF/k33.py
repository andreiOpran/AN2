import networkx as nx
import matplotlib.pyplot as plt

# Creăm un graf bipartit complet K3,3
K_33 = nx.complete_bipartite_graph(3, 3)

# Desenăm graful folosind NetworkX și Matplotlib
pos = nx.spring_layout(K_33)  # Calculăm pozițiile nodurilor
nx.draw(K_33, pos, with_labels=True, node_color='lightblue', edge_color='gray')
plt.title("Graful K3,3")
plt.show()