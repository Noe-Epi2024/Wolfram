module Error
    ( errorExit,
      successExit,
      usage,
    ) where

import Text.Read
import Control.Exception
import System.Exit

errorExit :: IO ()
errorExit = exitWith $ ExitFailure 84

successExit :: IO ()
successExit = exitSuccess

usage :: IO ()
usage = do
    putStrLn "Usage:"
    putStrLn "\t./wolfram -h: get the usage"
    putStrLn "\t./wolfram -rule (nb):   the ruleset to use"
    putStrLn "\t./wolfram -start (nb):  the generation number at which to start the display"
    putStrLn "\t./wolfram -lines (nb):  the number of lines to display"
    putStrLn "\t./wolfram -window (nb): the number of cells to display on each line"
    putStrLn "\t./wolfram -move (nb):   a translation to apply on the window."
    putStrLn "\nDescription:"
    putStrLn "The goal of this project is to implement Wolfram’s elementary cellular automaton in the terminal."