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
    def __init__(self, _start, _scopuri):
        self.start = _start
        self.scopuri = _scopuri

    def scop(self, informatieNod):
        return informatieNod in self.scopuri  # TODO daca informatieNod se afla in lista self.scopuri

    def estimeaza_h(self, informatieNod):
        if informatieNod[2] == 1:
            return 2 * (informatieNod[0] + informatieNod[1]) // (Graf.M - 1) - 1
        else:
            return 2 * (informatieNod[0] + informatieNod[1]) // (Graf.M - 1)

    # (3, 3, 1) -> (3, 1, 0) ; (2, 2, 0) ; (3, 2, 0)
    def succesori(self, nod):

        def test_conditie(m, c):
            return m == 0 or m > c

        lSuccesori = []
        if nod.informatie[2] == 1:  # mal curent = malul initial
            misMalCurent = nod.informatie[0]
            canMalCurent = nod.informatie[1]
            misMalOpus = Graf.N - nod.informatie[0]
            canMalOpus = Graf.N - nod.informatie[1]
        else:
            misMalCurent = Graf.N - nod.informatie[0]
            canMalCurent = Graf.N - nod.informatie[1]
            misMalOpus = nod.informatie[0]
            canMalOpus = nod.informatie[1]

        canMinBarca = 0
        canMaxBarca = min(canMalCurent, Graf.M)

        for cb in range(canMinBarca, canMaxBarca + 1):
            if cb == 0:
                misMinBarca = 1
                misMaxBarca = min(misMalCurent, Graf.M)
            else:
                misMinBarca = 0
                misMaxBarca = min(misMalCurent, Graf.M - cb, cb)

                for mb in range(misMinBarca, misMaxBarca + 1):
                    misMalCurentNou = misMalCurent - mb
                    canMalCurentNou = canMalCurent - cb
                    misMalOpusNou = misMalCurent + mb
                    canMalOpusNou = canMalCurent + cb

                    if not test_conditie(misMalCurentNou, canMalCurentNou):
                        continue

                    if not test_conditie(misMalOpusNou, canMalOpusNou):
                        continue

                    if nod.informatie[2] == 1:
                        infoSuccesor = (misMalCurentNou, canMalCurentNou, 0)
                    else:
                        infoSuccesor = (misMalOpusNou, canMalOpusNou, 1)

                    conditieNotInDrum = not nod.inDrum(infoSuccesor)
                    if conditieNotInDrum:
                        # TODO obiect de tip NodArbore cu informatia infoSuccesor si parintele egal cu variabila nod
                        nodNou = NodArbore(infoSuccesor, nod, nod.g + 1, self.estimeaza_h(infoSuccesor))
                        lSuccesori.append(nodNou)

        return lSuccesori


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
    # TO DO o lista cuprinzand un element de tip NodArbore cu informatia de start din graful gr
    # TO DO nodul de start fiind radacina, nu va avea parinte
    CLOSED = []
    OPEN = [NodArbore(gr.start)]
    while OPEN:
        # TO DO primul nod din coada care e sters si returnat in nodCurent (functia pop)
        nodCurent = OPEN.pop(0)
        CLOSED.append(nodCurent)
        if gr.scop(nodCurent.informatie):
            print("Solutie: ", end="")
            print(repr(nodCurent))
            return
        # TO DO adaugam succesorii generati cu gr.succesori pentru nodCurent
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
    print("Nu avem solutii")


f = open('input', 'r')
continut = f.read().strip().split()  # '3 2' -> ['3', '2']
Graf.N = int(continut[0])
Graf.M = int(continut[1])
# stare = (misionari mal stang, canibali mal stang, locatie barca)
# locatie barca = 1 daca malul este initial; 0 daca malul e final
start = (Graf.N, Graf.M, 1)
scopuri = [(0, 0, 0)]

gr = Graf(start, scopuri)
# aStarSolMultiple(gr, 5)
a_star(gr)
