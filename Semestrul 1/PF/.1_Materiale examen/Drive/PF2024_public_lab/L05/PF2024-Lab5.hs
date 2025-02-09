sumaPatrateImpare :: [Int] -> Int
sumaPatrateImpare l = foldr (+) 0 $ map (^2) $ filter odd l
-- sumaPatrateImpare l = foldr ((+) . (^2)) 0 (filter odd l)

toateTrue :: [Bool] -> Bool
toateTrue l = foldr (&&) True l

allVerifies :: (Int -> Bool) -> [Int] -> Bool
allVerifies f l = foldl (&&) True $ map f l

anyVerifies :: (Int -> Bool) -> [Int] -> Bool
anyVerifies f l = foldl (||) False $ map f l

mapFoldr :: (a -> b) -> [a] -> [b]
mapFoldr f l = foldr (\x acc -> f x : acc) [] l

filterFoldr :: (a -> Bool) -> [a] -> [a]
filterFoldr f l = foldr(\x acc -> if f x then x : acc else acc) [] l

listToInt :: [Integer]-> Integer
listToInt l = foldl (\acc x -> acc * 10 + x) 0 l

rmChar :: Char -> String -> String
rmChar c l = reverse $ foldl (\acc x -> if x /= c then x : acc else acc) "" l

rmCharsRec :: String -> String -> String
rmCharsRec c [] = []
rmCharsRec [] l = l
rmCharsRec (c:cs) l = rmCharsRec cs (rmChar c l)

rmCharsFold :: String -> String -> String
rmCharsFold cs l = foldr (rmChar) l cs

myReverse :: [Int] -> [Int]
myReverse l = foldr (\x acc -> acc ++ [x]) [] l

myElem :: Int -> [Int] -> Bool
myElem deCautat l = foldr (\x acc -> if x == deCautat then acc || True else acc) False l

myUnzip :: [(a, b)] -> ([a], [b])
myUnzip = foldr f e 
    where
        f (x, y) (xs, ys) = ((x : xs), (y : ys))
        e = ([],[])

-- laboranta

------ EX 11 ------
-- Scrieți o funcție union care întoarce lista reuniunii a două liste de întregi primite ca parametri.
union :: [Int] -> [Int] -> [Int]
union xs ys = foldr f e ys
    where
        f y r
            | y `elem` xs = r
            | otherwise = r ++ [y]
        e = xs


------ EX 12 ------
-- Scrieți o funcție intersect care întoarce lista intersecției a două liste de întregi primite ca parametri.
intersect :: [Int] -> [Int] -> [Int]
intersect xs ys = foldr f e ys
    where
        f y r
            | y `elem` xs = y:r
            | otherwise   = r
        e = []


------ EX 13 ------
-- Scrieți o funcție permutations care întoarce lista tuturor permutărilor elementelor unei liste de întregi primite ca parametru.
{-
concatMap :: forall (t :: Type -> Type) a b.
Foldable t =>
(a -> [b]) -> t a -> [b]
Defined in ‘Data.Foldable’ (base-4.17.2.1)

Map a function over all the elements of a container and concatenate the resulting lists.

Basic usage:
concatMap (take 3) [[1..], [10..], [100..], [1000..]] --[1,2,3,10,11,12,100,101,102,1000,1001,1002]
-}

permutations :: [Int] -> [[Int]]
permutations = foldr f e
    where
        f x r = concatMap (insertEverywhere x) r        -- r is the acc in this case; with foldr get every element, insert into the acc and concatenate the results
        e     = [[]]

{-
This function inserts an element x on all positions of a list (y : ys).
For example:
insertEverywhere 1 [2,3]

(before the first recursive call)
x = 1
(y : ys) = [2, 3]
y = 2
ys = [3]

insertEverywhere 1 [2,3] = (1 : 2 : [3]) : map (2 :) (insertEverywhere 1 [3])
Evaluate the recursive call insertEverywhere x ys.

First recursion: insertEverywhere 1 [3]
x = 1
(y : ys) = [3]
y = 3
ys = []

insertEverywhere 1 [3] = (1 : 3 : []) : map (3 :) (insertEverywhere 1 [])

Second recursion: insertEverywhere 1 []
x = 1
(y : ys) = []
y = ys = []

The base case is reached, result is [[1]] for second recursion.

Going backwards now. To [[1]] we applied map (3 :).
y = 3

map (3 :) [[1]] => [[3,1]]

We still have the (x : y : ys) to add.
x = 1
y = 3
ys = []

(1 : 3 : []) : [[3,1]] => [[1,3],[3,1]]

This is the result for the first recursion. Map and (x : y : ys) to get the final result.
x = 1
y = 2
ys = [3]

map (2 :) [[1,3],[3,1]] => [[2,1,3],[2,3,1]]
(1 : 2 : [3]) : [[2,1,3],[2,3,1]] => [[1,2,3],[2,1,3],[2,3,1]]
-}
insertEverywhere :: Int -> [Int] -> [[Int]]
insertEverywhere x [] = [[x]]
insertEverywhere x (y : ys) = (x : y : ys) : map (y :) (insertEverywhere x ys)

--concatMap g = foldr f e
--  where
--    f x r = g x ++ r
--    e     = []
