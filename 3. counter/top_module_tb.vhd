LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY top_module_tb IS
END top_module_tb;
 
ARCHITECTURE behavior OF top_module_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT up_counter_top
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         BTN : IN  std_logic;
         CNT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal BTN : std_logic := '0';

 	--Outputs
   signal CNT : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: up_counter_top PORT MAP (
          CLK => CLK,
          RST => RST,
          BTN => BTN,
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
	
      wait for CLK_period*10;

      For i in 0 to 355 loop
		
			BTN <= '1'; wait for 23ns;
			BTN <= '0'; wait for 16ns;
			BTN <= '1'; wait for 17ns;
			BTN <= '0'; wait for 18ns;
			BTN <= '1'; wait for 95ns;
			BTN <= '0'; wait for 16ns;
			BTN <= '1'; wait for 22ns;
			BTN <= '0'; wait for 13ns;
			BTN <= '1'; wait for 21ps;
			BTN <= '0'; wait for 120ns;
			
			if (i=20) then
				RST <= '1';
				wait for clk_period;
				RST <= '0';
			end if;
			
		end loop;

      wait;
   end process;

END;
