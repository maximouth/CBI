library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity Master is
  Port ( CLK   : in STD_LOGIC;
         BTNC  : in STD_LOGIC;
         BTNL  : in STD_LOGIC;
         BTNR  : in STD_LOGIC;
         reset  : in STD_LOGIC;
         CA  : out STD_LOGIC;
         CB  : out STD_LOGIC;
         CC  : out STD_LOGIC;
         CD  : out STD_LOGIC;
         CE  : out STD_LOGIC;
         CF  : out STD_LOGIC;
         CG  : out STD_LOGIC;
         DP  : out STD_LOGIC;
         AN  : out Std_Logic_Vector (7 downto 0);
         PULSE : out STD_LOGIC);

end Master;

--------------------------------------------------------------------------------

architecture Behavioral of Master is

-- DCC Central component
component sequencer is
  Port (
    clk      : in  STD_LOGIC;
    go       : in  STD_LOGIC := '0';
    addr     : in  Std_Logic_Vector (7 downto 0);
    data     : in  Std_Logic_Vector (7 downto 0);
    pulse    : out STD_LOGIC := '0'
    );      
end component;


-- IHM component
component control_seg is
  Port ( CLK : in STD_LOGIC;
         reset : in STD_LOGIC;
         CA : out STD_LOGIC;
         CB : out STD_LOGIC;
         CC : out STD_LOGIC;
         CD : out STD_LOGIC;
         CE : out STD_LOGIC;
         CF : out STD_LOGIC;
         CG : out STD_LOGIC;
         DP : out STD_LOGIC;
         AN : out STD_LOGIC_VECTOR (7 downto 0);
         ADD  : out STD_LOGIC_VECTOR (7 downto 0);
         DATA  : out STD_LOGIC_VECTOR (7 downto 0);
         -- chose setting
         BTNL : in STD_LOGIC;
         -- increment setting value
         BTNR : in STD_LOGIC
         );
end component;


component div_clock is
  Port (
    -- 100 MHz signla
    clk : in STD_LOGIC;
    -- 1 MHz signal
    div_clock : out STD_LOGIC);
end component;


signal clk1M : STD_LOGIC := '0';

signal go : STD_LOGIC := '0';
signal address : STD_LOGIC_VECTOR (7 downto 0);
signal data_send : STD_LOGIC_VECTOR (7 downto 0);

--------------------------------------------------------------------------------


begin

 sequencer_1: sequencer
    port map (
      clk     => clk1M,
      go      => go,
      addr    => address,
      data    => data_send,
      pulse   => PULSE
      );

 control_seg_1: control_seg
    port map (
      CLK     => CLK,
      reset   => reset,
      CA      => CA,
      CB      => CB,
      CC      => CC,
      CD      => CD,
      CE      => CE,
      CF      => CF,
      CG      => CG,
      DP      => DP,
      AN      => AN,
      ADD     => address,
      DATA    => data_send,
      BTNL    => BTNL,
      BTNR    => BTNR
      
      );

 div_clock_1: div_clock
    port map (
      clk         => CLK,
      div_clock   => clk1M
      );



end Behavioral;
