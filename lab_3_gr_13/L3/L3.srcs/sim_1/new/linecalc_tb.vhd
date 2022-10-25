library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity linecalc_tb is
end linecalc_tb;

architecture Behavioral of linecalc_tb is

component linecalc
    Port ( 
        clk                        : in std_logic;
        rst                        : in std_logic;
        en_reg                     : in std_logic_vector (2 downto 0);
        m, b, x, y                 : in std_logic_vector (15 downto 0);
        fit_err                    : out std_logic_vector (31 downto 0));

end component;

    signal clk              : std_logic                         := '0';
    signal rst              : std_logic := '1';
    signal m, b, x, y       : std_logic_vector (15 downto 0);
    signal fit_err          : std_logic_vector (31 downto 0);
    signal en_reg           : std_logic_vector (2 downto 0);
    
    constant clk_period : time := 20 ns;
    constant p : time := 1200 ns; -- some buffer signal
    
begin
  uut : linecalc port map (
    clk             => clk,
    rst             => rst,
    m               => m,
    b               => b,
    x               => x,
    y               => y,
    en_reg          => en_reg,
    fit_err         => fit_err
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
    rst    <=  '0' after 100 ns;
    m      <=  x"4567" after 180 ns;
    b      <=  x"23C6" after 180 ns;
    x      <=  x"007C" after 180 ns;
    y      <=  x"62C2" after 180 ns;
    en_reg <=   "011" after 200 ns,
                "000" after 220 ns,
                "100" after 240 ns;
                --"000" after 260 ns,
                --"100" after 280 ns,
                --"000" after 300 ns,
                --"100" after 320 ns,
                --"000" after 340 ns,
                --"100" after 360 ns,
                --"000" after 380 ns,
                --"100" after 400 ns,
                --"000" after 420 ns,
                --"100" after 440 ns,
                --"000" after 460 ns,
                --"100" after 480 ns,
                --"000" after 500 ns;
                
                
    wait;
end process;  
    
   

end Behavioral;