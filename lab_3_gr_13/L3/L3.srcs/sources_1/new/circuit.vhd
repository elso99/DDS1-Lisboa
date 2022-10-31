library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity circuit is
    port( 
        clk         : in std_logic;
        sw0         : in std_logic;
        btnR        : in std_logic;
        rst         : in std_logic; -- btnC
        fit_error   : out std_logic_vector(31 downto 0);
        k           : out std_logic_vector(7 downto 0) --to control what led from 0 to 7 that should light up.
    );
end circuit;

architecture Behavioral of circuit is

    component control
        port(
            clk             : in std_logic;
            btnR            : in std_logic; --start button
            rst             : in std_logic; --reset button which is btnD
            sw0             : in std_logic; -- displays either LSB or MSB
            done            : out std_logic;
            oper            : out std_logic_vector (3 downto 0); --0000 -nothing 0001 load mb, 0010 load xy, 0100 calculate
            mem_addr        : out std_logic_vector (8 downto 0) 
        );
    end component;

begin

    inst_control : control port map(
    );

end Behavioral;
