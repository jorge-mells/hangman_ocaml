.PHONY: all clean

all: hangman.out

hangman.out: hang_mod.ml hangman.ml
	ocamlc hang_mod.ml hangman.ml -o hangman.out

clean:
	rm -f *.cmo *.cmi hangman.out

