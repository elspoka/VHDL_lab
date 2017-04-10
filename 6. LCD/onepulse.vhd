library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--  Provides a one-shot pulse from a non-clock input, with reset

entity onepulse is
    Port ( CLK : in  STD_LOGIC;
           PB : in  STD_LOGIC;
           PB_OP : out  STD_LOGIC);
end onepulse;

architecture Behavioral of onepulse is

	signal Q1, Q2, Q3 : std_logic;

begin
	process(CLK)
	begin
		if (CLK'event and CLK = '1') then
				Q1 <= PB;
				Q2 <= Q1;
				Q3 <= Q2;
		end if;
	end process;
	 
	PB_OP <= Q1 and Q2 and (not Q3);
	
end Behavioral;

