#include <iostream>
#include <vector>
#include <algorithm>

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

// pregatim poligonul pentru cautare binara
vector<Punct> secventa;
Punct translatie;
int n;

void pregatirePoligon(vector<Punct>& puncte) {
	n = puncte.size();

	// gasim punctul cu coordonatele minime
	int pos = 0;
	for (int i = 1; i < n; i++) {
		if (compararePuncte(puncte[i], puncte[pos]))
			pos = i;
	}

	// rotim vectorul de puncte astfel incat primul punct sa fie cel cu coordonatele minime
	rotate(puncte.begin(), puncte.begin() + pos, puncte.end());

	// translatam punctele astfel incat primul punct sa fie originea
	n--;
	secventa.resize(n);
	for (int i = 0; i < n; i++) {
		secventa[i] = puncte[i + 1] - puncte[0];
	}

	translatie = puncte[0];
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

string pozitiePunctInPoligonConvex(Punct punct) {
	// verificare BOUNDARY
	// verificam daca punctul e chiar translatia (primul varf)
	if (punct.x == translatie.x && punct.y == translatie.y) {
		return "BOUNDARY";
	}

	punct = punct - translatie;

	// verificare OUTSIDE
	// verificam daca punctul e in dreapta primei laturi
	if (secventa[0].cross(punct) != 0 && semn(secventa[0].cross(punct)) != semn(secventa[0].cross(secventa[n - 1]))) {
		return "OUTSIDE";
	}

	// verificam daca punctul e in dreapta ultimei laturi
	if (secventa[n - 1].cross(punct) != 0 && semn(secventa[n - 1].cross(punct)) != semn(secventa[n - 1].cross(secventa[0]))) {
		return "OUTSIDE";
	}

	if (secventa[0].cross(punct) == 0)
	{
		// verificam pozitia pe raza primei muchii
		if (secventa[0].dot(punct) < 0 || secventa[0].sqrLen() < punct.sqrLen())
			return "OUTSIDE";
		else
			return "BOUNDARY";
	}

	// cautare binara pentru a gasi sectorul in care se afla punctul
	int l = 0, r = n - 1;
	while (r - l > 1) {
		int mid = (l + r) / 2;
		if (secventa[mid].cross(punct) >= 0)
			l = mid;
		else
			r = mid;
	}

	// verifica daca punctul e pe una din cele doua laturi
	Punct a1 = secventa[l] + translatie;
	Punct b1 = Punct(0, 0) + translatie;
	if (punctPeSegment(a1, b1, punct))
		return "BOUNDARY";

	Punct a2 = secventa[l + 1] + translatie;
	if (punctPeSegment(a1, a2, punct))
		return "BOUNDARY";

	// verificcam daca punctul e in triunghiul format de cele doua laturi
	if (punctInTriunghi(Punct(0, 0), secventa[l], secventa[l + 1], punct))
		return "INSIDE";
	else
		return "OUTSIDE";
}

int main() {
	int n, m;

	cin >> n;
	vector<Punct> poligon;
	for (int i = 0; i < n; i++) {
		long long x, y;
		cin >> x >> y;
		poligon.push_back(Punct(x, y));
	}
	pregatirePoligon(poligon);

	cin >> m;
	for (int i = 0; i < m; i++) {
		long long x, y;
		cin >> x >> y;
		Punct punct(x, y);
		cout << pozitiePunctInPoligonConvex(punct) << '\n';
	}
	return 0;
}
