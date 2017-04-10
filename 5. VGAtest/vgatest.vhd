library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;


entity vgatest is
  port (
    clk      : in  std_logic;
    rst      : in  std_logic;
    red      : out std_logic;
    green    : out std_logic;
    blue     : out std_logic;
    vs       : out std_logic;
    hs       : out std_logic
  );
end vgatest;


architecture top_level of vgatest is
  --
  -- Component declarations
  component vga_controller is
    generic (
      H_S     : integer := 800;
      H_DISP  : integer := 640;
      H_FP    : integer := 16;
      H_PW    : integer := 96;
      H_BP    : integer := 48;
      V_S     : integer := 521;
      V_DISP  : integer := 480;
      V_FP    : integer := 10;
      V_PW    : integer := 2;
      V_BP    : integer := 29
    );
    port (
      clk     : in  std_logic;
      rst     : in  std_logic;
      hs      : out std_logic;
      vs      : out std_logic;
      display : out std_logic
    );
  end component;
  --
  component colorgen is
    port (
      red      : out std_logic;
      green    : out std_logic;
      blue     : out std_logic
    );
  end component;
  --
  component clockdiv
    generic (
      DIVPARAM : integer := 5_000_000
    );
    port (
      clk_i    : in  std_logic;
      rst      : in  std_logic;
      clk_o    : out std_logic
    );
  end component;
  --
  -- Signal declarations
  signal clkdiv2  : std_logic;
  signal hsSig    : std_logic;
  signal vsSig    : std_logic;
  signal redSig   : std_logic;
  signal greenSig : std_logic;
  signal blueSig  : std_logic;
  signal vidonSig : std_logic;
  --
begin

  clockdiv_vga_instance : clockdiv
    generic map (
      DIVPARAM => 2
    )
    port map (
      clk_i    => clk,
      rst      => rst,
      clk_o    => clkdiv2
    );

  vgaSync_instance : vga_controller
    generic map (
      H_S     => 800,
      H_DISP  => 640,
      H_FP    =>  16,
      H_PW    =>  96,
      H_BP    =>  48,
      V_S     => 521,
      V_DISP  => 480,
      V_FP    =>  10,
      V_PW    =>   2,
      V_BP    =>  29
    )
    port map (
      clk     => clkdiv2,
      rst     => rst,
      hs      => hsSig,
      vs      => vsSig,
      display => vidonSig
    );

  colorgen_instance : colorgen
    port map (
      red      => redSig,
      green    => greenSig,
      blue     => blueSig
    );

  hs <= hsSig;
  vs <= vsSig;

  red   <= redSig and vidonSig;
  green <= greenSig and vidonSig;
  blue  <= blueSig and vidonSig;

end top_level;
