module Main where

import System.Environment
import Data.List
import Control.Exception
import System.Exit
import Text.Read
import Numeric

import Error
import Automaton

main :: IO ()
main = do
    args <- getArgs
    if (length (args) == 0)
        then usage >> errorExit
    else getArgs >>= (\args -> case getOpts defaultConf args of
        Nothing -> usage >> errorExit
        conf -> case checkRule conf of
            Nothing -> usage >> errorExit
            Just conf@(Conf _ _ _ window _) -> wolfram conf (createString window) 1)

data Conf = Conf { rule :: Maybe Int
                 , start :: Int
                 , line :: Maybe Int
                 , window :: Int
                 , move :: Int
                 } deriving (Show, Read)

defaultConf :: Conf
defaultConf = Conf Nothing 0 Nothing 80 0

getOpts :: Conf -> [String] -> Maybe Conf
getOpts conf [] = Just conf
getOpts conf ("--rule":value:xs) = case readMaybe value :: Maybe Int of 
    Just b -> getOpts (conf {rule = Just b}) xs
    Nothing -> Nothing
getOpts conf ("--start":value:xs) = case readMaybe value :: Maybe Int of 
    Just b -> getOpts (conf {start = b}) xs
    Nothing -> Nothing
getOpts conf ("--lines":value:xs) = case readMaybe value :: Maybe Int of 
    Just b -> getOpts (conf {line = Just b}) xs
    Nothing -> Nothing
getOpts conf ("--window":value:xs) = case readMaybe value :: Maybe Int of 
    Just b -> getOpts (conf {window = b}) xs
    Nothing -> Nothing
getOpts conf ("--move":value:xs) = case readMaybe value :: Maybe Int of 
    Just b -> getOpts (conf {move = b}) xs
    Nothing -> Nothing
getOpts conf _ = Nothing

checkRule :: Maybe Conf -> Maybe Conf
checkRule conf@(Just (Conf (Just rule) _ _ _ _))
    | rule < 0 || rule > 255 = Nothing
    | otherwise = conf
checkRule _ = Nothing

giveRule :: Conf -> String -> String
giveRule conf@((Conf (Just rule) _ _ _ _)) xs = generateNextLine rule xs

wolfram :: Conf -> String -> Int -> IO ()
wolfram conf@((Conf _ _ (Just 0) _ _)) _ _ = return ()
wolfram conf@((Conf _ 0 (Just ln) _ _)) xs nb = displayString conf xs >> wolfram (conf{line = Just (ln - 1)}) (giveRule conf xs) (nb + 1)
wolfram conf@((Conf _ st _ _ _)) xs nb = putStr "" >> wolfram (conf{start = st - 1}) (giveRule conf xs) (nb + 1)

displayString :: Conf -> String -> IO ()
displayString (Conf _ _ _ window move) xs =
    putStrLn $ take window $ drop center xs
    where
        center = (length xs `div` 2 - window `div` 2) + move

createString :: Int -> String
createString window = replicate (window `div` 2) ' ' ++ "■" ++ replicate (window - window `div` 2 - 1) ' '

generateNextLine :: Int -> String -> String
generateNextLine rule xs = map (applyRule rule) (windows xs)

windows :: String -> [(Char, Char, Char)]
windows xs = zip3 padded (tail padded) (tail (tail padded))
  where
    padded = "  " ++ xs ++ "  "
