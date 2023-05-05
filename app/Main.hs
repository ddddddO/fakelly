module Main (main) where

import System.Environment

import Lib

command :: String -> [String] -> IO ()
command "ls" = ls'
command "tree" = tree'
command xxx = \_ -> putStrLn $ "'" ++ xxx ++ "'" ++ " is not implemented."

main :: IO ()
main = do
  (cmd:args) <- getArgs
  command cmd args
