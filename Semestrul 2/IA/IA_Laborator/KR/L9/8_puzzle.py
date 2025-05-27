import math
import copy

class NodArbore:
    def __init__(self, _informatie, _parinte=None, _g=0, _h=0):
        self.informatie = _informatie
        self.parinte = _parinte
        self.g=_g
        self.h=_h
        self.f=_g+_h


    #  -------g--------====h===
    #  ---g---=========h=======
    
    def __lt__(self,elem):
        return self.f<elem.f or (self.f==elem.f and self.h<elem.h)

    def drumRadacina(self):
        nod=self
        l=[]
        while nod:
            l.append(nod)
            nod=nod.parinte
        return l[::-1]

    def inDrum(self,infoNod):
        nod=self
        while nod:
            #TO DO verificam daca informatia nodului nod e egala cu infoNod
            if infoNod==nod.informatie:
                return True
            #TO DO urcam cu un nivel; variabila nod devine parintele sau
            nod=nod.parinte
        return False


    def __str__(self):
        return str(self.informatie)

    #c (a->b->c)
    def __repr__(self):
        sirDrum="->".join(map(str,self.drumRadacina()))
        #TO DO se foloseste join cu separatorul "->" pe o lista cu informatiile nodurilor returnate de drumRadacina()
        return f"{self.informatie}, cost:{self.g} ({sirDrum})"

class Graf:
    def __init__(self,  _start, _scopuri):
        self.start=_start
        self.scopuri=_scopuri


    # de facut cu distanta manhattan
    def estimeaza_h(self, informatieNod):
        if self.scop(informatieNod):
            return 0
        minH=999999
        for infoScop in self.scopuri:
            h=0
            for i, stiva_i in enumerate(infoScop):
                for j, bloc_j in enumerate(stiva_i):
                    try:
                        if informatieNod[i][j]!=bloc_j:
                            h+=1
                    except:
                        h+=1
            if h<minH:
                minH=h
        return minH


    def scop(self, informatieNod):
        return informatieNod in self.scopuri #TO DO daca informatieNod se afla in lista self.scopuri

    def succesori(self, nod):
        
        def gasesteGol(matr):
            for i, linie in enumerate(matr):
                for j, elem in enumerate(linie):
                    if elem == 0:
                        return i, j
        
        lSuccesori=[]
        lGol, cGol = gasesteGol(nod.informatie)
        directii = [[-1, 0], [1, 0], [0, -1], [0, 1]]
        for d in directii:
            lPlacuta = lGol + d[0]
            cPlacuta = cGol + d[1]
            if 0 <= lPlacuta <= 2 and 0 <= cPlacuta <= 2:
                infoSuccesor = copy.deepcopy(nod.informatie)
                infoSuccesor[lPlacuta][cPlacuta], infoSuccesor[lGol][cGol] = infoSuccesor[lGol][cGol], infoSuccesor[lPlacuta][cPlacuta]
                conditieNotInDrum=not nod.inDrum(infoSuccesor)
                if conditieNotInDrum:
                    #TO DO obiect de tip NodArbore cu informatia infoSuccesor si parintele egal cu variabila nod
                    nodNou=NodArbore(infoSuccesor,nod, nod.g+1,self.estimeaza_h(infoSuccesor))
                    lSuccesori.append(nodNou)
        return lSuccesori


    def valideaza(self):
        matrDesfasurata=self.start[0]+self.start[1]+self.start[2]
        nrInvers=0
        matrDesfasurata.remove(0)
        for i, elem_i in enumerate(matrDesfasurata[:-1]):
            for j, elem_j in enumerate(matrDesfasurata[i+1:]):
                if elem_i>elem_j:
                    nrInvers+=1
        return nrInvers%2==0



def aStarSolMultiple(gr, nsol):
    #TO DO o lista cuprinzand un element de tip NodArbore cu informatia de start din graful gr
    #TO DO nodul de start fiind radacina, nu va avea parinte
    
    coada=[NodArbore(gr.start)]
    while coada:
        #TO DO primul nod din coada care e sters si returnat in nodCurent (functia pop)
        nodCurent=coada.pop(0)
        if gr.scop(nodCurent.informatie):
            print("Solutie: ", end="")
            print(repr(nodCurent))
            #TO DO scadem cu 1 numarul de solutii nsol
            nsol-=1
            #TO DO daca numarul de solutii nsol este 0
            if nsol==0:
                return
        #TO DO adaugam succesorii generati cu gr.succesori pentru nodCurent
        coada+=gr.succesori(nodCurent)
        coada.sort()


def a_star(gr):
    #TO DO o lista cuprinzand un element de tip NodArbore cu informatia de start din graful gr
    #TO DO nodul de start fiind radacina, nu va avea parinte
    CLOSED=[]
    OPEN=[NodArbore(gr.start)]
    while OPEN:
        #TO DO primul nod din coada care e sters si returnat in nodCurent (functia pop)
        nodCurent=OPEN.pop(0)
        CLOSED.append(nodCurent)
        if gr.scop(nodCurent.informatie):
            print("Solutie: ", end="")
            print(repr(nodCurent))
            return
        #TO DO adaugam succesorii generati cu gr.succesori pentru nodCurent
        lSuccesori=gr.succesori(nodCurent)
        for sc in lSuccesori:
            gasitOpen=False
            for nod in  OPEN:
                if nod.informatie==sc.informatie:
                    gasitOpen=True
                    if nod<sc:
                        lSuccesori.remove(sc)
                    else:
                        OPEN.remove(nod)
                    break
            if not gasitOpen:
                for nod in CLOSED:
                    if nod.informatie==sc.informatie:
                        if nod<sc:
                            lSuccesori.remove(sc)
                        else:
                            CLOSED.remove(nod)
                        break
        OPEN+=lSuccesori
        OPEN.sort()
    print("Nu avem solutii")

'''
1 2 3
4 5 6
7 8 0
'''

f=open("input_lab5.txt","r")

start= [list(map(int,linie.strip().split()))  for linie in f.read().strip().split("\n") ] #["1 0 3", ...]    
scopuri=[   [[1,2,3],[4,5,6],[7,8,0]]    ]
f.close()
print(start)
print(scopuri)
gr = Graf(start, scopuri)
if not gr.valideaza():
    print("Fara solutii")
else:
    a_star(gr)

