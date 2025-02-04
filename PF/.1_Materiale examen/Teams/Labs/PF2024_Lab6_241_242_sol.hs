------ LAB 6 ------

{-
    DATA TYPES

    We can create custom data types with a data constructor and one or more type constructors. Think about the BOOL type.

    data Bool = True | False

    In this case, BOOL is the DATA constructor and TRUE and FALSE are the TYPE constructors. We use in our code True and False,
    keeping in mind that they are only data of type BOOL.
    In the example below, FRUCT is our DATA constructor and MAR and PORTOCALA are our TYPE constructors. Both of the constructors can
    be given parameters of a certain type.

    By using DERIVING (type class), we can create instances of give type class automatically. By using DERIVING SHOW, we can print a
    custom data type by creating a SHOW type instance for it. Already implemented types like String, Int etc. come with their own SHOW instance. This can apply to other type
    classes too.
-}
data Fruct
    = Mar String Bool
    | Portocala String Int
        deriving Show

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


------ EX 1 ------
-- a) Scrieți un predicat ePortocalaDeSicilia :: Fruct -> Bool care verifică dacă un fruct este o portocală de Sicilia. Soiurile de portocale din Sicilia sunt Tarocco, Moro și Sanguinello.
{-
    TO REMEMBER: We have declared multiple data of type Fruct. In this case, we need to make function cases for all data.
    Both MAR and PORTOCALA are FRUCT types, but not all FRUCT data is MAR or PORTOCALA. If a case is missing, an error arises when
    giving a missing FRUCT type data.
-}
ePortocalaDeSicilia :: Fruct -> Bool
ePortocalaDeSicilia (Mar _ _) = False
ePortocalaDeSicilia (Portocala x _ ) =
    if(elem x ["Tarocco", "Moro", "Sanguinello"])
        then True
    else
        False

--SAU--
ePortocalaDeSicilia' :: Fruct -> Bool
ePortocalaDeSicilia' (Mar _ _) = False
ePortocalaDeSicilia' (Portocala soi _) = soi `elem` ["Sicilia","Tarocco","Moro", "Sanguinello"]

-- b) Scrieți o funcție nrFeliiSicilia :: [Fruct] -> Int care calculează numărul total de felii ale portocalelor de Sicilia dintr-o listă de fructe.
nrFelii :: Fruct -> Int
nrFelii (Mar _ _) = 0
nrFelii (Portocala _ x) = x

nrFeliiSicilia :: [Fruct] -> Int
nrFeliiSicilia [] = 0
nrFeliiSicilia (x:xs) = nrFelii x + nrFeliiSicilia xs

--SAU--
nrFeliiSicilia2 :: [Fruct] -> Int
nrFeliiSicilia2 v = sum [nrFelii x | x <- v, ePortocalaDeSicilia x]

--SAU--
nrFeliiSicilia' :: [Fruct] -> Int
nrFeliiSicilia' port = sum [nrFelii | (Portocala tip nrFelii) <- port, elem tip ["Tarocco", "Moro", "Sanguinello"]]

--SAU--
nrFeliiSicilia'' :: [Fruct] -> Int
nrFeliiSicilia'' [] = 0
nrFeliiSicilia'' ((Mar _ _) : restuFructe) = nrFeliiSicilia'' restuFructe
nrFeliiSicilia'' ((Portocala soi nrFelii) : restuFructe) =
    if ePortocalaDeSicilia(Portocala soi nrFelii) == True then
        nrFelii + nrFeliiSicilia'' restuFructe
    else
        nrFeliiSicilia'' restuFructe

-- c) Scrieți o funcție nrMereViermi :: [Fruct] -> Int care calculează numărul de mere care au viermi dintr-o listă de fructe.
nrMereViermi :: [Fruct] -> Int
nrMereViermi [] = 0
nrMereViermi ((Portocala _ _) : restuFructe) = nrMereViermi restuFructe
nrMereViermi ((Mar _ viermi) : restuFructe) =
    if viermi == True then
        1 + nrMereViermi restuFructe
    else
        nrMereViermi restuFructe

nrMereViermi1 :: [Fruct] -> Int
nrMereViermi1 list = length [(Mar tip vierme) | (Mar tip vierme) <- list , vierme]


type NumeA = String
type Rasa = String
data Animal = Pisica NumeA | Caine NumeA Rasa
    deriving Show


------ EX 2 ------
-- a) Scrieți o funcție vorbeste :: Animal -> String care întoarce "Meow!" pentru pisică și "Woof!" pentru câine.
vorbeste :: Animal -> String
vorbeste (Pisica _) = "Meow!"
vorbeste (Caine _ _) = "Woof!"

--SAU--
vorbeste' :: Animal -> String
vorbeste' animal =
    case animal of
        Pisica _ -> "Meow!"
        Caine _ _ -> "Woof!"

-- b) Scrieți o funcție rasa :: Animal -> Maybe String care întoarce rasa unui câine dat ca parametru sau Nothing dacă parametrul este o pisică.
{-
    MAYBE TYPE

    MAYBE is a predefined type in Haskell. It does not have any special syntactic attributes in comparison to other data types.
    We use it for the IDEA of maybe when coding, to help us show values that can be null, point to erorrs, handle an event that
    may or not be happening etc.
-}
rasa :: Animal -> Maybe String
rasa (Pisica _) = Nothing
rasa (Caine _ rasa) = Just rasa

rasa' :: Animal -> Maybe String
rasa' animal =
    case animal of
        Pisica _ -> Nothing
        Caine _ rasa -> Just rasa



data Linie = L [Int]
    deriving Show
data Matrice = M [Linie]
    deriving Show

------ EX 3 ------
-- a) Scrieți o funcție verifica :: Matrice -> Int -> Bool care verifică dacă suma elementelor de pe fiecare linie este egală cu o valoare dată n.
verifica :: Matrice -> Int -> Bool
verifica (M l) n = foldr (&&) True $ map (== n) [sum l2 | (L l2) <- l]

--SAU--
sumLinie :: Linie -> Int
sumLinie (L l) = sum l

verifica' :: Matrice -> Int -> Bool
verifica' (M l) n = foldr (&&) True
                    (map (\linie -> sumLinie linie == n) l)

-- b) Scrieți o funcție doarPozN :: Matrice -> Int -> Bool care verifică dacă toate liniile de lungime n din matrice au numai elemente strict pozitive.
liniePos :: Linie -> Bool
liniePos (L l) = foldr (&&) True (map (\x -> x > 0) l)

doarPozN :: Matrice -> Int -> Bool
doarPozN (M l) n = foldr (&&) True (map (\(L linie) -> if (length linie == n) then liniePos (L linie) else True) l)

--SAU--
doarPozN' :: Matrice -> Int -> Bool
doarPozN' (M list) n = foldr (&&) True (map pozitive liniiN)
    where
        liniiN = filter (\ (L l) -> length l == n) list
        pozitive (L l) = l == filter (> 0) l

-- c) Definiți predicatul corect :: Matrice -> Bool care verifică dacă toate liniile dintr-o matrice au aceeași lungime.
corect :: Matrice -> Bool
corect (M []) = True
corect (M [_]) = True
corect (M (L l:ls)) = foldr (\(L y) acc -> (length l == length y) && acc) True ls

--SAU--
allEqual (x:t) = all (== x) t

corect' :: Matrice -> Bool
corect' (M l) = allEqual [length l2 | (L l2) <- l]