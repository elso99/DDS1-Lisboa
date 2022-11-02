library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fpga_basicIO_tb is
--  Port ( );
end fpga_basicIO_tb;

architecture Behavioral of fpga_basicIO_tb is

component fpga_basicIO
port (
    clk                          : in  std_logic;  -- 100MHz clock
    btnU, btnL, btnR, btnD : in  std_logic;  -- buttons
    sw                           : in  std_logic;  -- switches
    led                          : out std_logic_vector(7 downto 0);  -- leds
    an                           : out std_logic_vector(3 downto 0);  -- display selectors
    seg                          : out std_logic_vector(6 downto 0);  -- display 7-segments
    dp                           : out std_logic   -- display point
    );
end component;
begin
 --inputs
 signal clk          : std_logic     := '0';
 --signal sw0          : std_logic     := '0';
 signal btnU         : std_logic     := '0';
 signal btnL         : std_logic     := '0';
 signal btnR         : std_logic     := '0';
 signal btnC         : std_logic     := '0'; --rst
 signal sw           : std_logic     := '0';
 
 --outputs
 signal fit_error    : std_logic_vector(31 downto 0);
 signal k            : std_logic_vector(7 downto 0);

 --constants
 constant clk_period : time := 20 ns;
 --constant p : time := 1500ns;
begin
 uut : fpga_basicIO port map (
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