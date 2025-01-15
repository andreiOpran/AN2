data Expr = Const Int
        | Expr :+: Expr
        | Expr :*: Expr
        deriving Eq
data Operation = Add | Mult deriving (Eq,Show) 
data Tree = Lf Int
        | Node Operation Tree Tree
        deriving (Eq,Show)

    
instance Show Expr where
    show (Const x) = show x
    show (e1 :+: e2) = "(" ++ show e1 ++ " + " ++ show e2 ++ ")"
    show (e1 :*: e2) = "(" ++ show e1 ++ " * " ++ show e2 ++ ")"

--ex1
evalExp :: Expr -> Int
evalExp (Const x) = x
evalExp (e1 :+: e2) = evalExp e1 + evalExp e2
evalExp (e1 :*: e2) = evalExp e1 * evalExp e2
exp1 = (Const 2 :*: Const 3) :+: (Const 0 :*: Const 5)
exp2 = Const 2 :*: (Const 3 :+: Const 4)
exp3 = Const 4 :+: (Const 3 :*: Const 3)
exp4 = ((Const 1 :*: Const 2) :*: (Const 3 :+: Const 1)) :*: Const 2
test11 = evalExp exp1 == 6
test12 = evalExp exp2 == 14
test13 = evalExp exp3 == 13
test14 = evalExp exp4 == 15

--ex2

evalArb :: Tree -> Int
evalArb (Lf x) = x
evalArb (Node Add x1 x2) = evalArb x1 + evalArb x2
evalArb (Node Mult x1 x2) = evalArb x1 * evalArb x2


arb1 = Node Add (Node Mult (Lf 2) (Lf 3)) (Node Mult (Lf 0)(Lf 5))
arb2 = Node Mult (Lf 2) (Node Add (Lf 3)(Lf 4))
arb3 = Node Add (Lf 4) (Node Mult (Lf 3)(Lf 3))
arb4 = Node Mult (Node Mult (Node Mult (Lf 1) (Lf 2)) (Node Add (Lf 3)(Lf 1))) (Lf 2)
test21 = evalArb arb1 == 6
test22 = evalArb arb2 == 14
test23 = evalArb arb3 == 13
test24 = evalArb arb4 == 16


--ex3
expToArb :: Expr ->Tree
expToArb (Const x) = Lf x
expToArb (e1 :+: e2) = Node Add (expToArb e1) (expToArb e2)
expToArb (e1 :*: e2) = Node Mult (expToArb e1) (expToArb e2)




--ex4

data IntSearchTree value
    = Empty
    | BNode
        (IntSearchTree value) -- elemente cu cheia mai mica
        Int -- cheia elementului
        (Maybe value) -- valoarea elementului
        (IntSearchTree value) -- elemente cu cheia mai mare


lookup' :: Int -> IntSearchTree value -> Maybe value
lookup' _ Empty = Nothing
lookup' x (BNode left key value right)
        | x == key = value
        | x < key = lookup' x left
        | otherwise = lookup' x right


--ex5

keys :: IntSearchTree value -> [Int]
keys Empty = []
keys (BNode left key _ right) = keys left ++ [key] ++ keys right

--ex6

values :: IntSearchTree value -> [value]
values Empty = []
values (BNode left _ (Just value) right) = values left ++ [value] ++ values right
values (BNode left _ Nothing right) = values left ++ values right

--ex7

insert :: Int -> value -> IntSearchTree value -> IntSearchTree value
insert x value Empty = BNode Empty x (Just value) Empty
insert x value (BNode left key v right)
        | x == key = BNode left key (Just value) right
        | x < key = BNode (insert x value left) key v right
        | otherwise = BNode left key v (insert x value right)

--ex8

delete :: Int -> IntSearchTree value -> IntSearchTree value
delete _ Empty = Empty
delete x (BNode left key v right)
        | x == key = BNode left key Nothing right
        | x < key = BNode (delete x left) key v right
        | otherwise = BNode left key v (delete x right) 


--ex9

toList :: IntSearchTree value -> [(Int, value)]
toList Empty =[]
toList (BNode left key (Just value) right) = toList left ++ [(key,value)] ++ toList right
toList (BNode left key Nothing right) = toList left ++ toList right 


--ex 10

fromList :: [(Int, value)] -> IntSearchTree value
fromList [] = Empty
fromList ((key,value):xs) = insert key value (fromList xs)

--ex11


printTree :: Show value => IntSearchTree value -> String
printTree (BNode left key (Just value) right) = printTree left ++ show key ++ " " ++ show value ++ " " ++ printTree right


printTree2 :: IntSearchTree value -> String
printTree2 Empty = ""
printTree2 (BNode left k _ right) = 
    "(" ++ printTree2 left ++ show k ++ printTree2 right ++ ")"
