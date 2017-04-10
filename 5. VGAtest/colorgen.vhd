library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;


entity colorgen is
  port (
    red      : out std_logic;
    green    : out std_logic;
    blue     : out std_logic
  );
end colorgen;


architecture rtl of colorgen is
  --
begin

  red   <= '1';
  green <= '0';
  blue  <= '1';

end rtl;
