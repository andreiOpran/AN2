/*

Se considera un arbore cu **n** noduri si radacina **r**.  
Se da un nod **c**. Sa se determine ascendentii si descendentii nodului **c**.  
Complexitate ceruta: **O(n)**.  

### Input Format  

Pe prima linie se afla 3 valori: **n, r, c**, reprezentand numarul de noduri, radacina arborelui 
si nodul pentru care trebuie afisati ascendentii si descendentii.  
Pe urmatoarele **n - 1** linii se afla cate o pereche de valori reprezentand muchiile arborelui.  

### Constraints  

**1 ≤ n, r, c ≤ 10⁵**  
Nodurile arborelui au valori de la **1** la **n**.  

### Output Format  

Pe prima linie se afiseaza ascendentii nodului **c**.  
In cazul in care acesta nu are niciun ascendent, se afiseaza valoarea **0**.  
Ascendentii pot fi afisati in orice ordine.  

Pe a doua linie se afiseaza descendentii nodului **c**.  
In cazul in care acesta nu are niciun descendent, se afiseaza valoarea **0**.  
Descendentii pot fi afisati in orice ordine.

*/

#include <iostream>
#include <vector>
using namespace std;

// Clasa pentru reprezentarea arborelui si operatiile necesare
class Tree 
{
private:
    // Numarul de noduri din arbore
    int NumNodes;
    // Lista de adiacenta pentru reprezentarea arborelui
    vector<vector<int>> AdjList;
    // Vector pentru marcarea nodurilor vizitate
    vector<bool> Visited;
    // Vector pentru stocarea parintilor fiecarui nod
    vector<int> Parent;
    // Vector pentru stocarea ascendentilor nodului cautat
    vector<int> Ancestors;
    // Vector pentru stocarea descendentilor nodului cautat
    vector<int> Descendants;

    // Parcurgere DFS pentru determinarea parintilor fiecarui nod
    void DfsParents(int Node, int ParentNode) 
    {
        Parent[Node] = ParentNode;
        for(int Child : AdjList[Node]) 
        {
            if(Child != ParentNode) 
            {
                DfsParents(Child, Node);
            }
        }
    }

    // Parcurgere DFS pentru gasirea tuturor descendentilor unui nod
    void DfsDescendants(int Node, int ParentNode) 
    {
        for(int Child : AdjList[Node]) 
        {
            if(Child != ParentNode) 
            {
                Descendants.push_back(Child);
                DfsDescendants(Child, Node);
            }
        }
    }

public:
    // Constructor - initializeaza structurile de date necesare
    Tree(int N) : NumNodes(N) 
    {
        AdjList.resize(N + 1);
        Parent.resize(N + 1);
        Visited.resize(N + 1, false);
    }

    // Adauga o muchie in arbore intre nodurile U si V
    void AddEdge(int U, int V) 
    {
        AdjList[U].push_back(V);
        AdjList[V].push_back(U);
    }

    // Returneaza toti ascendentii unui nod dat
    vector<int> GetAncestors(int Root, int Node) 
    {
        Ancestors.clear();
        DfsParents(Root, Root);
        
        int Current = Node;
        while(Current != Root) 
        {
            Current = Parent[Current];
            Ancestors.push_back(Current);
        }
        
        return Ancestors;
    }

    // Returneaza toti descendentii unui nod dat
    vector<int> GetDescendants(int Node) 
    {
        Descendants.clear();
        DfsDescendants(Node, Parent[Node]);
        return Descendants;
    }
};

// Functia principala a programului
int main() 
{
    // Citirea datelor de intrare
    int N, R, C;
    cin >> N >> R >> C;

    // Crearea si construirea arborelui
    Tree T(N);

    // Citirea muchiilor si adaugarea lor in arbore
    for(int i = 0; i < N - 1; i++) 
    {
        int U, V;
        cin >> U >> V;
        T.AddEdge(U, V);
    }

    // Obtinerea ascendentilor si descendentilor nodului C
    vector<int> Ancestors = T.GetAncestors(R, C);
    vector<int> Descendants = T.GetDescendants(C);

    // Afisarea ascendentilor
    if(Ancestors.empty()) 
    {
        cout << "0\n";
    } 
    else 
    {
        for(int Ancestor : Ancestors) 
        {
            cout << Ancestor << " ";
        }
        cout << "\n";
    }

    // Afisarea descendentilor
    if(Descendants.empty()) 
    {
        cout << "0\n";
    } 
    else 
    {
        for(int Descendant : Descendants) 
        {
            cout << Descendant << " ";
        }
        cout << "\n";
    }

    return 0;
}