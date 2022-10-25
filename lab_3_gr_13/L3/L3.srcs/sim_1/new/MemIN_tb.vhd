library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MemIN_tb is
end MemIN_tb;

architecture Behavioral of MemIN_tb is

component MemIN
    port(
        clk    : in  std_logic;
        addr_a : in  std_logic_vector(9 downto 0);
        addr_b : in  std_logic_vector(9 downto 0);
        do_a : out std_logic_vector(31 downto 0);
        do_b : out std_logic_vector(31 downto 0)
    );
end component;

    signal clk              : std_logic := '0';
    signal addr_a, addr_b   : std_logic_vector (9 downto 0);
    signal do_a, do_b       : std_logic_vector (31 downto 0);
    
    constant clk_period : time := 20 ns;
    constant p : time := 1200 ns; -- some buffer signal

begin
uut : MemIN port map (
    clk             => clk,
    do_a            => do_a,
    do_b            => do_b,
    addr_a          => addr_a,
    addr_b          => addr_b
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
    addr_a      <=  "0000000000" after 100 ns,
                    "0000000001" after 200 ns,
                    "0000000010" after 300 ns;
                    
    addr_b      <=  "0000000000" after 100 ns,
                    "0000000001" after 200 ns,
                    "0000000011" after 300 ns;
                
                
    wait;
end process;

end Behavioral;
