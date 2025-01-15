{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant ==" #-}
import Data.Maybe (fromJust)
import Data.List (nub)
import Data.Array (listArray)
import System.Win32 (COORD(xPos))

type Nume = String
data Prop
    = Var Nume
    | F
    | T
    | Not Prop
    | Prop :|: Prop
    | Prop :&: Prop
    | Prop :->: Prop
    | Prop :<->: Prop
    deriving Eq
infixr 2 :|:
infixr 3 :&:
infixr 1 :->:
infixr 1 :<->:

p1 :: Prop
p1 = (Var "P" :|: Var "Q") :&: (Var "P" :&: Var "Q")

p2 :: Prop
p2 = (Var "P" :|: Var "Q") :&: (Not (Var "P") :&: Not (Var "Q"))

p3 :: Prop
p3 = (Var "P":&:(Var "Q" :|: Var "R")) :&: ((Not(Var "P"):|:Not(Var "Q")) :&: (Not(Var "P") :|: Not(Var "R")))
--ex2
instance Show Prop where
    show (Var n) = n
    show F = "False"
    show T = "True"
    show (Not p) = "(~" ++ show p ++ ")"
    show (p1 :|: p2) = "(" ++ show p1 ++ "|" ++ show p2 ++ ")"
    show (p1 :&: p2) = "(" ++ show p1 ++ "&" ++ show p2 ++ ")"
    show (p1 :->: p2) = "(" ++ show p1 ++ " -> " ++ show p2 ++ ")"
    show (p1 :<->: p2) = "(" ++ show p1 ++ " <-> " ++ show p2 ++ ")"


--ex3

type Env = [(Nume, Bool)]

impureLookup :: Eq a => a -> [(a,b)] -> b
impureLookup a = fromJust . lookup a

eval :: Prop -> Env -> Bool
eval (Var x) l_adevar = impureLookup x l_adevar
eval (Not p) l_adevar
    |eval p l_adevar == True = False
    |otherwise = True
eval (p1 :&: p2) l_adevar
    |eval p1 l_adevar == True && eval p2 l_adevar == True = True
    |otherwise = False
eval (p1 :|: p2) l_adevar
    |eval p2 l_adevar == False && eval p1 l_adevar == False = False
    |otherwise = True
eval (p1 :->: p2) l_adevar = not (eval p1 l_adevar) || eval p2 l_adevar
eval (p1 :<->: p2) l_adevar = eval p1 l_adevar == eval p2 l_adevar


--ex4
variabile :: Prop -> [Nume]
variabile p = nub (lista p)
    where
         lista (Var x) = [x]
         lista (Not a) = lista a
         lista (p1 :&: p2) = lista p1 ++ lista p2
         lista (p1 :|: p2) = lista p1 ++ lista p2
         lista (p1 :->: p2) = lista p1 ++ lista p2
         lista (p1 :<->: p2) = lista p1 ++ lista p2

--ex5
envs :: [Nume] -> [Env]
envs [] =[[]]
envs (x:xs) = let rest = envs xs in
                [(x, False) : e | e <- rest] ++ [(x, True) : e | e <- rest] --de revizuit
    
--ex6
satisfiabila :: Prop -> Bool
satisfiabila p = any(eval p) (envs (variabile p))

--ex7
valida :: Prop -> Bool
valida p = not (satisfiabila (Not p))

--ex 10

