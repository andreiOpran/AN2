#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main()
{
	// vector<vector<int>> k; // valoarea maxima obtinuta folosind dintre primele i obiecte fara a depasi greutatea toala j
	
	int nrObiecte, capacitateRucsac;
	vector<int> greutati, valori;

#pragma region Citire
	
	cin >> nrObiecte >> capacitateRucsac;
	
	valori.resize(nrObiecte + 1);
	for(int i = 1; i <= nrObiecte; ++i)
		cin >> valori[i];

	greutati.resize(nrObiecte + 1);
	for(int i = 1; i <= nrObiecte; ++i)
		cin >> greutati[i];

#pragma endregion

	vector<int> previousRow(capacitateRucsac + 1, 0);
	vector<int> currentRow(capacitateRucsac + 1, 0);

	for(int i = 1; i <= nrObiecte; ++i)
	{
		for(int j = 1; j <= capacitateRucsac; ++j)
		{
			currentRow[j] = previousRow[j]; // nu luam obiectul i

			if(j >= greutati[i])
			{
				if(currentRow[j] < valori[i] + previousRow[j - greutati[i]])
				{
					currentRow[j] = valori[i] + previousRow[j - greutati[i]];
				}
			}
		}

		previousRow = currentRow;
	}
	cout << currentRow[capacitateRucsac];
	return 0;
}