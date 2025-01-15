--class Functor f where
--    fmap :: (a -> b) -> f a -> f b

--class Functor f => Applicative f where
--    pure :: a -> f a
--    (<*>) :: f (a -> b) -> f a -> f b
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use isNothing" #-}
{-# HLINT ignore "Use <$>" #-}

data List a = Nil
    | Cons a (List a)
    deriving (Eq, Show)

instance Functor List where
    fmap _ Nil = Nil
    fmap f (Cons a b) = Cons (f a) (fmap f b)

instance Applicative List where
    pure x = Cons x Nil
    Nil <*> _ = Nil
    _ <*> Nil = Nil
    (Cons f fs) <*> xs = (fmap f xs) `append` (fs <*> xs)

append :: List a -> List a -> List a
append Nil ys = ys
append (Cons x xs) ys = Cons x (append xs ys)

f = Cons (+1) (Cons (*2) Nil)
v = Cons 1 (Cons 2 Nil)
test1 = (f <*> v) == Cons 2 (Cons 3 (Cons 2 (Cons 4 Nil)))

data Cow = Cow {
        name :: String
        , age :: Int
        , weight :: Int
        } deriving (Eq, Show)
    
noEmpty :: String -> Maybe String
noEmpty a 
    |a == "" = Nothing
    |otherwise = Just a

noNegative :: Int -> Maybe Int
noNegative a
    |a < 0 = Nothing
    |otherwise = Just a

test21 = noEmpty "abc" == Just "abc"
test22 = noNegative (-5) == Nothing
test23 = noNegative 5 == Just 5

--b

cowFromString :: String -> Int -> Int -> Maybe Cow
cowFromString nume varsta greutate
            | noEmpty nume == Nothing || noNegative varsta == Nothing || noNegative greutate == Nothing = Nothing
            |otherwise = Just(Cow {name = nume,age = varsta,weight = greutate})
test24 = cowFromString "Milka" 5 100 == Just (Cow {name = "Milka", age = 5,weight = 100})
--c
cowFromString2 :: String -> Int -> Int -> Maybe Cow
cowFromString2 nume varsta greutate = pure Cow <*> noEmpty nume <*> noNegative varsta <*> noNegative greutate

--3
newtype Name = Name String deriving (Eq, Show)
newtype Address = Address String deriving (Eq, Show)
data Person = Person Name Address
    deriving (Eq, Show)

validateLength :: Int -> String -> Maybe String
validateLength lg cuv
        |length cuv < lg = Just cuv
        |otherwise = Nothing 

test31 = validateLength 5 "abc" == Just "abc"

mkName :: String -> Maybe Name
mkName nume
    | validateLength 26 nume == Nothing = Nothing
    |otherwise = Just (Name nume)
mkAddress :: String -> Maybe Address
mkAddress adresa
    |validateLength 101 adresa == Nothing = Nothing
    |otherwise = Just (Address adresa)

test32 = mkName "Gigel" == Just (Name "Gigel")
test33 = mkAddress "Str Academiei" == Just (Address "Str Academiei")

mkPerson :: String -> String -> Maybe Person
mkPerson nume adresa
    |mkName nume == Nothing || mkAddress adresa == Nothing = Nothing
    |otherwise = Just (Person (Name nume) (Address adresa))

test34 = mkPerson "Gigel" "Str Academiei" == Just (Person (Name "Gigel") (Address "Str Academiei"))

mkPerson2 :: String -> String -> Maybe Person
mkPerson2 nume adresa = pure Person <*> mkName nume <*> mkAddress adresa

