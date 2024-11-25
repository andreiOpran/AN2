import Data.Char (digitToInt)

fact n = if n == 0
    then 1
    else n * fact (n-1)

-- x = 1
-- z = let x = 3 in x

-- x = let
--         z = 5
--         g u = z + u
--     in let
--         z = 7
--     in g 0 + z


x = [let y = 8 in y, 9]


fact1 :: Integer -> Integer
fact1 n
    | n == 0 = 1
    | otherwise = n * fact1 (n-1)


-- factProst :: Integer -> Integer
-- factProst n = n * factProst (n-1)
-- factProst 0 = 1

(<+) :: String -> [Int] -> Bool
(<+) (x : xs) l = (digitToInt x) `elem` l

sec = ("1" <+)


l1 = [2,4..]
l2 = ['a','b'..]
l3 = zip l1 l2
-- ex9 = head . tail l3
ex9 = head $ tail l3


-- h x = x + g
--     where g x = x + 1

h x = x + g x
  where g x = x + 1


f x = x + x
g x = x * x

product :: [Int] -> Int
product xs = foldr (*) 1 xs

