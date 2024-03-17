.PHONY: all clean

all: hangman.out

hangman.out: dictionary.ml hang_mod.ml hangman.ml
	ocamlc -I +str str.cma dictionary.ml hang_mod.ml hangman.ml -o hangman.out

clean:
	rm -f *.cmo *.cmi hangman.out

