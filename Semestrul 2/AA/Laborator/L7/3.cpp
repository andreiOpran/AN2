#include <iostream>
#include <vector>
using namespace std;

int main() {
    long long x_min = -1e9, x_max = 1e9, y_min = -1e9, y_max = 1e9;
    int n;
    cin >> n;

    while (n--) {
        long long a, b, c;
        cin >> a >> b >> c;
        
        // tip semiplan
        if (a != 0 && b == 0) { // semiplan vertical: ax + by + c <= 0, b = 0 -> ax + c <= 0 -> x <= -c/a
            if (a > 0) {
                // x <= -c/a
                long long limita = -c / a;
                if (limita < x_max) {
                    x_max = limita;
                }
            } else {
                // x >= -c/a
                long long limita = -c / a;
                if (limita > x_min) {
                    x_min = limita;
                }
            }
        } else if (a == 0 && b != 0) { // semiplan orizontal: ax + by + c <= 0, a = 0 -> by + c <= 0 -> y <= -c/b
            if (b > 0) {
                // y <= -c/b
                long long limita = -c / b;
                if (limita < y_max) {
                    y_max = limita;
                }
            } else {
                // y >= -c/b
                long long limita = -c / b;
                if (limita > y_min) {
                    y_min = limita;
                }
            }
        }
    }
    
    if (x_min > x_max || y_min > y_max) {
        cout << "VOID" << endl;
        return 0;
    }
    
    bool marginit = true;
    
    // limitele != inf => intersectie marginita
    if (x_min == -1e9 || x_max == 1e9 || y_min == -1e9 || y_max == 1e9) {
        marginit = false;
    }

    if (marginit) {
        cout << "BOUNDED" << endl;
    } else {
        cout << "UNBOUNDED" << endl;
    }

    return 0;
}