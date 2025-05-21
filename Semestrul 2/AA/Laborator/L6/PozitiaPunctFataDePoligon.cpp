#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

const long long bigNumber = 1000000000000LL;

using namespace std;

/*

cross = produs vectorial
p.cross(q, r) = produsul vectorial dintre vectorii PQ si PR = determinantul din testul de orientare

dot = produs scalar
p.dot(q, r) = produsul scalar dintre vectorii PQ si PR adica
produsul dintre lungimea lui PQ si lungimea lui PR si cosinusul unghiului dintre ei

sqrLen = lungimea vectorului
Punct(x, y).sqrLen() = x^2 + y^2

*/
struct Punct {
	long long x;
	long long y;

	Punct() {}
	Punct(long long x, long long y) : x(x), y(y) {}

	Punct operator+(const Punct& other) const { return Punct(x + other.x, y + other.y); }
	Punct operator-(const Punct& other) const { return Punct(x - other.x, y - other.y); }

	long long cross(const Punct& other) const { return x * other.y - y * other.x; }
	long long dot(const Punct& other) const { return x * other.x + y * other.y; }

	long long cross(const Punct& a, const Punct& b) const { return (a.x - x) * (b.y - y) - (a.y - y) * (b.x - x); }
	long long dot(const Punct& a, const Punct& b) const { return (a.x - x) * (b.x - x) + (a.y - y) * (b.y - y); }

	long long sqrLen() const { return this->dot(*this); }
};

string testOrientare(long long px, long long py, long long qx, long long qy, long long rx, long long ry) {
	Punct p(px, py);
	Punct q(qx, qy);
	Punct r(rx, ry);

	long long orientare = p.cross(q, r);

	if (orientare == 0) {
		return "TOUCH";
	}
	else if (orientare > 0) {
		return "LEFT";
	}
	else {
		return "RIGHT";
	}
}

bool compararePuncte(const Punct& a, const Punct& b) {
	if (a.x == b.x) {
		return a.y < b.y;
	}
	return a.x < b.x;
}

int semn(long long x) {
	if (x > 0) return 1;
	if (x < 0) return -1;
	return 0;
}


bool punctInTriunghi(const Punct& a, const Punct& b, const Punct& c, const Punct& p) {
	long long orientare1 = abs(a.cross(b, c));
	long long orientare2 = abs(p.cross(a, b)) + abs(p.cross(b, c)) + abs(p.cross(c, a));
	return orientare1 == orientare2;
}

// verifica daca un punct e pe segment
bool punctPeSegment(const Punct& a, const Punct& b, const Punct& p) {
	if (a.cross(b, p) != 0) return false; // punctul nu e coliniar

	// verificam daca punctul e in interiorul segmentului
	if (min(a.x, b.x) <= p.x && p.x <= max(a.x, b.x) &&
		min(a.y, b.y) <= p.y && p.y <= max(a.y, b.y)) {
		return true;
	}
	return false;
}

bool segmenteIntersectate(const Punct& a1, const Punct& b1, const Punct& a2, const Punct& b2) {
	// doua segmente se intersecteaza daca si numai daca capetele unui segment sunt de o parte si de alta a celuilalt segment
	if (semn(a1.cross(b1, a2)) != semn(a1.cross(b1, b2))
		&& semn(a2.cross(b2, a1)) != semn(a2.cross(b2, b1)))
		return true;

	// puncte coliniare
	if (semn(a1.cross(b1, a2)) == 0 && punctPeSegment(a1, b1, a2)) return true;
	if (semn(a1.cross(b1, b2)) == 0 && punctPeSegment(a1, b1, b2)) return true;
	if (semn(a2.cross(b2, a1)) == 0 && punctPeSegment(a2, b2, a1)) return true;
	if (semn(a2.cross(b2, b1)) == 0 && punctPeSegment(a2, b2, b1)) return true;

	return false;
}

string pozitiePunctInPoligon(vector<Punct> poligon, Punct q) {
	int n = poligon.size();

	// verificare BOUNDARY
	for (int i = 0; i < n; i++) {
		if (punctPeSegment(poligon[i], poligon[(i + 1) % n], q)) {
			return "BOUNDARY";
		}
	}

	Punct exterior(q.x + 10000, q.y + 2000000000);
	int cont = 0;

	// contorizare pucnte care intersecteaza un segment de la q la exterior
	for (int i = 0; i < n; i++) {
		Punct p1 = poligon[i];
		Punct p2 = poligon[(i + 1) % n];

		// verificare intersectie
		if (segmenteIntersectate(p1, p2, q, exterior)) { 
			if (semn(q.cross(exterior, p1)) == 0) { // verificare coliniaritate
				if (punctPeSegment(q, exterior, p1)) { // p1 este pe segmentul qexterior
					Punct p0 = poligon[(i - 1 + n) % n];
					if ((p0.y < q.y && p2.y > q.y) || (p0.y > q.y && p2.y < q.y)) { // verificare daca p1 si p2 sunt de o parte si de alta a lui q rezulta intersectie
						cont++;
					}
				}
			}
			else {
				cont ++;
			}
		}
	}

	if (cont % 2 == 1) {
		return "INSIDE";
	}
	else {
		return "OUTSIDE";
	}
	
}

int main() {
	int n;
	cin >> n;

	vector<Punct> poligon;
	for (int i = 0; i < n; i++) {
		long long x, y;
		cin >> x >> y;
		poligon.push_back(Punct(x, y));
	}

	int m;
	cin >> m;

	for (int i = 0; i < m; i++) {
		long long x, y;
		cin >> x >> y;
		Punct q(x, y);
		cout << pozitiePunctInPoligon(poligon, q) << endl;
	}
	
	return 0;
}
