a = (1+sqrt(5)/2)/2
asq = sqrt(a)
doi = 2 ^ 3
catul = 10 %/% 5
restul = 10 %% 5
ls.str()
rm(list = ls())

x <- "test"
typeof(x)
typeof(AirPassengers)
typeof(UKgas)
typeof(UKDriverDeaths)
attributes(x)
attributes(UKgas)

typeof(y)
length(y)

z <- as.numeric(y)
z
typeof(z)

# vectorii au elemente cu acelasi tip


vector()
logical(0)

vector("character", length = 5)
character(5)
numeric(5)
logical(5)

# CONCATENARE
x <- c(0.5, 0.6) ## numeric
x <- c(TRUE, FALSE) ## logical
x <- c(T, F) ## logical
x <- c("a", "b", "c") ## character
x <- 9:29 ## integer
x <- c(1+0i, 2+4i) ## complex
x

z <- c("Sandra", "Traian", "Ionel")
z <- c(z, "Ana")
z
z <- c("George", z)
z


# REP
rep(c(1,2,3), 5)

# SEQ
seq(1, 10, length.out = 15)


# Operat, iile elementare pe care le puteam face cu scalari (adunarea +, scăderea -, înmult, irea *, împărt, irea / s, i
# ridicarea la putere ˆ) putem să le facem s, i cu vectori (între vectori sau între vectori s, i scalari).

# OPERATII PE VECTORI
# min(), max(), sum(), mean(), sd(), length(), round(), ceiling(), floor()


x <- 1:5
y <- 6:10
z <- 11:15
cbind(x, y, z)
rbind(x, y, z)

matrix(data = 1:10,
       nrow = 5,
       ncol = 2)

diag(M) # Diagonala matricei M
dim(M) # Dimensiunile matricei M
nrow(M) # Numarul de linii ale matricei M
ncol(M) # Numarul de coloane ale matricei M
t(M) # Transpusa

colSums(M)
rowSums(M) # Suma pe coloane si suma pe linii


#listele permit combinarea tipurilor de date (vectori recursivi)

a = list(nume = "Ionel", salariu = 1500, apartenenta = T)
a
str(a)

# data frame -> fiecare coloana poate avea tipuri de date diferite
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "sex" = c("m", "m", "m", "f", "f"),
                     "age" = c(99, 46, 23, 54, 23))
survey
