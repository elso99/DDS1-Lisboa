library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity circuit_tb is
end circuit_tb;

architecture Behavioral of circuit_tb is

component circuit
    port( 
        clk                 : in std_logic;
        --sw0                 : in std_logic; --disp LSB or MSB
        btnR                : in std_logic;
        rst                 : in std_logic; -- btnC
        fit_error           : out std_logic_vector(31 downto 0);
        k                   : out std_logic_vector(7 downto 0) --to control what led from 0 to 7 that should light up.
    );
end component;
    --inputs
    signal clk          : std_logic     := '0';
    --signal sw0          : std_logic     := '0';
    signal btnR         : std_logic     := '0';
    signal btnC         : std_logic     := '0'; --rst
    
    --outputs
    signal fit_error    : std_logic_vector(31 downto 0);
    signal k            : std_logic_vector(7 downto 0);

    --constants
    constant clk_period : time := 20 ns;
    --constant p : time := 1500ns;
begin
    uut : circuit port map (
        clk         => clk,
        rst         => btnC,
        btnR        => btnR,
        --sw0         => sw0,
        fit_error   => fit_error,
        k           => k
    );
-- Clock oscillates
    clk <= not clk after clk_period/2; -- 10ns

    stim_proc : process
        begin
            wait for 80 ns;
            
            btnC <= '1' after 30 ns,
                    '0' after 100 ns; --reset
            
            btnR <= '1' after 140 ns, --begin
                    '0' after 160 ns;
            
            --sw0 <= '1'  after 1000 ns;
            
            wait;
    end process;

end Behavioral;
