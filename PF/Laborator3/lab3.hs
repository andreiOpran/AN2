-- verifL :: [Int] -> Bool
-- verifL l = even(length l)

takefinal :: [Int] -> Int -> [Int]
takefinal l n = if n > length l then l else drop(length l - n) l

remove :: [Int] -> Int -> [Int]
remove l n = take (n - 1) l ++ drop n l -- concatenare -> ++


-- semiPareRec [0,2,1,7,8,56,17,18] == [0,1,4,28,9]
semiPareRec :: [Int] -> [Int]
semiPareRec [] = []
semiPareRec (h:t)
    | even h    = h `div` 2 : t'
    | otherwise = t'
 where t' = semiPareRec t

-- functia predefinita replicate
myreplicate :: Int -> a -> [a]
myreplicate n v
    | n == 0 = []
    | otherwise = v : myreplicate (n  - 1) v


-- sumImp :: [Int] -> Int
-- sumImp [] = 0
-- sumImp (h:t)
--     | odd h = h + t'
--     | otherwise = t'
--     where t' = sumImp


totalLen :: [String] -> Int
totalLen [] = 0
totalLen (h:hs)
    | h !! 0 == 'A' = length h + totalLen hs
    | otherwise = totalLen hs


-- NETERMINAT
-- nrVocale ["sos", "civic", "palton", "desen", "aerisirea"] == 9
-- nrVocale :: [String] -> Int
-- nrVocale [] = 0
-- nrVocale (h:t)
--     | palindrom h = cateVocale h + nrVocale t
--     | otherwise = nrVocale t

-- NETERMINAT
-- f 3 [1,2,3,4,5,6] = [1,2,3,3,4,3,5,6,3]
-- f :: Int -> [Int] -> [Int]
-- f n [] = []
-- f n (h:t)
--     | even h = (h:n) + n
--     | 



semiPareComp :: [Int] -> [Int]
semiPareComp l = [ x `div` 2 | x <- l, even x ]

-- divizori 4 == [1,2,4]
divizori :: Int -> [Int]
divizori n = [x | x <- [1..n], n `mod` x == 0]


-- listadiv [1,4,6,8] == [[1],[1,2,4],[1,2,3,6],[1,2,4,8]]
listadiv :: [Int] -> [[Int]]
listadiv n = [divizori(i) | i<-n]


-- inInterval 5 10 [1..15] == [5,6,7,8,9,10]
-- inInterval 5 10 [1,3,5,2,8,-1] == [5,8]
inInterval :: Int -> Int -> [Int] -> [Int]
inInterval a b l = [x | x <- l, x >= a, x <= b]


-- inIntervalRec :: Int -> Int -> [Int] -> [Int]
-- inIntrevalRec a b [] = []
-- inIntervalRec a b (h:t)
--     | h >= a && h <=b = h : inIntervalRec a b t


-- pozitive [0,1,-3,-2,8,-1,6] == 3

-- pozitiiImpare [0,1,-3,-2,8,-1,6,1] == [1,2,5,7]

-- multDigits "The time is 4:25" == 40
-- multDigits "No digits here!" == 1
