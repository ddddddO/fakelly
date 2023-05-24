module Main (main) where

import           Data.Char
import           System.Environment

import           Cat
import           Ls
import           Tree
import           Wc

dispatch :: String -> [String] -> IO ()
dispatch "ls"   = ls'
dispatch "tree" = tree'
dispatch "wc"   = wc'
dispatch "cat"  = cat'
-- TODO: 以下で、入力をパースして何かできるようにしたい。例えば、「stack exec fakelly 'ls . | wc'」が評価できるような。
--       インタプリタ作るような？ https://github.com/ddddddO/monkey たぶんこの本が役立ちそう
dispatch xxx    = \_ -> putStrLn $ "'" ++ xxx ++ "'" ++ " is not implemented."

main :: IO ()
main = do
  (cmd:args) <- getArgs
  dispatch cmd args


----------------------------------

-- ghci> lazyIO
-- aArRtTfFkK
lazyIO :: IO ()
lazyIO = do
  xs <- getContents
  putStrLn $ map toUpper xs

-- ghci> lazyIO'
-- aAfFrRkKlL
lazyIO' :: IO ()
lazyIO' = interact $ map toUpper