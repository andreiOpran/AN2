------ LAB 8 ------

class Collection c where
    empty :: c key value
    singleton :: key -> value -> c key value
    insert ::
        (Ord key) =>
        key ->
        value ->
        c key value ->
        c key value
    clookup :: (Ord key) => key -> c key value -> Maybe value
    delete :: (Ord key) => key -> c key value -> c key value
    keys :: c key value -> [key]
    values :: c key value -> [value]
    toList :: c key value -> [(key, value)]
    fromList :: (Ord key) => [(key, value)] -> c key value

------ EX 1 ------
-- Adăugați definiții implicite (folosind celelalte funcții din clasă) pentru keys, values și fromList.
-- TO REMEMBER : Implicit definitions must be written in the SAME indentation block of the class, where are the signatures are defined
    keys l = [x | (x, y) <- toList l]
    values l = [y | (x, y) <- toList l]
    fromList [(k, v)] = insert k v empty
    fromList ((k, v) : t) = insert k v (fromList t)



newtype PairList k v
    = PairList {getPairList :: [(k, v)]}

------ EX 2 ------
-- Faceți PairList instanță a clasei Collection.
instance Collection PairList where
    empty = PairList []
    singleton k v = PairList [(k, v)]

    -- insert k v empty = PairList [(k,v)]
    insert k v (PairList l) = PairList (l ++ [(k, v)])
    -- SAU --
    -- insert k v (PairList l) = PairList $ (k,v):filter ((/= k). fst) l

    clookup k (PairList [(x1, x2)]) =
        if k == x1
            then Just x2
            else Nothing
    clookup k (PairList ((x1, x2) : t)) =
        if k == x1
            then Just x2
            else clookup k (PairList t)
    -- SAU --
    -- clookup k = lookup k . getPairList

    delete k (PairList [(x1, x2)]) =
        if k == x1
            then PairList []
            else PairList [(x1, x2)]
    delete k (PairList ((x1, x2) : t)) =
        if k == x1
            then delete k (PairList t)
            else fromList ([(x1, x2)] ++ toList (delete k (PairList t)))
    -- SAU --
    -- delete k (PairList l) = PairList $ filter ((/= k). fst) l

    toList (PairList l) = l
    -- SAU --
    -- toList = getPairList



data SearchTree key value
    = Empty
    | BNode
            (SearchTree key value) -- elemente cu cheia mai mica
            key -- cheia elementului
            (Maybe value) -- valoarea elementului
            (SearchTree key value) -- elemente cu cheia mai mare

------ EX 3 ------
-- Faceți SearchTree instanță a clasei Collection.
instance Collection SearchTree where
    empty :: SearchTree k v
    empty = Empty
    singleton :: key -> value -> SearchTree key value
    singleton k v = BNode Empty k (Just v) Empty
    insert :: (Ord key) => key -> value -> SearchTree key value -> SearchTree key value
    insert k v Empty = (BNode Empty k (Just v) Empty)
    insert k v (BNode left key value right)
        | key == k = (BNode left key (Just v) right)
        | key < k = (BNode (insert k v left) key value right)
        | key > k = (BNode left key value (insert k v right))
    clookup :: (Ord key) => key -> SearchTree key value -> Maybe value
    clookup _ Empty = Nothing
    clookup key (BNode left k v right)
        | key == k = v
        | key < k = clookup key left
        | key > k = clookup key right
    delete :: (Ord key) => key -> SearchTree key value -> SearchTree key value
    delete _ Empty = Empty
    delete k (BNode left cheie val right)
        | k == cheie = BNode left cheie Nothing right
        | k < cheie = BNode (delete k left) cheie val right
        | k > cheie = BNode left cheie val (delete k right)
    toList :: SearchTree key value -> [(key, value)]
    toList (BNode left key Nothing right) = toList (left) ++ toList (right)
    toList (BNode left key (Just val) right) = toList (left) ++ [(key, val)] ++ toList (right)



data Punct = Pt [Int]

data Arb = Vid | F Int | N Arb Arb
    deriving (Show)

class ToFromArb a where
    toArb :: a -> Arb
    fromArb :: Arb -> a

------ EX 4 ------
-- Scrieți o instanță a clasei Show pentru tipul de date Punct, astfel încât lista coordonatelor să fie afișată ca tuplu.
instance Show Punct where
    show (Pt []) = "()"
    show (Pt [x]) = "(" ++ show x ++ ")"
    show (Pt (x : xs)) = "(" ++ show x ++ concatMap ((", " ++) . show) xs ++ ")"

-- SAU --
-- instance Show Punct where
--     show (Pt []) = "()"
--     show (Pt (x:xs)) = "(" ++ show x ++ show2 xs ++ ")"
--         where
--             show2 [] = ""
--             show2 (x:xs) = ", " ++ show x ++ show2 xs



------ EX 5 ------
-- Scrieți o instanță a clasei ToFromArb pentru tipul de date Punct astfel încât lista coordonatelor punctului să coincidă cu frontiera arborelui.
instance ToFromArb Punct where
    toArb :: Punct -> Arb
    toArb (Pt []) = Vid
    toArb (Pt [x]) = F x
    toArb (Pt (x : xs)) = N (F x) (toArb (Pt xs))

    fromArb (Vid) = Pt []
    fromArb (F x) = Pt [x]
    fromArb (N l r) = Pt (p1 ++ p2)
        where
            Pt p1 = fromArb l
            Pt p2 = fromArb r



data Geo a = Square a | Rectangle a a | Circle a
    deriving (Show)

class GeoOps g where
    perimeter :: (Floating a) => g a -> a
    area :: (Floating a) => g a -> a

------ EX 6 ------
-- Instanțiați clasa GeoOps pentru tipul de date Geo.
instance GeoOps Geo where
    perimeter (Square l) = 4 * l
    perimeter (Rectangle l1 l2) = 2 * l1 + 2 * l2
    perimeter (Circle r) = 2 * pi * r

    area (Square l) = l ^ 2
    area (Rectangle l1 l2) = l1 * l2
    area (Circle r) = pi * r ^ 2



------ EX 7 ------
-- Instanțiați clasa Eq pentru tipul de date Geo, astfel încât două figuri geometrice să fie egale dacă au perimetrul egal.
instance (Floating a, Eq a) => Eq (Geo a) where
    fig1 == fig2 = perimeter fig1 == perimeter fig2
