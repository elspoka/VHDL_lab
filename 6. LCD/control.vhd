--
-- Definition of a single port ROM for KCPSM3 program defined by control.psm
--
-- Generated by KCPSM3 Assembler 08Jun2007-21:06:28.
--
-- Standard IEEE libraries
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
-- The Unisim Library is used to define Xilinx primitives. It is also used during
-- simulation. The source can be viewed at %XILINX%\vhdl\src\unisims\unisim_VCOMP.vhd
--
library unisim;
use unisim.vcomponents.all;
--
--
entity control is
    Port (      address : in std_logic_vector(9 downto 0);
            instruction : out std_logic_vector(17 downto 0);
            proc_reset  : out std_logic;
                    clk : in std_logic);
    end control;
--
architecture low_level_definition of control is
--
-- Declare signals internal to this module
--
signal jaddr     : std_logic_vector(10 downto 0);
signal jparity   : std_logic_vector(0 downto 0);
signal jdata     : std_logic_vector(7 downto 0);
signal doa       : std_logic_vector(7 downto 0);
signal dopa      : std_logic_vector(0 downto 0);
signal tdo1      : std_logic;
signal tdo2      : std_logic;
signal update    : std_logic;
signal shift     : std_logic;
signal reset     : std_logic;
signal tdi       : std_logic;
signal sel1      : std_logic;
signal drck1     : std_logic;
signal drck1_buf : std_logic;
signal sel2      : std_logic;
signal drck2     : std_logic;
signal capture   : std_logic;
signal tap5      : std_logic;
signal tap11     : std_logic;
signal tap17     : std_logic;
--
-- Attributes to define ROM contents during implementation synthesis.
-- The information is repeated in the generic map for functional simulation
--
attribute INIT_00 : string;
attribute INIT_01 : string;
attribute INIT_02 : string;
attribute INIT_03 : string;
attribute INIT_04 : string;
attribute INIT_05 : string;
attribute INIT_06 : string;
attribute INIT_07 : string;
attribute INIT_08 : string;
attribute INIT_09 : string;
attribute INIT_0A : string;
attribute INIT_0B : string;
attribute INIT_0C : string;
attribute INIT_0D : string;
attribute INIT_0E : string;
attribute INIT_0F : string;
attribute INIT_10 : string;
attribute INIT_11 : string;
attribute INIT_12 : string;
attribute INIT_13 : string;
attribute INIT_14 : string;
attribute INIT_15 : string;
attribute INIT_16 : string;
attribute INIT_17 : string;
attribute INIT_18 : string;
attribute INIT_19 : string;
attribute INIT_1A : string;
attribute INIT_1B : string;
attribute INIT_1C : string;
attribute INIT_1D : string;
attribute INIT_1E : string;
attribute INIT_1F : string;
attribute INIT_20 : string;
attribute INIT_21 : string;
attribute INIT_22 : string;
attribute INIT_23 : string;
attribute INIT_24 : string;
attribute INIT_25 : string;
attribute INIT_26 : string;
attribute INIT_27 : string;
attribute INIT_28 : string;
attribute INIT_29 : string;
attribute INIT_2A : string;
attribute INIT_2B : string;
attribute INIT_2C : string;
attribute INIT_2D : string;
attribute INIT_2E : string;
attribute INIT_2F : string;
attribute INIT_30 : string;
attribute INIT_31 : string;
attribute INIT_32 : string;
attribute INIT_33 : string;
attribute INIT_34 : string;
attribute INIT_35 : string;
attribute INIT_36 : string;
attribute INIT_37 : string;
attribute INIT_38 : string;
attribute INIT_39 : string;
attribute INIT_3A : string;
attribute INIT_3B : string;
attribute INIT_3C : string;
attribute INIT_3D : string;
attribute INIT_3E : string;
attribute INIT_3F : string;
attribute INITP_00 : string;
attribute INITP_01 : string;
attribute INITP_02 : string;
attribute INITP_03 : string;
attribute INITP_04 : string;
attribute INITP_05 : string;
attribute INITP_06 : string;
attribute INITP_07 : string;
--
-- Attributes to define ROM contents during implementation synthesis.
--
attribute INIT_00 of ram_1024_x_18  : label is "0D015C0BEF00CE0100330D000EF40F01002100820520001800820510C001006C";
attribute INIT_01 of ram_1024_x_18  : label is "541946108601005B5020450D556006004008002100820520001800820510CD20";
attribute INIT_02 of ram_1024_x_18  : label is "002A0128A000542BC001000BA000542246208601005B5029450D55600610A000";
attribute INIT_03 of ram_1024_x_18  : label is "C40100380432A0005439C30100330314A0005434C201002E0219A000542FC101";
attribute INIT_04 of ram_1024_x_18  : label is "0048C408A4F01450A0000042C440A4F8A000C440E401002AC440E401A000543E";
attribute INIT_05 of ram_1024_x_18  : label is "0042C440C40CA4F01450A000C44004F0002E004804060406040604071450002A";
attribute INIT_06 of ram_1024_x_18  : label is "0038004804300038A000C44004F0002E0042C44004060406040704071450002A";
attribute INIT_07 of ram_1024_x_18  : label is "0033004C0501004C050C004C0506004C0528002E00480420002E004800330048";
attribute INIT_08 of ram_1024_x_18  : label is "509040006000E001A000004CC5C0A50FA000004CC580A50F50882510A0000033";
attribute INIT_09 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000080016001";
attribute INIT_0A of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_0B of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_0C of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_0D of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_0E of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_0F of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_10 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_11 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_12 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_13 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_14 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_15 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_16 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_17 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_18 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_19 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_1A of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_1B of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_1C of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_1D of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_1E of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_1F of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_20 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_21 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_22 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_23 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_24 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_25 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_26 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_27 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_28 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_29 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_2A of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_2B of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_2C of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_2D of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_2E of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_2F of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_30 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_31 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_32 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_33 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_34 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_35 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_36 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_37 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_38 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_39 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_3A of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_3B of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_3C of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_3D of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_3E of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_3F of ram_1024_x_18  : label is "408C000000000000000000000000000000000000000000000000000000000000";
attribute INITP_00 of ram_1024_x_18 : label is "F3333CFFF3A3EAA3E028FAA3C0B8A38B72DCB72DCB4B5F42D7D0FCF235C0F3CF";
attribute INITP_01 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000CD2B0B0DB";
attribute INITP_02 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INITP_03 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INITP_04 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INITP_05 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INITP_06 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INITP_07 of ram_1024_x_18 : label is "C000000000000000000000000000000000000000000000000000000000000000";
--
begin
--
  --Instantiate the Xilinx primitive for a block RAM
  ram_1024_x_18: RAMB16_S9_S18
  --synthesis translate_off
  --INIT values repeated to define contents for functional simulation
  generic map ( INIT_00 => X"0D015C0BEF00CE0100330D000EF40F01002100820520001800820510C001006C",
                INIT_01 => X"541946108601005B5020450D556006004008002100820520001800820510CD20",
                INIT_02 => X"002A0128A000542BC001000BA000542246208601005B5029450D55600610A000",
                INIT_03 => X"C40100380432A0005439C30100330314A0005434C201002E0219A000542FC101",
                INIT_04 => X"0048C408A4F01450A0000042C440A4F8A000C440E401002AC440E401A000543E",
                INIT_05 => X"0042C440C40CA4F01450A000C44004F0002E004804060406040604071450002A",
                INIT_06 => X"0038004804300038A000C44004F0002E0042C44004060406040704071450002A",
                INIT_07 => X"0033004C0501004C050C004C0506004C0528002E00480420002E004800330048",
                INIT_08 => X"509040006000E001A000004CC5C0A50FA000004CC580A50F50882510A0000033",
                INIT_09 => X"0000000000000000000000000000000000000000000000000000000080016001",
                INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_3F => X"408C000000000000000000000000000000000000000000000000000000000000",    
               INITP_00 => X"F3333CFFF3A3EAA3E028FAA3C0B8A38B72DCB72DCB4B5F42D7D0FCF235C0F3CF",
               INITP_01 => X"0000000000000000000000000000000000000000000000000000000CD2B0B0DB",
               INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INITP_07 => X"C000000000000000000000000000000000000000000000000000000000000000")
  --synthesis translate_on
  port map(    DIB => "0000000000000000",
              DIPB => "00",
               ENB => '1',
               WEB => '0',
              SSRB => '0',
              CLKB => clk,
             ADDRB => address,
               DOB => instruction(15 downto 0),
              DOPB => instruction(17 downto 16),
               DIA => jdata,
              DIPA => jparity,
               ENA => sel1,
               WEA => '1',
              SSRA => '0',
              CLKA => update,
              ADDRA=> jaddr,
               DOA => doa(7 downto 0),
              DOPA => dopa);
  v2_bscan: BSCAN_SPARTAN3
  port map(   TDO1 => tdo1,
         TDO2 => tdo2,
            UPDATE => update,
             SHIFT => shift,
             RESET => reset,
               TDI => tdi,
              SEL1 => sel1,
             DRCK1 => drck1,
              SEL2 => sel2,
             DRCK2 => drck2,
      CAPTURE => capture);
  --buffer signal used as a clock
  upload_clock: BUFG
  port map( I => drck1,
            O => drck1_buf);
  -- Assign the reset to be active whenever the uploading subsystem is active
  proc_reset <= sel1;
  srlC1: SRLC16E
  --synthesis translate_off
  generic map (INIT => X"0000")
  --synthesis translate_on
  port map(   D => tdi,
             CE => '1',
            CLK => drck1_buf,
             A0 => '1',
             A1 => '0',
             A2 => '1',
             A3 => '1',
              Q => jaddr(10),
            Q15 => jaddr(8));
  flop1: FD
  port map ( D => jaddr(10),
             Q => jaddr(9),
             C => drck1_buf);
  srlC2: SRLC16E
  --synthesis translate_off
  generic map (INIT => X"0000")
  --synthesis translate_on
  port map(   D => jaddr(8),
             CE => '1',
            CLK => drck1_buf,
             A0 => '1',
             A1 => '0',
             A2 => '1',
             A3 => '1',
              Q => jaddr(7),
            Q15 => tap5);
  flop2: FD
  port map ( D => jaddr(7),
             Q => jaddr(6),
             C => drck1_buf);
  srlC3: SRLC16E
  --synthesis translate_off
  generic map (INIT => X"0000")
  --synthesis translate_on
  port map(   D => tap5,
             CE => '1',
            CLK => drck1_buf,
             A0 => '1',
             A1 => '0',
             A2 => '1',
             A3 => '1',
              Q => jaddr(5),
            Q15 => jaddr(3));
  flop3: FD
  port map ( D => jaddr(5),
             Q => jaddr(4),
             C => drck1_buf);
  srlC4: SRLC16E
  --synthesis translate_off
  generic map (INIT => X"0000")
  --synthesis translate_on
  port map(   D => jaddr(3),
             CE => '1',
            CLK => drck1_buf,
             A0 => '1',
             A1 => '0',
             A2 => '1',
             A3 => '1',
              Q => jaddr(2),
            Q15 => tap11);
  flop4: FD
  port map ( D => jaddr(2),
             Q => jaddr(1),
             C => drck1_buf);
  srlC5: SRLC16E
  --synthesis translate_off
  generic map (INIT => X"0000")
  --synthesis translate_on
  port map(   D => tap11,
             CE => '1',
            CLK => drck1_buf,
             A0 => '1',
             A1 => '0',
             A2 => '1',
             A3 => '1',
              Q => jaddr(0),
            Q15 => jdata(7));
  flop5: FD
  port map ( D => jaddr(0),
             Q => jparity(0),
             C => drck1_buf);
  srlC6: SRLC16E
  --synthesis translate_off
  generic map (INIT => X"0000")
  --synthesis translate_on
  port map(   D => jdata(7),
             CE => '1',
            CLK => drck1_buf,
             A0 => '1',
             A1 => '0',
             A2 => '1',
             A3 => '1',
              Q => jdata(6),
            Q15 => tap17);
  flop6: FD
  port map ( D => jdata(6),
             Q => jdata(5),
             C => drck1_buf);
  srlC7: SRLC16E
  --synthesis translate_off
  generic map (INIT => X"0000")
  --synthesis translate_on
  port map(   D => tap17,
             CE => '1',
            CLK => drck1_buf,
             A0 => '1',
             A1 => '0',
             A2 => '1',
             A3 => '1',
              Q => jdata(4),
            Q15 => jdata(2));
  flop7: FD
  port map ( D => jdata(4),
             Q => jdata(3),
             C => drck1_buf);
  srlC8: SRLC16E
  --synthesis translate_off
  generic map (INIT => X"0000")
  --synthesis translate_on
  port map(   D => jdata(2),
             CE => '1',
            CLK => drck1_buf,
             A0 => '1',
             A1 => '0',
             A2 => '1',
             A3 => '1',
              Q => jdata(1),
            Q15 => tdo1);
  flop8: FD
  port map ( D => jdata(1),
             Q => jdata(0),
             C => drck1_buf);
--
end low_level_definition;
--
------------------------------------------------------------------------------------
--
-- END OF FILE control.vhd
--
------------------------------------------------------------------------------------
