module Main (main) where

import System.Environment

import Ls
import Tree
import Wc

command :: String -> [String] -> IO ()
command "ls" = ls'
command "tree" = tree'
command "wc" = wc
command xxx = \_ -> putStrLn $ "'" ++ xxx ++ "'" ++ " is not implemented."

main :: IO ()
main = do
  (cmd:args) <- getArgs
  command cmd args
