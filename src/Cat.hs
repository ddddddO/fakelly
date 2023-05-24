module Cat
  ( cat'
  ) where

-- fakelly cat Makefile README.md
cat' :: [String] -> IO ()
cat' []       = return ()
cat' (path:remaining) = do
  readFile path >>= putStrLn
  cat' remaining
