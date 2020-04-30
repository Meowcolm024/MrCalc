module Example where

import           Calc                           ( getSum )

main :: IO ()
main = mapM_ (putStrLn . getResult)
             ["Fe", "H2O", "H2SO4", "(NH4)2CO3", "Fe3[Fe(CN)6]2"]

getResult :: String -> String
getResult x = x ++ " : " ++ show (getSum x)
