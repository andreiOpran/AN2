{-
[x^2 |x <- [1..10], x `rem` 3 == 2]
[(x,y) | x <- [1..5], y <- [x..(x+2)]]
[(x,y) | x <- [1..3], let k = x^2, y <- [1..k]]
[x | x <- "Facultatea de Matematica si Informatica", elem x ['A'..'Z']]
[[x..y] | x <- [1..5], y <- [1..5], x < y]
-}

factori :: Int -> [Int]
factori n = [i | i <- [1..n], n `mod` i == 0]

prim :: Int -> Bool
prim p
    | length (factori p) == 2 = True
    | otherwise = False

numerePrime :: Int -> [Int]
numerePrime n = [i | i <- [2..n], prim i == True]

min3 :: Int -> Int -> Int -> Int
min3 a b c = min (min a b) c

myzip3 :: [Int] -> [Int] -> [Int] -> [(Int, Int, Int)]
myzip3 _ _ [] = []
myzip3 _ [] _ = []
myzip3 [] _ _ = []
myzip3 a b c = [(a !! i, b !! i, c !! i) | i <- [0..min3 (length a - 1) (length b - 1) (length c - 1)]]

-- sectiuni -> o aplocare partiala a unui operator, se obtine dintr-un operator prin fixare unui argument
-- p (*3) = functie cu un singur parametru, = cu parametrul inmultit cu 3
-- (10-) = functie cu un singur parametru, = cu diferenta dintre 10 si parametru

-- lambda expresii
-- f a -> a
-- valoare x de tip a

-- functia aplica2 primeste ca parametru o functie f si o valoare x de tip a, rezultatul fiind f (f x)
-- => aplica2 :: (a -> a) -> a -> a

-- aplica2 are mai multe definitii:
-- aplica2 f x = f (f x)
-- aplica2 f = f . f
-- aplica2 = \f x -> f (f x)
-- aplica2 f = \x -> f (f x)

-- Functia map are ca parametri o functie de tip a -> b si o lista de elemente de tip a, rezultatul fiind
-- lista elementelor de tip b obtinute prin aplicarea functiei date pe fiecare element de tip a:
-- map :: (a -> b) -> [a] -> [b]
-- map f xs = [f x | x <- xs]

-- map (*3) [1,3,4] = [3,9,12]
-- map ($ 3) [ (4 +) , (10 *) , (^ 2) , sqrt ] = [7.0,30.0,9.0,1.7320508075688772]

-- filter p xs = [x | x <- xs, p x]
-- filter (>2) [3,1,4,2,5] = [3,4,5]


firstEl :: [(a, b)] -> [a]
firstEl l = map fst l

sumList :: [[Int]] -> [Int]
sumList l = map sum l

prel2 :: [Int] -> [Int]
prel2 l = map (\x -> if even x then x `div` 2 else x * 2) l

strchr :: Char -> [String] -> [String]
strchr c l = filter (elem c) l

listaImparePatrate :: [Int] -> [Int]
listaImparePatrate l = map (^2) (filter odd l)

listaPozitiiImparePatrate :: [Int] -> [Int]
listaPozitiiImparePatrate l = map (\(i, x) -> x^2) (filter (\(i, _) -> odd i) (zip [0..] l))


esteVocala :: Char -> Bool
esteVocala c = c `elem` "aeiouAEIOU"

numaiVocale :: [String] -> [String]
numaiVocale l = map (filter esteVocala) l


mymap :: (a -> b) -> [a] -> [b]
mymap _ [] = []
mymap f (x:xs) = f x : mymap f xs

myfilter :: (a -> Bool) -> [a] -> [a]
myfilter _ [] = []
myfilter f (x:xs)
    | f x = x : myfilter f xs
    | otherwise = myfilter f xs



