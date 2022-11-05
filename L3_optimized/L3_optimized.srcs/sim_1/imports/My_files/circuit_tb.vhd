library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity circuit_tb is
end circuit_tb;

architecture Behavioral of circuit_tb is

component circuit
    port( 
        clk                 : in std_logic;
        --sw0                 : in std_logic; --disp LSB or MSB
        done                : out std_logic;
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
    signal done         : std_logic;
    
    --outputs
    signal fit_error    : std_logic_vector(31 downto 0);
    signal k            : std_logic_vector(7 downto 0);

    --constants
    constant clk_period : time := 10 ns;
    --constant p : time := 1500ns;
begin
    uut : circuit port map (
        clk         => clk,
        rst         => btnC,
        btnR        => btnR,
        --sw0         => sw0,
        done        => done,
        fit_error   => fit_error,
        k           => k
    );
-- Clock oscillates
    clk <= not clk after clk_period/2; -- 10ns

    stim_proc : process
        begin
            wait for 80 ns;
            
            btnC <= '1' after 30 ns,
                    '0' after 90 ns; --reset
            
            btnR <= '1' after 110 ns, --begin
                    '0' after 130 ns;
            
            --sw0 <= '1'  after 1000 ns;
            
            wait;
    end process;

end Behavioral;
