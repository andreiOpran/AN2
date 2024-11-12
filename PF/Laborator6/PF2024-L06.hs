-- ctrl+alt+up/down
-- ctrl+alt+l
-- selectare linie + alt + up/dowm

-- Apples and oranges
data Fruct
  = Mar String Bool
  | Portocala String Int

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
ePortocalaDeSicilia (Mar _ _) = False
-- ePortocalaDeSicilia (Portocala "Tarocco" _) = True
-- ePortocalaDeSicilia (Portocala "Moro" _) = True
-- ePortocalaDeSicilia (Portocala "Sanguinello" _) = True
ePortocalaDeSicilia (Portocala x _) =
    if(elem x ["Tarocco", "Moro", "Sanguinello"])
        then True
    else
        False

test_ePortocalaDeSicilia1 =
    ePortocalaDeSicilia (Portocala "Moro" 12) == True
test_ePortocalaDeSicilia2 =
    ePortocalaDeSicilia (Mar "Ionatan" True) == False


-- incorect
-- nrFelii :: Fruct -> Int
-- nrFelii(Mar _ _) = 0
-- nrFelii(Portocala _ x) = x

-- nrFeliiSicilia :: [Fruct] -> Int
-- nrFeliiSicilia [] = 0
-- nrFeliiSicilia (x:xs) = nrFelii x + nrFeliiSicilia xs

-- test_nrFeliiSicilia :: Bool
-- test_nrFeliiSicilia = nrFeliiSicilia listaFructe == 52

eMarCuViermi :: Fruct -> Bool
eMarCuViermi (Mar _ vierme) = vierme

nrMereViermi :: [Fruct] -> Int
nrMereViermi [] = 0
nrMereViermi ((Portocala _ _):t) = nrMereViermi t
nrMereViermi ((Mar _ vierme):t)
    | vierme = 1 + nrMereViermi t
    | otherwise = nrMereViermi t

test_nrMereViermi :: Bool
test_nrMereViermi = nrMereViermi listaFructe == 2


nrMereViermi2 :: [Fruct] -> Int
nrMereViermi2 l = length [x | x <- l, eMarCuViermi x]

test_nrMereViermi2 :: Bool
test_nrMereViermi2 = nrMereViermi2 listaFructe == 2

-- Paw Patrol
type NumeA = String
type Rasa = String
data Animal = Pisica NumeA | Caine NumeA Rasa
    deriving Show

pisicaMea = Pisica "Cat"
caineleMeu = Caine "Dog" "maidanez"

vorbeste :: Animal -> String
vorbeste (Pisica _) = "Meow!"
vorbeste (Caine _ _) = "Woof!"

rasa :: Animal -> Maybe String
rasa (Caine _ r) = Just r
rasa (Pisica _) = Nothing

-- Matrix Ressurections
data Linie = L [Int]
   deriving Show
data Matrice = M [Linie]
   deriving Show

sumaLinie :: Linie -> Int
sumaLinie (L l) = sum l

verifica :: Matrice -> Int -> Bool
verifica (M []) _ = False
verifica (M (x:xs)) n = sumaLinie x == n || verifica (M xs) n

test_verif1 = verifica (M [L [1,2,3], L [4,5], L [2,3,6,8], L [8,5,3]]) 10 == False
test_verif2 = verifica (M [L [2,20,3], L [4,21], L [2,3,6,8,6], L [8,5,3,9]]) 25 == True

verifLungimeaLinii :: Linie -> Int -> Bool
verifLungimeaLinii (L []) _ = False
verifLungimeaLinii (L l) n = length l == n

verifElementePoz :: Linie -> Bool
verifElementePoz (L []) = False
verifElementePoz (L l) = and [x > 0 | x <- l]

doarPozN :: Matrice -> Int -> Bool
doarPozN (M []) _ = False
-- doarPozN (M (x:xs)) n = verifLungimeaLinii x n && verifElementePoz x && doarPozN (M xs) n
doarPozN (M (x:xs)) n = 
    if verifLungimeaLinii x n == True then
    verifElementePoz x && doarPozN (M xs) n
    else
    True

testPoz1 = doarPozN (M [L [1,2,3], L [4,5], L [2,3,6,8], L [8,5,3]]) 3 == True
testPoz2 = doarPozN (M [L [1,2,-3], L [4,5], L [2,3,6,8], L [8,5,3]]) 3 == False

corect :: Matrice -> Bool
corect (M []) = False
corect (M (L l:ls)) = aux ls (length l)
    where
        aux [] _ = True
        aux (L x:xs) n = verifLungimeaLinii (L x) n && aux xs n


testcorect1 = corect (M [L [1,2,3], L [4,5], L [2,3,6,8], L [8,5,3]]) == False
testcorect2 = corect (M [L [1,2,3], L [4,5,8], L [3,6,8], L [8,5,3]]) == True

