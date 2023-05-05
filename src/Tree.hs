module Tree
  ( tree'
  ) where

import System.Directory

import Ls

tree' :: [String] -> IO ()
tree' [] = putStrLn "Specify directory."
tree' args = do
  tree $ head args

tree :: String -> IO ()
tree path = do
  putStrLn path
  paths <- ls path
  let dirs = map (\p -> path ++ "/" ++ p) $ filter (\p -> not (p == path || p == "." || p == "..")) paths
  mapM_ (\p -> do
          existsDir <- doesDirectoryExist p
          case existsDir of
            True  -> tree p
            False -> putStrLn p
        ) dirs
-- ghci> :l Main.hs
-- ghci> tree "gtree"
-- gtree
-- gtree/tree.go
-- gtree/testdata
-- gtree/testdata/sample2.md
-- gtree/testdata/sample1.md
-- gtree/cmd
-- gtree/cmd/gtree
-- gtree/cmd/gtree/main.go
-- gtree/makefile
