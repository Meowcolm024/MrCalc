module Main where

import           Calc                           ( getSum )
import           System.IO

main :: IO ()
main = flushStr "Mr Calculator\n" >> runRepl

runRepl :: IO ()
runRepl = readPrompt "Formula> " >>= \x -> case x of
    ""   -> runRepl
    ":q" -> flushStr "Bye bye"
    ":e" -> example >> runRepl
    ":h" -> help >> runRepl
    _    -> flushStr (show (getSum x) ++ "\n") >> runRepl

example :: IO ()
example = mapM_ (putStrLn . getResult)
                ["Fe", "H2O", "H2SO4", "(NH4)2CO3", "Fe3[Fe(CN)6]2"]
  where
    getResult :: String -> String
    getResult x = x ++ ": " ++ show (getSum x)

help :: IO ()
help = mapM_
    putStrLn
    [ "Help: "
    , "  `:q` to quit"
    , "  `:e` to show examples"
    , "  `:h` to show help"
    ]

flushStr :: String -> IO ()
flushStr str = putStr str >> hFlush stdout

readPrompt :: String -> IO String
readPrompt prompt = flushStr prompt >> getLine
