{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
import Data.Char
--v2 seria 23
data Expr = Var String | Val Int | Plus Expr Expr | Mult Expr Expr
    deriving (Show, Eq)

class Operations exp where
    simplify :: exp -> exp

instance Operations Expr where
    simplify (Var a) = Var a
    simplify (Val a) = Val a
    simplify (Plus e1 (Val 0)) = simplify e1
    simplify (Plus (Val 0) e2) = simplify e2
    simplify (Plus e1 e2) = Plus (simplify e1) (simplify e2)
    simplify (Mult e1 (Val 0)) = Val 0
    simplify (Mult (Val 0) e2) = Val 0
    simplify (Mult e1 (Val 1)) = simplify e1
    simplify (Mult (Val 1) e2) = simplify e2
    simplify (Mult e1 e2) = Mult (simplify e1) (simplify e2)


ex1 = Mult (Plus (Val 1) (Var "x")) (Val 1)
ex2 = Plus ex1 (Val 3)
ex3 = Plus (Mult (Val 0) (Val 2)) (Val 3)
ex4 = Mult ex3 (Val 5)

--2
{-
transformare :: String -> String
transformare cuvant = concatMap (\x -> if isAlpha x && notElem x "aeiouAEIOU" 
                                        then x : 'P' : [x] 
                                        else [x]) cuvant
-}
transformare :: String -> String
transformare [] = []
transformare (x:xs)
    | isAlpha x && notElem x "AEIOUaeiou" = x : 'P' : x : transformare xs
    | otherwise = x : transformare xs


isConsonant :: Char -> Bool
isConsonant c = isAlpha c && notElem (toLower c) "aeiou"

transformare3 :: String -> String
transformare3 str = concatMap transform str
  where
    transform x = do
      if isConsonant x
        then [x, 'p', x]
      else [x]

--24 v1

data Prop = V String | T | F | Prop :&: Prop | Prop :|: Prop
    deriving (Show, Eq)

class Operations2 exp where
    simplify2 :: exp -> exp

instance Operations Prop where
    simplify (V a :&: T) = V a
    simplify (V a :&: F) = F
    simplify (T :&: V a) = V a
    simplify (F :&: V a) = F
    simplify (V a :|: T) = T
    simplify (V a :|: F) = V a
    simplify (T :|: V a) = T
    simplify (F :|: V a) = V a
    simplify (p1 :&: p2) = simplify p1 :&: simplify p2
    simplify (p1 :|: p2) = simplify p1 :|: simplify p2
    simplify p = p
