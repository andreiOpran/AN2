# Breaks (bins) dilemma

data = rexp(100, rate = 0.5)

par(mfrow = c(1,3))
hist(data, breaks=12, col='blue')
hist(data, breaks=100,col='orange')
hist(data, breaks=2, col='cyan')

hist(data, breaks=12, col='blue', probability = TRUE)
hist(data, breaks=100,col='orange', probability = TRUE)
hist(data, breaks=2, col='cyan', probability = TRUE)

par(mfrow = c(1,1))