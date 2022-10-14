library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_tb is
end control_tb;

architecture Behavioral of control_tb is

component control
port(
    clk             : in std_logic;
    rst             : in std_logic;
    sel_set         : in std_logic_vector (1 downto 0); -- the 4 different memory addresses used for computation.
    done            : out std_logic;
    sw_out          : out std_logic;  -- choose who of VTr & VTi in datapa that write to RAMB16
    mem_out_we      : out std_logic;
    mem_out_addr    : out std_logic_vector (8 downto 0);
    mem_in_addr     : out std_logic_vector (8 downto 0);
    sel_load        : out std_logic_vector (1 downto 0); -- 00 nothing, 01 M & B, 10 Xr & Xi.
    oper            : out std_logic_vector (2 downto 0);
    en_reg          : out std_logic_vector (5 downto 0); -- AR1[5], AR2[4], MR1[3], MR2[2], YTR[1], YTI[0]
    st              : out std_logic_vector (3 downto 0));
end component;

signal clk : std_logic := '0';
signal rst : std_logic := '1';
signal sel_set : std_logic_vector(1 downto 0) := "00"; 

signal done            : std_logic;
signal sw_out          : std_logic;  -- choose who of VTr & VTi in datapa that write to RAMB16
signal mem_out_we      : std_logic;
signal mem_out_addr    : std_logic_vector (8 downto 0);
signal mem_in_addr     : std_logic_vector (8 downto 0);
signal sel_load        : std_logic_vector (1 downto 0); -- 00 nothing, 01 M & B, 10 Xr & Xi.
signal oper            : std_logic_vector (2 downto 0);
signal en_reg          : std_logic_vector (5 downto 0); -- AR1[5], AR2[4], MR1[3], MR2[2], YTR[1], YTI[0]
signal st              : std_logic_vector (3 downto 0);

constant clk_period : time := 20 ns;
constant p : time := 1200 ns; -- some buffer added

begin
  uut : control port map (
    clk             => clk,
    rst             => rst,
    sel_set         => sel_set,
    
    done            => done,
    sw_out          => sw_out,
    mem_out_we      => mem_out_we,
    mem_out_addr    => mem_out_addr,
    mem_in_addr     => mem_in_addr,
    sel_load        => sel_load,
    oper            => oper,
    en_reg          => en_reg,
    st              => st
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
    
    rst         <=  '0'  after 70 ns,          
                    '1'  after  p,    
                    '0'  after  p + 70 ns,
                    '1'  after  2*p,   
                    '0'  after  2*p + 70 ns,
                    '1'  after  3*p,   --testing inerrupt begin
                    '0'  after  3*p + 70 ns,
                    '1'  after  3*p + 500 ns,   
                    '0'  after  3*p + 540 ns, -- end
                    '1'  after  4*p,
                    '0'  after  4*p + 70 ns,
                    '1'  after  5*p;
    wait;
  end process;

end Behavioral;
