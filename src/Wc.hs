module Wc
  ( wc'
  ) where

-- fakelly ls . | fakelly wc
wc' :: [String] -> IO ()
wc' _ = fmap (length . lines) getContents >>= print
