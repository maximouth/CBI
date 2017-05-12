open Simul_t ;;

(* Print the header of the VHDL file *)
let print_header out_chan =
Printf.fprintf out_chan 
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


(* Generate the cycles *)
let rec generate_cycles out_channel cycles =
match cycles with
| [] -> ()
| c::[] -> ()
| c1::c2::t -> 
   generate_cycles out_channel (c2::t)
;;


let generate out_channel cycles =
  print_header out_channel;
  generate_cycles out_channel cycles; 
  print_trailer out_channel
;;
 




