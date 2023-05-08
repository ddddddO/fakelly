module Tree
  ( tree'
  ) where

import           Data.List.Split
import           System.Directory

import           Ls

-- fakelly tree
-- fakelly tree .
tree' :: [String] -> IO ()
tree' []               = tree "."
tree' (path:remaining) = tree path -- TODO: 引数に指定した複数のパスをtreeするのもいいかも

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
branchPath path = branch
  where
    branch :: String
    branch = (take ((len-1)*4) $ repeat ' ') ++ last ss

    ss = splitOn "/" path
    len = length ss


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
