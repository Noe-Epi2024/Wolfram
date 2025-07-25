NAME = wolfram

all:
	cabal build

run:
	cabal run $(NAME) -- --rule 30 --lines 20

clean:
	cabal clean

fclean: clean
	rm -f $(NAME)

re: fclean all
