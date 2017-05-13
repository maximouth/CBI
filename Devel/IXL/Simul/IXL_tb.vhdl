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


      CLK <= not CLK;
      wait for 1 ns;
      CLK <= not CLK;
      wait for 1 ns;
      report "Cycle 0: -- Enter TC07 from SE_08";
      Sensor(7).dir <= "01";

      CLK <= not CLK;
      wait for 1 ns;


      CLK <= not CLK;
      wait for 1 ns;
      report "Cycle 1: -- Train in TC07";
      Sensor(7).dir <= "00";

      CLK <= not CLK;
      wait for 1 ns;
      if (TC_out(6) = '0') then report "-- TC07 is occupied" & " : Pass"; else report "-- TC07 is occupied" & " : Fail."; end if;


      CLK <= not CLK;
      wait for 1 ns;
      report "Cycle 2: -- Exit TC07 from SE_09";
      Sensor(8).dir <= "01";

      CLK <= not CLK;
      wait for 1 ns;
      if (TC_out(6) = '0') then report "-- TC07 is occupied" & " : Pass"; else report "-- TC07 is occupied" & " : Fail."; end if;


      CLK <= not CLK;
      wait for 1 ns;
      report "Cycle 3: -- train outside TC07 from SE_09";
      Sensor(8).dir <= "00";

      CLK <= not CLK;
      wait for 1 ns;
      if (TC_out(6) = '1') then report "-- TC07 is free" & " : Pass"; else report "-- TC07 is free" & " : Fail."; end if;
      if (TC_out(7) = '0') then report "-- TC07 is occupied" & " : Pass"; else report "-- TC07 is occupied" & " : Fail."; end if;


      CLK <= not CLK;
      wait for 1 ns;
      report "Cycle 4: -- train enter TC07 from SE_09";
      Sensor(8).dir <= "10";

      CLK <= not CLK;
      wait for 1 ns;
      if (TC_out(6) = '1') then report "-- TC07 is occupied" & " : Pass"; else report "-- TC07 is occupied" & " : Fail."; end if;
      if (TC_out(7) = '0') then report "-- TC08 is occupied" & " : Pass"; else report "-- TC08 is occupied" & " : Fail."; end if;


      CLK <= not CLK;
      wait for 1 ns;
      report "Cycle 5: -- train inside TC07";
      Sensor(8).dir <= "00";

      CLK <= not CLK;
      wait for 1 ns;
      if (TC_out(6) = '0') then report "-- TC07 is occupied" & " : Pass"; else report "-- TC07 is occupied" & " : Fail."; end if;
      if (TC_out(7) = '1') then report "-- TC08 is free" & " : Pass"; else report "-- TC08 is free" & " : Fail."; end if;


      CLK <= not CLK;
      wait for 1 ns;
      report "Cycle 6: -- train exits TC07 from SE_08  ";
      Sensor(7).dir <= "10";

      CLK <= not CLK;
      wait for 1 ns;
      if (TC_out(6) = '0') then report "-- TC07 is occupied" & " : Pass"; else report "-- TC07 is occupied" & " : Fail."; end if;
      if (TC_out(7) = '1') then report "-- TC07 is free" & " : Pass"; else report "-- TC07 is free" & " : Fail."; end if;


      CLK <= not CLK;
      wait for 1 ns;
      report "Cycle 7: -- Train outside TC07 ";
      Sensor(7).dir <= "00";

      CLK <= not CLK;
      wait for 1 ns;
      if (TC_out(6) = '1') then report "-- TC07 is free" & " : Pass"; else report "-- TC07 is free" & " : Fail."; end if;
      if (TC_out(0) = '0') then report "-- TC01 is occupied" & " : Pass"; else report "-- TC01 is occupied" & " : Fail."; end if;


      CLK <= not CLK;
      wait for 1 ns;

      CLK <= not CLK;
      wait for 1 ns;
      if (TC_out(6) = '1') then report "-- TC07 is free" & " : Pass"; else report "-- TC07 is free" & " : Fail."; end if;
      if (TC_out(0) = '0') then report "-- TC01 is occupied" & " : Pass"; else report "-- TC01 is occupied" & " : Fail."; end if;


      CLK <= not CLK;
      wait for 1 ns;

      CLK <= not CLK;
      wait for 1 ns;


      CLK <= not CLK;
      wait for 1 ns;

      CLK <= not CLK;
      wait for 1 ns;


      CLK <= not CLK;
      wait for 1 ns;
    
    wait;
  end process;
end simu;
