#include <iostream>
#include <vector>
#include <set>
#include <algorithm>
#include <iomanip>
#include <cmath>
using namespace std;

struct Semiplan {
    double a, b, c;
    Semiplan() : a(0), b(0), c(0) {}
    Semiplan(double a, double b, double c) : a(a), b(b), c(c) {}
};

struct Dreptunghi {
    double x_left, x_right, y_bottom, y_top;
    double arie;

    Dreptunghi(double x_left, double x_right, double y_bottom, double y_top) : x_left(x_left), x_right(x_right), y_bottom(y_bottom), y_top(y_top) {
        arie = (x_right - x_left) * (y_top - y_bottom);
    }

    bool contineInInteriorPunct(double x, double y) const {
        return x > x_left && x < x_right && y > y_bottom && y < y_top;
    }
};

istream& operator>>(istream& is, Semiplan& obj) {
    is >> obj.a >> obj.b >> obj.c;
    return is;
}

int cautareBinaraLower(const vector<double>& v, double p) {
    int left = 0, right = v.size() - 1;
    int result = -1;
    
    while (left <= right) {
        int mid = left + (right - left) / 2;

        if (v[mid] < p) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    
    return result; // returneaza index
}

int cautareBinaraUpper(const vector<double>& v, double p) {
    int left = 0, right = v.size() - 1;
    int result = -1;
    
    while (left <= right) {
        int mid = left + (right - left) / 2;

        if (v[mid] > p) {
            result = mid; 
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    
    return result; 
}

int main() {
    int n, m;
    vector<Semiplan> semiplane;
    double x, y;
    cin >> n;

    while (n--) {
        Semiplan sp;
        cin >> sp;
        semiplane.push_back(sp);
    }

    // pentru a separa semiplanele in verticale si orizontale
    set<double> limitaStangaXSet; // x >= limita
    set<double> limitaDreaptaXSet;
    set<double> limitaJosYSet; // y >= limita
    set<double> limitaSusYSet;

    for (const auto& semiplan : semiplane) {
        if (semiplan.a != 0 && semiplan.b == 0) { // semiplan vertical
            double limita = -1.0 * semiplan.c / semiplan.a;
            if (semiplan.a > 0) { // x <= limita
                limitaDreaptaXSet.insert(limita);
            } else { // x >= limita
                limitaStangaXSet.insert(limita);
            }
        }
        if (semiplan.a == 0 && semiplan.b != 0) { // semiplan orizontal
            double limita = -1.0 * semiplan.c / semiplan.b;
            if (semiplan.b > 0) { // y <= limita
                limitaSusYSet.insert(limita);
            } else { // y >= limita
                limitaJosYSet.insert(limita);
            }
        }
    }

    vector<double> limitaStangaXVector(limitaStangaXSet.begin(), limitaStangaXSet.end());
    vector<double> limitaDreaptaXVector(limitaDreaptaXSet.begin(), limitaDreaptaXSet.end());
    vector<double> limitaJosYVector(limitaJosYSet.begin(), limitaJosYSet.end());
    vector<double> limitaSusYVector(limitaSusYSet.begin(), limitaSusYSet.end());

    sort(limitaStangaXVector.begin(), limitaStangaXVector.end());
    sort(limitaDreaptaXVector.begin(), limitaDreaptaXVector.end());
    sort(limitaJosYVector.begin(), limitaJosYVector.end());
    sort(limitaSusYVector.begin(), limitaSusYVector.end());

    cin >> m;
    while (m--) {
        cin >> x >> y;

        // cele mai apropiate limite
        int stanga = cautareBinaraLower(limitaStangaXVector, x);
        int dreapta = cautareBinaraUpper(limitaDreaptaXVector, x);
        int jos = cautareBinaraLower(limitaJosYVector, y);
        int sus = cautareBinaraUpper(limitaSusYVector, y);

        if (stanga == -1 || dreapta == -1 || jos == -1 || sus == -1) {
            cout << "NO\n";
            continue;
        }

        double stangaMax = limitaStangaXVector[stanga];
        double dreaptaMin = limitaDreaptaXVector[dreapta];
        double josMax = limitaJosYVector[jos];
        double susMin = limitaSusYVector[sus];

        // verificare (x, y) in dreptunghi
        if (x > stangaMax && x < dreaptaMin && y > josMax && y < susMin) {
            cout << "YES\n";
            Dreptunghi dreptunghi(stangaMax, dreaptaMin, josMax, susMin);
            double arie = dreptunghi.arie;
            cout << fixed << setprecision(6) << arie << "\n";
        } else {
            cout << "NO\n";
        }

    }

    return 0;
}