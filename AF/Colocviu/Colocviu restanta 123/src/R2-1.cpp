// NU MERGE

/*

Se considera un graf conex neorientat ponderat cu n noduri si m muchii.
Se dau k valori naturale i1, i2,...,ik intre 1 si m.
Pentru fiecare din cele k valori sa se verifice daca muchia cu indicele respectiv 
se afla in cel putin un arbore partial de cost minim al lui G. 
In caz afirmativ, se va afisa pe ecran mesajul Da, altfel Nu. 
Indicele unei muchii reprezinta pozitia ei (incepand de la 1) in lista de muchii din datele de intrare.

Input Format:
Se citesc de la tastatura valorile n, m reprezentand numarul de noduri si numarul de muchii ale grafului. Apoi se citesc m triplete reprezentand muchiile grafului si ponderile acestora. In continuare, se citeste o valoare k, reprezentand numarul de indici interogati si apoi se citesc k valori intre 1 si m, fiecare valoare reprezentand indicele unei muchii interogate (date fiecare pe o linie, ca in exemplu).

Constraints:
1 ≤ n ≤ 10³
1 ≤ k ≤ m ≤ n(n-1)/2
Ponderea unei muchii este un numar natural intre 1 si 1000.

Output Format:
Se afiseaza pe ecran Da in cazul in care muchia face parte din cel putin un arbore partial de cost minim si Nu in caz contrar.
Fiecare raspuns se afiseaza pe o linie separata.

Sample Input 0
5 7
5 1 1
5 4 2
1 2 2
2 3 2
3 4 2
4 2 2
1 3 3
3
6
7
3
Sample Output 0
Da
Nu
Da

Sample Input 1
4 5
1 3 1
3 4 4
2 4 3
1 2 2
2 3 5
2
5
2
Sample Output 1
Nu
Nu

Sample Input 2
4 4
1 3 1
3 4 4
2 4 3
1 2 2
2
1
3
Sample Output 2
Da
Da

*/

#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

// Structura pentru o muchie in graf
struct Edge 
{
    int From, To, Weight, Index;
    bool operator<(const Edge& Other) const 
    {
        return Weight < Other.Weight;
    }
};

// Clasa pentru implementarea structurii Union-Find (Paduri de multimi disjuncte)
class UnionFind 
{
private:
    vector<int> Parent, Rank;
    
public:
    // Initializeaza structura pentru N noduri
    UnionFind(int N) 
    {
        Parent.resize(N + 1);
        Rank.resize(N + 1, 0);
        for(int i = 0; i <= N; i++) 
            Parent[i] = i;
    }
    
    // Gaseste reprezentantul multimii care contine elementul X
    int Find(int X) 
    {
        if(Parent[X] != X)
            Parent[X] = Find(Parent[X]);
        return Parent[X];
    }
    
    // Uneste multimile care contin elementele X si Y
    void Union(int X, int Y) 
    {
        int RootX = Find(X);
        int RootY = Find(Y);
        
        if(RootX != RootY) 
        {
            if(Rank[RootX] < Rank[RootY])
                Parent[RootX] = RootY;
            else if(Rank[RootX] > Rank[RootY])
                Parent[RootY] = RootX;
            else 
            {
                Parent[RootY] = RootX;
                Rank[RootX]++;
            }
        }
    }
};

// Verifica daca muchia cu indexul EdgeIndex face parte din cel putin un MST
bool IsInMST(int EdgeIndex, vector<Edge>& Edges, int N) {
    // Find query edge first
    Edge QueryEdge;
    bool found = false;
    for(const Edge& E : Edges) {
        if(E.Index == EdgeIndex) {
            QueryEdge = E;
            found = true;
            break;
        }
    }
    if(!found) return false;

    // Create UnionFind structure
    UnionFind UF(N);
    
    // Add all edges with lower weight
    for(const Edge& E : Edges) {
        if(E.Weight < QueryEdge.Weight) {
            UF.Union(E.From, E.To);
        }
    }
    
    // If vertices already connected, edge is not in MST
    if(UF.Find(QueryEdge.From) == UF.Find(QueryEdge.To)) {
        return false;
    }

    // Try all same weight edges except query edge
    bool canBeInMST = false;
    UnionFind tempUF = UF;
    
    // First try without our edge
    for(const Edge& E : Edges) {
        if(E.Weight == QueryEdge.Weight && E.Index != EdgeIndex) {
            tempUF.Union(E.From, E.To);
        }
    }
    
    // If vertices still not connected, edge must be in some MST
    if(tempUF.Find(QueryEdge.From) != tempUF.Find(QueryEdge.To)) {
        canBeInMST = true;
    }

    return canBeInMST;
}
int main() 
{
    int N, M;
    cin >> N >> M;
    
    // Citire muchii
    vector<Edge> Edges(M);
    for(int i = 0; i < M; i++) 
    {
        cin >> Edges[i].From >> Edges[i].To >> Edges[i].Weight;
        Edges[i].Index = i + 1;
    }
    
    // Sorteaza muchiile dupa greutate
    sort(Edges.begin(), Edges.end());
    
    // Proceseaza interogari
    int K;
    cin >> K;
    
    for(int i = 0; i < K; i++) 
    {
        int EdgeIndex;
        cin >> EdgeIndex;
        cout << (IsInMST(EdgeIndex, Edges, N) ? "Da" : "Nu") << "\n";
    }
    
    return 0;
}