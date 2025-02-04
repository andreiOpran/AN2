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

myUnzip :: [(a, b)] -> ([a], [b])
myUnzip = undefined
