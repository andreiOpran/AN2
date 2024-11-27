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


data Point a b = Pt a b

data StrInt = VS String | VI Int

data Shape = Circle Float | Rectangle Float Float

data Pair a b = Pair a b

data Tree a = Empty | Leaf a | Branch (Tree a) (Tree a)


data Doggies a = Husky a | Mastiff a

-- data List a = Nil | Cons a (List a)
-- data [a] = [] | a : [a]

power :: Maybe Int -> Int -> Int
power Nothing n = 2 ^ n
power ( Just m ) n = m ^ n

-- power Nothing 3
-- power (Just 2) 3

divide :: Int -> Int -> Maybe Int
divide n 0 = Nothing
divide n m = Just (n `div` m)

right :: Int -> Int -> Int
right n m = case divide n m of
    Nothing -> 3
    Just r -> r + 3


type FirstName = String
type LastName = String
type Age = Int
type Height = Float
type Phone = String

-- data Person = Person FirstName LastName Age Height Phone

-- firstName :: Person -> String
-- firstName (Person firstName _ _ _ _) = firstName

data Person = Person
  { firstName   :: String
  , lastName    :: String
  , age         :: Int
  , height      :: Float
  , phoneNumber :: String
  }


-- instance Functor Maybe where
--     fmap f Nothing = Nothing
--     fmap f (Just x) = Just (f x)

data Arbore a = Nil
              | Nod a (Arbore a) (Arbore a)

instance Functor Arbore where
  fmap f Nil = Nil
  fmap f (Nod x l r) = Nod (f x) (fmap f l) (fmap f r)