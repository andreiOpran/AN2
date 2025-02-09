----------------------------------- P1 -----------------------------------
-- Se dau urmatoarele:
-- un tip de date ce reprezinta puncte cu numar variabil de coordonate intregi:
-- data Point = Pt [Int]
--   deriving Show
-- un tip de date ce reprezinta arbori binari de cautare (cu nodurile sortate):
-- data Arb = Empty | Node Int Arb Arb
--   deriving Show
-- si o clasa de tipuri ToFromArb:
-- class ToFromArb a where
--   toArb :: a -> Arb
--   fromArb :: Arb -> a
-- Scrieti o instanta a clasei ToFromArb pentru tipul Point. 
-- Inserarea in arbore se va face tinand cont de proprietatea arborelui de a fi sortat.
--------------------------------------------------------------------------

data Point = Pt [Int] deriving Show

data Arb = Empty | Node Int Arb Arb deriving Show

class ToFromArb a where
    toArb :: a -> Arb
    fromArb :: Arb -> a

-- helper to insert a value into BST
insert :: Int -> Arb -> Arb
insert x Empty = Node x Empty Empty
insert x (Node v left right)
    | x <= v = Node v (insert x left) right
    | otherwise = Node v left (insert x right)

-- helper for in-order traversal
inOrder :: Arb -> [Int]
inOrder Empty = []
inOrder (Node v left right) = inOrder left ++ [v] ++ inOrder right

instance ToFromArb Point where
    -- convert Point to BST by inserting each coordinate
    toArb :: Point -> Arb
    toArb (Pt xs) = foldr insert Empty xs
    
    -- convert BST back to Point by collecting coordinates in-order
    fromArb :: Arb -> Point
    fromArb arb = Pt (inOrder arb)

-- test
testPoint :: Point
testPoint = Pt [3,1,4,2]

testArb :: Arb
testArb = toArb testPoint

testFromArb :: Point
testFromArb = fromArb testArb

{-
ghci> testPoint
Pt [3,1,4,2]
ghci> testArb
-- BST structure
ghci> testFromArb
Pt [1,2,3,4]
-}

----------------------------------- P2 -----------------------------------
-- Scrieti o functie care primeste ca argumente doua numere intregi si o lista de numere intregi, 
-- si construieste, folosind lista initiala, lista numerelor aflate in intervalul definit de cele doua numere. 
-- Rezolvati problema in doua moduri (propuneti o solutie fara monade si o solutie cu monade).
-- getFromInterval 5 7 [1..10] == [5,6,7]
--------------------------------------------------------------------------

-- inInterval 5 10 [1,3,5,2,8,-1] == [5,8]

inIntervalRec :: Int -> Int -> [Int] -> [Int]
inIntervalRec _ _ [] = []
inIntervalRec a b (x:xs) = if x >= a && x <= b
                        then x : inIntervalRec a b xs
                        else inIntervalRec a b xs

inIntervalComp :: Int -> Int -> [Int] -> [Int]
inIntervalComp a b l = [i | i <- l, i >= a && i <= b]

inIntervalFilter :: Int -> Int -> [Int] -> [Int]
inIntervalFilter a b xs = filter (\x -> x >= min a b && x <= max a b) xs

inIntervalMonade :: Int -> Int -> [Int] -> [Int]
inIntervalMonade a b xs = do
    x <- xs
    if x >= min a b && x <= max a b then [x] else []

----------------------------------- P3 -----------------------------------
-- Se da tipul de date:
-- newtype ReaderWriter env a = RW {getRW :: env-> (a,String)}
-- Scrieti instanta completa a clasei Monad pentru tipul ReaderWriter, 
-- astfel incat sa pastreze proprietatea de monada, env fiind o memorie nemodificabila 
-- si concatenand toate stringurile (hint: nu este nevoie sa faceti instante si pentru clasele Applicative si Functor).
--------------------------------------------------------------------------

newtype ReaderWriter env a = RW {getRW :: env -> (a, String)}

instance Functor (ReaderWriter env) where
    fmap f (RW g) = RW $ \env -> let (a, s) = g env in (f a, s)

instance Applicative (ReaderWriter env) where
    pure x = RW (\env -> (x, ""))
    (RW f) <*> (RW g) = RW $ \env -> 
        let (a, s1) = f env
            (b, s2) = g env
        in (a b, s1 ++ s2)

instance Monad (ReaderWriter env) where
    return = pure
    
    (RW m) >>= f = RW $ \env -> 
        let (a, s1) = m env
            (RW m') = f a
            (b, s2) = m' env
        in (b, s1 ++ s2)

-- Test example:
test1 :: IO Int
test1 = do
    x <- return 5
    y <- return 3
    return (x + y)