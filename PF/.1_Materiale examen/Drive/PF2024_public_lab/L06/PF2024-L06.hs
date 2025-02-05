data Fruct = Mar String Bool | Portocala String Int

ionatanFaraVierme = Mar "Ionatan" False
goldenCuVierme = Mar "Golden Delicious" True
portocalaSicilia10 = Portocala "Sanguinello" 10
listaFructe = [Mar "Ionatan" False,
                Portocala "Sanguinello" 10,
                Portocala "Valencia" 22,
                Mar "Golden Delicious" True,
                Portocala "Sanguinello" 15,
                Portocala "Moro" 12,
                Portocala "Tarocco" 3,
                Portocala "Moro" 12,
                Portocala "Valencia" 2,
                Mar "Golden Delicious" False,
                Mar "Golden" False,
                Mar "Golden" True]

ePortocalaDeSicilia :: Fruct -> Bool
ePortocalaDeSicilia (Portocala soi _) = soi `elem` ["Tarocco", "Moro", "Sanguinello"]
ePortocalaDeSicilia _ = False

test_ePortocalaDeSicilia1 =
    ePortocalaDeSicilia (Portocala "Moro" 12) == True
test_ePortocalaDeSicilia2 =
    ePortocalaDeSicilia (Mar "Ionatan" True) == False

nrFelii :: Fruct -> Int
nrFelii (Mar _ _) = 0
nrFelii (Portocala _ x) = x

nrFeliiSicilia :: [Fruct] -> Int
nrFeliiSicilia l = sum [nrFelii i | i <- l, ePortocalaDeSicilia i]

test_nrFeliiSicilia = nrFeliiSicilia listaFructe == 52

areVierme :: Fruct -> Bool
areVierme (Portocala _ _) = False
areVierme (Mar _ areVierme) = areVierme 

nrMereViermi :: [Fruct] -> Int
nrMereViermi l = length [i | i <- l, areVierme i]

test_nrMereViermi = nrMereViermi listaFructe == 2



type NumeA = String
type Rasa = String
data Animal = Pisica NumeA | Caine NumeA Rasa deriving Show

pisica1 :: Animal
pisica1 = Pisica "Tom"
caine1 :: Animal
caine1 = Caine "Scooby-Doo" "Maro"


vorbeste :: Animal -> String
vorbeste (Pisica _) = "Meow!"
vorbeste (Caine _ _) = "Woof!"

rasa :: Animal -> Maybe String
rasa (Pisica _) = Nothing
rasa (Caine _ rasa) = Just rasa


data Linie = L [Int] deriving Show
data Matrice = M [Linie] deriving Show

sumaLinie :: Linie -> Int
sumaLinie (L l) = sum l

verifica :: Matrice -> Int -> Bool
verifica (M l) n = foldr (&&) True (map (\linie -> sumaLinie linie == n) l)

test_verif1 = verifica (M[L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) 10 == False
test_verif2 = verifica (M[L[2,20,3], L[4,21], L[2,3,6,8,6], L[8,5,3,9]]) 25 == True


linie1 :: Linie
linie1 = L [1,2,-3]

liniePozitiva :: Linie -> Bool
liniePozitiva (L []) = True
liniePozitiva (L (x:xs)) = if x > 0 then True && liniePozitiva (L xs) else False
-- liniePozitiva (L l) = foldr (&&) True (map (\x -> x > 0) l)

doarPozN :: Matrice -> Int -> Bool
doarPozN (M l) n = foldr (&&) True (map (\(L linie) -> if length linie == n then liniePozitiva (L linie) else True) l)

testPoz1 = doarPozN (M [L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) 3 == True

testPoz2 = doarPozN (M [L[1,2,-3], L[4,5], L[2,3,6,8], L[8,5,3]]) 3 == False

lungimeLinie :: Linie -> Int
lungimeLinie (L l) = length l

listaUniforma :: [Int] -> Bool
listaUniforma [] = True
listaUniforma [x] = True
listaUniforma (x:y:xs) = (x == y) && listaUniforma (y:xs)

corect :: Matrice -> Bool
corect (M l) = listaUniforma [lungimeLinie linie | linie <- l]

testcorect1 = corect (M[L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) == False
testcorect2 = corect (M[L[1,2,3], L[4,5,8], L[3,6,8], L[8,5,3]]) == True
