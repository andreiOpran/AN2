{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}
class Collection c where
    empty :: c key value
    empty = undefined

    singleton :: key -> value -> c key value
    singleton _ _ = undefined

    insert :: Ord key => key -> value -> c key value -> c key value
    insert _ _ _ = undefined

    lookup :: Ord key => key -> c key value -> Maybe value
    lookup _ _ = undefined

    delete :: Ord key => key -> c key value -> c key value
    delete _ _ = undefined

    keys :: c key value -> [key]
    keys _ = undefined

    values :: c key value -> [value]
    values _ = undefined

    toList :: c key value -> [(key, value)]
    toList _ = undefined

    fromList :: Ord key => [(key,value)] -> c key value
    fromList _ = undefined


newtype PairList k v = PairList { getPairList :: [(k, v)] }

instance Collection PairList where
    empty = PairList []
    
    singleton k v = PairList [(k, v)]
    
    insert k v (PairList kvs) = PairList ((k, v) : filteredKvs)
        where filteredKvs = filter (\(key, _) -> key /= k) kvs

    lookup k (PairList kvs) = Prelude.lookup k kvs
    
    delete k (PairList kvs) = PairList filteredKvs
        where filteredKvs = filter (\(key, _) -> key /= k) kvs
    
    keys (PairList kvs) = map fst kvs

    values (PairList kvs) = map snd kvs 

    toList (PairList kvs) = kvs
    fromList = PairList


data SearchTree key value
    = Empty
    | BNode
        (SearchTree key value) -- elemente cu cheia mai mica
        key -- cheia elementului
        (Maybe value) -- valoarea elementului
        (SearchTree key value) -- elemente cu cheia mai mare


instance Collection SearchTree where   

    empty = Empty

    singleton k v = BNode Empty k (Just v) Empty

    insert k v Empty = BNode Empty k (Just v) Empty
    insert k v (BNode left key value right)
            | k < key = insert k v left
            | k > key = insert k v right
            |otherwise = BNode left k (Just v) right

    {-
    insert k v Empty = BNode Empty k (Just v) Empty
    insert k v (BNode left key value right)
        | k < key = BNode (insert k v left) key value right  -- Rebuild tree with new left
        | k > key = BNode left key value (insert k v right)  -- Rebuild tree with new right
        | otherwise = BNode left k (Just v) right  -- Update value at current node
    -}

    lookup k  Empty = Nothing
    lookup k  (BNode left key value right)
            | k < key = Main.lookup k  left
            | k > key = Main.lookup k  right
            |otherwise = value

    delete _ Empty = Empty
    delete x (BNode left key v right)
        | x == key = BNode left key Nothing right
        | x < key = BNode (delete x left) key v right
        | otherwise = BNode left key v (delete x right) 

    keys Empty = []
    keys (BNode left key v right) = keys left ++ [key] ++ keys right


    values :: SearchTree key value -> [value]
    values Empty = []
    values (BNode left _ (Just value) right) = values left ++ [value] ++ values right
    values (BNode left _ Nothing right) = values left ++ values right   

    toList Empty = []
    toList (BNode left k Nothing right) = toList left ++ toList right
    toList (BNode left k (Just v) right) = toList left ++ [(k,v)] ++ toList right

    fromList [] = Empty
    fromList ((key,value):xs) = insert key value (fromList xs)


--puncte puncte

data Punct = Pt [Int]

data Arb = Vid | F Int | N Arb Arb
    deriving Show
class ToFromArb a where
    toArb :: a -> Arb
    fromArb :: Arb -> a

instance Eq Arb where 
    Vid == Vid = True
    F x == F y = x == y
    N left1 right1 == N left2 right2 = left1 == left2 && right1 == right2
    _ == _ = False



instance Show Punct where
    show (Pt []) = "()"
    show (Pt [x]) = "(" ++ show x ++ ")"
    show (Pt (x:xs)) = "(" ++ show x ++ go xs
      where
        go [] = ")"
        go (y:ys) = ", " ++ show y ++ go ys

    

instance ToFromArb Punct where
    toArb (Pt []) = Vid
    toArb (Pt [x]) = N (F x) Vid 
    toArb (Pt (x:xs)) = N (F x) (toArb (Pt xs))

    fromArb Vid = Pt []
    fromArb arb = Pt (fromArbHelper arb)
        where  
            fromArbHelper Vid = []
            fromArbHelper (F x) = [x]
            fromArbHelper (N left right) = fromArbHelper left ++ fromArbHelper right


--figuri geometrice

data Geo a = Square a | Rectangle a a | Circle a
    deriving Show

class GeoOps g where
    perimeter :: (Floating a) => g a -> a
    area :: (Floating a) => g a -> a

instance GeoOps Geo where
    perimeter (Square a) = 4*a
    perimeter (Rectangle a b) = 2*a + 2*b
    perimeter (Circle a) = 2*pi*a

    area (Square a) = a*a
    area (Rectangle a b) = a * b
    area (Circle a) = pi*a*a

instance (Floating a, Eq a) => Eq (Geo a) where
     x == y = perimeter x == perimeter y
 
