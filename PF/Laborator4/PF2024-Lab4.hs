{-
[x^2 |x <- [1..10], x `rem` 3 == 2]
[(x,y) | x <- [1..5], y <- [x..(x+2)]]
[(x,y) | x <- [1..3], let k = x^2, y <- [1..k]]
[x | x <- "Facultatea de Matematica si Informatica", elem x ['A'..'Z']]
[[x..y] | x <- [1..5], y <- [1..5], x < y]
-}

-- rem este restul impartirii
-- rem va avea semnul deimpartitului, iar mod va avea semnul impartitorului
-- div aproximeaza spre -inf iar quot aproximeaza spre 0

factori :: Int -> [Int]
factori n = [x | x <- [1..n], n `mod` x == 0]

prim :: Int -> Bool
prim n = length[x | x <- factori n] == 2

numerePrime :: Int -> [Int]
numerePrime n = [x | x <- [2..n], prim x]

myzip3 :: [Int] -> [Int] -> [Int] -> [(Int, Int, Int)]
myzip3 a b c = [(a !! i, b !! i, c !! i) | i <- [0..(min (min (length a) (length b)) (length c) - 1)]]


-- 6
firstEl :: [(a, b)] -> [a]
firstEl l = [fst x | x <- l]

-- 7 
sumList :: [[Int]] -> [Int]
sumList l = [sum x | x <- l]

-- 8
prel2 :: [Int] -> [Int]
prel2 l = [if x `mod` 2 == 0 then x `div` 2 else x * 2 | x <- l]

--de aici ar trebui cu map si filter

-- 9 (functia elem)
f9 :: Char -> [[Char]] -> [[Char]]
f9 x l = [y | y <- l, elem x y]

-- 10
f10 :: [Int] -> [Int]
f10 l = [x ^ 2 | x <- l, x `mod` 2 == 1]

-- 11
f11 :: [Int] -> [Int]
f11 l = [(l !! i) ^ 2 | i <- [0..(length l)], (l !! i) `mod` 2 == 1]

ordonataNat :: [Int] -> Bool
ordonataNat [] = True
ordonataNat [x] = True
ordonataNat (x:xs) = undefined

ordonata :: [a] -> (a -> a -> Bool) -> Bool
ordonata = undefined
