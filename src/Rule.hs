module Rule
    ( rule30,
      rule90,
      rule110,
    ) where

rule30 :: String -> String
rule30 [] = []
rule30 s@('*':'*':'*':a) = ' ':rule30 (tail s)
rule30 s@('*':'*':' ':a) = ' ':rule30 (tail s)
rule30 s@('*':' ':'*':a) = ' ':rule30 (tail s)
rule30 s@('*':' ':' ':a) = '*':rule30 (tail s)
rule30 s@(' ':'*':'*':a) = '*':rule30 (tail s)
rule30 s@(' ':'*':' ':a) = '*':rule30 (tail s)
rule30 s@(' ':' ':'*':a) = '*':rule30 (tail s)
rule30 s@(' ':' ':' ':a) = ' ':rule30 (tail s)
rule30 s@[_,_] = s
rule30 [s] = [s]

rule90 :: String -> String
rule90 [] = []
rule90 s@('*':'*':'*':a) = ' ':rule90 (tail s)
rule90 s@('*':'*':' ':a) = '*':rule90 (tail s)
rule90 s@('*':' ':'*':a) = ' ':rule90 (tail s)
rule90 s@('*':' ':' ':a) = '*':rule90 (tail s)
rule90 s@(' ':'*':'*':a) = '*':rule90 (tail s)
rule90 s@(' ':'*':' ':a) = ' ':rule90 (tail s)
rule90 s@(' ':' ':'*':a) = '*':rule90 (tail s)
rule90 s@(' ':' ':' ':a) = ' ':rule90 (tail s)
rule90 s@[_,_] = s
rule90 [s] = [s]

rule110 :: String -> String
rule110 [] = []
rule110 s@('*':'*':'*':a) = ' ':rule110 (tail s)
rule110 s@('*':'*':' ':a) = '*':rule110 (tail s)
rule110 s@('*':' ':'*':a) = '*':rule110 (tail s)
rule110 s@('*':' ':' ':a) = ' ':rule110 (tail s)
rule110 s@(' ':'*':'*':a) = '*':rule110 (tail s)
rule110 s@(' ':'*':' ':a) = '*':rule110 (tail s)
rule110 s@(' ':' ':'*':a) = '*':rule110 (tail s)
rule110 s@(' ':' ':' ':a) = ' ':rule110 (tail s)
rule110 s@[_,_] = s
rule110 [s] = [s]