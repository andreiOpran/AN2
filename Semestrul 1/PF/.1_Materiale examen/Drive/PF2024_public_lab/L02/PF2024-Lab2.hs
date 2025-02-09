import Data.List
import System.Win32 (xBUTTON1)

myInt = 31415926535897932384626433832795028841971693993751058209749445923

double :: Integer -> Integer
double x = x + x

maxim :: Integer -> Integer -> Integer
maxim x y = if (x > y) then x else y

-- Expresia let...in creeaza un domeniu de vizibilitate local.
max3 :: Integer -> Integer -> Integer -> Integer
max3 x y z =
    let
        u = maxim x y
    in (maxim u z)

max4 :: Integer -> Integer -> Integer -> Integer -> Integer
max4 a b c d =
    let
        u = max3 a b c
    in (maxim u d)

eeny :: Integer -> [Char]
eeny x = if even x then "eeny" else "meeny"


fizzbuzz :: Integer -> String
fizzbuzz x
    | x `mod` 15 == 0 = "FizzBuzz"
    | x `mod` 3 == 0 = "Fizz"
    | x `mod` 5 == 0 = "Buzz"
    | otherwise =  []

fizzbuzzVar2 :: Integer -> String
fizzbuzzVar2 x = if x `mod` 15 == 0 then "FizzBuzz" else
             if x `mod` 5 == 0 then "Buzz" else
             if x `mod` 3 == 0 then "Fizz" else ""
            


fibonacciCazuri :: Integer -> Integer
fibonacciCazuri n
    | n < 2     = n
    | otherwise = fibonacciCazuri (n - 1) + fibonacciCazuri (n - 2)

fibonacciEcuational :: Integer -> Integer
fibonacciEcuational 0 = 0
fibonacciEcuational 1 = 1
fibonacciEcuational n =
    fibonacciEcuational (n - 1) + fibonacciEcuational (n - 2)

tribonacci :: Integer -> Integer
tribonacci n
    | n == 1 = 1
    | n == 2 = 1
    | n == 3 = 2
    | otherwise = tribonacci(n - 1) + tribonacci(n - 2) + tribonacci(n - 3)

tribonacciVar2 :: Integer -> Integer
tribonacciVar2 1 = 1
tribonacciVar2 2 = 1
tribonacciVar2 3 = 2
tribonacciVar2 n = tribonacci(n - 1) + tribonacci(n - 2) + tribonacci(n - 3)

binomial :: Integer -> Integer -> Integer
binomial n k 
    | k == 0 = 1
    | n == 0 = 0
    | otherwise = binomial (n - 1) k + binomial (n - 1) (k - 1)

binomialVarianta2 :: Integer -> Integer -> Integer
binomialVarianta2 n 0 = 1
binomialVarianta2 0 k = 0
binomialVarianta2 n k = binomialVarianta2 (n - 1) k + binomialVarianta2 (n - 1) (k - 1)


sumaPatrate :: Integer -> Integer ->Integer
sumaPatrate x y = x^2 + y^2

paritate :: Integer -> [Char]
-- paritate x = if(x `mod` 2 == 0) then "par" else "impar"
paritate x = if even x then "par" else "impar"

factorial :: Integer -> Integer
factorial n
    | n < 2 = 1
    | otherwise = factorial (n - 1) * n

verificare :: Integer -> Integer -> Bool
verificare x y = x > 2 * y

maximLista :: [Integer] -> Integer
maximLista [] = error "Lista goala"
maximLista [x] = x
maximLista (x:xs) = maxim x (maximLista xs)

poly :: Double -> Double -> Double -> Double -> Double
poly a b c x = a*x*x + b*x + c

-- data Bool = False | True
-- Bool -> constructor de tip
-- False, True -> constructori de date