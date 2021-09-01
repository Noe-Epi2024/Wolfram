# Wolfram

### The goal of this project is to implement Wolfram’s elementary cellular automaton in the terminal.

What is cellular automaton ?
A cellular automaton consists of a regular grid of “cells” each containing a “state” chosen
from a finite set and which can change over time.

### How to use it ?

* ./wolfram -h: get the usage
* ./wolfram -rule (nb):   the ruleset to use
* ./wolfram -start (nb):  the generation number at which to start the display
* ./wolfram -lines (nb):  the number of lines to display
* ./wolfram -window (nb): the number of cells to display on each line
* ./wolfram -move (nb):   a translation to apply on the window.
* Example: ./wolfram --rule 30 --lines 20

> Projet made in Haskell Language
