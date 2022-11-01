library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity linecalc is
        Port ( 
        clk                         : in std_logic;
        rst                         : in std_logic;
        en_reg                      : in std_logic;
        m, b, x, y                  : in std_logic_vector (15 downto 0);
        line_err                    : out signed (31 downto 0));
end linecalc;

architecture Behavioral of linecalc is
    signal y_delay_1, y_delay_2, b_delay_1       : signed (15 downto 0); -- delay registers
    signal do_mult, mult_reg, do_add, add_reg, do_sub, sub_reg, do_abs, abs_reg  : signed (31 downto 0);

begin
    do_mult <=  signed(m) * signed(x);
    do_add  <=  mult_reg + resize(b_delay_1 & "00000000", mult_reg'length);
    do_sub  <=  add_reg - resize(y_delay_2 & "00000000", add_reg'length);
    do_abs  <=  abs(sub_reg);
    line_err <= abs_reg;
    
    process (clk)
    begin
        if clk'event and clk='1' then
            if rst='1' then
                y_delay_1 <= (others => '0');
                y_delay_2 <= (others => '0');
                b_delay_1  <= (others => '0');
                mult_reg <= (others => '0');
                add_reg <= (others => '0');
                sub_reg <= (others => '0');
                abs_reg <= (others => '0');
            end if;
            if en_reg='1' then
                mult_reg <= do_mult;
                add_reg <= do_add;
                sub_reg <= do_sub;
                abs_reg <= do_abs;
                y_delay_1 <= signed(y);
                y_delay_2 <= y_delay_1;
                b_delay_1 <= signed(b);
            end if;
        end if;
    end process;
end Behavioral;