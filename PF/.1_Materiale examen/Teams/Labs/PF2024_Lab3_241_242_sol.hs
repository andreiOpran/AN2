import Data.Char
------ LAB 3 ------

{-
Useful functions for handling lists:

head l - return the first element of a list l
tail l - returns the remaining LIST after removing the first element from the list l
take n l - returns the first n elements of l
drop n l - returns the remaining list after removing the first n elements
length l - returns the length of the list l
-}

------ EX 1 ------
--Implementați următoarele funcții folosind liste:
-- - a) verifL - verifică dacă lungimea unei liste date ca parametru este pară.
verifL :: [Int] -> Bool
verifL l = even(length l)
-- verifL l = mod (length l) 2 == 0

-- - b) takefinal - pentru o listă l dată ca parametru și un număr n, întoarce o listă care conține
-- ultimele n elemente ale listei l.
takefinal :: [Int] -> Int -> [Int]
takefinal l n =
    if n > length l then l
    else drop (length l - n) l

-- TO REMEMBER: In Haskell, we can concatenate LISTS with the ++ operator
-- - c) remove - pentru o listă și un număr n, întoarce lista primită ca parametru din care se șterge
-- elementul de pe poziția n.
remove ::  [Int] -> Int -> [Int]
remove l n = take n l ++ drop (n + 1) l

--SAU--

remove' :: [Int] -> Int -> [Int]
remove' l n = let
    a = take n l
    b = drop (n + 1) l
    in a ++ b


------ EX 2 ------
{-
We can construct list on the go by using the (:) form of a list. Haskell uses pattern-matching to determine the order and nature of elements,
where the last variable always acts the TAIL of a list and the rest are normal variables prepended to the tail

TO REMEMBER: we can also pass expressions and function call to this form so their result will be added to the list
Examples:
l = [1,2,3]
l1 = head l `div` 2 : tail l

l2 = 1 : 2 : [3,4,5,6]
-}
-- Scrieți următoarele funcții folosind conceptul de recursivitate:
-- a) myreplicate - pentru un întreg n și o valoare v, întoarce lista ce conține n elemente egale cu v.
myreplicate :: Int -> v -> [v]
myreplicate n v
    | n == 0 = []
    | otherwise = v : myreplicate (n-1) v

--SAU--

myreplicate' :: Int -> Int -> [Int]
myreplicate' 0 m = []
myreplicate' n m = [m] ++ myreplicate' (n-1) m

-- There also exists an already implemented function REPLICATE that does the same thing

-- b) sumImp - pentru o listă de numere întregi, calculează suma elementelor impare.
sumImp :: [Int] -> Int
sumImp [] = 0
sumImp (h:t)
    | odd h = h+t'
    | otherwise = t'
    where t' = sumImp t

--SAU--

sumImp' :: [Int]-> Int
sumImp' [] =0
sumImp' n = if even(head n) then 0 + sumImp (tail n)
            else head n + sumImp' (tail n)

{-TO REMEMBER: The LIST !! N operator gives as the list item on position N -}
-- c) totalLen - pentru o listă de șiruri de caractere, calculează suma lungimilor șirurilor care încep cu caracterul 'A'.
totalLen :: [String] -> Int
totalLen [] = 0
totalLen (h:t)
    | h !! 0 == 'A' = (length h) + t'
    | otherwise = t'
    where t' = totalLen t

--SAU--

totalLen' :: [String] -> Int
totalLen' []= 0
totalLen' n =
    if head (head n) == 'A'
        then length (head n) + totalLen' (tail n)
    else totalLen' (tail n)


------ EX 3 ------
-- Scrieți o funcție nrVocale care primește ca parametru o listă de șiruri de caractere și calculează numărul total de vocale 
-- din șirurile palindrom.
vocala :: Char -> Bool
vocala c = elem c "aeiouAEIOU"

nrDeVocale :: String -> Int
nrDeVocale [] = 0
nrDeVocale s = if vocala (head s) then 1 + nrDeVocale (tail s)
                else nrDeVocale (tail s)

-- The REVERSE function takes a list and returns the reversed list
palindrom :: String -> Bool
palindrom s = s == reverse s

nrVocale :: [String] -> Int
nrVocale [] = 0
nrVocale l =
    if palindrom (head l)
        then nrDeVocale (head l) + nrVocale(tail l)
    else nrVocale(tail l)


------ EX 4 ------
-- Scrieți o funcție care primește ca parametri un număr și o listă de întregi și adaugă numărul dat după fiecare element par din listă.
f :: Int -> [Int] -> [Int]
f n [] = []
f n (h:t)
    | even h = h:n: f n t
    | otherwise = h:f n t

--SAU--

f' :: Int -> [Int] -> [Int]
f' _ [] = []
f' n l = if head l `mod` 2 == 0 then
        [head l] ++ [n] ++ f' n (tail l)
        else [head l] ++ f' n (tail l)


{-
The basic formula for LIST COMPREHENSION is [expresie | selectori, legari, filtrari], where:
Expresie: any expresion whose result will end up forming the list
Selector: written with <-, a variable that parses a list
Legatura: written with let, a designated local variable
Filtru: Bool type expression, used for filtering the SELECTOR output

You can mix and match as you please, none of them (except the result expressions) are mandatory.
Examples:
[x * 2 | x <- [1,3..7]]
-- Output: [2,4,6,8,10]

[x | x <- [1..10], x `mod` 2 == 0]
-- Output: [2,4,6,8,10]

[(x, y) | x <- [1..5], y <- [1..5], x + y == 6]
-- Output: [(1,5),(2,4),(3,3),(4,2),(5,1)]

[y | let x = 2, y <- [1, 2, 3]]
-- Output: [1,2,3]

[() | _ <- [1..5]]
-- Output: [(),(),(),(),()]
-}

------ EX 5 ------
-- Scrieți o funcție care determină lista divizorilor unui număr întreg primit ca parametru.
divizori :: Int -> [Int]
divizori n = [x | x <- [1..n], mod n x == 0]


------ EX 6 ------
-- Scrieți o funcție care primește ca parametru o listă de numere întregi și întoarce lista listelor de divizori.
listaDiv :: [Int] -> [[Int]]
listaDiv n = [divizori i | i <- n]

--SAU--

listadiv' :: [Int] -> [[Int]]
listadiv' [] = []
listadiv' (h:t) = divizori h : listadiv' t

------ EX 7 ------
-- Scrieți o funcție care primește ca parametri două numere întregi ce reprezintă limita inferioară și cea superioară
-- a unui interval închis și o listă de numere întregi și întoarce numerele din listă ce aparțin intervalului.

-- a)
inIntervalRec :: Int -> Int -> [Int] -> [Int]
inIntervalRec a b [] =[]
inIntervalRec a b (h:t)
    | h >= a && h <= b = h : inIntervalRec a b t
    | otherwise = inIntervalRec a b t

--SAU--

inIntervalRec' :: Int -> Int -> [Int] -> [Int]
inIntervalRec' x y [] = []
inIntervalRec' x y l =
    if head l > x && head l < y
        then head l : inIntervalRec' x y (tail l)
    else inIntervalRec' x y (tail l)

-- b)
inIntervalComp :: Int -> Int -> [Int] -> [Int]
inIntervalComp x y [] = []
inIntervalComp x y l = [a | a <- l, a >= x && a <= y]

-- TO BE CONTINUED --

------ EX 8 ------
-- Scrieți o funcție care numără câte numere strict pozitive sunt într-o listă dată ca argument.
pozitive :: [Int] ->Int
pozitive [] =0
pozitive l =
    if head l > 0
        then 1 + pozitive (tail l)
    else pozitive (tail l)

pozitivecomp :: [Int] -> Int
pozitivecomp [] = 0
pozitivecomp l = length [a | a <- l, a > 0]


------ EX 9 ------
-- Scrieți o funcție care întoarce lista pozițiilor elementelor impare dintr-o listă de numere primită ca parametru.
pozitiiImpareRecAux :: Int -> [Int] -> [Int]
pozitiiImpareRecAux _ [] = []
pozitiiImpareRecAux i (x : xs)
    | odd x = i : pozitiiImpareRecAux (i + 1) xs
    | otherwise = pozitiiImpareRecAux (i + 1) xs

pozitiiImpareRec :: [Int] -> [Int]
pozitiiImpareRec l = pozitiiImpareRecAux 0 l

pozitiiImpareComp :: [Int] -> [Int]
pozitiiImpareComp l = [i | (x, i) <- zip l [0..], odd x]
-- pozitiiImpareComp l = [x| x <- [0.. length l - 1], odd(l !! x)]
-- pozitiiImpareComp l = [snd x| x <- zip l [0..], odd(fst x)]


------ EX 10 ------
-- Scrieți o funcție care calculează produsul tuturor cifrelor care apar într-un șir de caractere primit ca parametru.
multDigitsRec :: [Char] -> Int
multDigitsRec (c : s)
    | isDigit c = digitToInt c * multDigitsRec s
    | otherwise = multDigitsRec s

multDigitComp :: [Char] -> Int
multDigitComp s = product [digitToInt c | c <- s, isDigit c]