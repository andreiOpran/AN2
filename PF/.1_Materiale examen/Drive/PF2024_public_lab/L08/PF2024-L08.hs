class Collection c where
  empty :: c key value
  singleton :: key -> value -> c key value
  insert
      :: Ord key
      => key -> value -> c key value -> c key value
  clookup :: Ord key => key -> c key value -> Maybe value
  delete :: Ord key => key -> c key value -> c key value
  keys :: c key value -> [key]
  values :: c key value -> [value]
  toList :: c key value -> [(key, value)]
  fromList :: Ord key => [(key,value)] -> c key value

  keys l = [x | (x, y) <- toList l]
  values l = [y | (x, y) <- toList l]
  fromList [(k, v)] = insert k v empty
  fromList ((k, v) : kvs) = insert k v (fromList kvs)


newtype PairList k v
  = PairList { getPairList :: [(k, v)] }

-- faceti PairList o instanta a clasei Collection
instance Collection PairList where
  empty = PairList []

  singleton k v = PairList [(k, v)]

  insert k v (PairList l) = PairList (l ++ [(k, v)])
  -- sau
  -- insert k v (PairList l) = PairList $ (k, v) : filter ((/= k) . fst) l

  clookup k (PairList [(x1, x2)]) =
    if k == x1
      then Just x2
      else Nothing
  clookup k (PairList ((x1, x2) : t)) =
    if k == x1
      then Just x2
      else clookup k (PairList t)
  -- sau
  -- clookup k = lookup k . getPairList

  delete k (PairList [(x1, x2)]) =
    if k == x1
      then PairList []
      else PairList [(x1, x2)]
  delete k (PairList ((x1, x2) : t)) =
    if k == x1
      then delete k (PairList t)
      else fromList ([(x1, x2)] ++ toList (delete k (PairList t)))
  -- sau
  -- delete k (PairList l) = PairList $ filter ((/= k) . fst ) l

  toList (PairList l) = l
  -- sau
  -- toList = getPairList

data SearchTree key value
  = Empty
  | BNode
      (SearchTree key value) -- elemente cu cheia mai mica
      key                    -- cheia elementului
      (Maybe value)          -- valoarea elementului
      (SearchTree key value) -- elemente cu cheia mai mare

-- faceti SearchTree instanta a clasei Collection
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
  toList (BNode left key Nothing right) = toList left ++ toList right
  toList (BNode left key (Just val) right) = toList left ++ [(key, val)] ++ toList right


data Punct = Pt [Int]

data Arb = Vid | F Int | N Arb Arb
          deriving Show

class ToFromArb a where
      toArb :: a -> Arb
      fromArb :: Arb -> a


-- Pt [1,2,3]
-- (1, 2, 3)
-- Pt []
-- ()

instance Show Punct where
  show :: Punct -> String
  show (Pt []) = "()"
  show (Pt [x]) = "(" ++ show x ++ ")"
  show (Pt (x : xs)) = "(" ++ show x ++ concatMap ((", " ++). show) xs ++ ")"

-- sau
-- instance Show Punct where
--     show (Pt []) = "()"
--     show (Pt (x:xs)) = "(" ++ show x ++ show2 xs ++ ")"
--         where
--             show2 [] = ""
--             show2 (x:xs) = ", " ++ show x ++ show2 xs


-- toArb (Pt [1,2,3])
-- N (F 1) (N (F 2) (N (F 3) Vid))
-- fromArb $ N (F 1) (N (F 2) (N (F 3) Vid)) :: Punct
--  (1,2,3)
instance ToFromArb Punct where
  toArb :: Punct -> Arb
  toArb (Pt []) = Vid
  toArb (Pt [x]) = F x
  toArb (Pt (x : xs)) = N (F x) (toArb (Pt xs))

  fromArb Vid = Pt []
  fromArb (F x) = Pt [x]
  fromArb (N l r) = Pt (p1 ++ p2)
    where
      Pt p1 = fromArb l
      Pt p2 = fromArb r



data Geo a = Square a | Rectangle a a | Circle a
    deriving Show

class GeoOps g where
  perimeter :: (Floating a) => g a -> a
  area :: (Floating a) =>  g a -> a

instance GeoOps Geo where
  perimeter :: Floating a => Geo a -> a
  perimeter (Square l) = 4 * l
  perimeter (Rectangle lat lung) = 2 * lat + 2 * lung
  perimeter (Circle r) = 2 * pi * r
  
  area :: Floating a => Geo a -> a
  area (Square l) = l ^ 2
  area (Rectangle lat lung) = lat * lung
  area (Circle r) = pi * r ^ 2

instance (Floating a, Eq a) => Eq (Geo a) where
  (==) :: (Floating a, Eq a) => Geo a -> Geo a -> Bool
  fig1 == fig2 = perimeter fig1 == perimeter fig2

