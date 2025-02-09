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

p1 :: Prop
p1 = (Var "P" :|: Var "Q") :&: (Var "P" :&: Var "Q")

p2 :: Prop
p2 = (Var "P" :|: Var "Q") :&: (Not (Var "P") :&: Not (Var "Q"))

p3 :: Prop
p3 = (Var "P" :&: (Var "Q" :|: Var "R")) :&: (Not (Var "P") :|: Not (Var "Q")) :&: (Not (Var "P") :|: Not (Var "R"))

-- faceti tipul Prop instanta a clasei de tipuri Show
instance Show Prop where
  show (Var x) = x
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


variabile :: Prop -> [Nume]
variabile (Var x) = [x]
variabile T = []
variabile F = []
variabile (Not p) = variabile p
variabile (p :&: q) = nub (variabile p ++ variabile q)
variabile (p :|: q) = nub (variabile p ++ variabile q)
variabile (p :->: q) = nub (variabile p ++ variabile q)
variabile (p :<->: q) = nub (variabile p ++ variabile q)

test_variabile =
  variabile (Not (Var "P") :&: Var "Q") == ["P", "Q"]



envs :: [Nume] -> [[(Nume, Bool)]]
envs [] = [[]]
envs (str:xs) = map (\x -> (str, False) : x) $ envs xs ++ map (\x -> (str, True) : x) (envs xs)


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

satisfiabila :: Prop -> Bool
satisfiabila prop =or(map(\x->eval prop x) (envs(variabile prop)))

test_satisfiabila1 = satisfiabila (Not (Var "P") :&: Var "Q") == True
test_satisfiabila2 = satisfiabila (Not (Var "P") :&: Var "P") == False

valida :: Prop -> Bool
valida p = not(satisfiabila(Not p))

test_valida1 = valida (Not (Var "P") :&: Var "Q") == False
test_valida2 = valida (Not (Var "P") :|: Var "P") == True


echivalenta :: Prop -> Prop -> Bool
echivalenta p1 p2 = valida (p1 :<->: p2) 

test_echivalenta1 =
  True
  ==
  (Var "P" :&: Var "Q") `echivalenta` (Not (Not (Var "P") :|: Not (Var "Q")))
test_echivalenta2 =
  False
  ==
  (Var "P") `echivalenta` (Var "Q")
test_echivalenta3 =
  True
  ==
  (Var "R" :|: Not (Var "R")) `echivalenta` (Var "Q" :|: Not (Var "Q"))

