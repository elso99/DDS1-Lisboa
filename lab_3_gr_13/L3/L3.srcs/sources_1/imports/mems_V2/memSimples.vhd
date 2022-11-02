-----------------------------------------------------------------------------
-- VHDL memory model created by bestapprox, (c) 2022 Paulo Flores.
-- Version: 2.0
-- Command: bestapprox 13 memSimples
-- Seed: 13
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
--L.k=0  (m,b)= (     0,    256)->(0x0000, 0x0100)->(           0,            1)
--L.k=1  (m,b)= (   256,      0)->(0x0100, 0x0000)->(           1,            0)
--L.k=2  (m,b)= (   256,    256)->(0x0100, 0x0100)->(           1,            1)
--L.k=3  (m,b)= (     0,    512)->(0x0000, 0x0200)->(           0,            2)
--L.k=4  (m,b)= (   512,      0)->(0x0200, 0x0000)->(           2,            0)
--L.k=5  (m,b)= (   512,    512)->(0x0200, 0x0200)->(           2,            2)
--L.k=6  (m,b)= (   768,    768)->(0x0300, 0x0300)->(           3,            3)
--L.k=7  (m,b)= (   255,    255)->(0x00FF, 0x00FF)->(  0.99609375,   0.99609375)

-- Mem. Address: 0x010
--P.i=0  (x,y)= ( 13557,   8704)  (0x34F5, 0x2200)  ( 52.95703125,           34)
--P.i=1  (x,y)= ( 20400,  18226)  (0x4FB0, 0x4732)  (     79.6875,   71.1953125)
--P.i=2  (x,y)= (  9453, -25015)  (0x24ED, 0x9E49)  ( 36.92578125, -97.71484375)
--P.i=3  (x,y)= (-32768,  32767)  (0x8000, 0x7FFF)  (        -128, 127.99609375)
--P.i=4  (x,y)= ( 17633,  -5416)  (0x44E1, 0xEAD8)  ( 68.87890625,    -21.15625)
--P.i=5  (x,y)= (    -1,      1)  (0xFFFF, 0x0001)  ( -0.00390625,   0.00390625)
--P.i=6  (x,y)= ( -1173, -20159)  (0xFB6B, 0xB141)  ( -4.58203125, -78.74609375)
--P.i=7  (x,y)= ( 29699,  28437)  (0x7403, 0x6F15)  (116.01171875, 111.08203125)
--P.i=8  (x,y)= ( 12990,  21443)  (0x32BE, 0x53C3)  (  50.7421875,  83.76171875)
--P.i=9  (x,y)= ( 26533,   1595)  (0x67A5, 0x063B)  (103.64453125,   6.23046875)
--P.i=10 (x,y)= ( 29371, -25387)  (0x72BB, 0x9CD5)  (114.73046875, -99.16796875)
--P.i=11 (x,y)= ( -5050, -17276)  (0xEC46, 0xBC84)  ( -19.7265625,   -67.484375)
--P.i=12 (x,y)= (-16792,  24733)  (0xBE68, 0x609D)  (   -65.59375,  96.61328125)
--P.i=13 (x,y)= ( -6608,   5630)  (0xE630, 0x15FE)  (    -25.8125,   21.9921875)
--P.i=14 (x,y)= ( 16643, -32637)  (0x4103, 0x8083)  ( 65.01171875, -127.48828125)
--P.i=15 (x,y)= (-32167,  30200)  (0x8259, 0x75F8)  (-125.65234375,    117.96875)

--Line Results:        Integer  Hexdecimal   Fix Point
--  0: fitError =      2376896  (002444C0)   1160.59375      
--     Display solution Q24.8  _(00048898)_  1160.59375      
--  1: fitError =      3328912  (0032CB90)   1625.4453125    
--     Display solution Q24.8  _(00065972)_  1625.4453125    
--  2: fitError =      3341168  (0032FB70)   1631.4296875    
--     Display solution Q24.8  _(00065F6E)_  1631.4296875    
--* 3: fitError =      2372800  (002434C0)   1158.59375      
--*    Display solution Q24.8  _(00048698)_  1158.59375      
--  4: fitError =      5260800  (00504600)   2568.75         
--     Display solution Q24.8  _(000A08C0)_  2568.75         
--  5: fitError =      5293520  (0050C5D0)   2584.7265625    
--     Display solution Q24.8  _(000A18BA)_  2584.7265625    
--  6: fitError =      7377024  (00709080)   3602.0625       
--     Display solution Q24.8  _(000E1210)_  3602.0625       
--  7: fitError =      3333848  (0032DED8)   1627.85546875   
--     Display solution Q24.8  _(00065BDB)_  1627.85546875   

entity MemIN is
  port (
    clk    : in  std_logic;
    addr_a : in  std_logic_vector(9 downto 0);
    addr_b : in  std_logic_vector(9 downto 0);
    do_a : out std_logic_vector(31 downto 0);
    do_b : out std_logic_vector(31 downto 0)
    );
end MemIN;


architecture GEN_memSimples of MemIN is
begin

  MEM_memSimples : BRAM_TDP_MACRO
    generic map (                       -- memory initialization
      INIT_00 => X"00FF00FF03000300020002000200000000000200010001000100000000000100",
      INIT_01 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_02 => X"74036F15FB6BB141FFFF000144E1EAD880007FFF24ED9E494FB0473234F52200",
      INIT_03 => X"825975F841038083E63015FEBE68609DEC46BC8472BB9CD567A5063B32BE53C3",
      INIT_04 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_05 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0001",
      INIT_06 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_07 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000D",
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
end GEN_memSimples;


