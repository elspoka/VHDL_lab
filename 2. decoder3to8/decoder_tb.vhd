--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   
-- Design Name:   
-- Module Name:  
-- Project Name:  decoder3to8
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: decoder
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY decoder_tb IS
END decoder_tb;
 
ARCHITECTURE behavior OF decoder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decoder
    PORT(
         en : IN  std_logic;
         sel : IN  std_logic_vector(2 downto 0);
         D : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal en : std_logic := '0';
   signal sel : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal D : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decoder PORT MAP (
          en => en,
          sel => sel,
          D => D
        );


   -- Stimulus process
   stim_proc: process
   begin		
      sel <= "000";
		en <= '0';
		for j in 0 to 1 loop
			for i in 0 to 7 loop
				wait for 10ns;
				assert (en='0' or D(i)='1') report "ERROR"
				severity Error;
				sel <= sel + "001";
			end loop;
			en<=NOT(en);
		end loop;
		wait;
   end process;

END;
