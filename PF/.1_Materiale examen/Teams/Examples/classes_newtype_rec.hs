------ CLASSES ------

{-
The classes that lab 8 is talking about are actually the TYPECLASSES that we have met before,
like Num, Ord, Eq, Show and so on. Here, we are just defining custom ones, like we defined custom
data types previously. I will use the term TYPECLASS from now on.

A type class in Haskell defines a set of functions or operations that can be applied to a
particular type (or types) that are instances of that type class.

Let's look at Num. The Num typeclass is defined as:

class Num a where
    (+)   :: a -> a -> a   -- Addition
    (-)   :: a -> a -> a   -- Subtraction
    (*)   :: a -> a -> a   -- Multiplication
    negate :: a -> a       -- Unary negation (opposite)
    abs   :: a -> a        -- Absolute value
    signum :: a -> a       -- Sign function (returns -1, 0, or 1)
    fromInteger :: Integer -> a  -- Convert an integer to a type `a`

As you can see, the operations are given only the signature, no real definition. You can think of them as a BLUEPRINT.
We define what the operations do for every TYPE we want to have the properties of the typeclass, by creating an INSTANCE.

For Num, every type that has a Num INSTANCE, can use its operations.
In this case, types that have a NUM INSTANCE are Int, Integer, Float, Double etc.
From a logic point of view, we see all these types as numbers, so we want to be able to use addition, subtraction etc. on them.
So we use the typeclass Num to GROUP and give them the same properties.
It is important to keep in mind that the addition on Int is different from the addition on Float, for example. They are different types.
Haskell just uses the appropriate one for the given context.

TO REMEMBER: It is mandatory to give a definition for every function when defining an instance of a typeclass!!
-}

-- But as we can see in lab 8, we can define custom typeclasses as well. We will use the examples from lab 8 to work on.

{-
------ NEWTYPE ------

NEWTYPE, like DATA, used to define a new type. The difference is that the new type is distinct from an existing type
but has the same underlying representation. It is typically used to create a more specific or meaningful type, without creating
a completely, more complex, new data structure.

Example:

newtype Age = Age Int

Here, Age is a new type that wraps an Int (logically the same), but it's considered a distinct type from Int.
This means you can't mix Age with other Int values directly.

TO REMEMBER: Unlike DATA, NEWTYPE can have only ONE DATA CONSTRUCTOR!!
-}

{-
------ RECORDS ------

RECORDS are basically a nicer way of constructing a structure with multiple fields (arguments).
They are easier to understand when reading and BONUS! each RECORD FIELD is an IMPLICIT ACCESSOR to its data. wow

For example, let's say we want to define a person., with a (first name) (last name) (age) (height) (phone number) and (favorite ice-cream flavor).

data Person = Person String String Int Float String String
    deriving (Show)

Uf. Plus, if we define a Person object, we can't just get the age for example, without a custom function, which would
look like this:

age :: Person -> Int
age (Person _ _ age _ _ _) = age

It's so hard to read.

That's where RECORDS come in. Rewrite Person like this:

data Person = Person { firstName :: String
                    , lastName :: String
                    , age :: Int
                    , height :: Float
                    , phoneNumber :: String
                    , flavor :: String
                    } deriving (Show)

myPerson = Person "ana" "mere" 21 160 "112" "choco"

It's easier to see and read. Also we can use age myPerson to get the age directly.
You can also try:

age myPerson

-}

class Collection c where
    empty :: c key value
    singleton :: key -> value -> c key value
    insert
        :: Ord key
        => key -> value -> c key value -> c key value
    clookup :: Ord key => key -> c key value -> Maybe value
    delete :: Ord key => key -> c key value -> c key value
    keys :: c key value -> [key]
    values :: c key value -> [value]
    toList :: c key value -> [(key, value)]
    fromList :: Ord key => [(key,value)] -> c key value

-- We can define some IMPLICIT DEFINITIONS for some functions in a typeclass. These will apply, by default, for ALL types instances of the typeclass.
-- We can rewrite them if we want in the defined INSTANCES

-- These are inside the class, be careful
    keys c = [fst p | p <- toList c]
    values c = [snd p | p <- toList c]
    fromList [] = empty
    fromList ((k,v):es)  = insert k v (fromList es)


newtype PairList k v = PairList { getPairList :: [(k, v)] } deriving Show

-- So we have a type PairList and a typeclass Collection. Let's define an INSTANCE of Collection for PairList.

instance Collection PairList where
    empty = PairList []
    singleton k v = PairList [(k,v)]
    insert k v (PairList l) = PairList $ (k,v):filter ((/= k). fst) l
    clookup k = lookup k . getPairList
    delete k (PairList l) = PairList $ filter ((/= k). fst) l
    toList = getPairList
    -- deriving Show

-- As we can see, each function (skip the ones with default definitions) has a definition based on PairList.
-- That means, that we can use these as functions that work on PairList objects, like (+) works on Int, for example.


--- HOW TO USE

-- We use them as regular functions / operations.

pair :: PairList Int String
pair = PairList [(1 , "val")]

pair2 :: PairList Int String
pair2 = insert 2 "val2" pair

pairValue :: Int -> Maybe String
pairValue key = clookup key pair

-- >> pair2
-- PairList {getPairList = [(2,"val2"),(1,"val")]}      --> default show, print whole record

-- >> toList pair2
-- [(2,"val2"),(1,"val")]

-- I **HIGHLY RECOMMEND** writing the signature in the custom cases, because Haskell may not know to induce the type for SOME data
-- > comment the signature bellow and see what happens
emptyPair :: PairList k v
emptyPair = empty

-- We can also set some types when instantiating:

instance (Eq k, Eq v) => Eq (PairList k v) where
    PairList l1 == PairList l2 = l1 == l2
    -- something something...

-- So basically, what typeclasses do is that they help us GROUP types by certain shared properties, be it
-- implicit default properties or custom ones defined in instances