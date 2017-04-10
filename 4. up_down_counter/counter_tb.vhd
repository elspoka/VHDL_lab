LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY counter_tb IS
END counter_tb;
 
ARCHITECTURE behavior OF counter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT up_down_counter_top
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         SEL : IN  std_logic;
         CNT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal SEL : std_logic := '0';

 	--Outputs
   signal CNT : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: up_down_counter_top PORT MAP (
          CLK => CLK,
          RST => RST,
          SEL => SEL,
          CNT => CNT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 503 ns;	
		RST <= '1';
		wait for clk_period;
		RST<= '0';
		wait for 73 ns;
		RST <= '1';
		wait for 27ns;
		RST<= '0';
		wait for 300 ns;
		SEL <= '1';
		wait for 200 ns;
		SEl <= '0';

      wait;
   end process;

END;
