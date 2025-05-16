# inlocuiti fiecare comentariu TODO

class NodArbore:
    def __init__(self, _informatie, _parinte=None, _g=0, _h=0):
        self.informatie = _informatie
        self.parinte = _parinte
        self.g = _g
        self.h = _h
        self.f = _g + _h

    def __lt__(self, other):
        return self.f < other.f or (self.f == other.f and self.h < other.h)

    def drumRadacina(self):
        nod = self
        l = []
        while nod:
            l.append(nod)
            nod = nod.parinte
        return l[::-1]

    def inDrum(self, infoNod):
        nod = self
        while nod:
            # TODO verificam daca informatia nodului nod e egala cu infoNod
            if infoNod == nod.informatie:
                return True
            # TODO urcam cu un nivel; variabila nod devine parintele sau
            nod = nod.parinte
        return False

    def __str__(self):
        return str(self.informatie)

    # c (a->b->c)
    def __repr__(self):
        sirDrum = "->".join(map(str, self.drumRadacina()))
        # TODO se foloseste join cu separatorul "->" pe o lista cu informatiile nodurilor returnate de drumRadacina()
        return f"{self.informatie}, costul parcurs: {self.g} ({sirDrum})"


class Graf:
    def __init__(self, _matr, _start, _scopuri, _h):
        self.matr = _matr
        self.start = _start
        self.scopuri = _scopuri
        self._h = _h

    def scop(self, informatieNod):
        return informatieNod in self.scopuri  # TODO daca informatieNod se afla in lista self.scopuri

    def estimeaza_h(self, infoNod):
        return self._h[infoNod]

    def succesori(self, nod):
        lSuccesori = []
        for infoSuccesor in range(len(self.matr)):
            # TODO testam ca pe linia corespunzatoare informatiei nodului si pe coloana infoSuccesor avem 1 (muchie)
            conditieMuchie = self.matr[nod.informatie][infoSuccesor] > 0
            # TODO testam ca infoSuccesor nu se afla in drumul nodului nod (cu metoda inDrum)
            conditieNotInDrum = not nod.inDrum(infoSuccesor)
            if conditieMuchie and conditieNotInDrum:
                # TODO obiect de tip NodArbore cu informatia infoSuccesor si parintele egal cu variabila nod
                nodNou = NodArbore(infoSuccesor, nod, nod.g + self.matr[nod.informatie][infoSuccesor], self.estimeaza_h(infoSuccesor))
                lSuccesori.append(nodNou)
        return lSuccesori


m = [
    [0, 3, 5, 10, 0, 0, 100],
    [0, 0, 0, 4, 0, 0, 0],
    [0, 0, 0, 4, 9, 3, 0],
    [0, 3, 0, 0, 2, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 4, 0, 5],
    [0, 0, 3, 0, 0, 0, 0],
]
start = 0
scopuri = [4, 6]
h = [0, 1, 6, 2, 0, 3, 0]


def aStarSolMultiple(gr, nsol):
    # TODO o lista cuprinzand un element de tip NodArbore cu informatia de start din graful gr
    # TODO nodul de start fiind radacina, nu va avea parinte

    coada = [NodArbore(gr.start)]
    while coada:
        # TODO primul nod din coada care e sters si returnat in nodCurent (functia pop)
        nodCurent = coada.pop(0)
        if gr.scop(nodCurent.informatie):
            print("Solutie: ", end="")
            print(repr(nodCurent))
            # TODO scadem cu 1 numarul de solutii nsol
            nsol -= 1
            # TODO daca numarul de solutii nsol este 0
            if nsol == 0:
                return
        # TODO adaugam succesorii generati cu gr.succesori pentru nodCurent
        coada += gr.succesori(nodCurent)
        coada.sort()


def a_star(gr):
    # TODO o lista cuprinzand un element de tip NodArbore cu informatia de start din graful gr
    # TODO nodul de start fiind radacina, nu va avea parinte

    OPEN = [NodArbore(gr.start)]
    CLOSED = []
    while OPEN:
        # TODO primul nod din coada care e sters si returnat in nodCurent (functia pop)
        nodCurent = OPEN.pop(0)
        CLOSED.append(nodCurent)
        if gr.scop(nodCurent.informatie):
            print("Solutie: ", end="")
            print(repr(nodCurent))
            return
        # TODO adaugam succesorii generati cu gr.succesori pentru nodCurent
        lSuccesori = gr.succesori(nodCurent)
        for sc in lSuccesori:
            gasitOpen = False
            for nod in OPEN:
                if nod.informatie == sc.informatie:
                    gasitOpen = True
                    if nod < sc:
                        lSuccesori.remove(sc)
                    else:
                        OPEN.remove(nod)
                    break
            if not gasitOpen:
                for nod in CLOSED:
                    if nod.informatie == sc.informatie:
                        if nod < sc:
                            lSuccesori.remove(sc)
                        else:
                            CLOSED.remove(nod)
                        break

        OPEN += lSuccesori
        OPEN.sort()

    print("Nu exista solutie")


gr = Graf(m, start, scopuri, h)
# aStarSolMultiple(gr, 5)
a_star(gr)
