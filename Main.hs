module Main where

import           Calc                           ( calcMr )
import           System.IO                      ( hFlush
                                                , stdout
                                                )

main :: IO ()
main = flushStr "Mr Calculator\n" >> runRepl

runRepl :: IO ()
runRepl = readPrompt "Formula> " >>= \x -> case x of
    ""   -> runRepl
    ":q" -> flushStr "Bye bye\n"
    ":e" -> example >> runRepl
    ":h" -> help >> runRepl
    _    -> flushStr (show (calcMr x) ++ "\n") >> runRepl

example :: IO ()
example = mapM_ (putStrLn . getResult)
                ["Fe", "H2O", "H2SO4", "(NH4)2CO3", "Fe3[Fe(CN)6]2", "CuSO4.5H2O"]
  where
    getResult :: String -> String
    getResult x = x ++ ": " ++ show (calcMr x)

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
