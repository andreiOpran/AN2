# un plot (cu puncte relevante evidențiate, curbe, linii (comanda abline) etc) 
# o histogramă
# un barplot (care va presupune o agregare a datelor în categorii reprezentative)
# un boxplot


# ----------------------------------------------- SEATBELTS -----------------------------------------------


# ----------------------------------------------- PLOT ----------------------------------------------------
timp = time(Seatbelts)

plot(timp, Seatbelts[,"DriversKilled"], type="l", main="Decese din urma accidentelor auto in UK 1969 - 1984", 
     col="firebrick3", lwd=1, lty = 1, xlab="Anul curent", ylab="Decese", xaxt='n')

# marire frecventa afisare a anilor
axis(1, at = seq(1969, 1985, by = 1), labels = seq(1969, 1985, by = 1), las=2)
# adaugare linie punctata pentru fiecare an
abline(v = seq(1969, 1985, by = 1), col = "gray", lty = "dotted")

grid() # linii punctate

# adaugare linie orizontala pentru marcarea anului in care centura  adevenit obligatorie
abline(v=1983, col="blue4", lwd=1, lty=2)

legend("topright", legend = "Centura devine obligatorie", col="blue4", lwd=2, lty=2)




# ----------------------------------------------- HISTOGRAMA ----------------------------------------------- 

seatbelt_data <- data.frame(
    soferi = Seatbelts[,"drivers"],
    fata = Seatbelts[,"front"],
    spate = Seatbelts[,"rear"]
)

# 1 linie 3 colone
par(mfrow=c(1, 3)) 

hist(seatbelt_data$soferi, main = "Soferi", xlab="Soferi", col="firebrick3")
hist(seatbelt_data$fata, main = "Pasageri fata", xlab="Pasageri fata", col="firebrick3")
hist(seatbelt_data$spate, main = "Pasageri spate", xlab="Pasageri spate", col="firebrick3")

# resetare la 1 linie 1 coloana
par(mfrow=c(1, 1))





# ----------------------------------------------- BARPLOT ---------------------------------------------------
decese = Seatbelts[,"DriversKilled"]

decese_an <- aggregate(decese, nfrequency = 1, FUN = sum)

decese_an_vector <- as.numeric(decese_an) # nu merge altfel pt barplot

barplot(decese_an_vector, main="Decese din urma accidentelor auto in UK 1969 - 1984",  xlab="Anul curent", ylab="Decese", 
        col="firebrick3", names.arg=seq(1969, 1984, by=1))

abline(v=15, col="blue4", lwd=2, lty=2) # v = 15 deoarece 1983 este al 15-lea an din intervalul 1969 - 1984
legend("topright", legend = "Centura devine obligatorie", col="blue4", lwd=2, lty=2)




# ----------------------------------------------- BOXPLOT ---------------------------------------------------
decese <- Seatbelts[,"DriversKilled"]

# pentru fiecare luna
boxplot(decese ~ cycle(decese), main="Decese din urma accidentelor auto in UK 1969 - 1984", xlab="Luna", 
        ylab="Decese", col="firebrick3")

grid()













# ----------------------------------------------- YOUTUBE -----------------------------------------------

# https://www.kaggle.com/datasets/positivealexey/youtube-channel-performance-analytics
# youtube_channel_real_performance_analytics.csv

coloane = names(youtube_channel_real_performance_analytics)


yt = read.csv("C:/Users/andre/Desktop/AN2-SEM1/PS/Tema Laborator 7/R/youtube_channel_real_performance_analytics.csv")


# ----------------------------------------------- PLOT ----------------------------------------------------
# cast la date
yt$Video.Publish.Time = as.Date(yt$Video.Publish.Time)


plot(yt$Video.Publish.Time, yt$Revenue.per.1000.Views..USD., main = "Raportul dintre anul incarcarii si venitul per 1000 views", 
     xlab = "Anul incarcarii", ylab = "Venitul per 1000 views", pch =20, col = "firebrick3")

# mediana
lines(lowess(yt$Video.Publish.Time, yt$Revenue.per.1000.Views..USD.), col = "blue")

abline(v = as.Date("2020-01-01"), col = "olivedrab4", lty = 2, lwd = 2) 
abline(v = as.Date("2021-12-31"), col = "olivedrab4", lty = 2, lwd = 2)
legend("topright", legend = "Inceputul si sfarsitul pandemiei", col="olivedrab4", lwd=2, lty=2)


# ----------------------------------------------- HISTOGRAMA -----------------------------------------------


# fiecare zi a saptamanii este atribuita unui nivel
# consola: "Levels: Monday Tuesday Wednesday Thursday Friday Saturday Sunday"
yt$Day.of.Week <- factor(yt$Day.of.Week, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))
zi_numar <- as.numeric(yt$Day.of.Week)

hist(zi_numar, main = "Numarul de video-uri postate in fiecare zi a saptamanii", xlab = "Zi a saptamanii", ylab = "Numar video-uri", 
     col = "firebrick3", border = "black", breaks = 7, xaxt = 'n')

# axa cu zilele
axis(1, at = 1:7, labels = c("Luni", "Marti", "Miercuri", "Joi", "Vineri", "Sambata", "Duminica"))

