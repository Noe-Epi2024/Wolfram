{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_wolfram (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "wolfram"
version :: Version
version = Version [0,1,0,0] []

synopsis :: String
synopsis = "Terminal cellular automaton"
copyright :: String
copyright = ""
homepage :: String
homepage = ""
