-----------------------------------------------------------------------------
-- VHDL memory model created by bestapprox, (c) 2022 Paulo Flores.
-- Version: 2.0
-- Command: bestapprox 1666800474 mem4
-- Seed: 1666800474
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
--L.k=0  (m,b)= ( 20810,  18366)->(0x514A, 0x47BE)->(  81.2890625,   71.7421875)
--L.k=1  (m,b)= (  9710, -24244)->(0x25EE, 0xA14C)->(  37.9296875,   -94.703125)
--L.k=2  (m,b)= ( 15174, -12347)->(0x3B46, 0xCFC5)->(  59.2734375, -48.23046875)
--L.k=3  (m,b)= ( 24814, -12837)->(0x60EE, 0xCDDB)->(  96.9296875, -50.14453125)
--L.k=4  (m,b)= ( 20803, -31316)->(0x5143, 0x85AC)->( 81.26171875,  -122.328125)
--L.k=5  (m,b)= (-29015,  30497)->(0x8EA9, 0x7721)->(-113.33984375, 119.12890625)
--L.k=6  (m,b)= (-15911, -26774)->(0xC1D9, 0x976A)->(-62.15234375, -104.5859375)
--L.k=7  (m,b)= ( 32703,  19086)->(0x7FBF, 0x4A8E)->(127.74609375,   74.5546875)

-- Mem. Address: 0x010
--P.i=0  (x,y)= ( 26032, -14912)  (0x65B0, 0xC5C0)  (    101.6875,       -58.25)
--P.i=1  (x,y)= ( -5112, -17790)  (0xEC08, 0xBA82)  (   -19.96875,  -69.4921875)
--P.i=2  (x,y)= ( -8928, -27744)  (0xDD20, 0x93A0)  (     -34.875,     -108.375)
--P.i=3  (x,y)= (-32768,  32767)  (0x8000, 0x7FFF)  (        -128, 127.99609375)
--P.i=4  (x,y)= ( 15297,  -1597)  (0x3BC1, 0xF9C3)  ( 59.75390625,  -6.23828125)
--P.i=5  (x,y)= (    -1,      1)  (0xFFFF, 0x0001)  ( -0.00390625,   0.00390625)
--P.i=6  (x,y)= (  2077,  11907)  (0x081D, 0x2E83)  (  8.11328125,  46.51171875)
--P.i=7  (x,y)= (  1110,  22887)  (0x0456, 0x5967)  (   4.3359375,  89.40234375)
--P.i=8  (x,y)= ( 30273,  10821)  (0x7641, 0x2A45)  (118.25390625,  42.26953125)
--P.i=9  (x,y)= ( -1357, -20088)  (0xFAB3, 0xB188)  ( -5.30078125,    -78.46875)
--P.i=10 (x,y)= ( -1526,  23458)  (0xFA0A, 0x5BA2)  (  -5.9609375,   91.6328125)
--P.i=11 (x,y)= ( 32611,  19278)  (0x7F63, 0x4B4E)  (127.38671875,   75.3046875)
--P.i=12 (x,y)= ( -7858,   3596)  (0xE14E, 0x0E0C)  ( -30.6953125,    14.046875)
--P.i=13 (x,y)= (-15761, -23769)  (0xC26F, 0xA327)  (-61.56640625, -92.84765625)
--P.i=14 (x,y)= (-23178,  16942)  (0xA576, 0x422E)  ( -90.5390625,   66.1796875)
--P.i=15 (x,y)= ( -4682,   2854)  (0xEDB6, 0x0B26)  ( -18.2890625,   11.1484375)

--Line Results:        Integer  Hexdecimal   Fix Point
--  0: fitError =    134875894  (080A0AF6)   65857.3701172   
--     Display solution Q24.8  _(0101415E)_  65857.3671875   
--* 1: fitError =     63679273  (03CBAB29)   31093.3950195   
--*    Display solution Q24.8  _(00797565)_  31093.3945312   
--  2: fitError =     98831604  (05E40CF4)   48257.6191406   
--     Display solution Q24.8  _(00BC819E)_  48257.6171875   
--  3: fitError =    161679296  (09A307C0)   78944.96875     
--     Display solution Q24.8  _(013460F8)_  78944.96875     
--  4: fitError =    136127554  (081D2442)   66468.5322266   
--     Display solution Q24.8  _(0103A488)_  66468.53125     
--  5: fitError =    190556389  (0B5BA8E5)   93045.1118164   
--     Display solution Q24.8  _(016B751C)_  93045.109375    
--  6: fitError =    103741298  (062EF772)   50654.9306641   
--     Display solution Q24.8  _(00C5DEEE)_  50654.9296875   
--  7: fitError =    212380345  (0CA8AAB9)   103701.340332   
--     Display solution Q24.8  _(01951557)_  103701.339844   

entity MemIN is
  port (
    clk    : in  std_logic;
    addr_a : in  std_logic_vector(9 downto 0);
    addr_b : in  std_logic_vector(9 downto 0);
    do_a : out std_logic_vector(31 downto 0);
    do_b : out std_logic_vector(31 downto 0)
    );
end MemIN;


architecture GEN_mem4 of MemIN is
begin

  MEM_mem4 : BRAM_TDP_MACRO
    generic map (                       -- memory initialization
      INIT_00 => X"7FBF4A8EC1D9976A8EA97721514385AC60EECDDB3B46CFC525EEA14C514A47BE",
      INIT_01 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_02 => X"04565967081D2E83FFFF00013BC1F9C380007FFFDD2093A0EC08BA8265B0C5C0",
      INIT_03 => X"EDB60B26A576422EC26FA327E14E0E0C7F634B4EFA0A5BA2FAB3B18876412A45",
      INIT_04 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_05 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0001",
      INIT_06 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_07 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF63595B5A",
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
end GEN_mem4;


