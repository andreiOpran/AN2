class NodArbore:
    def __init__(self, _informatie, _parinte=None):
        self.informatie = _informatie
        self.parinte = _parinte

    def drum_radacina(self):
        nod = self
        l = []
        while nod:
            # adaugam nod la finalul lui l
            l.append(nod)
            # urcam cu un nivel
            nod = nod.parinte
        return l[::-1]

    def in_drum(self, info_nod):
        nod = self
        while nod:
            # verificam daca informatia nodului nod e egala cu infoNod
            if nod.informatie == info_nod:
                return True
            #TO DO urcam cu un nivel; variabila nod devine parintele sau
            nod = nod.parinte
        return False

    def __str__(self):
        # conversia proprietatii informatie la string
        return str(self.informatie)

    #c (a->b->c)
    def __repr__(self):
        # se foloseste join cu separatorul "->" pe o lista cu informatiile nodurilor returnate de drumRadacina()
        sir_drum = "->".join(map(str, self.drum_radacina()))
        return f"{self.informatie}, ({sir_drum})"


class Graf:
    def __init__(self, _matr, _start, _scopuri):
        self.matr = _matr
        self.start = _start
        self.scopuri = _scopuri

    def scop(self, informatie_nod):
        # daca informatie_nod se afla in lista self.scopuri
        return informatie_nod in self.scopuri

    def succesori(self, nod):
        l_succesori = []
        for infoSuccesor in range(len(self.matr)):
            # testam ca pe linia corespunzatoare informatiei nodului si pe coloana infoSuccesor avem 1 (muchie)
            conditie_muchie = self.matr[nod.informatie][infoSuccesor] == 1
            # testam ca infoSuccesor nu se afla in drumul nodului nod (cu metoda in_drum)
            conditie_not_in_drum = not nod.in_drum(infoSuccesor)
            if conditie_muchie and conditie_not_in_drum:
                # obiect de tip NodArbore cu informatia infoSuccesor si parintele egal cu variabila nod
                nod_nou = NodArbore(infoSuccesor, nod)
                l_succesori.append(nod_nou)
        return l_succesori


m = [
    [0, 1, 0, 1, 1, 0, 0, 0, 0, 0],
    [1, 0, 1, 0, 0, 1, 0, 0, 0, 0],
    [0, 1, 0, 0, 0, 1, 0, 1, 0, 0],
    [1, 0, 0, 0, 0, 0, 1, 0, 0, 0],
    [1, 0, 0, 0, 0, 0, 0, 1, 0, 0],
    [0, 1, 1, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 1, 0, 0, 0, 1, 1],
    [0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
]


def BF(gr, nsol):
    # o lista cuprinzand un element de tip NodArbore cu informatia de start din graful gr
    coada = [NodArbore(gr.start)]
    # nodul de start fiind radacina, nu va avea parinte
    while coada:
        # primul nod din coada care e sters si returnat in nodCurent (functia pop)
        nod_curent = coada.pop(0)
        if gr.scop(nod_curent.informatie):
            print("Solutie: ", end="")
            print(repr(nod_curent))
            # scadem cu 1 numarul de solutii nsol
            nsol -= 1
            # daca numarul de solutii nsol este 0
            if nsol == 0:
                return
        # adaugam succesorii generati cu gr.succesori pentru nodCurent
        coada += gr.succesori(nod_curent)


def depth_first(gr, nsol=1):
    # vom simula o stiva prin relatia de parinte a nodului curent
    DF(NodArbore(gr.start), nsol)


def DF(nodCurent, nsol):
    if nsol <= 0:
        return nsol
    # print("Stiva actuala: " + repr(nodCurent.drumRadacina()))
    if gr.scop(nodCurent.informatie):
        print("Solutie: ", end="")
        print(repr(nodCurent))
        print("\n----------------\n")
        # scadem cu 1 numarul de solutii nsol
        nsol -= 1
        # daca numarul de solutii nsol este 0
        if nsol == 0:
            return
    # lista cu succesorii generati cu gr.succesori pentru nodCurent
    l_succesori = gr.succesori(nodCurent)
    # pentru fiecare succesor sc din l_succesori
    for sc in l_succesori:
        if nsol != 0:
            nsol = DF(sc, nsol)
    return nsol


start = 0
scopuri = [5, 9]
gr = Graf(m, start, scopuri)
BF(gr, 4)
