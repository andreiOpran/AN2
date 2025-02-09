------ LAB 4 ------

------ EX 2 ------
-- Definiti o functie factori care întoarce lista divizorilor pozitivi ai unui numar primit ca parametru. Folositi doar
-- metoda de definire a listelor prin selectie.
factori :: Int -> [Int]
factori n = [x | x <- [1..n], n `mod` x == 0]


------ EX 3 ------
-- Folosind functia factori, definiti predicatul prim, care verifica daca un numar primit ca parametru este prim.
prim :: Int -> Bool
prim n =
    if(n == 1)
        then False
    else
        if(length (factori n) == 2)
            then True
        else False


------ EX 4 ------
-- Definiti functia numerePrime, care pentru un numar n primit ca parametru, întoarce lista numerelor prime din
-- intervalul [2..n]. Folositi metoda de definire a listelor prin selectie si functiile definite anterior.
numerePrime :: Int -> [Int]
numerePrime n = [x | x <- [2..n], prim x]


{-
The ZIP function combines elements from two lists into a list of pairs. Its attribute is that the combined elements
have the same index in the lists.
TO REMEMBER: We can use this for adding indexes to the elements of a list.

SECTIONS are partial applications of INFIX operators. They are created by surrounding an operator with parentheses
and providing one of its arguments. They are useful for creating simple functions on the fly, especially when
working with higher-order functions like map and filter.
Examples:
(2*) (+5) (4/) (/4) (>9) (`mod` 3) (3 `mod`)

LAMBDA expressions are anonymous functions in Haskell, defined using the \ symbol. They are useful when creating
short, one-use functions on to go.
Examples:
\x -> x * x
\(x, y) -> x + y

The MAP function applies a given function to every element of a list and returns the modified list.

FILTER creates a new list containing only the elements of the original list that satisfy a given predicate.
TO REMEMBER: A predicate is a function that return a Bool type.
-}

------ EX 5 ------
-- Definiti functia myzip3 ca o generalizare a functiei zip pentru trei argumente.
-- TO REMEMBER: When not given any type or type class, the function automatically uses the FORALL keyword
myzip3 :: [a] -> [b] -> [c] -> [(a, b, c)]
myzip3 l1 l2 l3 = [ (x ,y, z) |((x, y), z) <- zip (zip l1 l2) l3]

--SAU--
myzip3' :: [Int] -> [Int] -> [Int] ->  [(Int, Int, Int)]
myzip3' [] _ _ = []
myzip3' _ [] _ = []
myzip3' _ _ [] = []
myzip3' (x:xs) (y:ys) (z:zs) = (x, y, z) : myzip3 xs ys zs

--SAU--

min3 :: Int -> Int -> Int -> Int
min3 x y z = let min1 = min x y
                in min min1 z

myzipAux :: [Int] -> [Int] -> [Int] ->  [(Int, Int, Int)]
myzipAux l1 l2 l3 = let m = min3 (length l1) (length l2) (length l3)
                            in [(l1 !! i, l2 !! i, l3 !! i) | i<-[0..m-1]]

------ EX 6 ------
-- Scrieti o functie generica firstEl care primeste ca parametru o lista de perechi de tip (a,b) si întoarce lista
-- primelor elementelor din fiecare pereche.
firstEl :: [(Int,Int)] -> [Int]
firstEl lista = [x | (x, y) <- lista]
-- firstEl lista = [fst x | x <- lista]


------ EX 7 ------
-- Scrieti functia sumList care are ca parametru o lista de liste de valori Int si întoarce lista sumelor elementelor din fiecare lista.
sumList :: [[Int]] -> [Int]
sumList lista = [sum x | x <- lista]
-- sumList = map sum        --> just create a new function to apply to arguments later

------ EX 8 ------
-- Scrieti o functie prel2 care are ca parametru o lista de întregi (Int) si întoarce o lista în care elementele pare sunt înjumatatite,
-- iar cele impare sunt dublate.
prel2 :: [Int] -> [Int]
prel2 [] = []
prel2 (h:t)
    | h `mod` 2 == 0 = div h 2 : prel2 t
    | otherwise = h*2 : prel2 t


------ EX 9 ------
-- Scrieti o functie care primeste ca parametri un caracter si o lista de siruri de caractere, si întoarce lista sirurilor care contin caracterul primit ca argument.
caracter :: Char -> [String] -> [String]
caracter _ [] = []
caracter chr (h:t)
    | chr `elem` h = h : caracter chr t
    | otherwise = caracter chr t


------ EX 10 ------
-- Scrieti o functie care are ca parametru o lista de întregi si întoarce lista patratelor numerelor impare din acea lista.
listaimp  :: [Int] -> [Int]
listaimp l = map (^2) (filter odd l)

patrate  :: [Int] -> [Int]
patrate p = map (^2) $ map snd $ filter (odd . fst) $ zip [1..] p
-- patrate p = map ((^2) . snd) (filter (odd . fst) $ zip [1..] p)  --> for using map once
-- patrate p = map (^2) (map snd (filter (odd . fst) (zip [1..] p)))

------ EX 11 ------
-- Scrieti o functie care primeste ca argument o lista de întregi si întoarce lista patratelor elementelor din pozitii impare.
listaPozImp :: [Int] -> [Int]
listaPozImp l = map (^2) [x |(i, x) <- zip [0..] l, odd i]
-- listaPozImp l = map(^2) [x ^ 2 |(i,x)<- zip[0..] l, odd i]


------ EX 12 ------
-- Scrieti o functie care primeste ca parametru o lista de siruri de caractere si întoarce lista obtinuta prin eliminarea consoanelor din fiecare sir.
numaiVocale :: [String] -> [String]
numaiVocale list = map (filter (\c -> elem c "aeiouAEIOU")) $ list

------ EX 13 ------
-- Definiti recursiv functiile mymap si myfilter cu aceeasi functionalitate ca a functiilor map si filter predefinite.
mymap :: (a -> b) -> [a] -> [b]
mymap _ [] = []
mymap f (x:xs) = f x : mymap f xs

myfilter :: (a -> Bool)  -> [a] -> [a]
myfilter _ [] = []
myfilter p (x:xs)
    | p x = x : myfilter p xs
    | otherwise = myfilter p xs