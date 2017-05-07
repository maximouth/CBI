-- type declaration in a package
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package my_type is

  type sensor is
    record
      addr : STD_LOGIC_VECTOR (7 downto 0) ;
      dir  : STD_LOGIC_VECTOR (1 downto 0) ;
    end record ;

  -- sensors state type
  type SE_state is array (31 downto 0) of sensor ;

  --track circuit type
  type TC_St is array (19 downto 0) of STD_LOGIC_VECTOR (7 downto 0) ;
  
end package my_type;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

use work.my_type.all;

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
  signal Sw_Cmd_Aut :   STD_LOGIC_VECTOR (7 downto 0);

  --debug output
  signal TC_out     :   TC_St;

  
begin
  LO : entity work.IXL
    port map (CLK, reset, valid_in, Sw_Cmd_Req, Sw_State, Sensor, valid_out, Sw_Cmd_Aut, TC_out);

  process
  begin

    -- change le clock for X time
    -- for i in 0 to X loop
    --   clk <= not clk;
    --   wait for 1 us;      
    -- end loop;

    for i in 0 to X loop
      clk <= not clk;
      wait for 1 us;      
    end loop;

    
    -- change the clock for 1 time
    -- clk <= not clk;
    -- wait for 1 us;      


    -- IXL component only react on rising edge on the clock

    --> declate here the in signal declaration
    --> print allow with
    --    report " txt " & (signal type)'image( signal ) & ... ;

    -- on the chronogram everithing is display.

    wait;
  end process;
end simu;
