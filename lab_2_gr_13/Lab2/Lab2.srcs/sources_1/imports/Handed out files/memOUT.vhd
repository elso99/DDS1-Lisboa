-----------------------------------------------------------------------------
-- Vhdl model created on Oct 2022, (c) 2022 Paulo Flores.
-----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library UNISIM;
use UNISIM.Vcomponents.all;


entity MemOUT is
  port (
    addr_memOut : in  std_logic_vector(8 downto 0);
    we          : in  std_logic;
    dataIN      : in  std_logic_vector(31 downto 0);
    dataOUT     : out std_logic_vector(31 downto 0);
    clk         : in  std_logic
    );
end MemOUT;


architecture gen of MemOUT is
begin

  MEM_out : RAMB16_S36
    port map (
      ADDR => addr_memOUT,              -- 9-bit Address Input
      CLK  => clk,                      -- Clock
      DI   => dataIN,                   -- 32-bit Data Input
      DIP  => "0000",                   -- 4-bit parity Input
      EN   => '1',                      -- RAM Enable Input
      SSR  => '0',                      -- Synchronous Set/Reset Input
      WE   => we,                       -- Write Enable Input
      DO   => dataOUT,                  -- 32-bit Data Output
      DOP  => open                      -- 4-bitt parity Output
      );
end gen;
