let random n = Random.self_init (); Random.int n 
let get_word list =
  let len = List.length list in 
  let index = random len in
  List.nth list index

let total_lives word = String.length (String.fold_left (fun b a -> if String.contains b a then b else b ^ String.make 1 a) ("") (word))

let initial_blanks word = 
    let rec loop n s = if n < 1 then s else loop (n - 1) (s^"-") in loop (String.length word) ("") 

let rec guess () = 
  let line = (print_string "\nGuess: "; read_line ()) in
    if Str.string_match (Str.regexp "^[a-z]$") (line) 0 then line else guess () 

let letters_used guess list = (if List.mem guess list then list else guess :: list)

let lives_remaining previous_lives guess word = if String.contains (word) (String.get guess 0) then previous_lives else previous_lives - 1
  
let blank_spaces_filled previous_blank guess word =   
  let word_list = Str.split (Str.regexp "") word in
  let previous_b_list = Str.split (Str.regexp "") previous_blank in
  let rec loop w_list p_list =
      match w_list, p_list with
      | [], [] -> []
      | x :: l1, y :: l2 -> if x = guess then x :: loop l1 l2 else y :: loop l1 l2 
      | _, _ -> failwith "unreachable"
  in String.concat "" (loop word_list previous_b_list)

  let rec hang life blanks used_letters word = if blanks = word 
  then 
    ((print_endline (Printf.sprintf "\nYou have %d lives left and have used the following letters: %s" life (String.concat " " used_letters)));
    (print_endline (Printf.sprintf "Current word: %s" blanks));true) 
  else if life = 0 
    then
      ((print_endline (Printf.sprintf "\nYou have %d lives left and have used the following letters: %s" life (String.concat " " used_letters)));
    (print_endline (Printf.sprintf "The word is : %s" word));false)
    else 
      ((print_endline (Printf.sprintf "\nYou have %d lives left and have used the following letters: %s" life (String.concat " " used_letters)));
      (print_endline (Printf.sprintf "Current word: %s" blanks));
      let guess1 = guess () in
      (hang (lives_remaining life guess1 word) (blank_spaces_filled blanks guess1 word) (letters_used guess1 used_letters) word))

let hangman () = 
  let word = get_word Dictionary.words in
  print_string (Printf.sprintf "Welcome to hangman.\nOnly lower case letters allowed\n"); hang (total_lives word) (initial_blanks word) [] (word)
