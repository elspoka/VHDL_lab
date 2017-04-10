library IEEE;
use IEEE.std_logic_1164.all;


entity clockdiv is
  generic (
    DIVPARAM : integer := 5_000_000
  );
  port (
    clk_i    : in  std_logic;
    rst      : in  std_logic;
    clk_o    : out std_logic
  );
end clockdiv;

architecture rtl of clockdiv is
signal temp_q : std_logic;
begin
  --
  process (clk_i, rst)
  variable count_i : integer range 0 to DIVPARAM-1 := 0;
  begin
    if (clk_i'event and clk_i = '1') then
      if (rst = '1') then
        count_i := 0;
        temp_q <= '0';
      else
        count_i := count_i + 1;
        if (count_i = DIVPARAM-1) then
          count_i := 0;
          temp_q <= not temp_q;
        end if;
      end if;
    end if;
  end process;
  --
  clk_o <= temp_q;
  --
end rtl;
