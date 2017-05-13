open Simul_t ;;

(* Print the header of the VHDL file *)
let print_header out_channel =
Printf.fprintf out_channel 
"-- type declaration in a package
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

use work.IXL_type.all;

entity IXL_tb is
end IXL_tb;

architecture simu of IXL_tb is

  -- synchro   
  signal CLK        :   STD_LOGIC;
  signal reset      :   STD_LOGIC;

  -- input
  signal valid_in   :   STD_LOGIC; 
  signal Sw_Cmd_Req :   STD_LOGIC_VECTOR (7 downto 0);
  signal Sw_State   :   STD_LOGIC_VECTOR (7 downto 0);
  signal Sensor     :   SE_state;

  -- output
  signal valid_out  :   STD_LOGIC;
  signal Sw_Cmd_Aut :   Sw_cmd_aut_t;

  --debug output
  signal TC_out     :   TC_St;

  
begin
  LO : entity work.IXL
    port map (CLK, reset, valid_in, Sw_Cmd_Req, Sw_State, Sensor, valid_out, Sw_Cmd_Aut, TC_out);

  process
  begin

    -- Initialization
    reset <= '1';
    CLK <= '0';
    valid_in <= '0';
    wait for 1 ns;      

    -- Start cycle 1 
    CLK <= not CLK;
    wait for 1 ns;      

    -- end initialization
    
    reset <= '0';
    
    -- Move 1 full cycle 
    for i in 0 to 1 loop
      CLK <= not CLK;
      wait for 1 ns;      
    end loop;
	
	-- start the simulation with a clock at low level
    CLK <= not CLK;
    wait for 1 ns;

    valid_in <= '1';

"
;;

(* Print the trailer of the VHDL file *)
let print_trailer out_channel =
Printf.fprintf out_channel
"    
    wait;
  end process;
end simu;
"
;;

(* Print one event *)
let print_ident_in ident =
match ident with
| Simul.P_SE(nb, _, dir) -> 
  begin
  match dir with
  | Simul.Up   -> "      Sensor("^string_of_int(nb-1)^").dir <= \"01\";\n"
  | Simul.Down -> "      Sensor("^string_of_int(nb-1)^").dir <= \"10\";\n"
  | Simul.Idle -> "      Sensor("^string_of_int(nb-1)^").dir <= \"00\";\n"
  end
| Simul.P_TC(nb, _)      -> "?*&%$!! Error TC not an input"
| Simul.P_SW_CMD(nb, st) ->
  begin
  match st with 
  | Simul.Right -> "      Sw_Cmd_Req("^string_of_int(nb-1)^") <='1';\n"
  | Simul.Left  -> "      Sw_Cmd_Req("^string_of_int(nb-1)^") <='0';\n;"
  end
| Simul.P_SW_ST(nb, st)  -> 
  begin
  match st with 
  | Simul.Right -> "      Sw_State("^string_of_int(nb-1)^") <= '1';\n"
  | Simul.Left  -> "      Sw_State("^string_of_int(nb-1)^") <= '0';\n"
  end
| Simul.P_SW_AUT(nb, st) -> "!@*&* Error SW_AUT never in"
;;


(* Print the event list *)
let rec print_events c =
match c with
| [] -> ""
| e::t ->
  let s = print_ident_in e.Simul.evname
  in s^(print_events t)
;;


let print_ident_out ident =
match ident with
| Simul.P_SE(nb, _, dir) ->  "!@*&* Error TC never in"
| Simul.P_TC(nb, _)      -> "TC_out("^string_of_int(nb-1)^")"
| Simul.P_SW_CMD(nb, st) ->  "!@*&* Error SW_CMD never out"
| Simul.P_SW_ST(nb, st)  ->  "!@*&* Error SW_ST never in" 
| Simul.P_SW_AUT(nb, st) ->
  begin
  match st with 
    | Simul.Right -> "Sw_Cmd_Aut("^string_of_int((nb-1)*2)^")"
    | Simul.Left ->  "Sw_Cmd_Aut("^string_of_int((nb-1)*2 + 1)^")"
  end
;;

(* Print the output list *)
let rec print_outputs c =
match c with
| [] -> "\n"
| o::t ->
  let value = if o.Simul.outval then "\'1\'" else "\'0\'"
  in
  let id = print_ident_out o.Simul.outname
  in
  let s = match o.Simul.comment with
  | None -> ""
  | Some co -> 
     "      if ("^id^" = "^value^") then report \""^co^"\" & \" : Pass\"; else report \""^co^"\" & \" : Fail.\"; end if;\n"
  in 
  s^(print_outputs t)
;;


(* Generate one cycle:
   - generate the event of the current cycle (cc)
   - rising edge of the clock (start cycle)
   - check the outputs of the previous cycle (pc)
   - falling of the clock
*)
let generate_cycle out_channel pc cc =
  let outputs = print_outputs pc.Simul.outputs in
  let events = print_events cc.Simul.events in

  begin
  match cc.Simul.comment with
  | None -> ()
  | Some co -> Printf.fprintf out_channel "      report \"Cycle %i: %s\";\n" pc.Simul.cycle co;
  end;

  Printf.fprintf out_channel "%s" events;
  Printf.fprintf out_channel "
      CLK <= not CLK;
      wait for 1 ns;
";

  Printf.fprintf out_channel "%s" outputs;
  Printf.fprintf out_channel "
      CLK <= not CLK;
      wait for 1 ns;\n";
;;  


(* Generate the cycles *)
let rec generate_cycles out_channel cycles =
match cycles with
| [] -> ()
| c::[] ->
   let c0 = 
      {Simul_t.Simul.cycle = 0;
      Simul_t.Simul.comment = None;
      Simul_t.Simul.events = [];
      Simul_t.Simul.outputs = [];}
   in
   generate_cycle out_channel c c0
| c1::c2::t -> 
   generate_cycle out_channel c1 c2;
   generate_cycles out_channel (c2::t)
;;


let generate out_channel cycles =
  print_header out_channel;
  match cycles with
  | [] ->
    (* Aucun cycle *)
    Printf.fprintf out_channel ""
  | c1::_ ->
    begin
    (* Generate the first inputs *)
    let events = print_events c1.Simul.events 
    in
    Printf.fprintf out_channel "%s" events;
    Printf.fprintf out_channel "
      CLK <= not CLK;
      wait for 1 ns;
      CLK <= not CLK;
      wait for 1 ns;
";
    end;
  generate_cycles out_channel cycles; 
  print_trailer out_channel
;;
 




