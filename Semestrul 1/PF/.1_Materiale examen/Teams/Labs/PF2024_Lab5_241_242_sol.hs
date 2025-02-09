------ LAB 5 ------

------ FOLD ------
{-

------ FOLDR ------
FOLDR processes a list from RIGHT to LEFT, applying a BINARY function between each element and an accumulator.
The accumulator starts with an initial value and builds up as the fold progresses, containing the intermediary results.

------ FOLDL ------
The same, but from LEFT to RIGHT

Examples:

foldr (+) 0 [1, 2, 3, 4]        -- 1 + (2 + (3 + (4 + 0)))
foldl (+) 0 [1, 2, 3, 4]        -- (((0 + 1) + 2) + 3) + 4

To visualize the ACCUMULATOR better, lets look at foldr (+) 0 [1, 2, 3, 4]

At first, the acc has the given base value 0.
FOLDR applies (4 + 0) and the stored value, 4, is stored in the acc.
Next, (3 + (4 + 0) would mean 3 + result of (4 + 0), which is in the acc, so 3 + acc.

acc = 4 -> 3 + 4 = 7
acc is now 7
next 2 + 7 and so on

This continues till all the elements in the list are consumed.

TO REMEMBER: For FOLDR, the ACC is ALWAYS on the RIGHT of the operation (second argument)
    For FOLDL, the ACC is ALWAYS on the LEFT (first argument)

DIFFERENCE BETWEEN FOLD and MAP:
MAP parses a list and gives a list containing all results after applying a function on EACH list element.
FOLD (FOLDR / FOLDL) parses the list and gives a SINGLE result for all elements.

In this context, FOLD can also return a list, not only a simple variable, but the resulted list itself is treated as a SINGULAR
result to all the elements of the given input list.
-}

------ EX 1 ------
-- Calculați suma pătratelor elementelor impare dintr-o listă dată ca parametru.
verif :: [Int] -> [Int]
verif n = filter odd  n


------ EX 2 ------
-- Scrieți o funcție care verifică că toate elementele dintr-o listă sunt True, folosind foldr.
verif2 :: [Bool] -> Bool
verif2 = foldr (&&) True


------ EX 3 ------
-- Scrieți o funcție care verifică dacă toate elementele dintr-o listă de numere întregi satisfac o proprietate dată ca parametru.
allVerifies :: (Int -> Bool) -> [Int] -> Bool
allVerifies condition l = foldl (&&) True $ map condition l


------ EX 4 ------
-- Scrieți o funcție care verifică dacă există elemente într-o listă de numere întregi care satisfac o proprietate dată ca parametru.
anyVerifies :: (Int -> Bool) -> [Int] -> Bool
anyVerifies condition l = foldr (||) False $ map condition l


------ EX 5 ------
-- Redefiniți funcțiile map și filter folosind foldr. Le puteți numi mapFoldr și filterFoldr.
mapFoldr f l = foldr (\x acc -> (f x) : acc) [] l
filterFoldr f l = foldr (\x acc -> if (f x) then x : acc else acc) [] l


------ EX 6 ------
-- Folosind funcția foldl, definiți funcția listToInt care transformă o listă de cifre (un număr foarte mare reprezentat ca listă) în numărul întreg asociat. Se presupune că lista de intrare este dată corect.
listToInt :: [Integer]-> Integer
listToInt l = foldl (\acc x -> acc * 10 + x) 0 l


------ EX 7 ------
-- a) Scrieți o funcție care elimină toate aparițiile unui caracter dat dintr-un șir de caractere.
rmChar :: Char -> String -> String
rmChar c l = foldr (\x acc -> if(x == c) then acc else x : acc) [] l
-- b) Scrieți o funcție recursivă care elimină toate caracterele din al doilea argument care se găsesc în primul argument, folosind rmChar.
rmCharsRec :: String -> String -> String
rmCharsRec a  [] = []
rmCharsRec [] b = b
rmCharsRec (x:xs) b = rmCharsRec xs (rmChar x b)

--SAU--

rmCharsRec' :: String -> String -> String
rmCharsRec' s1 "" = ""
rmCharsRec' s1 (c:s)
    | c `elem` s1 = rmCharsRec' s1 s
    | otherwise = c:rmCharsRec' s1 s

-- c) Scrieți o funcție echivalentă cu cea de la (b) care folosește însă rmChar și foldr.
rmCharsFold :: String -> String -> String
rmCharsFold a b = foldr (rmChar) b a


------ EX 8 ------
-- Scrieți o funcție myReverse care primește ca parametru o listă de întregi și întoarce lista elementelor în ordine inversă.
myReverse :: [Int] -> [Int]
myReverse list = foldr (\x acc -> acc ++ [x]) [] list

--SAU--

myReverse' :: [Int] -> [Int]
myReverse' = foldr f e
    where
        f x acc = acc ++ [x]
        e = []


------ EX 9 ------
-- Scrieți un predicat myElem care verifică apartenența unui întreg la o listă de întregi.
myElem :: Int -> [Int] -> Bool
myElem y = foldr f e
    where
        f x r = (x == y) || r
        e = False


------ EX 10 ------
-- Scrieți o funcție myUnzip care transformă o listă de perechi într-o pereche de liste: una a componentelor de pe prima poziție, iar cealaltă a componentelor de pe a doua poziție din perechile din lista inițială.
myUnzip :: [(a, b)] -> ([a], [b])
myUnzip = foldr f e
    where
        f (x,y) (xs,ys) = ((x : xs), (y : ys))
        e = ([], [])


------ EX 11 ------
-- Scrieți o funcție union care întoarce lista reuniunii a două liste de întregi primite ca parametri.
union :: [Int] -> [Int] -> [Int]
union xs ys = foldr f e ys
    where
        f y r
            | y `elem` xs = r
            | otherwise = r ++ [y]
        e = xs


------ EX 12 ------
-- Scrieți o funcție intersect care întoarce lista intersecției a două liste de întregi primite ca parametri.
intersect :: [Int] -> [Int] -> [Int]
intersect xs ys = foldr f e ys
    where
        f y r
            | y `elem` xs = y:r
            | otherwise   = r
        e = []


------ EX 13 ------
-- Scrieți o funcție permutations care întoarce lista tuturor permutărilor elementelor unei liste de întregi primite ca parametru.
{-
concatMap :: forall (t :: Type -> Type) a b.
Foldable t =>
(a -> [b]) -> t a -> [b]
Defined in ‘Data.Foldable’ (base-4.17.2.1)

Map a function over all the elements of a container and concatenate the resulting lists.

Basic usage:
concatMap (take 3) [[1..], [10..], [100..], [1000..]] --[1,2,3,10,11,12,100,101,102,1000,1001,1002]
-}

permutations :: [Int] -> [[Int]]
permutations = foldr f e
    where
        f x r = concatMap (insertEverywhere x) r        -- r is the acc in this case; with foldr get every element, insert into the acc and concatenate the results
        e     = [[]]

{-
This function inserts an element x on all positions of a list (y : ys).
For example:
insertEverywhere 1 [2,3]

(before the first recursive call)
x = 1
(y : ys) = [2, 3]
y = 2
ys = [3]

insertEverywhere 1 [2,3] = (1 : 2 : [3]) : map (2 :) (insertEverywhere 1 [3])
Evaluate the recursive call insertEverywhere x ys.

First recursion: insertEverywhere 1 [3]
x = 1
(y : ys) = [3]
y = 3
ys = []

insertEverywhere 1 [3] = (1 : 3 : []) : map (3 :) (insertEverywhere 1 [])

Second recursion: insertEverywhere 1 []
x = 1
(y : ys) = []
y = ys = []

The base case is reached, result is [[1]] for second recursion.

Going backwards now. To [[1]] we applied map (3 :).
y = 3

map (3 :) [[1]] => [[3,1]]

We still have the (x : y : ys) to add.
x = 1
y = 3
ys = []

(1 : 3 : []) : [[3,1]] => [[1,3],[3,1]]

This is the result for the first recursion. Map and (x : y : ys) to get the final result.
x = 1
y = 2
ys = [3]

map (2 :) [[1,3],[3,1]] => [[2,1,3],[2,3,1]]
(1 : 2 : [3]) : [[2,1,3],[2,3,1]] => [[1,2,3],[2,1,3],[2,3,1]]
-}
insertEverywhere :: Int -> [Int] -> [[Int]]
insertEverywhere x [] = [[x]]
insertEverywhere x (y : ys) = (x : y : ys) : map (y :) (insertEverywhere x ys)

--concatMap g = foldr f e
--  where
--    f x r = g x ++ r
--    e     = []
