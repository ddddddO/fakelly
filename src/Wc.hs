module Wc
  ( wc
  ) where

-- fakelly ls . | fakelly wc
wc :: [String] -> IO ()
wc args = do
  stdin <- getContents
  print $ length $ lines stdin
