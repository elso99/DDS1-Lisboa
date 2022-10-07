--------------------------------------------------------------------------------
-- Description:
--
-- VHDL Test Bench Created by ISE for module: memsdata
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes:
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the
-- post-implementation simulation model.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity memIN_tb is
end memIN_tb;

architecture behavior of memIN_tb is

  -- Component Declaration for the Unit Under Test (UUT)
  component MemIN
    port (
      clk        : in  std_logic;
      addr_memIN : in  std_logic_vector(8 downto 0);
      Xr, Xi     : out std_logic_vector(15 downto 0)
      );
  end component;

  --Inputs
  signal addr_memIN : std_logic_vector(8 downto 0) := (others => '0');
  signal clk  : std_logic                    := '0';

  --Outputs
  signal Xi, Xr : std_logic_vector(15 downto 0);
  -- Clock period definitions
  constant clk_period   : time := 20 ns;  -- T = 20 ns, f = 50 MHz

  signal run : std_logic := '0';
begin

  -- Instantiate the Unit Under Test (UUT)
  uut : MemIN port map (
    clk => clk,
    addr_memIN => addr_memIN,
    Xr => Xr,
    Xi => Xi
    );


-- Clock process definitions 0 10^ 20 30^...
  clk <= not clk after clk_period/2;
  --clk_process : process
  --begin
  --  clk <= '0';
  --  wait for
  --  clk <= '1';
  --  wait for clk_period/2;
  --end process;


  -- Stimulus process
  stim_proc : process
  begin
    -- hold reset state for 100ms.
    wait for 100 ns;

    wait for 25 ns;
    run <= '1';
  -- insert stimulus here
  end process;

  address_counter : process
  begin
    wait for 40 ns;
    if (run = '1') then
      if addr_memIN = "000111111" then
        addr_memIN <= "000000000";
      else
        addr_memIN <= addr_memIn + 1;
      end if;
    end if;
  end process;

end;
