module Main where

import           Parser                         ( calcMr )
import           System.IO                      ( hFlush
                                                , stdout
                                                )

main :: IO ()
main = flushStr "Mr Calculator\n" >> runRepl

runRepl :: IO ()
runRepl = readPrompt "Formula> " >>= \x -> case x of
    ""        -> runRepl
    ":q"      -> flushStr "Bye bye\n"
    (':' : l) -> cmd l >> runRepl
    _         -> flushStr (showMr x ++ "\n") >> runRepl

example :: IO ()
example = mapM_
    (putStrLn . showMr)
    ["Fe", "H2O", "H2SO4", "(NH4)2CO3", "Fe3[Fe(CN)6]2", "CuSO4.5H2O"]

help :: IO ()
help = mapM_
    putStrLn
    [ "Help: "
    , "  `:q` to quit"
    , "  `:e` to show examples"
    , "  `:h` to show help"
    ]

cmd :: String -> IO ()
cmd "e" = example
cmd "h" = help
cmd _   = flushStr "(Unknown Command)\n"

flushStr :: String -> IO ()
flushStr str = putStr str >> hFlush stdout

readPrompt :: String -> IO String
readPrompt prompt = flushStr prompt >> getLine

showMr :: String -> String
showMr x = case calcMr x of
    Nothing -> "(unknown)"
    Just 0  -> "(unknown)"
    Just y  -> x ++ ": " ++ show y
