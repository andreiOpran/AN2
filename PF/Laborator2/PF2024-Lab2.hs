import Data.List

myInt = 31415926535897932384626433832795028841971693993751058209749445923

double :: Integer -> Integer
double x = x+x

--maxim :: Integer -> Integer -> Integer
maxim x y = if (x > y)
               then x
          else y

-- maxim x y = if x > y then x else y

max3 x y z = let
             u = maxim x y
             in (maxim  u z)


-- fibonacciCazuri :: Integer -> Integer
-- fibonacciCazuri n
--     | n < 2     = n
--     | otherwise = fibonacciCazuri (n - 1) + fibonacciCazuri (n - 2)
    
-- fibonacciEcuational :: Integer -> Integer
-- fibonacciEcuational 0 = 0
-- fibonacciEcuational 1 = 1
-- fibonacciEcuational n =
--     fibonacciEcuational (n - 1) + fibonacciEcuational (n - 2)
    
-- tribonacci :: Integer -> Integer
-- tribonacci = undefined

-- binomial :: Integer -> Integer -> Integer
-- binomial = undefined


-- let x = 3 in x + 5 

-- x + 5
-- where x = 3 

-- maxim3 x y z =
--     let max1 = maxim x y
--     in maxim max1 z561

maxim3 x y z =
    maxim max1 z
    where max1 = maxim x y

maxim4 x y z u =
    let max1 = maxim x y
    in
        let max2 = maxim z u
        in maxim max1 max2



-- 6 

-- a
sumaPatrate x y = 
    let x2 = x * x
        y2 = y * y
    in x2 + y2


-- b
paritate n =
    if even(n)
        then "par" 
    else "impar"

-- c
factorial n = 
    if(n == 0)
        then 1
    else
        factorial(n - 1) * n

-- d
dublu x y = 
    if x > 2*y
        then "true"
    else "false"

-- e
maximLista [] = error "lista goala"
maximLista[x] = x
maximLista(h:t) = max h (maximLista t)


-- 7
poly :: Double -> Double -> Double -> Double -> Double
poly a b c x = a * x^2 + b * x + c

-- 8 
eeny :: Integer -> String
eeny x = if even(x) then "eeny" else "meeny"
-- `mod` in loc de mod

--9
fizzbuzz :: Integer -> String
fizzbuzz x 
    | x `mod` 15 == 0 = "Fizzbuzz"
    | x `mod` 3 == 0 = "Fizz"
    | x `mod` 5 == 0 = "Buzz"
    | otherwise = ""


-- recursivitate    

fibonacciCazuri :: Integer -> Integer
fibonacciCazuri n
    | n < 2 = n
    | otherwise = fibonacciCazuri(n - 1) + fibonacciCazuri(n - 2)


fibonacciEcuational :: Integer -> Integer
fibonacciEcuational 0 = 0
fibonacciEcuational 1 = 1   
fibonacciEcuational n = fibonacciEcuational(n - 1) + fibonacciEcuational(n - 2)


tribonacci :: Integer -> Integer
tribonacci n
    | n == 1 = 1
    | n == 2 = 1
    | n == 3 = 2
    | otherwise = tribonacci(n - 1) + tribonacci(n - 2) + tribonacci(n - 3) 


binomial :: Integer -> Integer -> Integer
binomial = undefined