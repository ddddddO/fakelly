module Tree
  ( tree'
  ) where

import           Data.List.Split
import           System.Directory

import           Ls

-- fakelly tree
-- fakelly tree gtree src
tree' :: [String] -> IO ()
tree' []   = tree "."
tree' args = mapM_ tree args

tree :: String -> IO ()
tree path = do
  printBranch path
  ls path >>= mapM_ (\p -> do
          existsDir <- doesDirectoryExist p
          if existsDir
            then tree p
            else printBranch p
        ) . listDirs path
  where
    listDirs :: String -> [String] -> [String]
    listDirs current paths = fmap (\p -> current <> "/" <> p) $ filter (\p -> p `notElem` [current, ".", ".."]) $ paths

printBranch :: String -> IO ()
printBranch = putStrLn . branchPath

branchPath :: String -> String
branchPath path =
  (take (len path) $ repeat ' ') <> (last $ split path)
  where
    split = splitOn "/"
    len p = ((length . split $ p) - 1) * 4


{-

$ fakelly tree gtree src
gtree
    tree.go
    testdata
        sample2.md
        sample1.md
    cmd
        gtree
            main.go
    makefile
src
    Ls.hs
    Interpreter
        Lexer.hs
    Tree.hs
    Wc.hs

-}
