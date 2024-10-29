#   Lab 2 - exc de rezolvat

#   Exc1 (pag 7, lab 2)
?outer
n = 10    #dimensiunea matricei dorite n x n, cu n=?
x1 = 1:n
x2 = 1:n

#a) matricea N
N = outer(x1, x2^2, "/")
print(N)
N

#b) matricea M - definim noi operatorul dorit
operatie_noua <- function(i,j){
  k = sqrt( abs(i-j) + 1)
  return(1/k)
}
M = outer(x1, x2, operatie_noua)
print(M)

#alt exemplu
v1 = c("a","b", "c")
v2 = c("D", "E", "F")
P = outer(v1, v2, "paste")
print(P)

P_tilda = outer(v2,v1,"paste")
P_tilda

#-----------------------------------------
#    Exc2 (pag 12, lab 2)

#a) ca in prezentarea de la laborator
g_metoda1 <- function(x){
  if(x > 0){
    return((sin(x))^2 * log(x))
  }
  else{
    return((sin(x))^2 * x)
  }
}
g_metoda1(2)
g_metoda1(c(2,3)) #ok, am invatat lectia

#b) se cere investigat despre comanda Vectorize()
?Vectorize
g_metoda2 <- Vectorize(g_metoda1)
g_metoda2(c(2,3))

#c) se cere investigat ifelse (scris legat!)
?ifelse
g_metoda3 <- function(x){
  ifelse(x>0, (sin(x))^2 * log(x), (sin(x))^2 * x)
}

g_metoda3(3)     
g_metoda3(c(2,3))   #less is more, cumva, ar fi morala

#clarificari
valori = c(21, -62, -10, 53)
#asa nu (vezi eroarea: "the condition has length > 1 ..")
if(valori>0){
  print("Da")
}
else{
  print("Nu")
}

#asa da
ifelse(valori>0, "Da", "Nu")

#reprezentare grafica
?curve
#metoda rapida
curve(g_metoda2, from = -pi, to = pi)

#metoda clasica
?seq
x = seq(-pi, pi, length.out = 20)
plot(x, g_metoda2(x), type = "l", xlab = "Diviziune", ylab = "valori functie")
