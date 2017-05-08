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

    -- initialiser signaux
    reset <= '1';
    CLK <= '0';
    valid_in <= '0';
    wait for 1 ns;      

    -- bouger de 1 cycle d'horloge 
    for i in 0 to 1 loop
      CLK <= not CLK;
      wait for 1 ns;      
    end loop;

    -- Fin initialisation
    reset <= '0';
    
    -- bouger de 1 cycle d'horloge 
    for i in 0 to 1 loop
      CLK <= not CLK;
      wait for 1 ns;      
    end loop;

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
    Sensor(20).dir <= "00";
    Sensor(21).dir <= "00";
    Sensor(22).dir <= "00";
    Sensor(23).dir <= "00";
   
    -- assert ( condition ) report "string d'afficher" severity note/failure/error/warning ;

    -- bouger de 1 cycle d'horloge 
    for i in 0 to 1 loop
      CLK <= not CLK;
      wait for 1 ns;      
    end loop;
    
    -- assert ( condition ) report "string d'afficher" severity note/failure/error/warning ;
    
    -- a train enters TC(6) from sensor(6)
    -- a train leaves TC(6) from sensor(6)
    Sensor(5).dir <= "01";

    -- bouger de 1 cycle d'horloge 
    for i in 0 to 1 loop
      CLK <= not CLK;
      wait for 1 ns;      
    end loop;

    
    Sensor(5).dir <= "00";

    -- bouger de 1 cycle d'horloge 
    for i in 0 to 1 loop
      CLK <= not CLK;
      wait for 1 ns;      
    end loop;
     
   Sensor(0).dir <= "01";
    
    -- bouger de 1 cycle d'horloge 
    for i in 0 to 1 loop
      CLK <= not CLK;
      wait for 1 ns;      
    end loop;

    
   Sensor(0).dir <= "00";
    
    -- bouger de 1 cycle d'horloge 
    for i in 0 to 1 loop
      CLK <= not CLK;
      wait for 1 ns;      
    end loop;

    
   Sensor(1).dir <= "01";
    
    -- bouger de 1 cycle d'horloge 
    for i in 0 to 1 loop
      CLK <= not CLK;
      wait for 1 ns;      
    end loop;

    
     -- bouger de 1 cycle d'horloge 
    for i in 0 to 1 loop
      CLK <= not CLK;
      wait for 1 ns;      
    end loop;
    
   
    -- mettre les valeurs dans les signaux en entrée
    -- pour que les modifications soient prises en compte faire bouger les
    -- cycles d'horloge

    -- pour les tests
    -- assert ( condition ) report "string d'afficher" severiry note/failure/error/warning ;
    


    -- IXL component only react on rising edge on the clock

    --> declate here the in signal declaration
    --> print allow with
    --    report " txt " & (signal type)'image( signal ) & ... ;

    -- on the chronogram everithing is display.

    wait;
  end process;
end simu;
