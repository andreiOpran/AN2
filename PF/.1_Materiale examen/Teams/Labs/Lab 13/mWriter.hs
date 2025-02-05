--- Monada Writer

newtype WriterS a = Writer { runWriter :: (a, String)}
-- newtype WriterS a = Writer { runWriter :: (a, [String])}
  deriving Show

instance Monad WriterS where
  return va = Writer (va, "")
  -- return va = Writer (va, [])
  ma >>= k =
    let (va, log1) = runWriter ma
        (vb, log2) = runWriter (k va)
    in  Writer (vb, log1 ++ log2)


-- Let's run this example
ma :: WriterS Int
ma = Writer (5, "Start - ")

k :: Int -> WriterS Int
k x = Writer (x + 10, "Now add 10")

result = ma >>= k
-- Writer {runWriter = (15,"Start - Now add 10")}


instance Applicative WriterS where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)

instance Functor WriterS where
  fmap f ma = pure f <*> ma


tell :: String -> WriterS ()
tell log = Writer ((), log)
-- tell log = Writer ((), [log])

logIncrement :: Int  -> WriterS Int
logIncrement x = do
  tell ("incremented " ++ show x)
  return (x + 1)

logIncrement' :: Int  -> WriterS Int
logIncrement' x =
  tell ("incremented " ++ show x) >>
  return (x + 1)

logIncrement2 :: Int  -> WriterS Int
logIncrement2 x = do
  x' <- logIncrement x
  logIncrement x'

logIncrementN :: Int -> Int -> WriterS Int
logIncrementN x 1 = logIncrement x
logIncrementN x n = do
  x' <- logIncrement x
  logIncrementN x' (n - 1)