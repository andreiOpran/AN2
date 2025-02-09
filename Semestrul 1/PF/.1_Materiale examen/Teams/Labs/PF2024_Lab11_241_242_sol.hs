------ LAB 11 ------

-- Scrieți instanțe ale clasei Functor pentru tipurile de date descrise mai jos.

{-
class Functor f where
fmap : : ( a -> b ) -> f a -> f b
-}

{-
------ FUNCTORS ------

TO REMEMBER: FUNCTORS are DATA TYPES on which FMAP can be APPLIED, aka DATA TYPES that can be mapped.
FMAP IS NOT THE FUNCTOR!! FMAP is a "property" of FUNCTORS.

For example, (Maybe a) has already an instance of the CLASS, because it is primitive. That means that the
type (Maybe a) is ALSO a FUNCTOR.

What FMAP does is that it takes a function and an object, applies the function inside the object and returns the
object with the modified inside.
It is important to note that the function is to be applied only on the LAST TYPE that is passed to the TYPE CONSTRUCTOR.
The rest will be part of the FUNCTOR.

For example, for data Three a b c = Three a b c, we remember that FMAP is applied only on the LAST TYPE, so on c.
The rest of the type, aka (Three a b) will represent the FUNCTOR. So without the last type input, without c.
So when writing an instance of CLASS FUNCTOR that follows the template:

instance Functor `myType` where ...

We will have:
instance Functor (Three a b) where
    fmap that operates on c ...

Another important note is that FMAP will be applied on all arguments of type c.
If we have:

data Three a b c = Three a b c c  then
fmap functie (Three a b c) = Three a b (functie c) (functie c)

OR

data Three a b c = Three a c b c  then
fmap functie (Three a b c) = Three a (functie c) b (functie c)
-}

newtype Identity a = Identity a
instance Functor Identity where
    fmap functie (Identity a ) = Identity (functie a)


data Pair a = Pair a a
instance Functor Pair where
        fmap functie (Pair x y) = Pair (functie x) (functie y)


data Constant a b = Constant b
instance Functor (Constant a) where
    fmap functie (Constant b) = Constant (functie b)

data Two a b = Two a b
instance Functor (Two a) where
    fmap functie (Two a b) = Two a  (functie b)

data Three a b c = Three a b c
instance Functor (Three a b) where
    fmap functie (Three a b c)= Three a b (functie c)

data Three' a b = Three' a b b
instance Functor (Three' a) where
    fmap functie (Three' a b b')= Three' a (functie b) (functie b')

data Four a b c d = Four a b c d
instance Functor (Four a b c) where
    fmap functie (Four a b c d)= Four a b c (functie d)
data Four'' a b = Four'' a a a b
instance Functor (Four'' a) where
    fmap functie (Four'' a a1 a2 b)= Four'' a a1 a2 (functie b)

data Quant a b = Finance | Desk a | Bloor b
instance Functor (Quant a) where
    fmap functie (Finance)= Finance
    fmap functie (Desk a)=Desk a
    fmap functie (Bloor b)= Bloor (functie b)

data LiftItOut f a = LiftItOut (f a)
instance Functor f => Functor (LiftItOut f) where
    fmap functie (LiftItOut fa) = LiftItOut (fmap functie fa)

data Parappa f g a = DaWrappa (f a) (g a)
instance (Functor f, Functor g )=> Functor (Parappa f g) where
    fmap functie (DaWrappa fa ga)= DaWrappa (fmap functie fa) (fmap functie ga)

data IgnoreOne f g a b = IgnoringSomething (f a) (g b)
instance Functor g=> Functor (IgnoreOne f g a) where
    fmap functie (IgnoringSomething fa gb )= IgnoringSomething fa (fmap functie gb)

data Notorious g o a t = Notorious (g o) (g a) (g t)
instance Functor g => Functor (Notorious g o a) where
    fmap functie (Notorious go ga gt)= Notorious go ga (fmap functie gt)

data GoatLord a = NoGoat | OneGoat a | MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)
instance Functor GoatLord where
    fmap f NoGoat = NoGoat
    fmap f (OneGoat a) = OneGoat (f a)
    fmap f (MoreGoats a b c) = MoreGoats (fmap f a) (fmap f b) (fmap f c)

data TalkToMe a = Halt | Print String a | Read (String -> a)

instance Functor TalkToMe where
    fmap f Halt = Halt
    fmap f (Print a b) = Print a (f b)
    fmap f (Read fa) = Read (fmap f fa)