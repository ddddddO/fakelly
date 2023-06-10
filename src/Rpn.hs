module Rpn
  ( rpn'
  ) where

-- Reverse Polish notation（逆ポーランド記法）
-- fakelly rpn "10 4 3 + 2 * -"
rpn' :: [String] -> IO ()
rpn' []             = print "please enter expression"
rpn' (expression:_) = print $ rpn expression

-- http://learnyouahaskell.com/functionally-solving-problems#reverse-polish-notation-calculator
rpn :: String -> Double
rpn = head . foldl calculate [] . words
  where
    calculate (x:y:zs) "*" = (y * x):zs
    calculate (x:y:zs) "+" = (y + x):zs
    calculate (x:y:zs) "-" = (y - x):zs
    calculate (x:y:zs) "/" = (y / x):zs
    calculate (x:y:zs) "^" = (y ** x):zs
    calculate (x:xs) "ln"  = log x:xs
    calculate xs "sum"     = [sum xs]
    calculate xs numStr    = read numStr:xs