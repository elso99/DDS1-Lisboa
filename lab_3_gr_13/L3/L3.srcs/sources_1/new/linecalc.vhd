library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity linecalc is
        Port ( 
        clk                        : in std_logic;
        rst                        : in std_logic;
        en_reg                     : in std_logic;
        m, b, x, y                 : in std_logic_vector (15 downto 0);
        fit_err                    : out std_logic_vector (31 downto 0));
end linecalc;

architecture Behavioral of linecalc is
    signal y_temp1, y_temp2, b_temp       : signed (15 downto 0);
    signal do_mult, mult_reg, do_add, add_reg, do_sub, sub_reg, do_abs, abs_reg, out_reg, do_out  : signed (31 downto 0);

begin
    do_mult <=  signed(m) * signed(x);
    do_add  <=  mult_reg + resize(b_temp & "00000000", mult_reg'length);
    do_sub  <=  add_reg - resize(y_temp2 & "00000000", add_reg'length);
    do_abs  <=  abs(sub_reg);
    do_out  <=  (out_reg + ("0000" & abs_reg(31 downto 4)));
    fit_err     <= std_logic_vector(out_reg);
    process (clk)
    begin
        if clk'event and clk='1' then
            if rst='1' then
                y_temp1 <= (others => '0');
                y_temp2 <= (others => '0');
                b_temp  <= (others => '0');
                mult_reg <= (others => '0');
                add_reg <= (others => '0');
                sub_reg <= (others => '0');
                abs_reg <= (others => '0');
                out_reg <= (others => '0');
            end if;
            if en_reg='1' then
                mult_reg <= do_mult;
                add_reg <= do_add;
                sub_reg <= do_sub;
                abs_reg <= do_abs;
                y_temp1 <= signed(y);
                y_temp2 <= y_temp1;
                b_temp  <= signed(b);
                out_reg <= do_out;
            end if;
        end if;
    end process;
end Behavioral;