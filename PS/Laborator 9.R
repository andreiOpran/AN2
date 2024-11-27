# dataset -> Parade2005

data("Parade2005")

# venitul mediu in California

CA = mean(Parade2005$earnings[Parade2005$state == "CA"], na.rm = TRUE) 
CA

# count the number of individuals in Idaho
ID = sum(Parade2005$state == "ID", na.rm = TRUE)
ID

# mean and median of earnings of celebrities
mean_celebrity = mean(Parade2005$earnings[Parade2005$celebrity == "yes"], na.rm = TRUE)
median_celebrity = median(Parade2005$earnings[Parade2005$celebrity == "yes"], na.rm = TRUE)
mean_celebrity
median_celebrity

# vector 
View(sort(Parade2005$earnings[Parade2005$celebrity == "yes"]))

# exemplu
ex1 = c(1,2,3,4,5,6,7,8,1000)
mean(ex1)
median(ex1)


# problema 2
# distributia hipergeometrica
?dhyper
pb2 = dhyper(0:3, 3, 2, 3)
pb2

# Fx(49) = P(X <= 49), phyper(49,...)
# problema 3
?phyper
pb3 = phyper(49, 200, 20000 - 200, 1000, lower.tail = FALSE)
pb3

# problema 4.1
# distributia binomiala
?dbinom
pb4_1 = dbinom(0, 3, 0.3)
pb4_1


# problema 4.2
# distributia hipergeometrica
?dhyper
# pb4_2 = dhyper(, 8, 22, 3)
pb4_2

# problema 5
dbinom(0, size = 1e4, prob = 3/1e5)
dpois(0, lambda = 0.3)
1-exp(-0.3)*1.3


