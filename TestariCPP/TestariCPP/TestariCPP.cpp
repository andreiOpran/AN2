#include <iostream>
#include <cstring>
#include <vector>
#include <algorithm>
#include <unordered_map>
using namespace std;

class Solution {
public:
	string longestPalindrome(string s) {
		
		int len = s.length();

		for (int i = 0; i < len - 1; i++)
		{
			for (int j = i + 1; j < len; j++)
			{

			}
		}
	}

	bool palindrome(string s)
	{
		string aux = s;
		reverse(aux.begin(), aux.end());
		return aux == s;
	}
};


int main()
{
	string s = "babad";
	Solution sol;
	cout << sol.longestPalindrome(s);
	return 0;
}

