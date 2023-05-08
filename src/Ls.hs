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
ls' (path:remaining) = do -- TODO: 引数に指定した複数のパスをtreeするのもいいかも
  dirs <- ls path
  mapM_ putStrLn dirs

ls :: String -> IO [String]
ls dir = do
  dirs <- getDirectoryContents dir
  return dirs
