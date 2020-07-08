module Parser
    ( calcMr
    )
where

import           Text.Parsec.String
import           Text.ParserCombinators.Parsec
import           Data.Maybe                     ( fromMaybe
                                                , maybe
                                                )
import           Text.Read                      ( readMaybe )
import           Data.Char                      ( isDigit )
import           MrData                         ( getWeight )

data Chem = Atom String | Comp Chem Int | Par [Chem] Int deriving Show

regularParse :: Parser a -> String -> Either ParseError a
regularParse p = parse p "(unknown)"

parseChem :: Parser [Chem]
parseChem = many1 . choice $ [try parens2, try parens, context]

parens :: Parser Chem
parens =
    (\x n -> Par x (maybe 1 read n))
        <$> (char '(' *> many1 context)
        <*> (char ')' *> (optionMaybe . many1 . oneOf) ['0' .. '9'])

parens2 :: Parser Chem
parens2 =
    (\x n -> Par x (maybe 1 read n))
        <$> (char '[' *> (many1 . choice) [try parens, context])
        <*> (char ']' *> (optionMaybe . many1 . oneOf) ['0' .. '9'])

context :: Parser Chem
context =
    (\a b n -> maybe (Comp (Atom [a]) (maybe 1 read n))
                     (\x -> Comp (Atom [a, x]) (maybe 1 read n))
                     b
        )
        <$> oneOf ['A' .. 'Z']
        <*> (optionMaybe . oneOf) ['a' .. 'z']
        <*> (optionMaybe . many1 . oneOf) ['0' .. '9']

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

lM2ML :: [Maybe a] -> Maybe [a]
lM2ML = foldr (\x -> (<*>) ((:) <$> x)) (Just [])

getSum :: String -> Maybe Float
getSum = fmap sum . lM2ML . map weight . render

weight :: Chem -> Maybe Float
weight (Atom x  ) = getWeight x
weight (Comp x i) = (* fromIntegral i) <$> weight x
weight (Par xs i) =
    (* fromIntegral i)
        <$> foldr ((\x -> (<*>) ((+) <$> x)) . weight) (Just 0) xs

render :: String -> [Chem]
render x = case regularParse parseChem x of
    Right g -> g
    Left  _ -> []

calcMr :: String -> Maybe Float
calcMr =
    fmap sum
        . lM2ML
        . map ((\(x, y) -> (* fromIntegral x) <$> getSum y) . sepLeadnum)
        . sepDot
