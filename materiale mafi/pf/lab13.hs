{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}
addM :: Maybe Int -> Maybe Int -> Maybe Int
addM mx my = mx >>= (\x -> my >>= (\y -> Just (x + y)))

--notatia do
addM2 :: Maybe Int -> Maybe Int -> Maybe Int
addM2 mx my = do
    x <- mx 
    y <- my 
    return (x + y) 

--normal
addM3 :: Maybe Int -> Maybe Int -> Maybe Int
addM3 Nothing _ = Nothing
addM3 _ Nothing = Nothing
addM3 (Just x) (Just y) = Just (x + y)

--cartesian_product xs ys = xs >>= ( \x -> (ys >>= \y-> return (x,y)))

cartesian_product xs ys = do
        x <- xs 
        y <- ys
        return(x,y)

--prod f xs ys = [f x y | x <- xs, y<-ys]
prod f xs ys = do
    x <- xs
    y<-ys
    return (f x y)

{-
myGetLine :: IO String
myGetLine = getChar >>= \x ->
if x == '\n' then
return []
else
myGetLine >>= \xs -> return (x:xs)
-}

myGetLine = do
    x <- getChar
    if x == '\n' then 
        return []
    else do 
        xs <- myGetLine
        return(x:xs)

{-
prelNo noin = sqrt noin
ioNumber = do
noin <- readLn :: IO Float
putStrLn $ "Intrare\n" ++ (show noin)
let noout = prelNo noin
putStrLn $ "Iesire"
print noout
-}

prelNo :: Float -> Float
prelNo noin = sqrt noin

ioNumber :: IO ()
ioNumber = do
    noin <- readLn :: IO Float
    putStrLn $ "Intrare\n" ++ (show noin)
    let noout = prelNo noin
    putStrLn "Iesire"
    print noout


--writer
--- Monada Writer


newtype WriterS a = Writer { runWriter :: (a, String) } 


instance  Monad WriterS where
  return va = Writer (va, "")
  ma >>= k = let (va, log1) = runWriter ma
                 (vb, log2) = runWriter (k va)
             in  Writer (vb, log1 ++ log2)


instance  Applicative WriterS where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)       

instance  Functor WriterS where              
  fmap f ma = pure f <*> ma     

tell :: String -> WriterS () 
tell log = Writer ((), log)
  
logIncrement :: Int  -> WriterS Int
logIncrement x = do
    tell ("increment:" ++ show x ++ "--")
    return (x + 1)

logIncrement2 :: Int  -> WriterS Int
logIncrement2 x = do
    y <- logIncrement x 
    logIncrement y

logIncrementN :: Int -> Int -> WriterS Int
logIncrementN x 0 = return x 
logIncrementN x n = do
    y <- logIncrement x 
    logIncrementN y (n - 1)


data Person = Person { name :: String, age :: Int }

showPersonN :: Person -> String
showPersonN Person{name = nume,age = varsta} = "Name: " ++ nume


showPersonA :: Person -> String
showPersonA Person{name = nume, age = varsta} = "Age: " ++ show varsta

showPerson :: Person -> String
showPerson Person{name = nume, age = varsta} = "("++ showPersonN Person{name = nume, age = varsta} ++", " ++ showPersonA Person{name = nume, age = varsta} ++ ")"

--c monada reader