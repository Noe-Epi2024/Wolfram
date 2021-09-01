module Main where

import System.Environment
import Data.List
import Control.Exception
import System.Exit
import Text.Read
import Numeric

import Error

import Rule

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
checkRule conf@(Just (Conf (Just 30) _ _ _ _)) = conf -- (rule30 ("  " ++ xs)) (nb + 1)
checkRule conf@(Just (Conf (Just 90) _ _ _ _)) = conf
checkRule conf@(Just (Conf (Just 110) _ _ _ _)) = conf
checkRule conf@(Just (Conf rule _ _ _ _))
    | rule /= Just 30 = Nothing 
    | rule /= Just 90 = Nothing 
    | rule /= Just 110 = Nothing 
    | otherwise = conf

giveRule :: Conf -> String -> String
giveRule conf@((Conf (Just 30) _ _ _ _)) xs = rule30 ("  " ++ xs)
giveRule conf@((Conf (Just 90) _ _ _ _)) xs = rule90 ("  " ++ xs)
giveRule conf@((Conf (Just 110) _ _ _ _)) xs = rule110 ("  " ++ xs)

wolfram :: Conf -> String -> Int -> IO ()
wolfram conf@((Conf _ _ (Just 0) _ _)) _ _ = return ()
wolfram conf@((Conf _ 0 (Just ln) _ _)) xs nb = displayString xs nb >> wolfram (conf{line = Just (ln - 1)}) (giveRule conf xs) (nb + 1)
wolfram conf@((Conf _ st _ _ _)) xs nb = putStr "" >> wolfram (conf{start = st - 1}) (giveRule conf xs) (nb + 1)

displayString :: String -> Int -> IO ()
displayString xs nb = putStrLn (take (length xs - ((nb * 2) - 2)) (drop (nb - 1) xs))

createString :: Int -> String
createString 0 = []
createString nb
    | even nb = replicate (nb `div` 2) ' ' ++ "*" ++ replicate ((nb `div` 2) - 1) ' '
    | otherwise = replicate (nb `div` 2) ' ' ++ "*" ++ replicate (nb `div` 2) ' '