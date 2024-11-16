#include <iostream>
#include <cstring>
#include <vector>
#include <algorithm>
#include <unordered_map>
#include <numeric>
#include <stack>
#include <utility>
using namespace std;

/*

I can be placed before V (5) and X (10) to make 4 and 9.
X can be placed before L (50) and C (100) to make 40 and 90.
C can be placed before D (500) and M (1000) to make 400 and 900.

*/

class Solution {
public:
    int getMaxTraffic(int start[], int end[], int n)
    {
        
        const int size = n + 1;

       
        vector<bool> connected(size, false);

        /*unordered_map<int, pair<int, int>> map;
        for (int i = 0; i < n; i++)
        {
            map[i] = make_pair(start[i], end[i]);
        }*/

        int time = 1;
        int cont = 0;

        for (int i = 0; i < n; i++)
        {
            if()
        }
        
    }
};

int main()
{
    int start[] = { 1,6,2,9 };
    int end[] = { 8,7,6,10 };
    int n = 4;
    Solution sol;
    cout << sol.getMaxTraffic(start, end, n);
	return 0;
}
