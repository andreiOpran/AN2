------ LAB 2 ------

myInt = 31415926535897932384626433832795028841971693993751058209749445923

{-
TO REMEMBER: The last type gives the return variable. The rest are parameters
used by the function

We interpret this as such: "double" is a function that is given an Integer type variable
and returns another Integer
-}
double :: Integer -> Integer
double x = x + x

{-
In Haskell, we have "if" and "else" too. They can be nested to be used as "if else"
TO REMEMBER: IF needs to be used with THEN and must always be followed by an ELSE clause
-}
maxim x y = if x > y
            then x
            else y

{-
LET IN defines a local scope where we can define variables and use them in the current
IN section only. WHERE is similar, but it allows us to use the defined variables throughout
the whole function body
-}
max3 x y z = let
            u = maxim x y
            -- more variables
            in maxim  u z

max3' x y z =
    maxim max1 z
    where
        max1 = maxim x y
        -- more variables

maxim4 x y z u =
    let max1 = maxim x y
    in
        let max2 = maxim z u
        in maxim max1 max2

{-
It is not mandatory to write the signature of a function, as Haskell
will deduce it from our function definition. Sometimes though, it is better to
write it ourselves so we don't let anything to interpretation
-}
maxim4' :: Integer -> Integer -> Integer -> Integer -> Integer
maxim4' x y z u =
    let max1 = maxim x y
        max2 = maxim z u
    in maxim max1 max2

------ EX 6 ------
--Scrieti următoarele functii:
-- a) o functie cu doi parametri care calculează suma pătratelor lor
sumaPatrate :: Integer -> Integer -> Integer
sumaPatrate x y = x ^ 2 + y ^ 2

-- b) o functie cu un parametru ce întoarce stringul “par” dacă parametrul este par si “impar” altfel
{-
TO REMEMBER: In Haskell, functions are called in the form "func arg1 arg2 ..."
If we want to use a more intuitive form, we can use the INFIX form "arg1 `func` arg2" for
BINARY functions (usually). ` NOT ' !!!!!!
-}
parimpar:: Integer -> String
parimpar x =
    -- normal form
    --if mod x 2 == 0 then

    -- infix form
    if x `mod` 2 == 0 then
        "par"
    else
        "impar"

-- c) o functie care calculează factorialul unui număr
{-
TO REMEMBER: When passing to a function an equation/another function as an argument, uses parentheses
so the function won't take just the variable name: factorial (n - 1) vs. factorial n - 1
-}
factorial:: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- d) o functie care verifică dacă primul parametru este mai mare decât dublul celui de-al doilea parametru
verificanr :: Integer -> Integer -> Bool
verificanr x y =
    if x > y * 2 then
        True
    else
        False

--SAU--
dublu :: Integer -> Integer -> String
dublu x y =
    if x > 2 * y
        then "true"
    else "false"

-- e) o functie care calculează elementul maxim al unei liste
{-
In Haskell, we don't have traditional iterators for passing through a list. For this,
we take every first element, compute with it and use the rest of the list as the new list, recursively (head + tail).

HEAD -> the first element
TAIL -> what remains of the list

TO REMEMBER: We use the (h : hs) form of a list, where h is the HEAD and hs is the TAIL, where Haskell already knows that
(h : hs) is the list itself (same as [h1, h2, ...], but written differently)
-}
maxlist :: [Integer] -> Integer
maxlist [] = 0
maxlist [a] = a
maxlist (h : hs) = max h (maxlist hs)


------ EX 7 ------
-- Scrieti o functie poly cu patru argumente de tip Double (a,b,c,x)
-- care calculează a*xˆ2+b*x+c
poly :: Double -> Double -> Double -> Double -> Double
poly a b c x = a * x ^ 2 + b * x + c


------ EX 8 ------
-- Scrieti o functie eeny care întoarce stringul “eeny” atunci când primeste ca input un număr par si
-- “meeny” când primeste ca input un număr impar
eeny :: Integer -> String
eeny x = if even x then "eeny" else "meeny"
-- eeny x = if x `mod` 2 == 0 then "eeny" else "meeny"


------ EX 9 ------
-- Scrieti o functie fizzbuzz care întoarce “Fizz” pentru numerele divizibile cu 3, “Buzz” pentru numerele
-- divizibile cu 5 si “FizzBuzz” pentru numerele divizibile cu ambele.
fizzbuzz :: Integer -> String
fizzbuzz x = if x `mod` 3 == 0 && x `mod` 5 == 0 then "FizBuzz"
            else if x `mod` 3 == 0 then "Fizz"
            else if x `mod` 5 == 0 then "Buzz"
            else ""

--SAU CU GUARDS--
{-
Guards are a fancier way of doing pattern matching. After each case, we must use "=".
OTHERWISE is the default case, not mandatory, but good to be there

TO REMEMBER: order of function cases in Haskell is the order in which they are written
-}
fizzbuzz' x
    | x `mod` 3 == 0 && x `mod` 5 == 0 = "FizzBuzz"
    | x `mod` 3 == 0 = "Fizz"
    | x `mod` 5 == 0 = "Buzz"
    | otherwise = ""
--  | otherwise = []


fibonacciCazuri :: Integer -> Integer
fibonacciCazuri n
    | n < 2     = n
    | otherwise = fibonacciCazuri (n - 1) + fibonacciCazuri (n - 2)

fibonacciEcuational :: Integer -> Integer
fibonacciEcuational 0 = 0
fibonacciEcuational 1 = 1
fibonacciEcuational n =
    fibonacciEcuational (n - 1) + fibonacciEcuational (n - 2)


------ EX 10 ------
-- Implementati functia tribonacci dând o definitie bazată pe
-- cazuri si una ecuatională, cu sabloane

-- Ecuational/sabloane de functii (mai multe definitii pt fiecare caz)
tribonacci1 :: Integer -> Integer
tribonacci1 1 = 1
tribonacci1 2 = 1
tribonacci1 3 = 2
tribonacci1 n = tribonacci1 (n - 1) + tribonacci1 (n - 2) + tribonacci1 (n - 3)

-- Cazuri (tot intr-o singura definitie de functie)
tribonacci2 n
--  | n < 4 = fibonacciCazuri n
    | n < 3 = 1
    | n == 3 =2
    | otherwise = tribonacci2 (n - 1) + tribonacci2 (n - 2) + tribonacci2 (n - 3)


------ EX 11 ------
-- Scrieti o functie recursivă care calculează coeficientii binomiali.
-- B(n,k) = B(n-1,k) + B(n-1,k-1)
-- B(n,0) = 1
-- B(0,k) = 0
binomial :: Integer -> Integer -> Integer
binomial n 0 = 1
binomial 0 k = 0
binomial n k = binomial (n - 1) k  + binomial (n - 1) (k - 1)