module Example where

import Calc (getSum)

main :: IO()
main = do
    putStrLn $ "Fe : " ++ show (getSum "Fe")
    putStrLn $ "H2O : " ++ show (getSum "H2O")
    putStrLn $ "H2SO4 : " ++ show (getSum "H2SO4")
    putStrLn $ "(NH4)2CO3 : " ++ show (getSum "(NH4)2CO3")
    putStrLn $ "Fe3[Fe(CN)6]2 : " ++ show (getSum "Fe3[Fe(CN)6]2")
