import Data.List

myInt = 31415926535897932384626433832795028841971693993751058209749445923

double :: Integer -> Integer
double x = x+x

triple :: Integer -> Integer
triple x = x+x+x

--maxim :: Integer -> Integer -> Integer
maxim x y = if (x > y)
               then x
          else y

max3 x y z = let
             u = maxim x y
             in (maxim  u z)

               
suma_patrate :: Integer -> Integer -> Integer
suma_patrate x y = x*x + y*y

par_impar :: Integer -> String
par_impar x = if (mod x 2 == 0)
                 then "par"
              else "impar"

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n-1)

mai_mare :: Integer -> Integer -> String
mai_mare a b = if( a > 2*b) then "a mai mare"
               else "nu e mai mare"


maxim_list :: [Integer] -> Integer
maxim_list [] = error "lista vida"
maxim_list [x] = x
maxim_list (x:xs) = maxim x (maxim_list xs)
