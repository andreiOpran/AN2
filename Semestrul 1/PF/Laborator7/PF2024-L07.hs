import Language.Haskell.TH.Syntax (nothingName)
data Expr = Const Int -- integer constant -- const este numele constructorului
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
evalExp(Const nr) = nr
evalExp(e1 :+: e2) = evalExp e1 + evalExp e2
evalExp(e1 :*: e2) = evalExp e1 * evalExp e2

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
expToArb (e1 :+: e2) = Node Add (expToArb e1) (expToArb e2)
expToArb (e1 :*: e2) = Node Mult (expToArb e1) (expToArb e2)


data IntSearchTree value
  = Empty
  | BNode
      (IntSearchTree value)     -- elemente cu cheia mai mica
      Int                       -- cheia elementului
      (Maybe value)             -- valoarea elementului
      (IntSearchTree value)     -- elemente cu cheia mai mare
  
lookup' :: Int -> IntSearchTree value -> Maybe value
lookup' k Empty = Nothing
lookup' k (BNode treeLeft key value treeRight)
  | k == key = value
  | k < key = lookup' k treeLeft
  | otherwise = lookup' k treeRight

keys ::  IntSearchTree value -> [Int]
keys (BNode treeLeft key value treeRight) = (keys treeLeft) ++ ([key]) ++ (keys treeRight)

values :: IntSearchTree value -> [value]
values (BNode treeLeft key (Just value) treeRight) = (values treeLeft) ++ ([value]) ++ (values treeRight)

-- insert :: Int -> value -> IntSearchTree value -> IntSearchTree value
-- insert x value Empty = BNode Empty x (Just value) Empty
-- insert x value (BNode treeLeft key val treeRight)
--   | x == key = BNode treeLeft key (Just value) treeRight
--   | x < key = BNode (insert x value treeLeft) key val treeRight
--   | otherwise = BNode treeLeft key val (insert x value treeRight)

delete :: Int -> IntSearchTree value -> IntSearchTree value
delete x Empty = Empty
delete x (BNode left y val right)
  | x == y = BNode left x Nothing right
  | x < y = BNode (delete x left) y val right
  | x > y = BNode left y val (delete x right)

toList :: IntSearchTree value -> [(Int, value)]
toList Empty = []
toList (BNode left x (Just val) right) = (toList left) ++ [(x, val)] ++ (toList right)

fromList :: [(Int,value)] -> IntSearchTree value 
fromList = undefined

printTree :: IntSearchTree value -> String
printTree = undefined

-- balance :: IntSearchTree value -> IntSearchTree value
-- balance = undefined
