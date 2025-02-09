# ------------------------------- Problema 7 -------------------------------

# Mai întâi aruncăm o dată un zar (netrucat). 
# Apoi aruncăm zarul de atâtea ori câte arată rezultatul primei aruncări. 
# Fie variabila aleatoare X corespunzătoare numărului total de rezultate de șase obținute în toate aruncările zarului, 
# inclusiv în prima aruncare. 
# Care este funcția de masă a lui X?

N = 1e5
X = rep(0, N) # variabila aleatoare X

for (i in 1:N)
{
    primaAruncare = sample(1:6, 1)
    aruncari = sample(1:6, primaAruncare, replace = TRUE)
    X[i] = sum(aruncari == 6)
    if(primaAruncare == 6)
    {
        X[i] = X[i] + 1
    }
}

functieMasa = table(X) / N
functieMasa


# ------------------------------- Problema 8 -------------------------------

# Timpul de transmitere al unui mesaj necesită un număr de intervale de timp distribuite geometric, 
# de parametru q, cu 0 < q < 1.
# În fiecare interval de timp, un nou mesaj sosește cu probabilitate p, iar niciun mesaj nu sosește cu probabilitate 1 - p.
# Care este media și varianța numărului de mesaje nou-venite pe parcursul timpului 
# (și el aleator, dar cu distribuție știută) de transmitere al unui mesaj?

N = 1e5
q = 0.42
p = 0.56

mesaje = rep(0, N)

for(i in 1:N)
{
    n = rgeom(1, q) + 1 # numarul de esecuri + 1 (succesul)
    
    # reprezinta: in numarul n de intervale de timp, cate mesaje au sosit -> size = nr. experimente == 1 => Bernoulli, p = prob. din enunt
    mesaje[i] = sum(rbinom(n, size = 1, p)) 

    # sau
    # rbinom(1, size = n, p);    
}

media = mean(mesaje)
varianta = var(mesaje)

media
varianta





