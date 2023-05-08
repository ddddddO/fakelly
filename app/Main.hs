module Main (main) where

import           System.Environment

import           Ls
import           Tree
import           Wc

dispatch :: String -> [String] -> IO ()
dispatch "ls"   = ls'
dispatch "tree" = tree'
dispatch "wc"   = wc'
-- TODO: 以下で、入力をパースして何かできるようにしたい。例えば、「stack exec fakelly 'ls . | wc'」が評価できるような。
--       インタプリタ作るような？ https://github.com/ddddddO/monkey たぶんこの本が役立ちそう
dispatch xxx    = \_ -> putStrLn $ "'" ++ xxx ++ "'" ++ " is not implemented."

main :: IO ()
main = do
  (cmd:args) <- getArgs
  dispatch cmd args
