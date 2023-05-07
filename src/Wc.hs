module Wc
  ( wc
  ) where

-- stack exec fakelly ls . | stack exec fakelly wc
-- fakelly ls . | fakelly wc
wc :: [String] -> IO ()
wc args = do
  stdin <- getContents
  print $ length $ lines stdin
