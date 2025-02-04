------ LAB 9 ------

data Tree = Empty  -- arbore vid
    | Node Int Tree Tree Tree -- arbore cu valoare de tip Int in radacina si 3 fii

-- extree :: Tree
-- extree = Node 4 (Node 5 Empty Empty Empty)
--                 (Node 3 Empty Empty (Node 1 Empty Empty Empty)) Empty

class ArbInfo t where
    level :: t -> Int -- întoarce înălțimea arborelui; considerăm că un arbore vid are înălțimea 0
    sumval :: t -> Int -- întoarce suma valorilor din arbore
    nrFrunze :: t -> Int -- întoarce numărul de frunze al arborelui.

------ EX 1 ------
-- Instanțiați clasa următoare pentru tipul Tree:
instance ArbInfo Tree where
    level Empty = 0
    level (Node x left mid right) = 1 + maximum [level left, level mid, level right]

    sumval Empty = 0
    sumval (Node x left mid right) = x + sumval left + sumval mid + sumval right

    nrFrunze Empty = 0
    nrFrunze (Node x left mid right) =
        if level (Node x left mid right) == 1 then 1
        else nrFrunze left + nrFrunze mid + nrFrunze right



class Scalar a where
    zero :: a
    one :: a
    adds :: a -> a -> a
    mult :: a -> a -> a
    negates :: a -> a
    recips :: a -> a

class (Scalar a) => Vector v a where
    zerov :: v a
    onev :: v a
    addv :: v a -> v a -> v a -- adunare vector
    smult :: a -> v a -> v a -- înmulțire cu scalare
    negatev :: v a -> v a -- negare vector

------ EX 2 ------
-- Instanțiați clasa Scalar folosindu-vă de tipuri primitive (hint: nu uitați, trebuie să fie corpuri comutative).
-- NOTE : we could've chosen any primitive type here, but RATIONAL fits well the properties of a scalar (like RECIP giving 1 / x , which would be weird for an INT instance)
instance Scalar Rational where
    zero = 0
    one = 1
    adds = (+)
    mult = (*)
    negates = negate
    recips = recip



------ EX 3 ------
-- Scrieți două instanțe ale clasei Vector pentru a reprezenta vectori bidimensionali și tridimensionali.
data V2D a = V2D a a
        deriving Show

instance (Scalar a) => Vector V2D a where
    zerov = V2D zero zero
    onev = V2D one one
    addv (V2D x1 y1) (V2D x2 y2) = V2D (adds x1 x2) (adds y1 y2)
    smult a (V2D x y) = V2D (mult a x) (mult a y)
    negatev (V2D x y) = V2D (negates x) (negates y)


data V3D a = V3D a a a
        deriving Show

instance (Scalar a) => Vector V3D a where
    zerov = V3D zero zero zero
    onev = V3D one one one
    addv (V3D x1 y1 z1) (V3D x2 y2 z2) = V3D (adds x1 x2) (adds y1 y2) (adds z1 z2)
    smult a (V3D x y z) = V3D (mult a x) (mult a y) (mult a z)
    negatev (V3D x y z) = V3D (negates x) (negates y) (negates z)

{-
TO REMEMBER : Because we have zerov, for example, defined for both V2D and V3D, we need to give the EXPLICIT signature of the variable we want to define.
    This way Haskell doesn't get tangled in type ambiguities.

    In this case, we defined a SCALAR instance only for RATIONAL and V3D a has the "(Scalar a)" typeclass constraint.
    Despite of this, we need to EXPLICITLY specify that V3D takes Rational. "myV3D :: Scalar a => V3D a" won't work.
    Rational has the only defined Scalar instance, but Haskell will still see "myV3D :: Scalar a => V3D a" as polymorphic,
    a having the possibility to be Rational, Float, Int etc.
-}
-- myV3D :: Scalar a => V3D a       -- won't work
myV3D :: V3D Rational
myV3D = zerov
