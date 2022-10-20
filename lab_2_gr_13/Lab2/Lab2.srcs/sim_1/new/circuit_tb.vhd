library ieee;
use ieee.std_logic_1164.all;

entity circuit_tb is
end circuit_tb;

architecture behavior of circuit_tb is

  component circuit
    port (
      clk         : in std_logic; -- OK
      rst         : in std_logic; -- OK
      sel_set     : in std_logic_vector (1 downto 0); -- select signal for different sets in memIN. mandatory
      done        : out std_logic; -- OK
      dataOUT   : out std_logic_vector (31 downto 0); -- OK
      addr_memIN  : out std_logic_vector (4 downto 0); -- OK
      addr_memOut : out std_logic_vector (1 downto 0); -- OK
      we          : out std_logic -- OK
    );
  end component;

  -- inputs
  signal clk            : std_logic                         :='0';
  signal rst            : std_logic                         :='1';
  signal sel_set        : std_logic_vector (1 downto 0)     :="00";
  
  -- outputs
  signal done        : std_logic;
  signal dataOUT   : std_logic_vector (31 downto 0);
  signal addr_memIN  : std_logic_vector (4 downto 0);
  signal addr_memOut : std_logic_vector (1 downto 0);
  signal we          : std_logic;
  
  -- Clock period definitions
constant clk_period : time := 10 ns;
constant p : time := 1500ns; -- some buffer added

begin

  -- Instantiate the Unit Under Test (UUT)
  uut : circuit port map (
    clk         => clk,
    rst         => rst,
    sel_set     => sel_set,
    done        => done,
    dataOUT   => dataOUT,
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
    wait for 80 ns;
    -- insert stimulus here
    -- note that input signals should never change at the positive edge of the clock
    sel_set     <=  "00" after 40 ns,
                    "01" after  p + 40 ns,
                    "10" after  2*p + 40 ns,
                    "11" after  3*p + 40 ns;
    
    rst         <=  '0'  after 60 ns,          
                    '1'  after  p,    
                    '0'  after  p + 80 ns,
                    '1'  after  2*p,   
                    '0'  after  2*p + 80 ns,
                    '1'  after  3*p,   --testing inerrupt begin
                    '0'  after  3*p + 80 ns,
                    '1'  after  3*p + 500 ns,   
                    '0'  after  3*p + 580 ns, -- end
                    '1'  after  4*p,
                    '0'  after  4*p + 80 ns,
                    '1'  after  5*p;
    wait;
  end process;

end;