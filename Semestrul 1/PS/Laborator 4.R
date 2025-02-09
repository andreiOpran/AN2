rm(list = ls())



# concatenare prin:
# paste -> returneaza concatenarea
# cat -> doar afiseaza concatenarea

x = paste("a", "b", sep = " ");
cat("a", "b", sep = " ");



x = runif(1, 0, 10)
if(x > 3) {
    y = 10
} else {
    y = 0
}


for(i in 1:10)
{
    print(i)
}

x = c(17,29,4,35,3)
seq_along(x)
for(i in seq_along(x))
{
    print(x[i])
}

mat = matrix(0, nrow = 10, ncol = 10)
for(i in 1:10)
{
    for(j in 1:10)
    {
         if(i - j >= 0)
         {
             mat[i,j] = 1/sqrt(i-j+1)
         }
         else mat[i,j] = 1/sqrt(j-i+1)
    }
}
print(mat)



v1 = c("a", "b", "c", "d")
v2 = c("d", "e", "f", "g")
p = outer(v1,v2,"paste") # ultimul argument poate fi o functie definita de utilizator
print(p)

# alta modalitate pentru mat
operatie_noua = function(i, j)
{
    k = sqrt(abs(i-j) + 1)
    return (1/k)
}
x1 = 1:10
x2 = 1:10
mat = outer(x1, x2, operatie_noua)
print(mat)



# sume partiale
n = 100
steps_2 = sample(c(-1,1), n, replace = TRUE)
steps_etape = cumsum(steps_2)

plot(1:n, steps_etape, type = "b")
cat("Final position after", n, "steps:", steps_etape[n])


?ifelse
x = 5
y = c(2,3)
g1 = function(x){
    if(x > 0)
    {
        return(sin(x)^2 * log(x))
    } else {
        return(sin(x)^2 * x)
    }
}

g2 = function(x){
    ifelse(x > 0, sin(x)^2 * log(x), sin(x)^2 * x)
}

g1(x)
g2(x)
g1(y)
g2(y)



# merge doar pe ifelse, (?vectorize)
curve(g1, from = -pi, to = pi) 
curve(g2, from = -pi, to = pi, add = TRUE, col = "palegreen4")



# problema familie cu 2 copii -> 2.2 pagina 5
n = 10^5
copil1 = sample(c("fata", "baiat"), n, replace = TRUE)
copil2 = sample(c("fata", "baiat"), n, replace = TRUE)

# intrebare 1
numitor_a = sum(copil1 == "baiat" | copil2 == "baiat") # formula de la probabilitati conditionate putin prelucrata
numarator_a = sum(copil1 == "baiat" & copil2 == "baiat")

p_macar_un_baiat = numarator_a / numitor_a
p_macar_un_baiat

#intrebare 2
numitor_b = sum(copil1 == "baiat")
p_primul_baiat = numarator_a / numitor_b
p_primul_baiat









