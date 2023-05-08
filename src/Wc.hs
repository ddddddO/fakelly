module Wc
  ( wc'
  ) where

-- fakelly ls . | fakelly wc
wc' :: [String] -> IO ()
wc' args = do
  stdin <- getContents
  wc stdin

wc :: String -> IO ()
wc = print . length . lines