module Ls
  ( ls'
  , ls
  ) where

import           System.Directory

-- fakelly ls
-- fakelly ls .
ls' :: [String] -> IO ()
ls' [] = do
  dirs <- ls "."
  mapM_ putStrLn dirs
ls' args = do
  dirs <- ls $ head args
  mapM_ putStrLn dirs

ls :: String -> IO [String]
ls dir = do
  dirs <- getDirectoryContents dir
  return dirs
