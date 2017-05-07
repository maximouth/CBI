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


    -- initialiser signaux
    reset <= '1';

    -- bouger de 1 cycle d'horloge 
    for i in 0 to 2 loop
      CLK <= not CLK;
      wait for 1 us;      
    end loop;

    Sw_Cmd_Req <= "11110000";

    -- assert ( condition ) report "string d'afficher" severity note/failure/error/warning ;

    -- bouger de 1 cycle d'horloge 
    for i in 0 to 2 loop
      CLK <= not CLK;
      wait for 1 us;      
    end loop;
    
    
    -- mettre les valeurs dans les signaux en entrée
    -- pour que les modifications soient prises en compte faire bouger les
    -- cycles d'horloge

    -- pour les tests
    -- asssert ( condition ) report "string d'afficher" severiry note/failure/error/warning ;
    


    -- IXL component only react on rising edge on the clock

    --> declate here the in signal declaration
    --> print allow with
    --    report " txt " & (signal type)'image( signal ) & ... ;

    -- on the chronogram everithing is display.

    wait;
  end process;
end simu;
