import Data.Char
------ EXAMPLES FOR FUNCTION COMPOSITION AND FUNCTION APPLICATION ------

------ FUNCTION COMPOSITION ------
{-
Function composition is achieved using the . operator. Basically, we chain functions (creating new ones in the process).
The . operator isn't focused on the application of the function, but on its creation.
-}

-- funComp f x = f (f x)
funComp f x = f . f x

------ FUNCTION APPLICATION ------
{-
Function application can be achieved by using the $ operator. Semantically, $ does't bring anything new.
It's main purpose is to apply functions, thus avoiding parentheses in the process. It is also know
as the LOWEST PRECEDENCE OPERATOR, as it has lowest precedence than any other operator in Haskell.

HOW IT WORKS:
    The $ operator evaluates its right-hand side as a single expression. That means that what comes
    AFTER it is treated as one unit and evaluated together before being passed to the function on the left.
    Thus, the order it evaluates expressions is FROM RIGHT TO LEFT. That is all :]
-}

-- funApplic f x = f x
funApplic f x = f $ x

-- funApplic' f x = f (f x)
funApplic' f x = f $ f x

{-
DIFFERENCES BETWEEN . AND $ :

. (Function Composition) -> it CREATES a new function by combining other functions
$ (Function Application) -> it APPLIES a function to a set of variables

The ways the two operators are used can be similar, but the way we think of them is different.

Look at funComp f x = f (f x) and funApplic' f x = f $ f x from above.

funApplic' f x = f $ f x can be written as funApplic' f x = f (f x), which is identical to funcComp.
Indeed, their logic in this example is the same, but we read them as such:

funComp f x = f . f x       --> we CREATE the function f . f (then it is applied to x)
funApplic' f x = f $ f x    --> we APPLY f to the result of f x

Alternatively, we can use composition to create a new function without parameters. We can apply this
function independently later.
-}

funComp'' f = f . f
-- funComp'' x

------ EXAMPLES ------

-- 1.
-- We apply sqrt to the result of the function 3 + 4 + 5
ex1 = sqrt $ 3 + 4 + 5      -- sqrt (3 + 4 + 5)

-- 2.
-- We create a function from two anonymous functions. We first add one, then square.
-- This function does not need arguments, as . does not imply application, just creation. We can apply ex2 later.
ex2 = (\x -> x * x) . (\x -> x + 1)

-- 3.
-- Let's rewrite this version of ex10 from lab4.
lab4ex10 p = map (^2) (map snd (filter (odd . fst) (zip [1..] p)))

-- It becomes:
ex3 p = map ((^2) . snd) $ filter (odd . fst) $ zip [1..] p

{-  Explanation:

Reading from right to left:
- we apply zip
- we create the function odd . fst
- we apply filter (odd . fst) on the result of zip (it takes the first element from each pair and verifies if odd)
- we create ((^2 . snd)) (by using composition, we also skip using map twice)
- we apply map ((^2 . snd)) on the result of filter

Question: Why doesn't the form below work? Why do we need parentheses in map ((^2) . snd). Can't we just apply $?
ex3Bad p  = map $ (^2) . snd $ filter (odd . fst) $ zip [1..] p
                ^
Answer: No, because MAP needs a function that it applies on a list.
In the example above, $ (^2) . snd is interpreted as a separate expression, that is evaluated before and independently from map.
Because of this, map is evaluated afterwards without the function it needs as an argument.
Thus, we must give map its parameter function BEFORE $, so it can be applied over the evaluation AFTER $.

This also applied to filter (odd . fst)
-}

-- 4.
-- toUpper is a function that transforms a LOWERCASE char to UPPERCASE

-- This function takes a list of strings, converts each string to uppercase, calculates the length of each uppercase string,
-- and then sums these lengths, returning the total.
ex4 :: [[Char]] -> Int
ex4 = sum . map length . map (map toUpper)
ex4' :: [[Char]] -> Int
ex4' list = sum $ map length $ map (map toUpper) $ list

{-
Question: Why do we need to give an argument to ex4' when using $ and not to ex4 with .?

Answer: ex4 just creates the function. ex4' uses $, which forces function application, that does, indeed, need
an argument to be applied on :]
-}

-- 5.
-- We can mix and match . and $

-- maximum is a function that returns the MAX from a LIST
-- takes a list of numbers, filters out the numbers that are less than or equal to 5, squares the remaining numbers,
-- and then returns the maximum squared value from that list.
ex5 :: [Int] -> Int
-- we apply maximum on the result of map (^ 2) applied on the result of filter (> 5) applied on list
ex5 list = maximum $ map (^ 2) $ filter (> 5) list

-- we create a function from maximum and map (^ 2) applied on the result of filter (> 5) applied on list
ex5' list = maximum . map (^ 2) $ filter (> 5) list

-- we apply maximum on the result of the function created from map (^ 2) and filter (> 5)
ex5'' :: (Num a, Ord a) => [a] -> a     -- this means that a must be from both Ord and Num
{-
Question: Why do we need $ list and can't write the function without the last $ as :
ex5'' list  = maximum $ map (^ 2) . filter (> 5) list
                                                ^
Answer: It's just a matter of operator precedence. Let's take only the map (^ 2) . filter (> 5) list part.
. has higher precedence than any other operator (except for f x itself). In this case, map (^ 2) . filter (> 5)
is evaluated before list. List would be applied after. Unfortunately, the composition still needs an argument,
which at the time of its evaluation, it doesn't have. Thus, we must tell it to do it after we give it an argument.
This is done with $ or parentheses.
-}
ex5'' list = maximum $ map (^ 2) . filter (> 5) $ list

-- we create the function from maximum, map (^ 2) and filter (> 5)
ex5''' = maximum . map (^ 2) . filter (> 5)