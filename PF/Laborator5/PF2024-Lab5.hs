import Data.Array (listArray)
-- Exemplul 1
exemplu1 l = foldl (\acc x -> acc + x ^ 2) 0 l
exemplu1right l = foldr(\x acc -> acc + x ^ 2) 0 l


-- Exercitiul 1
ex1 l = foldr (+) 0 $ map (^ 2)  $ filter odd l

-- Exercitiul 2
ex2 l = foldr (&&) True l

-- Exercitiul 3
cond :: Int -> Bool
cond x = x `mod` 2 == 0
allVerifies :: (Int -> Bool) -> [Int] -> Bool
allVerifies cond xs = foldr (&&) True $ map cond xs

-- Exercitiul 4
anyVerifies :: (Int -> Bool) -> [Int] -> Bool
anyVerifies cond xs = foldr (||) False $ map cond xs

-- Exercitiul 5
mapFoldr f xs = foldr(\x acc -> (f x) : acc) [] xs
filterFoldr f xs = foldr(\x acc -> if f x then x : acc else acc) [] xs

-- Exercitiul 6
listToInt :: [Integer]-> Integer
listToInt xs = foldl (\acc x -> acc * 10 + x) 0 xs 

-- Exercitiul 7 a.
rmChar :: Char -> String -> String
rmChar = undefined

rmCharsRec :: String -> String -> String
rmCharsRec = undefined

rmCharsFold :: String -> String -> String
rmCharsFold = undefined
    
myUnzip :: [(a, b)] -> ([a], [b])
myUnzip = undefined
