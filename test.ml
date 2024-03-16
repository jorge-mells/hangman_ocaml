try
  (match Sys.argv with
  | [|test|] -> if Hang_mod.hangman () then print_string "You win\n" else print_string "You lose\n"
  | _ -> print_string "Usage: <./test>"
  )
with _ -> print_endline "should be unreachable"