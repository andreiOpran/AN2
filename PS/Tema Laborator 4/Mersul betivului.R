#a) Mersul cetateanului turmentat

n = 100000  # Number of steps
position = 0

for (i in 1:n) {
  step = sample(c(-1, 1), 1)  
  #Obs: nu e nevoie de replace = TRUE; oricum fac o singura extragere
  position = position + step
}

cat("Final position after", n, "steps:", position)

#------------------------------

#b) Varianta 2: mai compact
n = 100  # Number of steps
steps_2 = sample(c(-1, 1), n, replace = TRUE)
position_2 = sum(steps_2)

cat("Final position after", n, "steps:", position_2)

#---------------------------

#c) Varianta 3: probabilitati diferite left-right
?sample
n = 100  # Number of steps
steps_3 = sample(c(-1, 1), n, replace = TRUE, prob = c(0.7, 0.3))
position_3 = sum(steps_3)

cat("Final position after", n, "steps:", position_3)

#--------------------------

#Extra: evolutia
n = 100  # Number of steps
steps_2 = sample(c(-1, 1), n, replace = TRUE)
steps_etape = cumsum(steps_2)

plot(1:n, steps_etape, type = "b")
cat("Final position after", n, "steps:", steps_etape[n])  #sau sum(steps_2)
