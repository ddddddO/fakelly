module Ls
  ( ls'
  , ls
  ) where

import           System.Directory

-- fakelly ls
-- fakelly ls .
ls' :: [String] -> IO ()
ls' []               = ls "." >>= mapM_ putStrLn
ls' (path:remaining) = ls path >>= mapM_ putStrLn -- TODO: 引数に指定した複数のパスをlsするのもいいかも

ls :: String -> IO [String]
ls dir = do
  dirs <- getDirectoryContents dir
  return dirs
