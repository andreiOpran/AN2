{- 
class Functor f where 
     fmap :: (a -> b) -> f a -> f b 
class Functor f => Applicative f where
    pure :: a -> f a
    (<*>) :: f (a -> b) -> f a -> f b

Just length <*> Just "world"
Just (++" world") <*> Just "hello,"
pure (+) <*> Just 3 <*> Just 5
pure (+) <*> Just 3 <*> Nothing
(++) <$> ["ha","heh"] <*> ["?","!"]
-}
data List a = Nil
            | Cons a (List a)
        deriving (Eq, Show)

instance Functor List where
    fmap _ Nil = Nil
    fmap functie (Cons x xs) = Cons (functie x) (fmap functie xs)
instance Applicative List where
    pure x = Cons x Nil
    (<*>) :: List (a -> b) -> List a -> List b
    Nil <*> _ = Nil
    _ <*> Nil = Nil
    Cons f fs <*> xs = fmap f xs `adaugare` (fs <*> xs)
        where 
            adaugare (Cons x xs) ys = Cons x (xs `adaugare` ys)
            adaugare Nil ys = ys

f = Cons (+1) (Cons (*2) Nil)
v = Cons 1 (Cons 2 Nil)
test1 = (f <*> v) == Cons 2 (Cons 3 (Cons 2 (Cons 4 Nil)))



data Cow = Cow {
        name :: String
        , age :: Int
        , weight :: Int
        } deriving (Eq, Show)

noEmpty :: String -> Maybe String
noEmpty "" = Nothing
noEmpty str = Just str

noNegative :: Int -> Maybe Int
noNegative a = if a < 0 then Nothing else Just a 

test21 = noEmpty "abc" == Just "abc"
test22 = noNegative (-5) == Nothing 
test23 = noNegative 5 == Just 5 

cowFromString :: String -> Int -> Int -> Maybe Cow
cowFromString n a w
    | noEmpty n == Nothing || noNegative a == Nothing || noNegative w == Nothing = Nothing
    | otherwise = Just Cow { name = n, age = a, weight = w}

test24 = cowFromString "Milka" 5 100 == Just (Cow {name = "Milka", age = 5, weight = 100})

cowFromStringFmap n a w = Cow <$> noEmpty n <*> noNegative a <*> noNegative w
-- <$> is just the INFIX for for FMAP



newtype Name = Name String deriving (Eq, Show)
newtype Address = Address String deriving (Eq, Show)

data Person = Person Name Address
    deriving (Eq, Show)

validateLength :: Int -> String -> Maybe String
validateLength n str = if length str <= n then Just str else Nothing

test31 = validateLength 5 "abc" == Just "abc"

mkName :: String -> Maybe Name
mkName string = Name <$> validateLength 25 string
-- mkName string
--     | validateLength 25 string == Nothing = Nothing
--     | otherwise = Just (Name string)

mkAddress :: String -> Maybe Address
mkAddress string = Address <$> validateLength 100 string

test32 = mkName "Gigel" ==  Just (Name "Gigel")
test33 = mkAddress "Str Academiei" ==  Just (Address "Str Academiei")

mkPerson :: String -> String -> Maybe Person
mkPerson name add = Person <$> mkName name <*> mkAddress add

test34 = mkPerson "Gigel" "Str Academiei" == Just (Person (Name "Gigel") (Address "Str Academiei"))
