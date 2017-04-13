open Ixl_t ;;
open Utils_IXL ;;
open Parsing;;
open Lexer_IXL;;

let in_IXL_channel = ref stdin ;;

let eq_list = ref([]: (Ixl.equations));;
let end_loop = ref true;;

(* value 0 reserved for no rank in ident structure *) 
let ind = ref 1;;

 
let parse_IXL in_IXL_channel =
  (* Parse of the IXL file *)
  let current_expr_lexbuf = Lexing.from_channel in_IXL_channel in
  begin
    try
      let equations = Parser_IXL.toplevel_phrase
		       Lexer_IXL.token current_expr_lexbuf
      in 
	  equations
    with
      | Parsing.Parse_error -> 
	Format.printf "Syntax error at line '%i' @." !Lexer_IXL.line; exit 0
      | Lexer_IXL.LexError -> 
	Format.printf "Lexical error at line '%i' @." !Lexer_IXL.line; exit 0
      | Lexer_IXL.Unterminated_comment -> 
	Format.printf "Unterminated comment@." ; exit 0
  end;
;;

let mainloop in_IXL_channel =
	let equation_l = 
	  if (in_IXL_channel <> stdin) then
	     parse_IXL in_IXL_channel
	  else
	  begin
	    Format.printf "option -i  mandatory.\n";
		exit(0)
      end
	in
    Utils_IXL.print_eqs equation_l	
;;

Arg.parse 
 [("-i", 
   Arg.String(fun f_in_name -> in_IXL_channel := open_in f_in_name;),
   " : IXL input file");
 ]
  (fun f_other -> ())
  "Glop pas glop..." ;

mainloop !in_IXL_channel;;
