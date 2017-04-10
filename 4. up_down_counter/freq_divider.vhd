library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity freq_divider is
	Generic ( Divider : integer := 50000000); --4);
    Port ( CLK_in : in  STD_LOGIC;
           CLK_out : out  STD_LOGIC);
end freq_divider;

architecture Behavioral of freq_divider is

begin
	process (CLK_in)
	variable count: integer range 0 to Divider/2:=1;
	variable CLK: STD_LOGIC :='0';
	begin
	
		if (CLK_in='1' and CLK_in'event) then
				if count = Divider/2 then
					count := 1;
					CLK := not CLK;
				else
					count := count + 1;
				end if;
		end if;
		CLK_out <= CLK;
	end process;

end Behavioral;

