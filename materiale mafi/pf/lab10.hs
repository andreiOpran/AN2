--defapt asta e lab 9
data Tree = Empty 
    | Node Int Tree Tree Tree

class ArbInfo t where
    level :: t -> Int -- intoarce inaltimea arborelui;
    sumval :: t -> Int -- intoarce suma valorilor din arbore
    nrFrunze :: t -> Int -- intoarce nr de frunze al arborelui  


extree :: Tree
extree = Node 4 (Node 5 Empty Empty Empty)(Node 3 Empty Empty (Node 1 Empty Empty Empty)) Empty

instance ArbInfo Tree where
    level Empty = 0
    level (Node nod t1 t2 t3) = 1 + max(level t1) ( max(level t2) (level t3))
    sumval Empty = 0
    sumval (Node nod t1 t2 t3) = nod + sumval t1 + sumval t2 + sumval t3
    
    nrFrunze Empty = 0
    nrFrunze (Node _ Empty Empty Empty) = 1
    nrFrunze (Node _ left middle right) = nrFrunze left + nrFrunze middle + nrFrunze right
            
class Scalar a where
    zero :: a
    one :: a
    adds :: a -> a -> a
    mult :: a -> a -> a
    negates :: a -> a
    recips :: a -> a

--ex2
instance Scalar Int where
    zero = 0
    one = 1
    adds = (+)
    mult = (*)
    negates = negate
    recips x = if x /= 0 then div 1 x else error "Division by zero"

instance Scalar Float where
    zero = 0.0
    one = 1.0
    adds = (+)
    mult = (*)
    negates = negate
    recips x = if x /= 0.0 then 1.0 / x else error "Division by zero"

class (Scalar a) => Vector v a where
    zerov :: v a
    onev :: v a
    addv :: v a -> v a -> v a -- adunare vector
    smult :: a -> v a -> v a -- inmultire cu scalare
    negatev :: v a -> v a -- negare vector

data Vector2D a = Vector2D a a deriving (Show, Eq)
data Vector3D a = Vector3D a a a deriving (Show, Eq)


instance (Scalar a) => Vector Vector2D a where
    zerov = Vector2D zero zero
    onev = Vector2D one one
    addv (Vector2D x1 y1) (Vector2D x2 y2) = Vector2D (adds x1 x2) (adds y1 y2)
    smult s (Vector2D x y) = Vector2D (mult s x) (mult s y)
    negatev (Vector2D x y) = Vector2D (negates x) (negates y)


instance (Scalar a) => Vector Vector3D a where
    zerov = Vector3D zero zero zero
    onev = Vector3D one one one
    addv (Vector3D x1 y1 z1) (Vector3D x2 y2 z2) = Vector3D (adds x1 x2) (adds y1 y2) (adds z1 z2)
    smult s (Vector3D x y z) = Vector3D (mult s x) (mult s y) (mult s z)
    negatev (Vector3D x y z) = Vector3D (negates x) (negates y) (negates z)
