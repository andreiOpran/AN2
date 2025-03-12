#include <iostream>
using namespace std;

int main()
{
	int k; // l - lungimea cromozomului, k - numarul de mutatii
	string cromozomi;
	cin >> k >> k >> cromozomi;
	for(int i = 0; i < k; i++)
	{
		int pozitie;
		cin >> pozitie;
		cromozomi[pozitie] ^= 1;
	}
	cout << cromozomi;
	return 0;
}