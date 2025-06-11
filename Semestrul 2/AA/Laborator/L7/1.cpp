#include <iostream>
#include <vector>
#include <algorithm>
#include <fstream>
#include <cmath>
#include <iomanip>
using namespace std;
ifstream in("input");
struct Semiplan{
    double a, b, c;
    Semiplan():a(0), b(0), c(0){}
    Semiplan(double a, double b, double c):a(a),b(b),c(c){}
};
istream& operator>>(istream& in, Semiplan& sp) {
    in >> sp.a >> sp.b >> sp.c;
    return in;
}
struct Punct{
    double x, y;
    Punct(double x = 0, double y = 0):x(x), y(y){}
};
istream& operator>>(istream& in, Punct& p) {
    in >> p.x >> p.y;
    return in;
}
int main()
{
    int n, m;
    cin>> n;
    vector<double> left, right, bottom, top; // bounds
    vector<Semiplan> semiplans(n);
    for(int i = 0; i < n; ++i) {
        cin>> semiplans[i];
        if(semiplans[i].a == 0) { // orizontal
            if(semiplans[i].b > 0) 
                top.push_back(-semiplans[i].c / semiplans[i].b);
            else 
                bottom.push_back(-semiplans[i].c / semiplans[i].b);
        } 
        else { // vertical
            if(semiplans[i].a > 0)
                right.push_back(-semiplans[i].c / semiplans[i].a);
            else 
                left.push_back(-semiplans[i].c / semiplans[i].a);
        }
    }


    // sort the bounds
    sort(left.begin(), left.end());
    sort(right.begin(), right.end());
    sort(bottom.begin(), bottom.end());
    sort(top.begin(), top.end());

    cin>>m;
    for(int i=0;i<m;i++){
        Punct p;
        cin>>p;

        // check if the point is within the bounds defined by the semiplans
        auto leftIterator = lower_bound(left.begin(), left.end(), p.x);
        if(leftIterator == left.begin()) {
            cout<< "NO\n";
            continue;
        }
        double leftMax = *(--leftIterator); // largest value in left < p.x
    
        auto rightIterator = upper_bound(right.begin(), right.end(), p.x);
        if(rightIterator == right.end()) {
            cout<< "NO\n";
            continue;
        }
        double rightMin = *rightIterator; // smallest value in right > p.x

        auto bottomIterator = lower_bound(bottom.begin(), bottom.end(), p.y);
        if(bottomIterator == bottom.begin()) {
            cout<< "NO\n";
            continue;
        }
        double bottomMax = *(--bottomIterator); // largest value in bottom < p.y
    
        auto topIterator = upper_bound(top.begin(), top.end(), p.y);
        if(topIterator == top.end()) {
            cout<< "NO\n";
            continue;
        }
        double topMin = *topIterator; // smallest value in top > p.y
        
        
        if(leftMax < p.x && p.x < rightMin && bottomMax < p.y && p.y < topMin) {
            cout << "YES\n";
            double area = (rightMin - leftMax) * (topMin - bottomMax);
            double roundedArea = round(area);
            if(abs(area - roundedArea) < 1e-9) {
                cout << static_cast<long long>(roundedArea) << "\n";
            } else{
                cout << fixed << setprecision(6) << area << "\n";
            }
        } else {
            cout << "NO\n";
        }
    }
    return 0;
}