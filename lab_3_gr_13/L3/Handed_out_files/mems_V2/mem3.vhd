-----------------------------------------------------------------------------
-- VHDL memory model created by bestapprox, (c) 2022 Paulo Flores.
-- Version: 2.0
-- Command: bestapprox 1666800456 mem3
-- Seed: 1666800456
-----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library UNISIM;
use UNISIM.vcomponents.all;

library UNIMACRO;
use UNIMACRO.vcomponents.all;

--Parameters:     Integer            Hexdecimal           Fix Point 8.8

-- Mem. Address: 0x000
--L.k=0  (m,b)= ( 23859,  -8773)->(0x5D33, 0xDDBB)->( 93.19921875, -34.26953125)
--L.k=1  (m,b)= (  9024,  -2069)->(0x2340, 0xF7EB)->(       35.25,  -8.08203125)
--L.k=2  (m,b)= (-10034, -26709)->(0xD8CE, 0x97AB)->( -39.1953125, -104.33203125)
--L.k=3  (m,b)= (-18768, -15381)->(0xB6B0, 0xC3EB)->(    -73.3125, -60.08203125)
--L.k=4  (m,b)= ( 18370,  11282)->(0x47C2, 0x2C12)->(  71.7578125,   44.0703125)
--L.k=5  (m,b)= (-18795, -31541)->(0xB695, 0x84CB)->(-73.41796875, -123.20703125)
--L.k=6  (m,b)= ( 21351,  26109)->(0x5367, 0x65FD)->( 83.40234375, 101.98828125)
--L.k=7  (m,b)= (  2465,  -6033)->(0x09A1, 0xE86F)->(  9.62890625, -23.56640625)

-- Mem. Address: 0x010
--P.i=0  (x,y)= ( 10336,  23976)  (0x2860, 0x5DA8)  (      40.375,     93.65625)
--P.i=1  (x,y)= ( 12382, -26369)  (0x305E, 0x98FF)  (  48.3671875, -103.00390625)
--P.i=2  (x,y)= ( -1104, -26068)  (0xFBB0, 0x9A2C)  (     -4.3125,  -101.828125)
--P.i=3  (x,y)= (-32768,  32767)  (0x8000, 0x7FFF)  (        -128, 127.99609375)
--P.i=4  (x,y)= ( 14865, -25359)  (0x3A11, 0x9CF1)  ( 58.06640625, -99.05859375)
--P.i=5  (x,y)= (    -1,      1)  (0xFFFF, 0x0001)  ( -0.00390625,   0.00390625)
--P.i=6  (x,y)= ( -7363,  26042)  (0xE33D, 0x65BA)  (-28.76171875,  101.7265625)
--P.i=7  (x,y)= (-18591,  16496)  (0xB761, 0x4070)  (-72.62109375,      64.4375)
--P.i=8  (x,y)= ( 17269,  -9567)  (0x4375, 0xDAA1)  ( 67.45703125, -37.37109375)
--P.i=9  (x,y)= ( 14427,   7235)  (0x385B, 0x1C43)  ( 56.35546875,  28.26171875)
--P.i=10 (x,y)= ( 29260,  -4341)  (0x724C, 0xEF0B)  (  114.296875, -16.95703125)
--P.i=11 (x,y)= ( -8146, -17905)  (0xE02E, 0xBA0F)  ( -31.8203125, -69.94140625)
--P.i=12 (x,y)= (  6941, -26941)  (0x1B1D, 0x96C3)  ( 27.11328125, -105.23828125)
--P.i=13 (x,y)= ( 16090,  28292)  (0x3EDA, 0x6E84)  (  62.8515625,   110.515625)
--P.i=14 (x,y)= (  -832,  18556)  (0xFCC0, 0x487C)  (       -3.25,    72.484375)
--P.i=15 (x,y)= ( 22260,   9504)  (0x56F4, 0x2520)  (   86.953125,       37.125)

--Line Results:        Integer  Hexdecimal   Fix Point
--  0: fitError =    158986625  (0979F181)   77630.1879883   
--     Display solution Q24.8  _(012F3E30)_  77630.1875      
--  1: fitError =     60517638  (039B6D06)   29549.6279297   
--     Display solution Q24.8  _(00736DA0)_  29549.625       
--  2: fitError =     67143233  (04008641)   32784.7817383   
--     Display solution Q24.8  _(008010C8)_  32784.78125     
--  3: fitError =    124613787  (076D749B)   60846.5756836   
--     Display solution Q24.8  _(00EDAE93)_  60846.5742188   
--  4: fitError =    123013305  (075508B9)   60065.090332    
--     Display solution Q24.8  _(00EAA117)_  60065.0898438   
--  5: fitError =    125310314  (0778156A)   61186.6767578   
--     Display solution Q24.8  _(00EF02AD)_  61186.6757812   
--  6: fitError =    143295860  (088A8574)   69968.6816406   
--     Display solution Q24.8  _(011150AE)_  69968.6796875   
--* 7: fitError =     17021152  (0103B8E0)   8311.109375     
--*    Display solution Q24.8  _(0020771C)_  8311.109375     

entity MemIN is
  port (
    clk    : in  std_logic;
    addr_a : in  std_logic_vector(9 downto 0);
    addr_b : in  std_logic_vector(9 downto 0);
    do_a : out std_logic_vector(31 downto 0);
    do_b : out std_logic_vector(31 downto 0)
    );
end MemIN;


architecture GEN_mem3 of MemIN is
begin

  MEM_mem3 : BRAM_TDP_MACRO
    generic map (                       -- memory initialization
      INIT_00 => X"09A1E86F536765FDB69584CB47C22C12B6B0C3EBD8CE97AB2340F7EB5D33DDBB",
      INIT_01 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_02 => X"B7614070E33D65BAFFFF00013A119CF180007FFFFBB09A2C305E98FF28605DA8",
      INIT_03 => X"56F42520FCC0487C3EDA6E841B1D96C3E02EBA0F724CEF0B385B1C434375DAA1",
      INIT_04 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_05 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0001",
      INIT_06 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_07 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF63595B48",
      INIT_08 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_09 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_0A => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_0B => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_0C => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_0D => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_0E => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_0F => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      BRAM_SIZE     => "36Kb",          -- Target BRAM, "18Kb" or "36Kb"
      READ_WIDTH_A  => 32,      -- Valid 1-36 (19-36 only for BRAM_SIZE="36Kb")
      READ_WIDTH_B  => 32,      -- Valid 1-36 (19-36 only for BRAM_SIZE="36Kb")
      WRITE_WIDTH_A => 32,      -- Valid 1-36 (19-36 only for BRAM_SIZE="36Kb")
      WRITE_WIDTH_B => 32       -- Valid 1-36 (19-36 only for BRAM_SIZE="36Kb")
      )
    port map (
      DOA    => DO_A,   -- Output port-A data, width defined by READ_WIDTH_A
      DOB    => DO_B,   -- Output port-B data, width defined by READ_WIDTH_B
      ADDRA  => ADDR_A,  -- Input port-A address, width defined by Port A depth
      ADDRB  => ADDR_B,  -- Input port-B address, width defined by Port B depth
      CLKA   => CLK,                    -- 1-bit input port-A clock
      CLKB   => CLK,                    -- 1-bit input port-B clock
      DIA    => x"00000000",    -- Input port-A data, width WRITE_WIDTH_A
      DIB    => x"00000000",    -- Input port-B data, width WRITE_WIDTH_B
      ENA    => '1',                    -- 1-bit input port-A enable
      ENB    => '1',                    -- 1-bit input port-B enable
      REGCEA => '1',    -- 1-bit input port-A output register enable
      REGCEB => '1',    -- 1-bit input port-B output register enable
      RSTA   => '0',                    -- 1-bit input port-A reset
      RSTB   => '0',                    -- 1-bit input port-B reset
      WEA    => "0000", -- Input port-A write enable, width def by Port A depth
      WEB    => "0000"  -- Input port-B write enable, width def by Port B depth
      );
end GEN_mem3;


