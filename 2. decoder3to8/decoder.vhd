library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder is
    Port ( en : in  STD_LOGIC;
           sel : in  STD_LOGIC_VECTOR (2 downto 0);
           D : out  STD_LOGIC_VECTOR (7 downto 0));
end decoder;

architecture Behavioral of decoder is
begin

process (sel, en)
begin
	D <= (others => '0');
	if (en = '1') then
		D(to_integer(unsigned(sel))) <= '1'; 
	end if;
end process;

end Behavioral;

