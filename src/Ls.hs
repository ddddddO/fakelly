module Ls
  ( ls'
  , ls
  ) where

import           System.Directory

-- fakelly ls
-- fakelly ls .
-- fakelly ls src test app
ls' :: [String] -> IO ()
ls' []               = ls "." >>= mapM_ putStrLn
ls' (path:remaining) = do
  ls path >>= mapM_ putStrLn
  case remaining of
    [] -> return ()
    otherwise -> ls' remaining

ls :: String -> IO [String]
ls dir = getDirectoryContents dir
