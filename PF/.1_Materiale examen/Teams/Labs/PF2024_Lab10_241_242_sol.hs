------ LAB 10 ------

import Data.List (nub)
import Data.Maybe (fromJust)

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
    deriving (Eq, Read)
infixr 2 :|:
infixr 3 :&:
{-
We want here to create a custom version of the `&&` and `||` operator that already exist to use in our exercises
To make sure they act accordingly, we must give them the appropriate associativity direction and precedence.

infixr 2 -> right associativity, 2 precedence
infixl 3 -> left associativity, 3 precedence
-}


------ EX 1 ------
-- Scrieți următoarele formule ca expresii de tip Prop, denumindu-le p1, p2, p3.
p1 :: Prop
p1 = (Var "P" :|: Var "Q") :&: (Var "P" :&: Var "Q")

p2 :: Prop
p2 = (Var "P" :|: Var "Q") :&: (Not (Var "P") :&: Not (Var "Q"))

p3 :: Prop
p3 = (Var "P" :&: (Var "Q" :|: Var "R")) :&: ((Not(Var "P") :|: Not(Var "Q")) :&: (Not(Var "P") :|: Not(Var "R")))


------ EX 2 ------
-- Faceți tipul Prop instanță a clasei de tipuri Show, înlocuind conectorii Not, :|: și :&: cu ~, | și & și folosind direct numele variabilelor în loc de construcția Var nume.
instance Show Prop where
    show (Var x) = show x
    show T = "T"
    show F = "F"
    show (x :&: y) = "(" ++ show x ++ "&" ++ show y ++ ")"
    show (x :|: y) = "(" ++ show x ++ "|" ++ show y ++ ")"
    show (Not x) = "(" ++ "~" ++ show x ++ ")"
    show (x :->: y) = "(" ++ show x ++ "->" ++ show y ++ ")"
    show (x :<->: y) = "(" ++ show x ++ "<->" ++ show y ++ ")"

test_ShowProp :: Bool
test_ShowProp =
    show (Not (Var "P") :&: Var "Q") == "((~P)&Q)"


------ EX 3 ------
-- Definiți o funcție eval care, dată fiind o expresie logică și un mediu de evaluare, calculează valoarea de adevăr a expresiei.
type Env = [(Nume, Bool)]

impureLookup :: Eq a => a -> [(a,b)] -> b
impureLookup a = fromJust . lookup a

eval :: Prop -> Env -> Bool
eval (Var name) env = impureLookup name env
eval T _ = True
eval F _ = False
eval (Not p) env = not (eval p env)
eval (p :|: q) env = eval p env || eval q env
eval (p :&: q) env = eval p env && eval q env
eval (p :->: q) env = not (eval p env) || eval q env
eval (p :<->: q) env = eval (p :->: q) env == eval (q :->: p) env

test_eval = eval  (Var "P" :|: Var "Q") [("P", True), ("Q", False)] == True


------ EX 4 ------
-- Definiți o funcție variabile care colectează lista tuturor variabilelor dintr-o formulă. Hint: folosiți funcția nub.
variabile :: Prop -> [Nume]
variabile (Var x)= [x]
variabile T = []
variabile F = []
variabile (Not p) = variabile p
variabile (p :&: q) = nub(variabile p ++ variabile q)
variabile (p :|: q) = nub(variabile p ++ variabile q)
variabile (p :->: q) = nub(variabile p ++ variabile q)
variabile (p :<->: q) = nub(variabile p ++ variabile q)

test_variabile =
    variabile (Not (Var "P") :&: Var "Q") == ["P", "Q"]


------ EX 5 ------
-- Dată fiind o listă de nume, definiți toate atribuirile de valori de adevăr posibile pentru ea.
envs :: [Nume] -> [[(Nume, Bool)]]
envs [] = [[]]
--envs [x] = [[(x,False)],[(x,True)]]
envs (str:xs) =
    -- let r = envs xs
    -- in map (\x-> (str,False) : x) r  ++ map (\x->(str,True):x) r
    map (\x-> (str,False) : x) $ envs xs  ++ (map (\x->(str,True):x) $ envs xs)

test_envs =
    envs ["P", "Q"]
    ==
    [ [ ("P",False)
    , ("Q",False)
    ]
    , [ ("P",False)
    , ("Q",True)
    ]
    , [ ("P",True)
    , ("Q",False)
    ]
    , [ ("P",True)
    , ("Q",True)
    ]
    ]

-- NOTE: Depending on the implementation, the test might fail, even if your function is correct. The answer
-- you get might have the items in another order than the hard-coded test_envs, but still contain everything it's supposed to.


------ EX 6 ------
-- Definiți o funcție satisfiabila care, dată fiind o propoziție, verifică dacă aceasta este satisfiabilă. Hint: puteți folosi rezultatele de la exercițiile 4 și 5.
satisfiabila :: Prop -> Bool
satisfiabila prop =or(map(\x->eval prop x) (envs(variabile prop)))

test_satisfiabila1 = satisfiabila (Not (Var "P") :&: Var "Q") == True
test_satisfiabila2 = satisfiabila (Not (Var "P") :&: Var "P") == False


------ EX 7 ------
-- Definiți o funcție valida care verifică dacă o propoziție este validă.
valida :: Prop -> Bool
valida p =  not(satisfiabila(Not(p)))

test_valida1 = valida (Not (Var "P") :&: Var "Q") == False
test_valida2 = valida (Not (Var "P") :|: Var "P") == True


------ EX 9 ------
-- Extindeți tipul de date Prop și funcțiile definite până acum pentru a include conectorii logici -> (implicație) și <-> (echivalență), folosind constructorii :->: și :<->:.
-- Already in the code above


------ EX 10 ------
-- Scrieți o funcție echivalenta care verifică dacă două propoziții sunt echivalente.
echivalenta :: Prop -> Prop -> Bool
echivalenta p1 p2 = valida (p1 :<->: p2)

test_echivalenta1 =
    True == (Var "P" :&: Var "Q") `echivalenta` (Not (Not (Var "P") :|: Not (Var "Q")))
test_echivalenta2 =
    False == (Var "P") `echivalenta` (Var "Q")
test_echivalenta3 =
    True == (Var "R" :|: Not (Var "R")) `echivalenta` (Var "Q" :|: Not (Var "Q"))