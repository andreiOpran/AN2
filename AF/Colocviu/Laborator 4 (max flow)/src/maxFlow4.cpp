#include <iostream>
#include <vector>
#include <queue>
using namespace std;

class Graph 
{
private:
    int NumVertices;
    vector<vector<int>> ResidualCapacity;
    vector<int> Parent;
    
    // Gaseste drum in graful rezidual folosind BFS
    bool FindAugmentingPath(int Source, int Sink) 
    {
        vector<bool> Visited(NumVertices + 1, false);
        queue<int> Queue;
        
        Queue.push(Source);
        Visited[Source] = true;
        Parent[Source] = -1;
        
        while (!Queue.empty()) 
        {
            int Current = Queue.front();
            Queue.pop();
            
            for (int Next = 1; Next <= NumVertices; Next++) 
            {
                if (!Visited[Next] && ResidualCapacity[Current][Next] > 0) 
                {
                    Parent[Next] = Current;
                    Visited[Next] = true;
                    Queue.push(Next);
                    
                    if (Next == Sink)
                        return true;
                }
            }
        }
        return false;
    }

public:
    Graph(int V) : NumVertices(V)
    {
        ResidualCapacity = vector<vector<int>>(V + 1, vector<int>(V + 1, 0));
        Parent = vector<int>(V + 1);
    }
    
    // Adauga muchie in graf
    void AddEdge(int Source, int Destination, int Capacity) 
    {
        ResidualCapacity[Source][Destination] = Capacity;
    }
    
    // Implementare Edmonds-Karp (Ford-Fulkerson cu BFS)
    int MaxFlow(int Source, int Sink) 
    {
        int MaxFlow = 0;
        
        // Cat timp exista drum de la sursa la destinatie
        while (FindAugmentingPath(Source, Sink)) 
        {
            // Gaseste capacitatea minima pe drum
            int PathFlow = INT_MAX;
            for (int V = Sink; V != Source; V = Parent[V]) 
            {
                int U = Parent[V];
                PathFlow = min(PathFlow, ResidualCapacity[U][V]);
            }
            
            // Actualizeaza capacitatile reziduale
            for (int V = Sink; V != Source; V = Parent[V]) 
            {
                int U = Parent[V];
                ResidualCapacity[U][V] -= PathFlow;
                ResidualCapacity[V][U] += PathFlow;  // Adauga muchie inversa
            }
            
            MaxFlow += PathFlow;
        }
        
        return MaxFlow;
    }
    
    // Afiseaza graful rezidual
    void PrintResidualGraph() 
    {
        for (int i = 1; i <= NumVertices; i++) 
        {
            for (int j = 1; j <= NumVertices; j++) 
            {
                if (ResidualCapacity[i][j] > 0) 
                {
                    cout << i << " -> " << j << " : " << ResidualCapacity[i][j] << endl;
                }
            }
        }
    }
};

int main() 
{
    int V, E;
    cout << "Numarul de varfuri si muchii: ";
    cin >> V >> E;
    
    Graph G(V);
    
    cout << "Introduceti muchiile (sursa destinatie capacitate):\n";
    for (int i = 0; i < E; i++) 
    {
        int Source, Destination, Capacity;
        cin >> Source >> Destination >> Capacity;
        G.AddEdge(Source, Destination, Capacity);
    }
    
    int Source, Sink;
    cout << "Sursa si destinatie: ";
    cin >> Source >> Sink;
    
    cout << "Flux maxim: " << G.MaxFlow(Source, Sink) << endl;
    
    return 0;
}