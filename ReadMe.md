# Hangman

A single player hangman game written in OCaml.

The possible words are specified in `dictionary.txt`.
You get as many tries as there are unique letters in the word.

Example game:
```
Welcome to hangman.
You have 6 lives left and have used the following letters: 
Current word: -------

Guess: e
You have 6 lives left and have used the following letters: e
Current word: -e-e---

Guess: a
You have 5 lives left and have used the following letters: a e
Current word: -e-e---

Guess: n
You have 4 lives left and have used the following letters: a e n
Current word: -e-e---

Guess: r
You have 3 lives left and have used the following letters: a e n r
Current word: -e-e---

Guess: i
You have 2 lives left and have used the following letters: a e i n r
Current word: -e-e---

Guess: d
You have 2 lives left and have used the following letters: a d e i n r
Current word: de-e---

Guess: s
You have 1 lives left and have used the following letters: a d e i n r s
Current word: de-e---

Guess: v
You have 1 lives left and have used the following letters: a d e i n r s v
Current word: deve---

Guess: l
You have 1 lives left and have used the following letters: a d e i l n r s v
Current word: devel--

Guess: o
You have 1 lives left and have used the following letters: a d e i l n o r s v
Current word: develo-

Guess: p
You have 1 lives left and have used the following letters: a d e i l n o p r s v
Current word: develop
You win
```