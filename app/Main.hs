module Main (main) where

import System.Environment

import Ls
import Tree
import Wc

command :: String -> [String] -> IO ()
command "ls" = ls'
command "tree" = tree'
command "wc" = wc
-- TODO: 以下で、入力をパースして何かできるようにしたい。例えば、「stack exec fakelly 'ls . | wc'」が評価できるような。
--       インタプリタ作るような？ https://github.com/ddddddO/monkey たぶんこの本が役立ちそう
command xxx = \_ -> putStrLn $ "'" ++ xxx ++ "'" ++ " is not implemented."

main :: IO ()
main = do
  (cmd:args) <- getArgs
  command cmd args
