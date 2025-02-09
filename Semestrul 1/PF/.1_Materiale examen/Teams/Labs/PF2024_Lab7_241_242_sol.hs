------ LAB 7 ------

{-
Expr :+: Expr is written this way, because, by default, custom operators are defined in INFIX form. To define it in PREFIX,
we can write it as (:+:) Expr Expr. This also applies when using the operator.

TO REMEMBER: In the case of Expr, Const, :+: and :*: all DATA CONSTRUCTORS. Even if we think about :+: as an operation,
    it still defines a term of type Expr, that itself has two arguments of type Expr. Because we use Expr to
    build itself, we can think of it as a recursion. Later on, when we want to use the Int given to the Const, we have to
    unwrap all the way to the non-recursive data, Const Int.

DERIVING EQ:
When creating an EQ instance for a custom data by deriving it, Haskell will interpret equality ONLY if all parameters are the same
AND in the same order.

Examples:
Const 3 == Const 3 -- True
Const 3 == Const 4 -- False
Const 3 /= Const 4 -- True

(Const 2 :*: Const 3) == (Const 2 :*: Const 3) -- True
(Const 2 :*: Const 3) == (Const 3 :*: Const 2) -- False

TO REMEMBER: Because :+: and :*: are DATA CONSTRUCTORS, that means that (Const 2 :*: Const 3) :: Expr. They are Expr objects of their own.
-}

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

------ EX 1 ------
-- Scrieți o funcție evalExp :: Expr -> Int care evaluează o expresie determinând valoarea acesteia.
evalExp :: Expr -> Int
evalExp (Const nr) = nr
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

------ EX 2 ------
-- Scrieți o funcție evalArb :: Tree -> Int care evaluează o expresie modelată sub formă de arbore, determinând valoarea acesteia.
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

------ EX 3 ------
-- Scrieți o funcție expToArb :: Expr -> Tree care transformă o expresie în arborele corespunzător.
expToArb :: Expr -> Tree
expToArb (Const x) = Lf x
expToArb (e1 :+: e2) = Node Add (expToArb(e1)) (expToArb(e2))
expToArb (e1 :*: e2) = Node Mult (expToArb(e1)) (expToArb(e2))

data IntSearchTree value =
    Empty
    | BNode
        (IntSearchTree value)     -- elemente cu cheia mai mica
        Int                       -- cheia elementului
        (Maybe value)             -- valoarea elementului    -> Maybe so we can mark a deleted node with NOTHING, without actually deleting it
        (IntSearchTree value)     -- elemente cu cheia mai mare

------ EX 4 ------
-- Scrieți o funcție lookup' :: Int -> IntSearchTree value -> Maybe value care caută un element într-un arbore.
lookup' :: Int -> IntSearchTree value -> Maybe value
lookup' _ Empty = Nothing
lookup' key (BNode left k v right)
    | key == k = v
    | key < k = lookup' key left
    | key > k = lookup' key right

------ EX 5 ------
-- Scrieți o funcție keys :: IntSearchTree value -> [Int] care întoarce lista cheilor nodurilor dintr-un arbore de căutare.
keys :: IntSearchTree value -> [Int]
keys Empty = []
keys (BNode left key value right) = keys left ++ [key] ++ keys right

------ EX 6 ------
-- Scrieți o funcție values :: IntSearchTree value -> [value] care întoarce lista valorilor nodurilor dintr-un arbore de căutare.
values :: IntSearchTree value -> [value]
values Empty = []
values (BNode left key value right) = maybeToList value ++ values left ++ values right
    where
        maybeToList Nothing  = []       -- TO REMEMBER: Patterns for ALL cases. We have a Maybe type here, so both Nothing and (Just a) must be treated
        maybeToList (Just v) = [v]

--SAU--

values' :: IntSearchTree value -> [value]
values'  Empty= []
values' (BNode left k (Just v) right) = values' left ++ [v] ++ values' right
values' (BNode left k  Nothing right) = values' left ++ values' right

------ EX 7 ------
-- Scrieți o funcție insert :: Int -> value -> IntSearchTree value -> IntSearchTree value care adaugă un element într-un arbore de căutare.
insert :: Int -> value -> IntSearchTree value -> IntSearchTree value
insert k v Empty = BNode Empty k (Just v) Empty
insert k v (BNode left key value right)
    | k == key = BNode left key (Just v) right
    | k < key  = BNode (insert k v left) key value right
    | k > key  = BNode left key value (insert k v right)

------ EX 8 ------
-- Scrieți o funcție delete :: Int -> IntSearchTree value -> IntSearchTree value care șterge (marchează ca șters) un element dintr-un arbore de căutare.
delete :: Int -> IntSearchTree value -> IntSearchTree value
delete _ Empty = Empty
delete k (BNode left key value right)
    | k == key = BNode left key Nothing right
    | k < key  = BNode (delete k left) key value right
    | k > key  = BNode left key value (delete k right)

------ EX 9 ------
-- Scrieți o funcție toList :: IntSearchTree value -> [(Int, value)] care întoarce lista elementelor dintr-un arbore de căutare.
toList :: IntSearchTree value -> [(Int, value)]
toList Empty = []
toList (BNode left x (Just val) right) = (toList left) ++ [(x, val)] ++ (toList right)
toList (BNode left x Nothing right) = (toList left) ++ (toList right)

------ EX 10 ------
-- Scrieți o funcție fromList :: [(Int, value)] -> IntSearchTree value care construiește un arbore dintr-o listă de perechi cheie-valoare.
fromList :: [(Int, value)] -> IntSearchTree value
fromList [] = Empty
fromList ((k,v):xs) = insert k v (fromList xs)

------ EX 11 ------
-- Scrieți o funcție printTree :: IntSearchTree value -> String care produce o reprezentare liniară a structurii arborelui (ignorând valorile).
-- TO REMEMBER: The SHOW function uses the existing Show instance to print the object. SHOW instance REQUIRED!
printTree :: IntSearchTree value -> String
printTree Empty = ""
printTree (BNode left key value right) = "(" ++ printTree left ++ ")" ++ show key ++ "(" ++ printTree right ++ ")"