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
