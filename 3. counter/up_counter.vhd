----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:37:05 01/13/2015 
-- Design Name: 
-- Module Name:    up_counter - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity up_counter is
    Port ( CLK : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CNT : out  STD_LOGIC_VECTOR (7 downto 0));
end up_counter;

architecture Behavioral of up_counter is

begin

	counting_process: process (CLK,RST)
	variable count: integer range 0 to 255:=0;
	begin
	
		if RST='1' then
			count := 0;
		elsif (CLK='1' and CLK'event) then
			if (enable='1') then
				if count = 255 then
					count := 0;
				else
					count := count + 1;
				end if;
			else
				count := count;
			end if;
		end if;
		
		CNT <= CONV_STD_LOGIC_VECTOR(count,8);
		
	end process;
	

end Behavioral;

