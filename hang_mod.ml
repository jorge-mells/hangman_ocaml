let explode s = List.of_seq (String.to_seq s)
let rec implode l = String.of_seq (List.to_seq l)
let random n = Random.int n

let load_words file =
  let ic = open_in file in
  let rec loop acc =
    try
      let line = input_line ic in
      loop (line :: acc)
    with End_of_file -> acc
  in
  let words = loop [] in
  close_in ic;
  words

let get_word list =
  let len = List.length list in
  let index = random len in
  List.nth list index

let total_lives word =
  String.length
    (String.fold_left
       (fun b a -> if String.contains b a then b else b ^ String.make 1 a)
       "" word)

let initial_blanks word =
  let rec loop n s = if n < 1 then s else loop (n - 1) (s ^ "-") in
  loop (String.length word) ""

let rec guess () =
  let line =
    print_string "\nGuess: ";
    read_line ()
  in
  if String.length line > 1 then guess ()
  else
    let line = String.lowercase_ascii line in
    line.[0]

let letters_used guess list =
  if List.mem guess list then list else guess :: list

let lives_remaining previous_lives guess word =
  if String.contains word guess then previous_lives else previous_lives - 1

let blank_spaces_filled previous_blank guess word =
  let word_list = explode word in
  let previous_b_list = explode previous_blank in
  let rec loop w_list p_list =
    match (w_list, p_list) with
    | [], [] -> []
    | x :: l1, y :: l2 -> if x = guess then x :: loop l1 l2 else y :: loop l1 l2
    | _, _ -> failwith "unreachable"
  in
  implode (loop word_list previous_b_list)

let rec hang life blanks used_letters word =
  let used_letter_str =
    List.sort_uniq compare used_letters
    |> List.map (String.make 1)
    |> String.concat " "
  in
  Printf.printf
    "You have %d lives left and have used the following letters: %s\n" life
    used_letter_str;
  if life = 0 then (
    Printf.printf "The word was: %s\n" word;
    false)
  else (
    Printf.printf "Current word: %s\n" blanks;
    if blanks = word then true
    else
      let guess1 = guess () in
      hang
        (lives_remaining life guess1 word)
        (blank_spaces_filled blanks guess1 word)
        (letters_used guess1 used_letters)
        word)

let hangman () =
  (* init once at the start *)
  Random.self_init ();
  Printf.printf "Welcome to hangman.\n";
  let word = get_word (load_words "dictionary.txt") in
  hang (total_lives word) (initial_blanks word) [] word
