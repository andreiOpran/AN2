import Data.Char (digitToInt)

verifL :: [Int] -> Bool
verifL l
    | even (length l) = True
    | otherwise = False

takefinal :: [Int] -> Int -> [Int]
takefinal l n = if length l < n then l else drop (length l - n) l

takefinalString :: String -> Int -> String
takefinalString l n = if length l < n then l else
        drop (length l - n) l

remove :: [Int] -> Int -> [Int]
remove l n = take n l ++ drop (n + 1) l

sumImp :: [Int] -> Int
sumImp [] = 0
sumImp (x:xs) = if odd x then x + sumImp xs else sumImp xs

-- semiPareRec [0,2,1,7,8,56,17,18] == [0,1,4,28,9]
semiPareRec :: [Int] -> [Int]
semiPareRec [] = []
semiPareRec (h:t)
 | even h    = h `div` 2 : t'
 | otherwise = t'
 where t' = semiPareRec t

myreplicate :: Int -> v -> [v]
myreplicate 0 v = []
myreplicate 1 v = [v]
myreplicate n v = myreplicate (n - 1) v ++ [v]


totalLen :: [String] -> Int
totalLen [] = 0
totalLen (x:xs) = if head x == 'A' then length x + totalLen xs else totalLen xs

esteVocala :: Char -> Bool
esteVocala c = c `elem` "aeiouAEIOU"

nrVocaleSir :: String -> Int
nrVocaleSir [] = 0
nrVocaleSir (x:xs) = if esteVocala x then 1 + nrVocaleSir xs else nrVocaleSir xs

estePalindrom :: String -> Bool
estePalindrom s = s == reverse s

-- nrVocale ["sos", "civic", "palton", "desen", "aerisirea"] == 9
nrVocale :: [String] -> Int
nrVocale [] = 0
nrVocale (x:xs) = if estePalindrom x then nrVocaleSir x + nrVocale xs else nrVocale xs

-- f 3 [1,2,3,4,5,6] = [1,2,3,3,4,3,5,6,3]
f :: Int -> [Int] -> [Int]
f n [] = []
f n (x:xs)
    | even x = x : n : f n xs
    | otherwise = x : f n xs

fVar2 :: Int -> [Int] -> [Int]
fVar2 _ [] = []
fVar2 n l = if even (head l) then [head l] ++ [n] ++ fVar2 n (tail l)
            else [head l] ++ fVar2 n (tail l)

-- descrieri de liste
semiPareComp :: [Int] -> [Int]
semiPareComp l = [ x `div` 2 | x <- l, even x ]

-- divizori 4 == [1,2,4]
divizori :: Int -> [Int]
divizori n = [i | i <- [1..n], n `mod` i == 0]

-- listadiv [1,4,6,8] == [[1],[1,2,4],[1,2,3,6],[1,2,4,8]]
listadiv :: [Int] -> [[Int]]
listadiv [] = []
listadiv (x:xs) = divizori x : listadiv xs

-- inInterval 5 10 [1..15] == [5,6,7,8,9,10]
-- inInterval 5 10 [1,3,5,2,8,-1] == [5,8]
inIntervalRec :: Int -> Int -> [Int] -> [Int]
inIntervalRec _ _ [] = []
inIntervalRec a b (x:xs) = if x >= a && x <= b
                        then x : inIntervalRec a b xs
                        else inIntervalRec a b xs

inIntervalComp :: Int -> Int -> [Int] -> [Int]
inIntervalComp a b l = [i | i <- l, i >= a && i <= b]

-- pozitive [0,1,-3,-2,8,-1,6] == 3
pozitiveRec :: [Int] -> Int
pozitiveRec [] = 0
pozitiveRec (x:xs) = if x > 0 then 1 + pozitiveRec xs else pozitiveRec xs

pozitiveComp :: [Int] -> Int
pozitiveComp l = length [i | i <- l, i > 0]

pozitiiImpareRecAux :: Int -> [Int] -> [Int]
pozitiiImpareRecAux _ [] = []
pozitiiImpareRecAux i (x:xs)
    | odd x = i : pozitiiImpareRecAux (i + 1) xs
    | otherwise = pozitiiImpareRecAux (i + 1) xs

-- pozitiiImpare [0,1,-3,-2,8,-1,6,1] == [1,2,5,7]
pozitiiImpareRec :: [Int] -> [Int]
pozitiiImpareRec [] = []
pozitiiImpareRec l = pozitiiImpareRecAux 0 l

pozitiiImpareComp :: [Int] -> [Int]
pozitiiImpareComp l = [i | i <- [0..(length l - 1)], odd (l !! i)]

-- multDigits "The time is 4:25" == 40
-- multDigits "No digits here!" == 1
esteCifra :: Char -> Bool
esteCifra c = c `elem` "0123456789"

multDigitsRec :: String -> Int
multDigitsRec [] = 1
multDigitsRec (x:xs)
    | esteCifra x = digitToInt x * multDigitsRec xs
    | otherwise = multDigitsRec xs

multDigitsComp :: String -> Int
multDigitsComp s = product [digitToInt i | i <- s, esteCifra i]

-- functie primeste ca argument o lista si intoarce toate permutarile
permutari :: Eq a => [a] -> [[a]]
permutari [] = [[]]
permutari xs = [x:ps | x <- xs, ps <- permutari (removeElem x xs)]
    where
        removeElem _ [] = []
        removeElem y (z:zs)
            | y == z    = zs
            | otherwise = z : removeElem y zs

-- functie care primeste o lista si un int k, intoarce toate combinarile de k elemente din lista
combinari :: Int -> [a] -> [[a]]
combinari 0 _  = [[]]
combinari _ [] = []
combinari k (x:xs) = [x:c | c <- combinari (k-1) xs] ++ combinari k xs

-- functie care primeste o lista si un int k, intoarce toate aranjamentele de k elemente din lista
aranjamente :: Eq a => Int -> [a] -> [[a]]
aranjamente 0 _  = [[]]
aranjamente _ [] = []
aranjamente k xs = [y:ys | y <- xs, ys <- aranjamente (k-1) (removeElem y xs)]
    where
        removeElem _ [] = []
        removeElem y (z:zs)
            | y == z    = zs
            | otherwise = z : removeElem y zs


-- Scrieti o functie care primeste ca argument un numar intreg ce reprezinta dimensiunea 
-- unei table de sah si un numar intreg ce reprezinta numarul de dame ce trebuie asezate pe tabla, 
-- si intoarce lista pozitiilor in care pot fi asezate damele fara sa se atace.
type Position = (Int, Int)

-- Verifică dacă o poziție este sigură pentru a plasa o damă
isSafe :: Position -> [Position] -> Bool
isSafe _ [] = True
isSafe (row, col) ((r, c):ps)
    | row == r = False
    | col == c = False
    | abs (row - r) == abs (col - c) = False
    | otherwise = isSafe (row, col) ps

-- Plasează damele pe tablă
placeQueens :: Int -> Int -> [Position] -> [[Position]]
placeQueens 0 _ placed = [placed]
placeQueens n size placed = [result | col <- [1..size], let pos = (n, col), isSafe pos placed, result <- placeQueens (n-1) size (pos:placed)]

-- Funcția principală care primește dimensiunea tablei și numărul de dame
nQueens :: Int -> Int -> [[Position]]
nQueens size numQueens = placeQueens numQueens size []

-- Exemplu de utilizare
-- nQueens 8 8