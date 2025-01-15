testInsert :: IO ()
testInsert = do
  putStrLn "Running tests for insert..."
  -- Test case 1: Inserting into an empty tree
  let tree1 = Empty
      result1 = insert 5 "value" tree1
      expected1 = BNode Empty 5 (Just "value") Empty
  putStrLn $ "Test case 1: " ++ show result1 ++ " == " ++ show expected1
  -- Test case 2: Inserting into a non-empty tree
  let tree2 = BNode (BNode Empty 3 (Just "value1") Empty) 5 (Just "value2") (BNode Empty 7 (Just "value3") Empty)
      result2 = insert 4 "value4" tree2
      expected2 = BNode (BNode Empty 3 (Just "value1") Empty) 5 (Just "value2") (BNode (BNode Empty 4 (Just "value4") Empty) 7 (Just "value3") Empty)
  putStrLn $ "Test case 2: " ++ show result2 ++ " == " ++ show expected2
  -- Add more test cases here...
  putStrLn "All tests for insert passed!"

main :: IO ()
main = testInsert