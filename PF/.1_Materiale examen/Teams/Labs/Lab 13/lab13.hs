{-
What does a MONAD do?

1. It gets us from point A to point B (past and future)
2. It gives us control over the computation (monad vs applicative)
3. It makes the syntax simpler (do blocks and just bind op in general)
-}

{- Monada Maybe este definita in GHC.Base

class Applicative m => Monad m where
  (>>=) :: m a -> (a -> m b) -> m b
    -- we get something wrapped
    -- we get that something from the wrapper
    -- based on it, we create a new something
    -- we wrap it
    -- we throw out the new wrapped something

  (>>) :: m a -> m b -> m b
  return :: a -> m a
instance Monad Maybe where
  return = Just
  Just va >>= k   = k va
  Nothing >>= _   = Nothing


class Functor f => Applicative f where
  pure :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b
instance Applicative Maybe where
  pure = return
  mf <*> ma = do
    f <- mf
    va <- ma
    return (f va)

instance Functor Maybe where
  fmap f ma = pure f <*> ma
-}

-- Let's discuss this example:
safeRootPlus10Div2 :: Double -> Maybe Double
safeRootPlus10Div2 x =
  case safeRoot x of
    Nothing -> error "The input is less than 0"
    Just s  ->
      let r = s + 10
      in
        case is5 r of
          Nothing -> Nothing
          Just r -> return (r / 2)

safeRootPlus10Div2Do :: Double -> Maybe Double
safeRootPlus10Div2Do x = do
  s <- case safeRoot x of
    Nothing -> error "The input is less than 0"
    Just val  -> return val
  r <- is5 (s + 10)
  return (r / 2)

safeRoot :: Double -> Maybe Double
safeRoot x
  | x < 0     = Nothing
  | otherwise = Just (sqrt x)

is5 :: Double -> Maybe Double
is5 x
  | x == 5 = Just 5
  | otherwise = Nothing




-- Exercises

pos :: Int -> Bool
pos  x = if (x>=0) then True else False

fct :: Maybe Int ->  Maybe Bool
fct  mx =  mx  >>= (\x -> Just (pos x))

fct' :: Maybe Int ->  Maybe Bool
fct' mx = do
  x <- mx
  return (pos x)


addM :: Maybe Int -> Maybe Int -> Maybe Int
addM (Just x) (Just y) = Just (x+y)
addM _ _ = Nothing

addM':: Maybe Int -> Maybe Int -> Maybe Int
addM' mx my = do
  x <- mx
  y <- my
  return (x+y)

addM'' :: Maybe Int -> Maybe Int -> Maybe Int
addM'' mx my = mx >>= (\x -> my >>= (\y -> return (x + y)))

cartesian_product xs ys = xs >>= ( \x -> (ys >>= \y-> return (x,y)))
cartesian_product' xs ys = do
  x <- xs
  y <- ys
  return (x, y)

prod f xs ys = [f x y | x <- xs, y<-ys]
prod' f xs ys = do
  x <- xs
  y <- ys
  return $ f x y

myFunc a b = a * b
myProd = prod' myFunc [4,5] [5,6]

myGetLine :: IO String
myGetLine = getChar >>= \x ->
      if x == '\n' then
          return []
      else
          myGetLine >>= \xs -> return (x:xs)

myGetLine' :: IO String
myGetLine' = do
    x <- getChar
    if x == '\n' then
        return []
    else
        do
            xs <- myGetLine'
            return (x:xs)

prelNo noin =  sqrt noin

ioNumber = do
    noin  <- readLn :: IO Float
    putStrLn $ "Intrare\n" ++ (show noin)
    let  noout = prelNo noin
    putStrLn $ "Iesire"
    print noout

ioNumber' =
  (readLn :: IO Float) >>=
  \noin -> putStrLn ("Intrare\n" ++ show noin) >>
  let noout = prelNo noin
    in
      putStrLn "Iesire" >>
      print noout