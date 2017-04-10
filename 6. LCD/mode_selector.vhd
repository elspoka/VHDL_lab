library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mode_selector is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           TOGGLE : in  STD_LOGIC;
           MODE : out  STD_LOGIC);
end mode_selector;

architecture Behavioral of mode_selector is
	signal MODE_SIG: STD_LOGIC;
begin
	process(CLK)
	begin
		if (CLK'event and CLK = '1') then
				if(RST = '1') then
					MODE_SIG <= '0';
				elsif(TOGGLE = '1') then
					MODE_SIG <= NOT MODE_SIG;
				end if;
		end if;
	end process;
	MODE <= MODE_SIG;
end Behavioral;

