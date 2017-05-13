-- type declaration in a package
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

      Sensor(0).dir <= "00";
      Sensor(1).dir <= "00";
      Sensor(2).dir <= "00";
      Sensor(3).dir <= "00";
      Sensor(4).dir <= "00";
      Sensor(5).dir <= "00";
      Sensor(6).dir <= "00";
      Sensor(7).dir <= "00";
      Sensor(8).dir <= "00";
      Sensor(9).dir <= "00";
      Sensor(10).dir <= "00";
      Sensor(11).dir <= "00";
      Sensor(12).dir <= "00";
      Sensor(13).dir <= "00";
      Sensor(14).dir <= "00";
      Sensor(15).dir <= "00";
      Sensor(16).dir <= "00";
      Sensor(17).dir <= "00";
      Sensor(18).dir <= "00";
      Sensor(19).dir <= "00";

      CLK <= not CLK;
      wait for 1 ns;
      CLK <= not CLK;
      wait for 1 ns;
      report "Cycle 1: --reset the circuit";
      Sensor(0).dir <= "01";

      CLK <= not CLK;
      wait for 1 ns;


      CLK <= not CLK;
      wait for 1 ns;
      report "Cycle 2:";
      Sensor(0).dir <= "00";
      Sensor(1).dir <= "01";

      CLK <= not CLK;
      wait for 1 ns;
      if (TC_out(0) = '0') then report "-- TC01 occupied" & " : Pass"; else report "-- TC01 occupied" & " : Fail."; end if;


      CLK <= not CLK;
      wait for 1 ns;
      report "Cycle 3: -- move train from TC1 to TC 2 forward";
      Sensor(1).dir <= "00";

      CLK <= not CLK;
      wait for 1 ns;
      if (TC_out(0) = '1') then report "-- TC01 free" & " : Pass"; else report "-- TC01 free" & " : Fail."; end if;
      if (TC_out(1) = '0') then report "-- TC02 occupied" & " : Pass"; else report "-- TC02 occupied" & " : Fail."; end if;


      CLK <= not CLK;
      wait for 1 ns;
      report "Cycle 4: -- train in TC 2";
      Sensor(1).dir <= "10";

      CLK <= not CLK;
      wait for 1 ns;
      if (TC_out(0) = '1') then report "-- TC01 free" & " : Pass"; else report "-- TC01 free" & " : Fail."; end if;
      if (TC_out(1) = '0') then report "-- TC02 occupied" & " : Pass"; else report "-- TC02 occupied" & " : Fail."; end if;


      CLK <= not CLK;
      wait for 1 ns;
      report "Cycle 5: --move train from TC2 to TC 1 in reverse";

      CLK <= not CLK;
      wait for 1 ns;
      if (TC_out(0) = '0') then report "-- TC01 occupied" & " : Pass"; else report "-- TC01 occupied" & " : Fail."; end if;
      if (TC_out(1) = '1') then report "-- TC02 free" & " : Pass"; else report "-- TC02 free" & " : Fail."; end if;


      CLK <= not CLK;
      wait for 1 ns;
      report "Cycle 5:";

      CLK <= not CLK;
      wait for 1 ns;


      CLK <= not CLK;
      wait for 1 ns;
      report "Cycle 6:";

      CLK <= not CLK;
      wait for 1 ns;


      CLK <= not CLK;
      wait for 1 ns;
    
    wait;
  end process;
end simu;
