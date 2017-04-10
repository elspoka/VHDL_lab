----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:01:26 01/13/2015 
-- Design Name: 
-- Module Name:    up_counter_top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity up_counter_top is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           BTN : in  STD_LOGIC;
           CNT : out  STD_LOGIC_VECTOR (7 downto 0));
end up_counter_top;

architecture Behavioral of up_counter_top is

	signal BTN_sig : std_logic:='0';
	
	component debounce_circ is
		Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Button_in : in  STD_LOGIC;
           Button_out : out  STD_LOGIC);
	end component;
	
	component up_counter is
    Port ( CLK : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CNT : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;

begin
	
	counter : up_counter
	port map (	CLK => CLK,
					enable => BTN_sig,
					RST => RST,
					CNT => CNT);
	
	trigger : debounce_circ
	port map ( 	CLK => CLK,
					RST => RST,
					Button_in => BTN,
					Button_out => BTN_sig);

end Behavioral;

