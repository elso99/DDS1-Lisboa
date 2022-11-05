library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity linecalc is
        Port ( 
        clk         : in std_logic;
        rst         : in std_logic;
        en          : in std_logic;
        mb, xy      : in std_logic_vector (31 downto 0); -- m = mb(31 downto 16)...
        line_err    : out signed (31 downto 0));
end linecalc;

architecture Behavioral of linecalc is
    signal reg_y_delay_1, reg_y_delay_2, reg_b_delay    : signed (15 downto 0); -- delay registers
    signal reg_mult, reg_add, reg_sub, reg_abs          : signed (31 downto 0); -- registers
    signal do_mult, do_add, do_sub              : signed (31 downto 0); -- operation signals
    signal do_abs                                       : signed(31 downto 0);

begin
    do_mult     <=  signed(mb(31 downto 16)) * signed(xy(31 downto 16));
    do_add      <=  reg_mult + resize(reg_b_delay & "00000000", reg_mult'length);
    do_sub      <=  reg_add - resize(reg_y_delay_2 & "00000000", reg_add'length);
    do_abs      <=  signed(abs(reg_sub));
    line_err    <=  reg_abs;
    
    process (clk)
    begin
        if rising_edge(clk) then
            if rst='1' then
                reg_y_delay_1   <= (others => '0');
                reg_y_delay_2   <= (others => '0');
                reg_b_delay     <= (others => '0');
                reg_mult        <= (others => '0');
                reg_add         <= (others => '0');
                reg_sub         <= (others => '0');
                reg_abs         <= (others => '0');
            end if;
            if en='1' then
                reg_mult        <= do_mult;
                reg_add         <= do_add;
                reg_sub         <= do_sub;
                reg_abs         <= do_abs;
                reg_y_delay_1   <= signed(xy(15 downto 0));
                reg_y_delay_2   <= reg_y_delay_1;
                reg_b_delay     <= signed(mb(15 downto 0));  
            end if;
        end if;
    end process;
end Behavioral;