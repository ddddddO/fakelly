module Tree
  ( tree'
  ) where

import           System.Directory
import           Data.List.Split

import           Ls

-- fakelly tree gtree
tree' :: [String] -> IO ()
tree' [] = putStrLn "Specify directory."
tree' args = do
  tree $ head args

tree :: String -> IO ()
tree path = do
  printBranch path
  paths <- ls path
  let dirs = map (\p -> path ++ "/" ++ p) $ filter (\p -> not (p == path || p == "." || p == "..")) paths
  mapM_ (\p -> do
          existsDir <- doesDirectoryExist p
          case existsDir of
            True  -> tree p
            False -> printBranch p
        ) dirs

printBranch :: String -> IO ()
printBranch = putStrLn . branchPath

branchPath :: String -> String
branchPath path =
  let ss = splitOn "/" path
      len = length ss
  in case len of
      1 -> head ss
      _ -> (take ((len-1)*4) $ repeat ' ') ++ last ss

{-

$ fakelly tree gtree
gtree
    tree.go
    testdata
        sample2.md
        sample1.md
    cmd
        gtree
            main.go
    makefile

-}