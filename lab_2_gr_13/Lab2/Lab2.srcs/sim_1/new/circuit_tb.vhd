library ieee;
use ieee.std_logic_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

entity circuit_tb is
end circuit_tb;

architecture behavior of circuit_tb is

  -- Component Declaration for the Unit Under Test (UUT)

  component circuit
    port (
      clk         : in std_logic;
      rst         : in std_logic;
      sel_set     : in std_logic_vector (1 downto 0);
      done        : out std_logic;
      nr_output   : out std_logic_vector (31 downto 0);
      addr_memIN  : inout std_logic_vector (8 downto 0);
      addr_memOut : inout std_logic_vector (8 downto 0);
      we          : inout std_logic
    );
  end component;

  -- inputs
  signal clk         : std_logic                        :='0';
  signal rst         : std_logic                        :='1';
  signal sel_set     : std_logic_vector (1 downto 0)    :="00";
  
  -- outputs
  signal done        : std_logic;
  signal nr_output   : std_logic_vector (31 downto 0);
  signal addr_memIN  : std_logic_vector (8 downto 0);
  signal addr_memOut : std_logic_vector (8 downto 0);
  signal we          : std_logic;
  
  -- Clock period definitions
  constant clk_period : time := 20 ns;

begin

  -- Instantiate the Unit Under Test (UUT)
  uut : circuit port map (
    clk         => clk,
    rst         => rst,
    sel_set     => sel_set,
    done        => done,
    nr_output   => nr_output,
    addr_memIN  => addr_memIN,
    addr_memOut => addr_memOut,
    we          => we
    );

  -- Clock definition
  clk <= not clk after clk_period/2; -- 20ns

  -- Stimulus process
  stim_proc : process
  begin
    -- hold reset state for 100 ns.
    wait for 100 ns;

    wait for clk_period;

    -- insert stimulus here
    -- note that input signals should never change at the positive edge of the clock
    rst   <= '0' after 80 ns;
    sel_set <= "01" after 40 ns;          

    wait;
  end process;

end;