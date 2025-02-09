rm(list = ls())

x = c(1,2,3,7,11)
x > 4
x[x>4] == c(7,11)

# & -> vector
# && -> scalar (T,F)


# x = c(1, 2, 3, 7, 11)
# y = c(7, 14, 2, 1, 9)
# x < 19 & y > 0 -> T T F T T
# x < 19 && y > 0 -> T


cbind(1:4, 5:12)


survey = data.frame("index" = c(1, 2, 3, 4, 5),
                     "sex" = c("f", "m", "m", "f", "f"),
                     "age" = c(99, 46, 23, 54, 23))

survey

!mtcars
?mtcars
str(mtcars)

str(survey)
head(survey)
tail(survey)
View(survey)
rownames(survey)
names(survey)
str(mtcars)
head(mtcars)
tail(mtcars)
View(mtcars)


mtcars$mpg>13 & mtcars$hp > 100


stat_course= data.frame(student = c("Ionel", "Maria", "Gigel", "Vasile", "Ana"),
                        note_stat = c(9, 8, 5, 7, 9),
                        prenume = c("A", "B", "C", "D", "E", "F"))
alg_course = data.frame(student = c("Maria", "Ana", "Gigel", "Ionel", "Vasile", "Maria"),
                        note_alg = c(10,8,9,7,9,3),
                        prenume = c("B", "E", "C", "A", "D", "F"))

combined_courses = merge(x = stat_course, alg_course, by = "student")

combined_courses


mean(ChickWeight$weight[ChickWeight$Diet == 2])
mean(ChickWeight$weight[ChickWeight$Diet == 3])
mean(ChickWeight$weight[ChickWeight$Diet == 4])

aggregate(x = weight ~ Diet + Time, FUN = mean, data = ChickWeight)


View(mtcars)


# pag 26
mean(mtcars$wt[mtcars$am == 0])
mean(mtcars$wt[mtcars$am == 1])

# in loc de x se foloseste formula, in caz de erori
aggregate(x = wt ~ am, FUN = mean, data = mtcars)

aggregate(x = wt ~ cyl, FUN = mean, data = mtcars)

aggregate(x = mpg ~ cyl + am, FUN = mean, data = mtcars)




