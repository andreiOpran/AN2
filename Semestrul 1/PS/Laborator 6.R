rm(list = ls())

# Efron's dice
 
# A: 0 0 4 4 4 4
# V: 3 3 3 3 3 3
# R: 2 2 2 2 6 6
# G: 1 1 1 5 5 5 

n = 1e6

a = sample(c(0,4), size = n, replace = TRUE, prob = c(1/3, 2/3))
v = rep(3, times = n)
r = sample(c(2,6), size = n, replace = TRUE, prob = c(2/3, 1/3))
g = sample(c(1,5), size = n, replace = TRUE, prob = c(1/2, 1/2))

# cont = 0
# for (i in 1:n) 
# {
#     if (a[i] > 3) 
#     {
#         cont = cont + 1
#     }
# }
# probAV = cont/n

probAV = sum(a > 3)/n # prob ca A > V
probVR = sum(v > r)/n # prob ca V > R 
probRG = sum(r > g)/n # prob ca R > G
probGA = sum(g > a)/n # prob ca G > A


# monede mutual independente
# m1, m2, m3
# a1 = (m1 == m2)
# a2 = (m2 == m3)
# a3 = (m1 == m3)


m1 = sample(c("H", "T"), size = n, replace = TRUE)
m2 = sample(c("H", "T"), size = n, replace = TRUE)
m3 = sample(c("H", "T"), size = n, replace = TRUE)

a1 = sum(m1 == m2)/n
a2 = sum(m2 == m3)/n
a3 = sum(m1 == m3)/n

a1_intersectat_a2 = sum(m1 == m2 & m2 == m3)/n
a1_intersectat_a3 = sum(m1 == m2 & m1 == m3)/n
a2_intersectat_a3 = sum(m2 == m3 & m1 == m3)/n
a1_intersectat_a2_intersectat_a3 = sum(m1 == m2 & m2 == m3 & m1 == m3)/n

independente = 0

if(abs(a1_intersectat_a2 - a1 * a2) < 0.001)
{
    independente = independente + 1
}
if(abs(a1_intersectat_a3 - a1 * a3) < 0.001)
{
    independente = independente + 1
}
if(abs(a2_intersectat_a3 - a2 * a3) < 0.001)
{
    independente = independente + 1
}
if(abs(a1_intersectat_a2_intersectat_a3 - (a1 * a2 * a3) < 0.0001))
{
    independente = independente + 1
}
if(independente == 4)
{
    print("Independente")
} else
{
    print("Nu sunt independente")
}


# Secretaries problem

m = 1e4 # nr de simulari
n = 20 # nr persoane

n.potriviri = rep(0, m)
persoane = 1:n

for(i in 1:m)
{
    palarii = sample(1:n, size = n, replace = FALSE)
    n.potriviri[i] = sum(palarii == persoane)
}

sum(n.potriviri > 0) / m
n.potriviri


# Ruina jucatorului

ruina = function(N, k){
    flag = TRUE
    joc = 0
    capital = k
    y = capital
    while(flag){
        x = 2*rbinom(1,1,0.5)-1
        capital = capital + x
        y = c(y, capital)
        joc = joc + 1
        if (capital == 0 || capital == N){
            flag = FALSE
        }
    }
    return(y) # daca am 0 este ruina altfel este succes
}

N = 50
k = 5
# set.seed(1234)
y = ruina(N, k)
joc = length(y) - 1 # nr de jocuri
plot(0:joc, y, type = "l",
     main = "Ruina jucatorului",
     xlab = "Numar de jocuri",
     ylab = "Capitalul jucaturului",
     bty = "n",
     lty = 3, col = "grey50")
abline(h = c(0,N), col = "lightgrey", lty = 3)
points(0:joc, y, col = "red",
       pch = 16,
       cex = 0.5)
points(0, k, col = "red", pch = 16)
text(0, k, labels = paste0("k = ", k), pos = 1, cex = 0.7)
