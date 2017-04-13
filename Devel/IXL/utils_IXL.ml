open Ixl_t ;;


let print_dir dir =
match dir with
| Ixl.Up -> "Up"
| Ixl.Down -> "Down"
;;

let print_sw_state st =
match st with
| Ixl.Left  -> "Left"
| Ixl.Right -> "Right"
;;

let print_ident id =
match id with
| Ixl.P_SE(nb, ad, di) -> "P_SE_"^string_of_int(nb)^"_"^string_of_int(ad)^"_"^print_dir(di)
| Ixl.P_TC(nb, ad)     -> "P_SE_"^string_of_int(nb)^"_"^string_of_int(ad)
| _ -> "To do"
;;

let rec print_bool_exp bool_exp =
match bool_exp with
| Ixl.P_IDENT(id)   -> print_ident id
| Ixl.P_NOT(id)     -> "NOT "^(print_ident id)
| Ixl.P_AND(e1, e2) -> (print_bool_exp e1)^" AND "^(print_bool_exp e1)
| Ixl.P_OR(e1, e2)  -> (print_bool_exp e1)^" OR "^(print_bool_exp e1)
;;

let print_eq eq =
  let id = print_ident eq.Ixl.exprname in
  let exp = print_bool_exp eq.Ixl.boolexpr
  in Printf.fprintf stdout "%s <= %s ;\n" id exp
;;
  
let rec print_eqs eq_l =
match eq_l with
| [] -> 
    ()
| t::q -> 
    print_eq t; 
    print_eqs q
;;

