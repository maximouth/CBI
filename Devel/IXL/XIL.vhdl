-- type declaration in a package
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package my_type is
  
  type sensor is
    record
      addr : STD_LOGIC_VECTOR (7 downto 0) ;
      dir  : STD_LOGIC_VECTOR (1 downto 0) ;
    end record ;

  type SE_state is array (31 downto 0) of sensor ;

  type TC_St is array (19 downto 0) of STD_LOGIC_VECTOR (7 downto 0) ;
  
end package my_type;

-- beggining of program
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.my_type.all;

entity Xil is  

  Port (
         -- synchro   
         CLK        : in  STD_LOGIC;
         reset      : in  STD_LOGIC;

         -- input
         valid_in   : in  STD_LOGIC; 
         Sw_Cmd_Req : in  STD_LOGIC_VECTOR (7 downto 0);
         Sw_State   : in  STD_LOGIC_VECTOR (7 downto 0);
         Sensor     : in  SE_state;
         
         -- output
         valid_out  : out STD_LOGIC;
         Sw_Cmd_aut : out STD_LOGIC_VECTOR (7 downto 0);

         --debug output
         TC_out     : out TC_St
         );

end Xil;

--------------------------------------------------------------------------------

architecture Behavioral of Xil is

  -- component declaration


--------------------------------------------------------------------------------
  
  -- signals declaration

  -- Track circuit state
  signal TC : TC_St;          


--------------------------------------------------------------------------------
  
begin

  -- component instantiation

  
--------------------------------------------------------------------------------

  
 process (CLK,reset)
 
   -- variable declaration

   
 begin

   
   -- RESET gestion
   if reset = '1' then

     -- clear TC
     for i in 0 to 19 loop
       TC(i) <= "00000111";
     end loop;
     -- reset the output value
     valid_out <= '0';
     
   -- end if reset
   end if;
   

   
   if rising_edge (CLK) then 

     -- for debug
     TC_out <= TC;

     -- reset the output value
     valid_out <= '0';
     
     -- process only if the inputs are ok
     if valid_in = '1' then
       
       
       
       
     -- end valid = 1
     end if;
   --end if rising edge
   end if;    


 end process;
end Behavioral;
