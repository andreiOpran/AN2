------ LAB 12 ------

{-
class Functor f where
     fmap :: (a -> b) -> f a -> f b
class Functor f => Applicative f where
    pure :: a -> f a        -- wrap the given object in the most default form for a type
    (<*>) :: f (a -> b) -> f a -> f b

Just length <*> Just "world"

Just (++" world") <*> Just "hello,"
pure (+) <*> Just 3 <*> Just 5
pure (+) <*> Just 3 <*> Nothing
(++) <$> ["ha","heh"] <*> ["?","!"]
-}

-- NOTE: The same as FUNCTORS, but now the FUNCTION is also wrapped.

------ EX 1 ------
-- Scrieți instanțe ale claselor Functor și Applicative pentru constructorul de tip List.
data List a = Nil
            | Cons a (List a)   -- head + tail
        deriving (Eq, Show)

instance Functor List where
    fmap _ Nil = Nil
    fmap functie (Cons x xs) = Cons (functie x) (fmap functie xs)

instance Applicative List where
    pure x = Cons x Nil
    Nil <*> _ = Nil
    _ <*> Nil = Nil
    Cons f fs <*> xs = fmap f xs `adaugare` (fs <*> xs)
        where
            adaugare (Cons x xs) ys = Cons x (xs `adaugare` ys)
            adaugare Nil ys = ys

f = Cons (+1) (Cons (*2) Nil)
v = Cons 1 (Cons 2 Nil)
test1 = (f <*> v) == Cons 2 (Cons 3 (Cons 2 (Cons 4 Nil)))


------ EX 2 ------
data Cow = Cow {
        name :: String
        , age :: Int
        , weight :: Int
        } deriving (Eq, Show)

-- a) Scrieți funcțiile noEmpty și noNegative care validează un string, respectiv un număr întreg.
noEmpty :: String -> Maybe String
noEmpty "" = Nothing
noEmpty str = Just str

noNegative :: Int -> Maybe Int
noNegative a = if a < 0 then Nothing else Just a

test21 = noEmpty "abc" == Just "abc"
test22 = noNegative (-5) == Nothing
test23 = noNegative 5 == Just 5


-- b) Scrieți o funcție cowFromString care construiește un element de tip Cow verificând numele, vârsta și greutatea, folosind funcțiile definite la a).
cowFromString n a w
    | noEmpty n == Nothing || noNegative a == Nothing || noNegative w == Nothing = Nothing
    | otherwise = Just Cow { name = n, age = a, weight = w}

test24 = cowFromString "Milka" 5 100 == Just (Cow {name = "Milka", age = 5, weight = 100})


-- c) Scrieți funcția de la b) folosind fmap și <*>.
{-
In this exercise, we want to handle errors by using Nothing. We want to construct the Cow, but at the same time,
if any of the arguments doesn't respect the property, the whole Cow object will become Nothing.
We do this by applying partially the Cow DATA CONSTRUCTOR on the results of the property verification.
Any Nothing will propagate from the implementation of <*> in the Applicative Maybe.
-}
cowFromStringMaiSmecher n a w = Cow <$> noEmpty n <*> noNegative a <*> noNegative w
-- <$> is just the INFIX for for FMAP


------ EX 3 ------
newtype Name = Name String deriving (Eq, Show)
newtype Address = Address String deriving (Eq, Show)

data Person = Person Name Address
    deriving (Eq, Show)
-- a) Implementați o funție validateLength care validează lungimea unui șir de caractere – să fie mai mică decât numărul dat ca parametru.
validateLength :: Int -> String -> Maybe String
validateLength = undefined

test31 = validateLength 5 "abc" == Just "abc"


-- b) Implementați funcțiile mkName și mkAddress care transformă un șir de caractere într-un element din tipul de date asociat, validând stringul cu funcția validateLength (numele trebuie să aibă maxim 25 caractere, iar adresa maxim 100).
mkName :: String -> Maybe Name
mkName string = Name <$> validateLength 25 string
-- mkName string
--     | validateLength 25 string == Nothing = Nothing
--     | otherwise = Just (Name string)

mkAddress :: String -> Maybe Address
mkAddress string = Address <$> validateLength 100 string

test32 = mkName "Gigel" ==  Just (Name "Gigel")
test33 = mkAddress "Str Academiei" ==  Just (Address "Str Academiei")


-- c) Implementați funcția mkPerson care primește ca argumente două șiruri de caractere și formează un element de tip Person dacă sunt validate condițiile, folosind funcțiile implementate mai sus.
mkPerson :: String -> String -> Maybe Person
mkPerson name add = Person <$> mkName name <*> mkAddress add

test34 = mkPerson "Gigel" "Str Academiei" == Just (Person (Name "Gigel") (Address "Str Academiei"))


-- d) Implementați funcțiile de la b) și c) folosind fmap și <*>.
-- Already there.
