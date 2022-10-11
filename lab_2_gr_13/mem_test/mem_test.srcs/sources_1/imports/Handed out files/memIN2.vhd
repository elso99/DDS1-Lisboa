-----------------------------------------------------------------------------
-- Vhdl model created by memgen, (c) 2022 Paulo Flores.
-- Version: 1
-- Command: memgen.pl -s 11
-- Seed: -s 11
-----------------------------------------------------------------------------
library ieee;
library UNISIM;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use UNISIM.Vcomponents.all;

-- Set 0   m[0] = -1 + -70 i		 b[0] = 10 + 96 i
-- i:      Xr +    Xi   =>         Yr  +    Yi 	     Yr     +     Yi
-- 0: x=  -41 +  -23 i  =>   y=  -1559 +   2989 i  (0xFFFFF9E9 + 0x00000BAD i)
-- 1: x=  116 +  105 i  =>   y=   5685 +  -5140 i  (0x00001635 + 0xFFFFEBEC i)
-- 2: x=  104 +  100 i  =>   y=  12591 + -12424 i  (0x0000312F + 0xFFFFCF78 i)
-- 3: x=   60 +   22 i  =>   y=  14081 + -16550 i  (0x00003701 + 0xFFFFBF5A i)
-- 4: x=  -35 +  -46 i  =>   y=  10906 + -13958 i  (0x00002A9A + 0xFFFFC97A i)
-- 5: x= -102 + -119 i  =>   y=   2688 +  -6603 i  (0x00000A80 + 0xFFFFE635 i)
-- 6: x= -126 +   64 i  =>   y=   7304 +   2249 i  (0x00001C88 + 0x000008C9 i)
-- 7: x=    8 + -120 i  =>   y=  -1094 +   1905 i  (0xFFFFFBBA + 0x00000771 i)
-- Sol[0]:		          -136 +    238 i  (0xFFFFFF78 + 0x000000EE i)

-- Set 1   m[1] = 21 + 111 i		 b[1] = -93 + -105 i
-- i:      Xr +    Xi   =>         Yr  +    Yi 	     Yr     +     Yi
-- 0: x= -399 +   58 i  =>   y= -14910 + -43176 i  (0xFFFFC5C2 + 0xFFFF5758 i)
-- 1: x=  342 + -302 i  =>   y=  25701 + -11661 i  (0x00006465 + 0xFFFFD273 i)
-- 2: x=  438 + -239 i  =>   y=  61335 +  31833 i  (0x0000EF97 + 0x00007C59 i)
-- 3: x=  484 +  206 i  =>   y=  48540 +  89778 i  (0x0000BD9C + 0x00015EB2 i)
-- 4: x=  216 + -158 i  =>   y=  70521 + 110331 i  (0x00011379 + 0x0001AEFB i)
-- 5: x= -474 +  262 i  =>   y=  31392 +  63114 i  (0x00007AA0 + 0x0000F68A i)
-- 6: x=  347 + -418 i  =>   y=  84984 +  92748 i  (0x00014BF8 + 0x00016A4C i)
-- 7: x=  139 +  304 i  =>   y=  54066 + 114456 i  (0x0000D332 + 0x0001BF18 i)
-- Sol[1]:		          6758 +  14307 i  (0x00001A66 + 0x000037E3 i)

-- Set 2   m[2] = 0 + -32 i		 b[2] = 84 + -42 i
-- i:      Xr +    Xi   =>         Yr  +    Yi 	     Yr     +     Yi
-- 0: x=  399 +  -41 i  =>   y=  -1228 + -12810 i  (0xFFFFFB34 + 0xFFFFCDF6 i)
-- 1: x=  159 +  503 i  =>   y=  14952 + -17940 i  (0x00003A68 + 0xFFFFB9EC i)
-- 2: x=  336 + -237 i  =>   y=   7452 + -28734 i  (0x00001D1C + 0xFFFF8FC2 i)
-- 3: x=  -13 +  126 i  =>   y=  11568 + -28360 i  (0x00002D30 + 0xFFFF9138 i)
-- 4: x= -480 + -100 i  =>   y=   8452 + -13042 i  (0x00002104 + 0xFFFFCD0E i)
-- 5: x= -197 +  -97 i  =>   y=   5432 +  -6780 i  (0x00001538 + 0xFFFFE584 i)
-- 6: x= -300 +   44 i  =>   y=   6924 +   2778 i  (0x00001B0C + 0x00000ADA i)
-- 7: x= -118 + -464 i  =>   y=  -7840 +   6512 i  (0xFFFFE160 + 0x00001970 i)
-- Sol[2]:		          -980 +    814 i  (0xFFFFFC2C + 0x0000032E i)

-- Set 3   m[3] = -512 + -512 i		 b[3] = 511 + 511 i
-- i:      Xr +    Xi   =>         Yr  +    Yi 	     Yr     +     Yi
-- 0: x= -512 + -512 i  =>   y=    511 + 524799 i  (0x000001FF + 0x000801FF i)
-- 1: x=  511 +  511 i  =>   y=   1022 +   2046 i  (0x000003FE + 0x000007FE i)
-- 2: x=  511 + -512 i  =>   y= -522243 +   3069 i  (0xFFF807FD + 0x00000BFD i)
-- 3: x= -512 +  511 i  =>   y=   2044 +   4092 i  (0x000007FC + 0x00000FFC i)
-- 4: x= -512 + -512 i  =>   y=   2555 + 528891 i  (0x000009FB + 0x000811FB i)
-- 5: x=  511 + -512 i  =>   y= -520710 + 529914 i  (0xFFF80DFA + 0x000815FA i)
-- 6: x= -512 +  511 i  =>   y=   3577 + 530937 i  (0x00000DF9 + 0x000819F9 i)
-- 7: x=  511 +  511 i  =>   y=   4088 +   8184 i  (0x00000FF8 + 0x00001FF8 i)
-- Sol[3]:		           511 +   1023 i  (0x000001FF + 0x000003FF i)



entity MemIN is
  port (
    clk          : in  std_logic;
    addr_memIN   : in  std_logic_vector(8 downto 0);
    Xr, Xi       : out std_logic_vector(15 downto 0)
    );
end MemIN;


architecture GEN11 of MemIN is
   signal ImRe: std_logic_vector(31 downto 0);
begin

  MEM0_DataIN : RAMB16_S36
    generic map (                       -- memory initialization 
      INIT_00 => X"FF820040FF9AFF89FFDDFFD2003C00160068006400740069FFD7FFE9FFBA0A60", -- 8-bit values => 60 in hex => 96 dec (6*16 + 0), FFE9 = Xi[0]
      INIT_01 => X"000000000000000000000000000000000000000000000000000000000008FF88", --0008 = Xr[7]
      INIT_02 => X"015BFE5EFE26010600D8FF6201E400CE01B6FF110156FED2FE71003A156FA397",
      INIT_03 => X"00000000000000000000000000000000000000000000000000000000008B0130",
      INIT_04 => X"FED4002CFF3BFF9FFE20FF9CFFF3007E0150FF13009F01F7018FFFD700E054D6",
      INIT_05 => X"00000000000000000000000000000000000000000000000000000000FF8AFE30",
      INIT_06 => X"FE0001FF01FFFE00FE00FE00FE0001FF01FFFE0001FF01FFFE00FE000000FFFF",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000001FF01FF",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
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
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
    port map (
      CLK   => clk,                     -- Clock
      ADDR  => addr_memIN,              -- 10-bit Address Input
      DI    => x"00000000",             -- 32-bit Data Input
      DIP   => x"0",                    -- 4-bit parity Input
      EN    => '1',                     -- RAM Enable Input
      SSR   => '0',                     -- Synchronous Set/Reset Input
      WE    => '0',                     -- Write Enable Input
      DO    => ImRe,                    -- 32-bit Data Output
      DOP   => open                     -- 1-bit parity Output
      );

   Xr <= ImRe(31 downto 16);
   Xi <= ImRe(15 downto 0);

end GEN11;
