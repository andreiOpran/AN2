#include <iostream>
#include <vector>
#include <algorithm>
#include <unordered_map>
using namespace std;

class Solution {
public:
	bool containsDuplicate(vector<int>& nums) {

		if (nums.size() == 2 && nums[0] == nums[1])
			return true;

		sort(nums.begin(), nums.end());

		bool existaDuplicate = false;
		for (int i = 1; i < nums.size() - 1; i+=2)
		{
			//cout << nums[i - 1] << ' ' << nums[i] << ' ' << nums[i + 1] << '\n';
			if (nums[i] == nums[i - 1] || nums[i] == nums[i + 1])
				return true;
			if (nums.size() % 2 == 0)
			{
				if (nums[i] == nums[i + 1])
					return true;
			}
		}
		if (nums[nums.size() - 1] == nums[nums.size() - 2] && nums.size() > 3)
			return true;
		return existaDuplicate;
	}
};


int main()
{
	vector<int> nums = {0 };
	Solution sol;
	cout << sol.containsDuplicate(nums);
    return 0;
}

