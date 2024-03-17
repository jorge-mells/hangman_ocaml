let () =
  let won = Hang_mod.hangman () in
  if won then print_endline "You win" else print_endline "You lose. Better luck next time."
