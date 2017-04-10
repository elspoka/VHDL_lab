library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;


entity vga_controller is
  generic (
    -- horizontal timing
    -- sync pulse
    H_S     : integer := 800;
    -- display
    H_DISP  : integer := 640;
    -- front porch
    H_FP    : integer := 16;
    -- pulse width
    H_PW    : integer := 96;
    -- back porch
    H_BP    : integer := 48;
    -- vertical timing
    -- sync pulse
    V_S     : integer := 521;
    -- display
    V_DISP  : integer := 480;
    -- front porch
    V_FP    : integer := 10;
    -- pulse width
    V_PW    : integer := 2;
    -- back porch
    V_BP    : integer := 29
  );
  port (
    clk     : in  std_logic; -- assuming a clock of 25MHz
    rst     : in  std_logic; -- reset (synchronous)
    hs      : out std_logic; -- Horizontal sync pulse. Active low.
    vs      : out std_logic; -- Vertical sync pulse. Active low.
    display : out std_logic  -- Color signals can be displayed.
  );
end vga_controller;

architecture behavioral of vga_controller is
  --
  -- Constants
  -- 800 horizontal pixels indexed 0 to 799
  constant HPIXELS : std_logic_vector(9 downto 0) := conv_std_logic_vector(H_S, 10);
  -- 521 vertical pixels indexed 0 to 520
  constant VLINES  : std_logic_vector(9 downto 0) := conv_std_logic_vector(V_S, 10);
  --
  -- Signals
  -- horizontal pixel and vertical line counters
  signal hc        : std_logic_vector(9 downto 0) := conv_std_logic_vector(0, 10);
  signal vc        : std_logic_vector(9 downto 0) := conv_std_logic_vector(0, 10);
  --
begin

  -- Runs the horizontal counter  when it resets vertical counter is incremented
  counter_proc : process(clk)
  begin
    if (rising_edge(clk)) then
      if (rst = '1') then
        hc <= conv_std_logic_vector(0, 10);
        vc <= conv_std_logic_vector(0, 10);
      else
        if (hc = HPIXELS) then    --If hc has reached the end of pixel count
          hc <= conv_std_logic_vector(0, 10);
          if (vc = VLINES) then      -- if vc has reached end of line count
            vc <= conv_std_logic_vector(0, 10);
          else
            vc <= vc + 1;
          end if; -- vc
        else
          hc <= hc + 1;
        end if; -- hc
      end if; -- rst
    end if; -- clkdiv
  end process;

  --horizontal sync pulse is 96 pixels long at pixels 656-752
  hsync_proc : process(hc)
  begin
    if (hc >= H_DISP + H_FP and hc < H_DISP + H_FP + H_PW) then
      hs <= '0';
    else
      hs <= '1';
    end if;
  end process;

  --vertical sync pulse is 2 lines (800 pixels) long at line 490-491
  vsync_proc : process(vc)
  begin
    if (vc >= V_DISP + V_FP and vc < V_DISP + V_FP + V_PW) then
      vs <= '0';
    else
      vs <= '1';
    end if;
  end process;

  --only display pixels between horizontal 0-639 and vertical 0-479 (640x480)
  blank_proc : process(hc, vc)
  begin
    if ((hc >= H_DISP) or (vc >= V_DISP)) then
      display <= '0';
    else
      display <= '1';
    end if;
  end process;

end behavioral;
