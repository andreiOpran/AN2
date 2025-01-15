{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}
data Point = Pt [Int]
    deriving Show   
data Arb = Empty | Node Int Arb Arb
    deriving Show
class ToFromArb a where
    toArb :: a -> Arb
    fromArb :: Arb -> a

instance ToFromArb Point where
    toArb (Pt []) = Empty
    toArb (Pt (x:xs)) = insert x (toArb (Pt xs))
        where
            insert x Empty = Node x Empty Empty
            insert x (Node nod t1 t2) = if x < nod then Node nod (insert x t1) t2 else Node nod t1 (insert x t2)

    fromArb Empty = Pt []
    fromArb (Node x left right) = Pt (fromList left ++ [x] ++ fromList right)
      where
        fromList Empty = []
        fromList (Node y left right) = fromList left ++ [y] ++ fromList right
 
 --2

getFromInterval :: Int -> Int -> [Int] ->[Int]
getFromInterval _ _ [] = []
getFromInterval a b (x:xs) 
    |x >= a && x <= b = x : getFromInterval a b xs
    | otherwise = getFromInterval a b xs
{-
sau asa
getFromInterval a b xs = filter (\x -> x >= a && x <= b) xs

-}

getFromInterval2 :: Int -> Int -> [Int] ->[Int]
getFromInterval2 a b xs = do
    x <- xs
    if x>=a && x <=b then
        return x
    else []
{-
gpt zice ca si asta e monada
getFromInterval :: Int -> Int -> [Int] -> [Int]
getFromInterval a b xs = [x | x <- xs, x >= a, x <= b]
-}
--3

newtype ReaderWriter env a = RW {getRW :: env-> (a,String)}
instance Functor (ReaderWriter env) where
    fmap f ma = RW (\env -> let (a, log) = getRW ma env in (f a, log))

instance Applicative (ReaderWriter env) where
    pure = return
    mf <*> ma = do
        f <- mf
        a <- ma
        return (f a)

instance Monad (ReaderWriter env) where
    return a = RW (\_ -> (a,""))
    ma >>= k = RW f
        where f env = let (a, log1) = getRW ma env
                          (b, log2) = getRW (k a) env
                      in (b, log1 ++ log2)

{-
asta zice gpt 

{-# LANGUAGE InstanceSigs #-}

newtype ReaderWriter env a = RW { getRW :: env -> (a, String) }

instance Functor (ReaderWriter env) where
    fmap :: (a -> b) -> ReaderWriter env a -> ReaderWriter env b
    fmap f (RW rwa) = RW $ \env ->
        let (a, log) = rwa env
        in (f a, log)

instance Applicative (ReaderWriter env) where
    pure :: a -> ReaderWriter env a
    pure a = RW $ \env -> (a, "")
    
    (<*>) :: ReaderWriter env (a -> b) -> ReaderWriter env a -> ReaderWriter env b
    (RW rwf) <*> (RW rwa) = RW $ \env ->
        let (f, log1) = rwf env
            (a, log2) = rwa env
        in (f a, log1 ++ log2)

instance Monad (ReaderWriter env) where
    return :: a -> ReaderWriter env a
    return = pure
    
    (>>=) :: ReaderWriter env a -> (a -> ReaderWriter env b) -> ReaderWriter env b
    (RW rwa) >>= f = RW $ \env ->
        let (a, log1) = rwa env
            (b, log2) = getRW (f a) env
        in (b, log1 ++ log2)

-}