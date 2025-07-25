module Automaton
  ( patternToIndex
  , intToBinary
  , applyRule
  ) where

import Data.Bits (testBit)

-- | convert a pattern of three characters into an index between 0 and 7
patternToIndex :: (Char, Char, Char) -> Int
patternToIndex (l, c, r) = bit l 2 + bit c 1 + bit r 0
  where
    bit '■' i = 2 ^ i
    bit _ i = 0

intToBinary :: Int -> [Int]
intToBinary n = map (isBinary n) [7,6..0]
  where
    isBinary x i = if testBit x i then 1 else 0

applyRule :: Int -> (Char, Char, Char) -> Char
applyRule rule (l, c, r) =
    let
      binary = intToBinary rule
      index = patternToIndex (l, c, r)
      reverseBinary = reverse binary
    in
      if reverseBinary !! index == 1 then '■' else ' '