library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity up_down_counter_top is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           SEL : in  STD_LOGIC;
           CNT : out  STD_LOGIC_VECTOR (7 downto 0));
end up_down_counter_top;

architecture Behavioral of up_down_counter_top is

	signal CLK_sig : std_logic;
	
	component freq_divider is
    Port ( CLK_in : in  STD_LOGIC;
           CLK_out : out  STD_LOGIC);
	end component;
	
	component up_down_counter is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           SEL : in  STD_LOGIC;
           CNT : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;

begin
	
	divider : freq_divider 
   port map (	CLK_in	=> CLK,
					CLK_out	=> CLK_sig);
	
	counter : up_down_counter
	port map (	CLK => CLK_sig,
					RST => RST,
					SEL => SEL,
					CNT => CNT);
	
end Behavioral;

