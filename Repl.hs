module Repl where

import           Calc                           ( getSum )

main :: IO ()
main = do
    putStr "Formula: "
    getLine >>= print . getSum
    main
