--class Functor f where
--fmap :: ( a -> b ) -> f a -> f b
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}

newtype Identity a = Identity a
data Pair a = Pair a a
data Constant a b = Constant b
data Two a b = Two a b
data Three a b c = Three a b c
data Three' a b = Three' a b b
data Four a b c d = Four a b c d
data Four'' a b = Four'' a a a b
data Quant a b = Finance | Desk a | Bloor b

instance Functor Identity where
    fmap f (Identity a) = Identity (f a)
instance Functor Pair where
    fmap f (Pair a b) = Pair(f a)(f b)

instance Functor (Constant a) where
    fmap f (Constant b) = Constant(f b)
instance Functor (Two a) where
    fmap f (Two a b) = Two a (f b)

instance Functor (Three a b) where
    fmap f (Three a b c) = Three a b (f c)

instance Functor (Three' a) where
    fmap f (Three' a b c) = Three' a (f b) (f c)                      
instance Functor (Four a b c) where
    fmap f (Four a b c d) = Four a b c (f d)

instance Functor (Four'' a) where
    fmap f (Four'' a b c d) = Four'' a  b  c (f d)

instance Functor (Quant a) where
    fmap _ Finance = Finance         -- No action needed, as Finance carries no data
    fmap _ (Desk a) = Desk a         -- No action on `a`, as Functor targets `b`
    fmap f (Bloor b) = Bloor (f b) 

data LiftItOut f a = LiftItOut (f a)
--data Parappa f g a = DaWrappa (f a) (g a)
data IgnoreOne f g a b = IgnoringSomething (f a) (g b)
data Notorious g o a t = Notorious (g o) (g a) (g t)
data GoatLord a = NoGoat | OneGoat a
    | MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)
data TalkToMe a = Halt | Print String a | Read (String -> a)



instance Functor f => Functor (LiftItOut f) where 
    fmap f (LiftItOut a) = LiftItOut (fmap f a) 

data Parappa f g a = DaWrappa (f a) (g a)
instance (Functor f, Functor g) => Functor (Parappa f g) where
    fmap f (DaWrappa a b) = DaWrappa (fmap f a) (fmap f b)
    
instance (Functor f, Functor g) => Functor (IgnoreOne f g a) where
    fmap f (IgnoringSomething a b) = IgnoringSomething a (fmap f b)

instance Functor g => Functor (Notorious g o a) where
    fmap f (Notorious a b c) = Notorious a b (fmap f c)

instance Functor GoatLord where
    fmap _ NoGoat = NoGoat
    fmap f (OneGoat a) = OneGoat (f a)
    fmap f (MoreGoats a b c) = MoreGoats (fmap f a) (fmap f b) (fmap f c)

instance Functor TalkToMe where
    fmap _ Halt = Halt
    fmap f (Print a b) = Print a (f b)
    fmap f (Read g) = Read (f . g)

