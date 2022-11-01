-----------------------------------------------------------------------------
-- VHDL memory model created by bestapprox, (c) 2022 Paulo Flores.
-- Version: 2.0
-- Command: bestapprox 1666800413 mem2
-- Seed: 1666800413
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
--L.k=0  (m,b)= ( 24883,  20968)->(0x6133, 0x51E8)->( 97.19921875,     81.90625)
--L.k=1  (m,b)= (-10348,  22815)->(0xD794, 0x591F)->(  -40.421875,  89.12109375)
--L.k=2  (m,b)= ( 31711,  28710)->(0x7BDF, 0x7026)->(123.87109375,  112.1484375)
--L.k=3  (m,b)= ( 24548,  -3919)->(0x5FE4, 0xF0B1)->(   95.890625, -15.30859375)
--L.k=4  (m,b)= (-23087,  19371)->(0xA5D1, 0x4BAB)->(-90.18359375,  75.66796875)
--L.k=5  (m,b)= (-26594,  23616)->(0x981E, 0x5C40)->(-103.8828125,        92.25)
--L.k=6  (m,b)= (  8737, -10270)->(0x2221, 0xD7E2)->( 34.12890625,  -40.1171875)
--L.k=7  (m,b)= ( 25144, -11034)->(0x6238, 0xD4E6)->(    98.21875,  -43.1015625)

-- Mem. Address: 0x010
--P.i=0  (x,y)= (  -480, -26733)  (0xFE20, 0x9793)  (      -1.875, -104.42578125)
--P.i=1  (x,y)= (-26121, -12876)  (0x99F7, 0xCDB4)  (-102.03515625,   -50.296875)
--P.i=2  (x,y)= (  4315,  27279)  (0x10DB, 0x6A8F)  ( 16.85546875, 106.55859375)
--P.i=3  (x,y)= (-32768,  32767)  (0x8000, 0x7FFF)  (        -128, 127.99609375)
--P.i=4  (x,y)= (  7777,   1465)  (0x1E61, 0x05B9)  ( 30.37890625,   5.72265625)
--P.i=5  (x,y)= (    -1,      1)  (0xFFFF, 0x0001)  ( -0.00390625,   0.00390625)
--P.i=6  (x,y)= ( 19762, -16595)  (0x4D32, 0xBF2D)  (  77.1953125, -64.82421875)
--P.i=7  (x,y)= (-10069, -20891)  (0xD8AB, 0xAE65)  (-39.33203125, -81.60546875)
--P.i=8  (x,y)= (  4373, -20416)  (0x1115, 0xB040)  ( 17.08203125,       -79.75)
--P.i=9  (x,y)= (  1924, -29452)  (0x0784, 0x8CF4)  (    7.515625,  -115.046875)
--P.i=10 (x,y)= (  8294,  26472)  (0x2066, 0x6768)  (  32.3984375,    103.40625)
--P.i=11 (x,y)= ( 32165, -14793)  (0x7DA5, 0xC637)  (125.64453125, -57.78515625)
--P.i=12 (x,y)= (-19693,   5571)  (0xB313, 0x15C3)  (-76.92578125,  21.76171875)
--P.i=13 (x,y)= (  8823, -10956)  (0x2277, 0xD534)  ( 34.46484375,   -42.796875)
--P.i=14 (x,y)= ( -4699, -31568)  (0xEDA5, 0x84B0)  (-18.35546875,    -123.3125)
--P.i=15 (x,y)= (-21990,  -5179)  (0xAA1A, 0xEBC5)  ( -85.8984375, -20.23046875)

--Line Results:        Integer  Hexdecimal   Fix Point
--  0: fitError =    158224380  (096E4FFC)   77257.9980469   
--     Display solution Q24.8  _(012DC9FF)_  77257.9960938   
--  1: fitError =     65902551  (03ED97D7)   32178.9799805   
--     Display solution Q24.8  _(007DB2FA)_  32178.9765625   
--  2: fitError =    201700421  (0C05B445)   98486.5336914   
--     Display solution Q24.8  _(0180B688)_  98486.53125     
--  3: fitError =    155745922  (09487E82)   76047.8134766   
--     Display solution Q24.8  _(01290FD0)_  76047.8125      
--  4: fitError =    146816697  (08C03EB9)   71687.840332    
--     Display solution Q24.8  _(011807D7)_  71687.8398438   
--  5: fitError =    169092068  (0A1423E4)   82564.4863281   
--     Display solution Q24.8  _(0142847C)_  82564.484375    
--* 6: fitError =     55320690  (034C2072)   27012.0556641   
--*    Display solution Q24.8  _(0069840E)_  27012.0546875   
--  7: fitError =    159531527  (09824207)   77896.253418    
--     Display solution Q24.8  _(01304840)_  77896.25        

entity MemIN is
  port (
    clk    : in  std_logic;
    addr_a : in  std_logic_vector(9 downto 0);
    addr_b : in  std_logic_vector(9 downto 0);
    do_a : out std_logic_vector(31 downto 0);
    do_b : out std_logic_vector(31 downto 0)
    );
end MemIN;


architecture GEN_mem2 of MemIN is
begin

  MEM_mem2 : BRAM_TDP_MACRO
    generic map (                       -- memory initialization
      INIT_00 => X"6238D4E62221D7E2981E5C40A5D14BAB5FE4F0B17BDF7026D794591F613351E8",
      INIT_01 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_02 => X"D8ABAE654D32BF2DFFFF00011E6105B980007FFF10DB6A8F99F7CDB4FE209793",
      INIT_03 => X"AA1AEBC5EDA584B02277D534B31315C37DA5C6372066676807848CF41115B040",
      INIT_04 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_05 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0001",
      INIT_06 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_07 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF63595B1D",
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
end GEN_mem2;


