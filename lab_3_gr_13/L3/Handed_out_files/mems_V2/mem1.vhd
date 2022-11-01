-----------------------------------------------------------------------------
-- VHDL memory model created by bestapprox, (c) 2022 Paulo Flores.
-- Version: 2.0
-- Command: bestapprox 1 mem1
-- Seed: 1
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
--L.k=0  (m,b)= ( 17767,   9158)->(0x4567, 0x23C6)->( 69.40234375,   35.7734375)
--L.k=1  (m,b)= (-26519,  18547)->(0x9869, 0x4873)->(-103.58984375,  72.44921875)
--L.k=2  (m,b)= ( -9135,  23807)->(0xDC51, 0x5CFF)->(-35.68359375,  92.99609375)
--L.k=3  (m,b)= (-27574,  22764)->(0x944A, 0x58EC)->(-107.7109375,    88.921875)
--L.k=4  (m,b)= (  7977,  31949)->(0x1F29, 0x7CCD)->( 31.16015625, 124.80078125)
--L.k=5  (m,b)= ( 22714, -10325)->(0x58BA, 0xD7AB)->(  88.7265625, -40.33203125)
--L.k=6  (m,b)= ( 16882,   7931)->(0x41F2, 0x1EFB)->(  65.9453125,  30.98046875)
--L.k=7  (m,b)= (-22045,  -7866)->(0xA9E3, 0xE146)->(-86.11328125,  -30.7265625)

-- Mem. Address: 0x010
--P.i=0  (x,y)= (   124,  25282)  (0x007C, 0x62C2)  (    0.484375,   98.7578125)
--P.i=1  (x,y)= (  2132,  10232)  (0x0854, 0x27F8)  (    8.328125,     39.96875)
--P.i=2  (x,y)= (  8987,  -5656)  (0x231B, 0xE9E8)  ( 35.10546875,    -22.09375)
--P.i=3  (x,y)= (-32768,  32767)  (0x8000, 0x7FFF)  (        -128, 127.99609375)
--P.i=4  (x,y)= (  3958,   9562)  (0x0F76, 0x255A)  (  15.4609375,   37.3515625)
--P.i=5  (x,y)= (    -1,      1)  (0xFFFF, 0x0001)  ( -0.00390625,   0.00390625)
--P.i=6  (x,y)= (-15821, -10337)  (0xC233, 0xD79F)  (-61.80078125, -40.37890625)
--P.i=7  (x,y)= (-15159,   1946)  (0xC4C9, 0x079A)  (-59.21484375,    7.6015625)
--P.i=8  (x,y)= ( -1178,  23858)  (0xFB66, 0x5D32)  (  -4.6015625,   93.1953125)
--P.i=9  (x,y)= ( 20493, -10313)  (0x500D, 0xD7B7)  ( 80.05078125, -40.28515625)
--P.i=10 (x,y)= (-17871,  -7080)  (0xBA31, 0xE458)  (-69.80859375,    -27.65625)
--P.i=11 (x,y)= ( 12451,  -9894)  (0x30A3, 0xD95A)  ( 48.63671875,  -38.6484375)
--P.i=12 (x,y)= ( 24869, -30371)  (0x6125, 0x895D)  ( 97.14453125, -118.63671875)
--P.i=13 (x,y)= (-20219, -23785)  (0xB105, 0xA317)  (-78.98046875, -92.91015625)
--P.i=14 (x,y)= (-22440,  23273)  (0xA858, 0x5AE9)  (   -87.65625,  90.91015625)
--P.i=15 (x,y)= (-31650, -22316)  (0x845E, 0xA8D4)  (-123.6328125,   -87.171875)

--Line Results:        Integer  Hexdecimal   Fix Point
--  0: fitError =    128122528  (07A2FEA0)   62559.828125    
--     Display solution Q24.8  _(00F45FD4)_  62559.828125    
--  1: fitError =    190766452  (0B5EDD74)   93147.6816406   
--     Display solution Q24.8  _(016BDBAE)_  93147.6796875   
--  2: fitError =     65837380  (03EC9944)   32147.1582031   
--     Display solution Q24.8  _(007D9328)_  32147.15625     
--  3: fitError =    198420725  (0BD3A8F5)   96885.1196289   
--     Display solution Q24.8  _(017A751E)_  96885.1171875   
--* 4: fitError =     57600208  (036EE8D0)   28125.1015625   
--*    Display solution Q24.8  _(006DDD1A)_  28125.1015625   
--  5: fitError =    164137513  (09C88A29)   80145.2700195   
--     Display solution Q24.8  _(01391145)_  80145.2695312   
--  6: fitError =    121784793  (074249D9)   59465.230957    
--     Display solution Q24.8  _(00E8493B)_  59465.2304688   
--  7: fitError =    158294545  (096F6211)   77292.2583008   
--     Display solution Q24.8  _(012DEC42)_  77292.2578125   

entity MemIN is
  port (
    clk    : in  std_logic;
    addr_a : in  std_logic_vector(9 downto 0);
    addr_b : in  std_logic_vector(9 downto 0);
    do_a : out std_logic_vector(31 downto 0);
    do_b : out std_logic_vector(31 downto 0)
    );
end MemIN;


architecture GEN_mem1 of MemIN is
begin

  MEM_mem1 : BRAM_TDP_MACRO
    generic map (                       -- memory initialization
      INIT_00 => X"A9E3E14641F21EFB58BAD7AB1F297CCD944A58ECDC515CFF98694873456723C6",
      INIT_01 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_02 => X"C4C9079AC233D79FFFFF00010F76255A80007FFF231BE9E8085427F8007C62C2",
      INIT_03 => X"845EA8D4A8585AE9B105A3176125895D30A3D95ABA31E458500DD7B7FB665D32",
      INIT_04 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_05 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0001",
      INIT_06 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_07 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000001",
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
end GEN_mem1;


