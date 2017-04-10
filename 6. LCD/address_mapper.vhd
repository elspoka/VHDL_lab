library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity address_mapper is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           UPD : in  STD_LOGIC;
           MODE : in  STD_LOGIC;
           ENABLE : in  STD_LOGIC;
			  ROTATOR : in STD_LOGIC_VECTOR (1 downto 0);
           ADDR_I : in  STD_LOGIC_VECTOR (4 downto 0);
           ADDR_O : out  STD_LOGIC_VECTOR (5 downto 0));
end address_mapper;

architecture Behavioral of address_mapper is
	signal shift_rot: UNSIGNED (5 downto 0);
	signal shift_clk: UNSIGNED (5 downto 0);
	signal shift: UNSIGNED (5 downto 0);
	signal rot_hist: Std_logic_vector(9 downto 0) := (others => '0');
	type rot_prev_type is array(1 downto 0) of std_logic_vector(5 downto 0);
	signal rot_prev: rot_prev_type;
begin

	process(CLK,ROTATOR)
	begin
		if (CLK'event and CLK = '1') then
			if (RST = '1') then
				shift_clk <= (others=>'0');
				shift_rot <= (others=>'0');
			else
				if ( (UPD = '1') and (ENABLE = '1') ) then
					shift_clk <= shift_clk + 1;
				end if;
				
				if (ROTATOR(0)='1' and rot_prev(0) = (5 => '0', 4 downto 0 => '1')  and rot_hist = (9 downto 0 => '0') and ROTATOR(1)='0') then
					shift_rot <= shift_rot + 1;
					rot_hist(0) <= '1';
				elsif (ROTATOR(1)='1' and rot_prev(1) = (5 => '0', 4 downto 0 => '1') and rot_hist = (9 downto 0 => '0') and ROTATOR(0)='0') then
					shift_rot <= shift_rot - 1;
					rot_hist(0) <= '1';
				else
					rot_hist(0) <= '0';
				end if;
				rot_hist(9 downto 1) <= rot_hist(8 downto 0);
				rot_prev(0)(5 downto 1) <= rot_prev(0)(4 downto 0);
				rot_prev(1)(5 downto 1) <= rot_prev(1)(4 downto 0);
				rot_prev(0)(0) <= ROTATOR(0);
				rot_prev(1)(0) <= ROTATOR(1);
				
			end if;
		end if;
	end process;
	shift <= shift_clk + shift_rot;
	ADDR_O <= 	std_logic_vector(resize(unsigned(ADDR_I),6) + shift) when (MODE = '1') else
					ADDR_I(4) & std_logic_vector( resize(unsigned(ADDR_I(3 downto 0)),5) + resize(shift,5) );
	
end Behavioral;

