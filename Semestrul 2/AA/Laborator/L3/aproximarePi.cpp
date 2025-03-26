// in a square of side 1, we have a circle of radius 1/2
// the ratio of the area of the circle to the area of the square is pi/4
// we generate n random points in the square and count how many of them are in the circle
// the ratio of the number of points in the circle to the total number of points is pi/4

#include <iostream>
#include <random>
using namespace std;
int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);

    random_device rd;
    mt19937 gen(rd());
    uniform_real_distribution<> dis(0, 1);

    int n = 10000000, numbersInCircle = 0;
    double x, y;
    int i = n;
    // int progressInterval = 100000;
    while (i--) {
        // if ((n - i) % progressInterval == 0) {
        //     cout << "Experiment " << n - i << " out of " << n << '\n';
        // }

        x = dis(gen);
        y = dis(gen);
    
        double d = (x - 0.5) * (x - 0.5) + (y - 0.5) * (y - 0.5);
        if (d <= 0.25) {
            ++numbersInCircle;
        }
    }
    cout << "\nNumber of experiments: " << n;
    cout << "\nApproximation of pi: " << 4 * (double)numbersInCircle / n << '\n';
    return 0;
}