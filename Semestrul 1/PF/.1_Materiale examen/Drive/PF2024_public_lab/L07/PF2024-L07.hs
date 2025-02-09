import System.Win32 (xBUTTON1)
data Expr = Const Int -- integer constant
          | Expr :+: Expr -- addition
          | Expr :*: Expr -- multiplication
           deriving Eq

data Operation = Add | Mult deriving (Eq, Show)

data Tree = Lf Int -- leaf
          | Node Operation Tree Tree -- branch
           deriving (Eq, Show)
           
instance Show Expr where
  show (Const x) = show x
  show (e1 :+: e2) = "(" ++ show e1 ++ " + "++ show e2 ++ ")"
  show (e1 :*: e2) = "(" ++ show e1 ++ " * "++ show e2 ++ ")"           

evalExp :: Expr -> Int
evalExp (Const n) = n
evalExp (a :+: b) = evalExp a + evalExp b
evalExp (a :*: b) = evalExp a * evalExp b

exp1 = ((Const 2 :*: Const 3) :+: (Const 0 :*: Const 5))
exp2 = (Const 2 :*: (Const 3 :+: Const 4))
exp3 = (Const 4 :+: (Const 3 :*: Const 3))
exp4 = (((Const 1 :*: Const 2) :*: (Const 3 :+: Const 1)) :*: Const 2)
test11 = evalExp exp1 == 6
test12 = evalExp exp2 == 14
test13 = evalExp exp3 == 13
test14 = evalExp exp4 == 16

evalArb :: Tree -> Int
evalArb (Lf x) = x
evalArb (Node Add left right) = evalArb left + evalArb right
evalArb (Node Mult left right) = evalArb left * evalArb right

arb1 = Node Add (Node Mult (Lf 2) (Lf 3)) (Node Mult (Lf 0)(Lf 5))
arb2 = Node Mult (Lf 2) (Node Add (Lf 3)(Lf 4))
arb3 = Node Add (Lf 4) (Node Mult (Lf 3)(Lf 3))
arb4 = Node Mult (Node Mult (Node Mult (Lf 1) (Lf 2)) (Node Add (Lf 3)(Lf 1))) (Lf 2)

test21 = evalArb arb1 == 6
test22 = evalArb arb2 == 14
test23 = evalArb arb3 == 13
test24 = evalArb arb4 == 16


expToArb :: Expr -> Tree
expToArb (Const x) = Lf x
exprToArb (a :+: b) = Node Add (expToArb a) (expToArb b)
exprToArb (a :*: b) = Node Mult (expToArb a) (expToArb b)



data IntSearchTree value
  = Empty
  | BNode
      (IntSearchTree value)     -- elemente cu cheia mai mica
      Int                       -- cheia elementului
      (Maybe value)             -- valoarea elementului
      (IntSearchTree value)     -- elemente cu cheia mai mare
  
lookup' :: Int -> IntSearchTree value -> Maybe value
lookup' _ Empty = Nothing
lookup' key (BNode left k v right)
  | key == k = v
  | key < k = lookup' key left
  | key > k = lookup' key right

keys ::  IntSearchTree value -> [Int]
keys Empty = []
keys (BNode left key value right) = keys left ++ [key] ++ keys right

values :: IntSearchTree value -> [value]
values Empty = []
values (BNode left key value right) = maybeToList value ++ values left ++ values right
  where
      maybeToList Nothing = [] -- avem maybe (value) deci tratam nothing si just
      maybeToList (Just v) = [v]

-- sau
values' :: IntSearchTree value -> [value]
values'  Empty= []
values' (BNode left k (Just v) right) = values' left ++ [v] ++ values' right
values' (BNode left k  Nothing right) = values' left ++ values' right

insert :: Int -> value -> IntSearchTree value -> IntSearchTree value
insert k v Empty = BNode Empty k (Just v) Empty
insert k v (BNode left key value right)
  | k == key = BNode left key (Just v) right
  | k < key = BNode (insert k v left) key value right
  | k > key = BNode left key value (insert k v right)

delete :: Int -> IntSearchTree value -> IntSearchTree value
delete _ Empty = Empty
delete k (BNode left key value right)
  | k == key = BNode left key Nothing right
  | k < key = BNode (delete k left) key value right
  | k > key = BNode left key value (delete k right)

toList :: IntSearchTree value -> [(Int, value)]
toList Empty = []
toList (BNode left x (Just val) right) = toList left ++ [(x, val)] ++ toList right
toList (BNode left x Nothing right) = toList left ++ toList right

fromList :: [(Int,value)] -> IntSearchTree value 
fromList [] = Empty
fromList ((k, v):xs) = insert k v (fromList xs)

printTree :: IntSearchTree value -> String
printTree Empty = ""
printTree (BNode left key value right) = "(" ++ printTree left ++ ")" ++ show key ++ "(" ++ printTree right ++ ")"

balance :: IntSearchTree value -> IntSearchTree value
balance tree = fromList $ toList tree
