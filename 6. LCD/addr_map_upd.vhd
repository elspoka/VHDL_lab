library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity addr_map_upd is
    Port ( CLK : in  STD_LOGIC;
           WRITE_STROBE : in  STD_LOGIC;
           OUT_PORT : in  STD_LOGIC_VECTOR (7 downto 0);
           PORT_ID : in  STD_LOGIC_VECTOR (7 downto 0);
           UPD : out  STD_LOGIC);
end addr_map_upd;

architecture Behavioral of addr_map_upd is

begin
process(CLK)
	begin
		if (CLK'event and CLK = '1') then
				if( (WRITE_STROBE = '1') and (OUT_PORT = X"01") and (PORT_ID = X"20") ) then
					UPD <= '1';
				else
					UPD <= '0';
				end if;
		end if;
	end process;

end Behavioral;

