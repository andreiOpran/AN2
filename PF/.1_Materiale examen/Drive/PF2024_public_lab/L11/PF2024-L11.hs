{-
class Functor f where
fmap : : ( a -> b ) -> f a -> f b
-}
newtype Identity a = Identity a
instance Functor Identity where
    fmap :: (a -> b) -> Identity a -> Identity b
    fmap functie (Identity a) = Identity (functie a)

data Pair a = Pair a a
instance Functor Pair where
    fmap :: (a -> b) -> Pair a -> Pair b
    fmap functie (Pair x y) = Pair (functie x) (functie y)

data Constant a b = Constant b
instance Functor (Constant a) where
    fmap :: forall k (a1 :: k) a2 b . (a2 -> b) -> Constant a1 a2 -> Constant a1 b
    fmap functie (Constant b) = Constant (functie b)

data Two a b = Two a b
instance Functor (Two a) where
    fmap :: (a2 -> b) -> Two a1 a2 -> Two a1 b
    fmap functie (Two a b) = Two a (functie b)

data Three a b c = Three a b c
instance Functor (Three a b) where
    fmap :: (a2 -> b2) -> Three a1 b1 a2 -> Three a1 b1 b2
    fmap functie (Three a b c) = Three a b (functie c)

data Three' a b = Three' a b b
instance Functor (Three' a) where
    fmap :: (a2 -> b) -> Three' a1 a2 -> Three' a1 b
    fmap functie (Three' a b b') = Three' a (functie b) (functie b')

data Four a b c d = Four a b c d
instance Functor (Four a b c) where
    fmap :: (a2 -> b2) -> Four a1 b1 c a2 -> Four a1 b1 c b2
    fmap functie (Four a b c d) = Four a b c (functie d)

data Four'' a b = Four'' a a a b
instance Functor (Four'' a) where
    fmap :: (a2 -> b) -> Four'' a1 a2 -> Four'' a1 b
    fmap functie (Four'' a a1 a2 b) = Four'' a a1 a2 (functie b)

data Quant a b = Finance | Desk a | Bloor b
instance Functor (Quant a) where
    fmap :: (a2 -> b) -> Quant a1 a2 -> Quant a1 b
    fmap functie (Finance) = Finance
    fmap functie (Desk a) = Desk a
    fmap functie (Bloor b) = Bloor (functie b)

data LiftItOut f a = LiftItOut (f a)
instance Functor f => Functor (LiftItOut f) where
    fmap functie (LiftItOut fa) = LiftItOut (fmap functie fa)

data Parappa f g a = DaWrappa (f a) (g a)
instance (Functor f, Functor g) => Functor (Parappa f g) where
    fmap :: (Functor f, Functor g) => (a -> b) -> Parappa f g a -> Parappa f g b
    fmap functie (DaWrappa fa ga) = DaWrappa (fmap functie fa) (fmap functie ga)

data IgnoreOne f g a b = IgnoringSomething (f a) (g b)
instance Functor g => Functor (IgnoreOne f g a) where
    fmap :: forall k (g :: * -> *) (f :: k -> *) (a :: k) a1 b. Functor g => (a1 -> b) -> IgnoreOne f g a a1 -> IgnoreOne f g a b
    fmap functie (IgnoringSomething fa gb) = IgnoringSomething fa (fmap functie gb)

data Notorious g o a t = Notorious (g o) (g a) (g t)
instance Functor g => Functor (Notorious g o a) where
    fmap :: Functor g => (a1 -> b) -> Notorious g o a a1 -> Notorious g o a b
    fmap functie (Notorious go ga gt)= Notorious go ga (fmap functie gt)

data GoatLord a = NoGoat | OneGoat a | MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)
instance Functor GoatLord where
    fmap :: (a -> b) -> GoatLord a -> GoatLord b
    fmap f NoGoat = NoGoat
    fmap f (OneGoat a) = OneGoat (f a)
    fmap f (MoreGoats a b c) = MoreGoats (fmap f a) (fmap f b) (fmap f c)

data TalkToMe a = Halt | Print String a | Read (String -> a)
instance Functor TalkToMe where
    fmap :: (a -> b) -> TalkToMe a -> TalkToMe b
    fmap f Halt = Halt
    fmap f (Print a b) = Print a (f b)
    fmap f (Read fa) = Read (fmap f fa)
