data Tree = Empty  -- arbore vid
   | Node Int Tree Tree Tree -- arbore cu valoare de tip Int in radacina si 3 fii
      
extree :: Tree
extree = Node 4 (Node 5 Empty Empty Empty) 
                (Node 3 Empty Empty (Node 1 Empty Empty Empty)) Empty

class ArbInfo t where
  level :: t -> Int -- intoarce inaltimea arborelui; pt un arbore vid
                      -- se considera ca are inaltimea 0
  sumval :: t -> Int -- intoarce suma valorilor din arbore
  nrFrunze :: t -> Int -- intoarce nr de frunze al arborelui
-- level extree
-- 3
-- sumval extree
-- 13
-- nrFrunze extree
-- 2

instance ArbInfo Tree where
  level :: Tree -> Int
  level Empty = 0
  level (Node x left mid right) = 1 + maximum [level left, level mid, level right]

  sumval :: Tree -> Int
  sumval Empty = 0
  sumval (Node x left mid right) = x + sumval left + sumval mid + sumval right

  nrFrunze :: Tree -> Int
  nrFrunze Empty = 0
  nrFrunze (Node x left mid right)
    | level (Node x left mid right) == 1 = 1
    | otherwise = nrFrunze left + nrFrunze mid + nrFrunze right



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
  smult :: a -> v a -> v a  -- inmultire cu scalare
  negatev :: v a -> v a -- negare vector

-- instantiati calsa Scalar folosindu-va de tipuri primitive
-- am ales rational pentru ca se pliaza pe vectori, daca am fi ales INT era ciudat la recips
instance Scalar Rational where
  zero :: Rational
  zero = 0
  
  one :: Rational
  one = 1

  adds :: Rational -> Rational -> Rational
  adds = (+)

  mult :: Rational -> Rational -> Rational
  mult = (*)

  negates :: Rational -> Rational
  negates = negate

  recips :: Rational -> Rational
  recips = recip


-- de la copilot
-- instance Scalar Int where
--   zero :: Int
--   zero = 0
  
--   one :: Int
--   one = 1
  
--   adds :: Int -> Int -> Int
--   adds = (+)
  
--   mult :: Int -> Int -> Int
--   mult = (*)
  
--   negates :: Int -> Int
--   negates = negate

--   recips :: Int -> Int
--   recips x = error "No reciprocal for Int"

-- instance Scalar Double where
--   zero :: Double
--   zero = 0.0
  
--   one :: Double
--   one = 1.0
  
--   adds :: Double -> Double -> Double
--   adds = (+)
  
--   mult :: Double -> Double -> Double
--   mult = (*)
  
--   negates :: Double -> Double
--   negates = negate
  
--   recips :: Double -> Double
--   recips = (1 /)


-- scrieti 2 instante ale clasei Vector pentru a reprezenta vectori bidimensionali si tridimensionali
data V2D a = V2D a a deriving Show

instance (Scalar a) => Vector V2D a where
  zerov :: Scalar a => V2D a
  zerov = V2D zero zero
  
  onev :: Scalar a => V2D a
  onev = V2D one one

  addv :: Scalar a => V2D a -> V2D a -> V2D a
  addv (V2D x1 y1) (V2D x2 y2) = V2D (adds x1 x2) (adds y1 y2)

  smult :: Scalar a => a -> V2D a -> V2D a
  smult a (V2D x y) = V2D (mult a x) (mult a y)

  negatev :: Scalar a => V2D a -> V2D a
  negatev (V2D x y) = V2D (negates x) (negates y)

data V3D a = V3D a a a deriving Show

instance (Scalar a) => Vector V3D a where
  zerov :: Scalar a => V3D a
  zerov = V3D zero zero zero

  onev :: Scalar a => V3D a
  onev = V3D one one one

  addv :: Scalar a => V3D a -> V3D a -> V3D a
  addv (V3D x1 y1 z1) (V3D x2 y2 z2) = V3D (adds x1 x2) (adds y1 y2) (adds z1 z2)

  smult :: Scalar a => a -> V3D a -> V3D a
  smult a (V3D x y z) = V3D (mult a x) (mult a y) (mult a z)

  negatev :: Scalar a => V3D a -> V3D a
  negatev (V3D x y z) = V3D (negates x) (negates y) (negates z)

myV3D :: V3D Rational
myV3D = zerov

