module MrData
  ( getWeight
  )
where

import qualified Data.Map                      as M

getWeight :: String -> Maybe Int
getWeight e = M.lookup e elements

elements :: M.Map String Int
elements = M.fromList elementsData

elementsData :: [(String, Int)]
elementsData =
  [ ("H" , 1)
  , ("Li", 7)
  , ("Be", 9)
  , ("B", 11)
  , ("C" , 12)
  , ("N" , 14)
  , ("O" , 16)
  , ("F", 19)
  , ("Na", 23)
  , ("Mg", 24)
  , ("Al", 27)
  , ("Si", 28)
  , ("P" , 31)
  , ("S" , 32)
  , ("Cl", 36)  -- 35.5
  , ("K" , 39)
  , ("Ca", 40)
  , ("Cr", 52)
  , ("Mn", 55)
  , ("Fe", 56)
  , ("Cu", 64)
  , ("Br", 80)
  , ("Ag", 108)
  , ("Pb", 207)
  ]
