rm(list = ls()) #  STERGERE 

# ?sample

# sample(c(1,2,3,4), size = 5)


# EXC 1 
nr_repetari = 1e6   # 10 la a 5-a

a = sample(c("HHH","TTT",
             "HHT","HTH","THH",
             "TTH","THT","HTT"),
           size = nr_repetari, replace = TRUE)
p = sum(a == "HHH" | a == "TTT")/length(a)
p
a[1:20]


# EXC PAG. 10
timp = c(106, 123, 123, 111, 125, 113, 130, 113, 114, 100, 120, 130, 118, 114, 127, 112, 121, 114, 120, 119, 127, 114, 108, 127, 131, 157, 157, 133)
zile = rep(c("luni","marti","miercuri","joi","vineri","sambata","duminica"), times = 4)

# a)
# timp == max(timp)
zile[timp == max(timp)]

# sau pentru a obtine indexul

which(timp == max(timp))

# b)
# timp == min(timp)
zile[timp == min(timp)]

# c)
raspunsC = zile[timp > 120]
table(raspunsC)
unique(raspunsC)
