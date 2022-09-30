--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:   14:31:45 09/10/2014
-- Design Name:
-- Module Name:   C:/xup/vhdl/introLab/tb_circuito.vhd
-- Project Name:  introLab
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: circuito
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
-- to guarantee that the testbench will bind correctly to the post-implementation
-- simulation model.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

entity circuito_tb is
end circuito_tb;

architecture behavior of circuito_tb is

  -- Component Declaration for the Unit Under Test (UUT)

  component circuito
    port (
    clk, sw_15  : in  std_logic;
    instr     : in  std_logic_vector(4 downto 0);
    ent   : in  std_logic_vector(11 downto 0);
    disp : out std_logic_vector(11 downto 0)
    );
  end component;


  --Inputs
  signal clk     : std_logic                    := '0';
  signal sw_15   : std_logic                    := '0';
  signal instr   : std_logic_vector(4 downto 0) := (others => '0');
  signal ent     : std_logic_vector(11 downto 0) := (others => '0');

  --Outputs
  signal disp  : std_logic_vector(11 downto 0);

  -- Clock period definitions
  constant clk_period : time := 10 ns;

begin

  -- Instantiate the Unit Under Test (UUT)
  uut : circuito port map (
    clk     => clk,
    sw_15   => sw_15,
    instr   => instr,
    ent     => ent,
    disp    => disp
    );

  -- Clock definition
  clk <= not clk after clk_period/2;

  -- Stimulus process
  stim_proc : process
  begin
    -- hold reset state for 100 ns.
    wait for 100 ns;

    wait for clk_period*10;

    -- insert stimulus here
    -- note that input signals should never change at the positive edge of the clock
    sw_15   <= '1' after 40 ns,
                '0' after 400 ns;
                
    ent     <= X"002" after 40 ns,
               X"003" after 360 ns;
    instr <= "10000" after 40 ns, -- load 002 to reg1
             "00000" after 80 ns,
             "00001" after 120 ns,-- load 002 to reg2
             "00000" after 160 ns,
             "00010" after 200 ns,-- mult 004
             "00000" after 240 ns,
             "00010" after 280 ns, -- mult 008
             "00000" after 320 ns,
             "01000" after 360 ns, -- add 00A
             "00000" after 400 ns,
             "01000" after 440 ns, -- xnor ff7
             "00000" after 480 ns,
             "01000" after 520 ns, --xnor 00a
             "00000" after 560 ns,
             "10000" after 600 ns, -- 003 
             "00000" after 640 ns,
             "00010" after 680 ns, -- rtr 801 
             "00000" after 720 ns,
             "00100" after 760 ns, -- reset
             "00000" after 800 ns;

    wait;
  end process;

end;