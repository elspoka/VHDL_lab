library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.lcd_cntrl_pkg.all;


entity msg_rom is
  port (
    clk  : in  std_logic;
    addr : in  std_logic_vector(5 downto 0);
    data : out std_logic_vector(7 downto 0)
  );
end msg_rom;


architecture rtl of msg_rom is
  type mem_type is array (0 to 63) of std_logic_vector(7 downto 0);
  constant mem : mem_type := (
     0 => LCD_CHR_H_UP,
     1 => LCD_CHR_e_LO,
     2 => LCD_CHR_l_LO,
     3 => LCD_CHR_l_LO,
     4 => LCD_CHR_o_LO,
     5 => LCD_CHR_SPACE,
     6 => LCD_CHR_W_UP,
     7 => LCD_CHR_o_LO,
     8 => LCD_CHR_r_LO,
     9 => LCD_CHR_l_LO,
    10 => LCD_CHR_d_LO,
    11 => LCD_CHR_XCLAIM,
    12 => LCD_CHR_SPACE,
    13 => LCD_CHR_H_UP,
    14 => LCD_CHR_o_LO,
    15 => LCD_CHR_w_LO, 
    16 => LCD_CHR_SPACE,
    17 => LCD_CHR_a_LO,
    18 => LCD_CHR_r_LO,
    19 => LCD_CHR_e_LO,
    20 => LCD_CHR_SPACE,
    21 => LCD_CHR_y_LO,
    22 => LCD_CHR_o_LO,
    23 => LCD_CHR_u_LO,
    24 => LCD_CHR_SPACE,
    25 => LCD_CHR_t_LO,
    26 => LCD_CHR_o_LO,
    27 => LCD_CHR_d_LO,
    28 => LCD_CHR_a_LO,
    29 => LCD_CHR_y_LO,
    30 => LCD_CHR_QMARK,
    31 => LCD_CHR_SPACE,
	
    32 => LCD_CHR_I_UP,
    33 => LCD_CHR_t_LO,
    34 => LCD_CHR_SPACE,
    35 => LCD_CHR_i_LO,
    36 => LCD_CHR_s_LO,
    37 => LCD_CHR_SPACE,
    38 => LCD_CHR_t_LO,
    39 => LCD_CHR_i_LO,
    40 => LCD_CHR_m_LO,
    41 => LCD_CHR_e_LO,
    42 => LCD_CHR_SPACE,
    43 => LCD_CHR_t_LO,
    44 => LCD_CHR_o_LO,
    45 => LCD_CHR_SPACE,
    46 => LCD_CHR_g_LO,
    47 => LCD_CHR_e_LO,
    48 => LCD_CHR_t_LO,
    49 => LCD_CHR_SPACE,
    50 => LCD_CHR_u_LO,
    51 => LCD_CHR_p_LO,
    52 => LCD_CHR_SPACE,
    53 => LCD_CHR_a_LO,
    54 => LCD_CHR_n_LO,
    55 => LCD_CHR_d_LO,
    56 => LCD_CHR_SPACE,
    57 => LCD_CHR_g_LO,
    58 => LCD_CHR_o_LO,
    59 => LCD_CHR_i_LO,
    60 => LCD_CHR_n_LO,
    61 => LCD_CHR_g_LO,
    62 => LCD_CHR_XCLAIM,
	 63 => LCD_CHR_SPACE,
    others => X"20"
  );
begin
  rom : process (clk)
  begin
    if (clk'EVENT and clk='1') then
      data <= mem(conv_integer(addr));
    end if;
  end process rom;
end rtl;