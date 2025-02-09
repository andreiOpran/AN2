rm(list = ls())

# O familie are doi copii. 
# Unul dintre copii este fata, nascuta Miercuri. 
# Care e probabilitatea ca celalalt copil sa fie tot fata? 


c1 = c("B", "F")
c2 = c("B", "F")

N = 1e5

cont1 = 0 # cand o fata este nascuta miercuri
cont2 = 0 # ambii copii sunt fete



for(i in 1:N)
{
    zile1 = sample(c(1:7), 1)
    zile2 = sample(c(1:7), 1)
    
    gen1 = sample(c1,1);
    gen2 = sample(c2,1);
    
    
    if((gen1 == "F" && zile1 == 3) || (gen2 == "F" && zile2 == 3))
    {
        cont1 = cont1 + 1
        if(gen1 == "F" && gen2 == "F")
        {
            cont2 = cont2 + 1
        }
        
    }
}
print(cont2/cont1)

# ------------------------------------------------------------------------------------

rm(list = ls())

# Extra: vedeti daca atunci cand in loc de zilele saptamanii luam anotimpuri 


c1 = c("B", "F")
c2 = c("B", "F")

N = 1e6

cont1 = 0 # cand o fata este nascuta miercuri
cont2 = 0 # ambii copii sunt fete



for(i in 1:N)
{
    anotimpuri1 = sample(c(1:4), 1)
    anotimpuri2 = sample(c(1:4), 1)
    
    gen1 = sample(c1,1);
    gen2 = sample(c2,1);
    
    
    if((gen1 == "F" && anotimpuri1 == 3) || (gen2 == "F" && anotimpuri2 == 3))
    {
        cont1 = cont1 + 1
        if(gen1 == "F" && gen2 == "F")
        {
            cont2 = cont2 + 1
        }
        
    }
}
print(cont2/cont1)




