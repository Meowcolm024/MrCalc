{-# LANGUAGE LambdaCase #-}
module Calc
  ( calcMr
  )
where

import           Data.Char
import           Text.Read                      ( readMaybe )
import           Data.Maybe                     ( fromMaybe )
import           MrData                         ( getWeight )

-- separate elements and numbers
sepElem :: String -> [String]
sepElem []  = []
sepElem [e] = [[e]]
sepElem (a : b : rest) | isUpper a && isLower b = [a, b] : sepElem rest
                       | all isDigit [a, b]     = [a, b] : sepElem rest
                       | otherwise              = [a] : sepElem (b : rest)

-- separate parens [] ()
sepPars :: String -> String -> [String] -> [[String]]
sepPars _ _ [] = []
sepPars l r xs
  | length right < 2 = [left, mid]
  | isDigit . head $ right !! 1 = left : tail cnt : [right !! 1] : sepPars
    l
    r
    (drop 2 right)
  | otherwise = left : tail cnt : sepPars l r (tail right)
 where
  (left, mid  ) = span (/= l) xs
  (cnt , right) = span (/= r) mid

sepAll :: [String] -> [[[String]]]
sepAll =
  filter (not . null) . map (filter (not . null) . sepPars "(" ")") . sepPars
    "["
    "]"

-- see https://stackoverflow.com/questions/60929459/similar-functions-applied-to-nested-list-in-haskell
flat :: (a -> Maybe Int) -> [a] -> [a]
flat _ []  = []
flat _ [x] = [x]
flat readElem (a : b : xs)
  | Just n <- readElem b = replicate n a ++ flat readElem xs
  | otherwise            = a : flat readElem (b : xs)

flatA :: [[[String]]] -> [[[String]]]
flatA = flat readHead
 where
  readHead [] = Nothing
  readHead (n : _) =
    (\case
        []      -> Nothing
        (m : _) -> readMaybe m
      )
      n

flatB :: [[String]] -> [[String]]
flatB = flat readHead
 where
  readHead []      = Nothing
  readHead (n : _) = readMaybe n

flatC :: [String] -> [String]
flatC = flat readMaybe

flattenElems :: String -> [String]
flattenElems = concatMap flatC . concatMap flatB . flatA . sepAll . sepElem

getSum :: String -> Maybe Float
getSum =
  foldr ((\x -> (<*>) ((+) <$> x)) . getWeight) (Just 0)
    . filter (`notElem` ["[", "]", "(", ")"])
    . flattenElems

sepDot :: String -> [String]
sepDot [] = []
sepDot xs = if null r then [l] else l : sepDot (tail r)
  where (l, r) = break (== '.') xs

sepLeadnum :: String -> (Int, String)
sepLeadnum [] = (0, "")
sepLeadnum xs =
  let (m, n) = span isDigit xs
      p      = fromMaybe 1 (readMaybe m :: Maybe Int)
  in  (p, n)

parse :: String -> [(Int, String)]
parse = map sepLeadnum . sepDot

calculate :: [(Int, String)] -> Maybe Float
calculate = foldr
  ((\x -> (<*>) ((+) <$> x)) . (\(x, y) -> (* fromIntegral x) <$> getSum y))
  (Just 0)

calcMr :: String -> Maybe Float
calcMr = calculate . parse
