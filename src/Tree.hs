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
          case existsDir of
            True  -> tree p
            False -> printBranch p
        ) . genDirs
  where
    genDirs :: [String] -> [String]
    genDirs = map (\p -> path ++ "/" ++ p) . filter (\p -> not $ p `elem` [path, ".", ".."])

printBranch :: String -> IO ()
printBranch = putStrLn . branchPath

branchPath :: String -> String
branchPath path = branch
  where
    branch :: String
    branch = (take ((len-1)*4) $ repeat ' ') <> last ss

    ss = splitOn "/" path
    len = length ss


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
