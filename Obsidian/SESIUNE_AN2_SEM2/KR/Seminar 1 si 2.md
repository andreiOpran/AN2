![[Pasted image 20250616135618.png]]

Rezolvați subpunctele de mai jos pentru următorul graf (_a_ e **nodul start** și _f_ e **nodul scop**). Costurile arcelor sunt trecute în dreptul lor, iar estimațiile sunt trecute în pătrățele, lângă noduri. Considerăm un drum soluție ca fiind un drum de la nodul start la un nod scop.

1. Care este drumul soluție de lungime minimă? Este acesta și drumul de cost minim?

	drumul solutie de lungime minima: a -> g -> f cu cost 27
	nu este drumul de cost minim, avem a -> b -> e -> f cu cost 26

2. Ce este o euristică consistentă? Dar admisibilă? Euristica dată este admisibilă? Dar consistentă?

	euristica consistenta = h(n) <= cost (n -> m) + h(m), m succesor
		c -> g => 8 <= 3 + 14 Adevarat
		b -> e => 22 <= 1 + 20 Fals
	
	euristica admisibila => nu se supraestimeaza costul real de la nodul curent la scop
		=> h(n) <= h(n)\*, h(n)* este costul real minim de la n la scop, h(n) este estimare
			h(a) = 7, dar costul real minim a -> f este 26 => 7 <= 26
			
3. Să se realizeze arborele A* și să se determine drumul de cost minim. Arătați la fiecare pas cum se modifică listele OPEN și CLOSED



4. Considerăm și nodul e ca fiind nod scop, dar pastram euristicile. Care este primul drum returnat de A*? (trebuie să refaceți arborele?) Mai este euristica admisibilă? Dacă nu, corectați euristica. Pentru o euristică neadmisibilă mai avem garantat faptul că A* returnează drumul de cost minim?
5. Presupunănd că am schimba euristica nodului d din 10 în 21. Mai este aceasta o euristică admisibilă?
6. Este vreodată folosită euristica nodului start? Justificați.
7. Pentru o euristică admisibilă ce valori avem mereu pentru nodurile scop?
8. Cum ar trebui să schimbăm euristica dacă avem și e și c considerate noduri speciale, și scopul e să găsim un drum care trece prin ambele, intai prin e si apoi prin c (nu mai e obligatoriu să ajungă în f)? În acest caz, drumul de cost minim ar conține arcul e->c? Dar dacă trebuie doar să trecem prin ele, indiferent de ordine? Dar dacă scopul e să trecem prin k noduri date indiferent de ordine?
9. Dați exemplu de euristică astfel încât numărul de extrageri de nod din coada OPEN realizate de A* pe acest graf să fie egal cu numărul de noduri din drumul de cost minim. Putem avea mai puține extrageri din coada OPEN?
10. Cum s-ar schimba problema dacă scopul nostru ar fi să găsim un drum cu un arc scop (drumul soluție trebuie obligatoriu să treacă prin acel arc); de exemplu, arcul e->c? Găsiți un exemplu de euristică admisibilă. Dar dacă se cere un drumul soluție de cost minim, care trece întâi prin arcul e->c și apoi prin d->g? Dar dacă scopul e să trecem prin cele două arce indiferent de ordinea parcurgerii? Dar dacă scopul e să trecem prin k arce date indiferent de ordine?

euristici:
a start, f scop
a 7  
b 22  
c 8  
d 10  
e 20  
f 0  
g 14

muchii:
a -> b cost 4  
a -> d cost 11  
a -> g cost 9  

b -> e cost 1  
b -> g cost 7  

c -> d cost 1
c -> f cost 17
c -> g cost 3  

d -> c cost 5  
d -> e cost 11  

e -> c cost 15  
e -> f cost 21  
e -> g cost 8   

g -> f cost 18
