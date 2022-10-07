-----------------------------------------------------------------------------
-- Vhdl model created by memgen, (c) 2022 Paulo Flores.
-- Version: 1
-- Command: memgen.pl -s 7
-- Seed: -s 7
-----------------------------------------------------------------------------
library ieee;
library UNISIM;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use UNISIM.Vcomponents.all;

-- Set 0   m[0] = -109 + -98 i		 b[0] = -76 + 51 i
-- i:      Xr +    Xi   =>         Yr  +    Yi 	     Yr     +     Yi
-- 0: x=  -57 + -100 i  =>   y=  -3663 +  16537 i  (0xFFFFF1B1 + 0x00004099 i)
-- 1: x=  -55 +  -22 i  =>   y=    100 +  24376 i  (0x00000064 + 0x00005F38 i)
-- 2: x=   33 +   66 i  =>   y=   2895 +  13999 i  (0x00000B4F + 0x000036AF i)
-- 3: x=  104 +    5 i  =>   y=  -8027 +   3313 i  (0xFFFFE0A5 + 0x00000CF1 i)
-- 4: x=  121 +  -22 i  =>   y= -23448 +  -6096 i  (0xFFFFA468 + 0xFFFFE830 i)
-- 5: x=   16 +  -25 i  =>   y= -27718 +  -4888 i  (0xFFFF93BA + 0xFFFFECE8 i)
-- 6: x=   -4 +  -50 i  =>   y= -32258 +   1005 i  (0xFFFF81FE + 0x000003ED i)
-- 7: x=  -30 +  -46 i  =>   y= -33572 +   9010 i  (0xFFFF7CDC + 0x00002332 i)
-- Sol[0]:		         -4196 +   1126 i  (0xFFFFEF9C + 0x00000466 i)

-- Set 1   m[1] = -24 + -104 i		 b[1] = 29 + 111 i
-- i:      Xr +    Xi   =>         Yr  +    Yi 	     Yr     +     Yi
-- 0: x= -193 +  -53 i  =>   y=   -851 +  21455 i  (0xFFFFFCAD + 0x000053CF i)
-- 1: x= -365 +   10 i  =>   y=   8978 +  59286 i  (0x00002312 + 0x0000E796 i)
-- 2: x= -260 + -498 i  =>   y= -36545 +  98389 i  (0xFFFF713F + 0x00018055 i)
-- 3: x=  336 + -450 i  =>   y= -91380 +  74356 i  (0xFFFE9B0C + 0x00012274 i)
-- 4: x=  205 +  239 i  =>   y= -71415 +  47411 i  (0xFFFEE909 + 0x0000B933 i)
-- 5: x= -508 + -431 i  =>   y= -104018 + 110698 i  (0xFFFE69AE + 0x0001B06A i)
-- 6: x= -436 + -508 i  =>   y= -146357 + 168345 i  (0xFFFDC44B + 0x00029199 i)
-- 7: x= -489 +  461 i  =>   y= -86648 + 208248 i  (0xFFFEAD88 + 0x00032D78 i)
-- Sol[1]:		        -10831 +  26031 i  (0xFFFFD5B1 + 0x000065AF i)

-- Set 2   m[2] = -77 + 33 i		 b[2] = -84 + 45 i
-- i:      Xr +    Xi   =>         Yr  +    Yi 	     Yr     +     Yi
-- 0: x=   59 + -234 i  =>   y=   3095 +  20010 i  (0x00000C17 + 0x00004E2A i)
-- 1: x= -128 +   44 i  =>   y=  11415 +  12443 i  (0x00002C97 + 0x0000309B i)
-- 2: x=  -17 +  313 i  =>   y=   2311 + -12174 i  (0x00000907 + 0xFFFFD072 i)
-- 3: x= -431 +   16 i  =>   y=  34886 + -27584 i  (0x00008846 + 0xFFFF9440 i)
-- 4: x=   81 + -450 i  =>   y=  43415 +   9784 i  (0x0000A997 + 0x00002638 i)
-- 5: x=   78 +  157 i  =>   y=  32144 +    314 i  (0x00007D90 + 0x0000013A i)
-- 6: x=  320 +  408 i  =>   y=  -6044 + -20497 i  (0xFFFFE864 + 0xFFFFAFEF i)
-- 7: x= -485 + -209 i  =>   y=  38114 + -20364 i  (0x000094E2 + 0xFFFFB074 i)
-- Sol[2]:		          4764 +  -2545 i  (0x0000129C + 0xFFFFF60F i)

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


architecture GEN7 of MemIN is
   signal ImRe: std_logic_vector(31 downto 0);
begin

  MEM0_DataIN : RAMB16_S36
    generic map (                       -- memory initialization
      INIT_00 => X"FFFCFFCE0010FFE70079FFEA0068000500210042FFC9FFEAFFC7FF9C939EB433",
      INIT_01 => X"00000000000000000000000000000000000000000000000000000000FFE2FFD2",
      INIT_02 => X"FE4CFE04FE04FE5100CD00EF0150FE3EFEFCFE0EFE93000AFF3FFFCBE8981D6F",
      INIT_03 => X"00000000000000000000000000000000000000000000000000000000FE1701CD",
      INIT_04 => X"01400198004E009D0051FE3EFE510010FFEF0139FF80002C003BFF16B321AC2D",
      INIT_05 => X"00000000000000000000000000000000000000000000000000000000FE1BFF2F",
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

end GEN7;
