module Repl where

import           Calc                           ( getSum )

main :: IO ()
main = putStr "Formula: " >> getLine >>= \x -> case x of
    ""  -> main
    "q" -> putStrLn "Bye bye"
    _   -> print (getSum x) >> main
