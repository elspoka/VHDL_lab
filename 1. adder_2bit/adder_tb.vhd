LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY adder_tb IS
END adder_tb;
 
ARCHITECTURE behavior OF adder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adder
    PORT(
         a : IN  std_logic_vector(1 downto 0);
         b : IN  std_logic_vector(1 downto 0);
         S : OUT  std_logic_vector(1 downto 0);
         C : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(1 downto 0) := (others => '0');
   signal b : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal S : std_logic_vector(1 downto 0);
   signal C : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder PORT MAP (
          a => a,
          b => b,
          S => S,
          C => C
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
		a<="00";
		b<="00";
		for I in 0 to 3 loop
			for J in 0 to 3 loop
				wait for 10ns;
				assert (S=A+B) report "SUM INCORRECT"
				severity Error;
				B<=B+"01";
			end loop;
			A<=A+"01";
		end loop;
		wait;
   end process;

END;
