	--
-- Library declarations
--
-- Standard IEEE libraries
--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
--
--------------------------------------------------------------------------------
--
--
entity msgmach is
  port (
    clk      : in    std_logic;
    rst      : in    std_logic;
	 modsw    : in    std_logic;
	 scrolsw  : in    std_logic;
	 ROTATOR  : in STD_LOGIC_VECTOR (1 downto 0);
    lcd_d    : inout std_logic_vector(7 downto 4);
    lcd_rs   : out   std_logic;
    lcd_rw   : out   std_logic;
    lcd_e    : out   std_logic;
    sf_oe    : out   std_logic;
    sf_ce    : out   std_logic;
    sf_we    : out   std_logic
  );
end msgmach;
--
--------------------------------------------------------------------------------
--
-- Start of test architecture
--
architecture behavioral of msgmach is
--
--------------------------------------------------------------------------------
--
-- declaration of KCPSM3
--
  component kcpsm3
    port (
      address       : out std_logic_vector(9 downto 0);
      instruction   : in  std_logic_vector(17 downto 0);
      port_id       : out std_logic_vector(7 downto 0);
      write_strobe  : out std_logic;
      out_port      : out std_logic_vector(7 downto 0);
      read_strobe   : out std_logic;
      in_port       : in  std_logic_vector(7 downto 0);
      interrupt     : in  std_logic;
      interrupt_ack : out std_logic;
      reset         : in  std_logic;
      clk           : in  std_logic
    );
  end component;
--
-- declaration of program ROM
--
  component control
    port (
      address     : in  std_logic_vector(9 downto 0);
      instruction : out std_logic_vector(17 downto 0);
      proc_reset  : out std_logic;
      clk         : in  std_logic
    );
  end component;
--
-- declaration of message ROM
--
  component msg_rom
    port (
      clk  : in  std_logic;
      addr : in  std_logic_vector(5 downto 0);
      data : out std_logic_vector(7 downto 0)
    );
  end component;
--
-- declaration of onepluse to debounce button
--
	component onepulse
		 Port ( CLK : in  STD_LOGIC;
				  PB : in  STD_LOGIC;
				  PB_OP : out  STD_LOGIC);
	end component;
--
-- declaration mode selector to select wanted mode of scrolling
--
	component mode_selector
		 Port ( CLK : in  STD_LOGIC;
				  RST : in  STD_LOGIC;
				  TOGGLE : in  STD_LOGIC;
				  MODE : out  STD_LOGIC);
	end component;
--
-- declaration of addr map updater to generate update signal of shift value
--
	component addr_map_upd
		 Port ( CLK : in  STD_LOGIC;
				  WRITE_STROBE : in  STD_LOGIC;
				  OUT_PORT : in  STD_LOGIC_VECTOR (7 downto 0);
				  PORT_ID : in  STD_LOGIC_VECTOR (7 downto 0);
				  UPD : out  STD_LOGIC);
	end component;
--
-- declaration of address mapper which maps the adresses of the message register for scrolling message
--
	component address_mapper 
		 Port ( CLK : in  STD_LOGIC;
				  RST : in  STD_LOGIC;
				  UPD : in  STD_LOGIC;
				  MODE : in  STD_LOGIC;
				  ENABLE : in  STD_LOGIC;
				  ROTATOR : in STD_LOGIC_VECTOR (1 downto 0);
				  ADDR_I : in  STD_LOGIC_VECTOR (4 downto 0);
				  ADDR_O : out  STD_LOGIC_VECTOR (5 downto 0));
	end component;
--
--------------------------------------------------------------------------------
--
-- Constant declarations
constant HIGH           : std_logic := '1';
--
-- Signals used to connect KCPSM3 to program ROM and I/O logic
--
signal address          : std_logic_vector(9 downto 0);
signal instruction      : std_logic_vector(17 downto 0);
signal port_id          : std_logic_vector(7 downto 0);
signal out_port         : std_logic_vector(7 downto 0);
signal in_port          : std_logic_vector(7 downto 0);
signal write_strobe     : std_logic;
signal read_strobe      : std_logic;
signal interrupt        : std_logic := '0';
signal interrupt_ack    : std_logic;
signal kcpsm3_reset     : std_logic;
--
-- Signals for LCD controller operation
--
-- Tri-state output requires internal signals
-- 'lcd_drive' is used to differentiate between LCD and StrataFLASH
-- communications which share the same data bits.
--
signal lcd_rw_control   : std_logic;
signal lcd_output_data  : std_logic_vector(7 downto 4);
signal lcd_drive        : std_logic;
--
-- signals for address mapping
--
signal upd_mapping		: std_logic;
signal scrolling_mode	: std_logic;
signal scrolling_enable	: std_logic;
signal toggle_mode		: std_logic;
signal toggle_enable		: std_logic;
signal port_id_mapped	: std_logic_vector(5 downto 0);

--
--------------------------------------------------------------------------------
--
-- Start of circuit description
--
begin
  --
  ------------------------------------------------------------------------------
  -- Disable unused components
  ------------------------------------------------------------------------------
  --
  -- StrataFLASH must be disabled to prevent it conflicting with the LCD display
  --
  sf_oe <= '1';
  sf_ce <= '1';
  sf_we <= '1';

  --
  ------------------------------------------------------------------------------
  -- KCPSM3 and the program memory
  ------------------------------------------------------------------------------
  --
  processor : kcpsm3
    port map (
      address       => address,
      instruction   => instruction,
      port_id       => port_id,
      write_strobe  => write_strobe,
      out_port      => out_port,
      read_strobe   => read_strobe,
      in_port       => in_port,
      interrupt     => interrupt,
      interrupt_ack => interrupt_ack,
      reset         => kcpsm3_reset,
      clk           => clk
    );
  --
  program_rom : control
    port map (
      address     => address,
      instruction => instruction,
      -- JTAG Loader version
      proc_reset  => kcpsm3_reset,
      clk         => clk
    );

  --
  ------------------------------------------------------------------------------
  -- Interrupt
  ------------------------------------------------------------------------------
  --
  interrupt_control: process(clk)
  begin
    if clk'event and clk='1' then
      -- processor interrupt waits for an acknowledgement
      if interrupt_ack='1' then
         interrupt <= '0';
        else
         interrupt <= interrupt;
      end if;
    end if;
  end process interrupt_control;

  --
  ------------------------------------------------------------------------------
  -- KCPSM3 input ports
  ------------------------------------------------------------------------------
  --
  msg_rom_instance : msg_rom
    port map (
      clk  => clk,
      addr => port_id_mapped,
      data => in_port
    );

  --
  ------------------------------------------------------------------------------
  -- KCPSM3 output ports
  ------------------------------------------------------------------------------
  --
  -- adding the output registers to the processor
  output_ports: process(clk)
  begin
    if (clk'EVENT and clk='1') then
      if (write_strobe = '1') then
        -- LCD data output and controls at address 40 hex.
        if (port_id(6) = '1') then
          lcd_output_data <= out_port(7 downto 4);
          lcd_drive       <= out_port(3);
          lcd_rs          <= out_port(2);
          lcd_rw_control  <= out_port(1);
          lcd_e           <= out_port(0);
        end if;
      end if;
    end if;
  end process output_ports;

  --
  ------------------------------------------------------------------------------
  -- LCD interface
  ------------------------------------------------------------------------------
  --
  -- The 4-bit data port is bidirectional.
  -- lcd_rw is '1' for read and '0' for write
  -- lcd_drive is like a master enable signal which prevents either the
  -- FPGA outputs or the LCD display driving the data lines.
  --
  --Control of read and write signal
  lcd_rw <= lcd_rw_control and lcd_drive;

  --use read/write control to enable output buffers.
  lcd_d <= lcd_output_data when (lcd_rw_control='0' and lcd_drive='1') else
           "ZZZZ";
  --
  ------------------------------------------------------------------------------
  --
  --scrolling - address signal modification/mapping
  --
	scrolling_address_mapper : address_mapper
		port map (
			CLK 		=> clk,
			RST		=> rst,
			UPD		=> upd_mapping,
			MODE		=> scrolling_mode,
			ENABLE	=> scrolling_enable,
			ROTATOR  => ROTATOR,
			ADDR_I	=> port_id(4 downto 0),
			ADDR_O	=> port_id_mapped
		);
	scrolling_address_mapper_updater : addr_map_upd
		port map (
			CLK 		=> clk,
			WRITE_STROBE	=> write_strobe,
			OUT_PORT =>	out_port,
			PORT_ID	=> port_id,
			UPD		=> upd_mapping
		);
	scrolling_mode_selector : mode_selector
		port map (
			CLK 		=> clk,
			RST		=>	rst,
			TOGGLE	=> toggle_mode,
			MODE		=> scrolling_mode
		);
	scrolling_onepulse : onepulse
		port map (
			CLK 		=> clk,
			PB 		=> modsw,
			PB_OP		=> toggle_mode	
		);
	scrolling_enable_selector : mode_selector
		port map (
			CLK 		=> clk,
			RST		=>	rst,
			TOGGLE	=> toggle_enable,
			MODE		=> scrolling_enable
		);
	scrolling_enable_onepulse : onepulse
		port map (
			CLK 		=> clk,
			PB 		=> scrolsw,
			PB_OP		=> toggle_enable
		);
end behavioral;
