library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- This module will calculate and output one error[k][i]. Will be possible to use for parallellisation.

entity linecalc is
    Port ( 
        clk                        : in std_logic;
        en_reg                     : in std_logic_vector (3 downto 0);
        m, b, x, y                 : in std_logic_vector (15 downto 0));
end linecalc;

architecture Behavioral of linecalc is
    signal m_reg, b_reg, x_reg, y_reg       : signed (15 downto 0);
begin

process (clk)
begin
    if clk'event and clk='1' then
        if en_reg(0)='1' then
            m_reg <= signed(m);
        if en_reg(1)='1' then
            b_reg <= signed(b);
        if en_reg(2)='1' then
            x_reg <= signed(x);
        if en_reg(3)='1' then
            y_reg <= signed(y);
end process

end Behavioral;