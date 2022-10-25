library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.all;

entity datapath is
    port(
        clk : in std_logic;
        rst : in std_logic;
        oper : in std_logic_vector(3 downto 0);
        en_reg : in std_logic_vector(1 downto 0);
        do_a : in std_logic_vector(31 downto 0);
        do_b : in std_logic_vector(31 downto 0);
        fit_err : out std_logic_vector(31 downto 0)
    );
end datapath;

architecture Behavioral of datapath is
    
    component linecalc
    Port ( 
        clk                        : in std_logic;
        rst                        : in std_logic;
        en_reg                     : in std_logic;
        m, b, x, y                 : in std_logic_vector (15 downto 0);
        fit_err                    : out std_logic_vector (31 downto 0)
        );
    end component;

        signal m1, m2, m3, m4, m5, m6, m7, m8, b1, b2, b3, b4, b5, b6, b7, b8, x, y : std_logic_vector (15 downto 0);
        signal fit_err1, fit_err2, fit_err3, fit_err4, fit_err5, fit_err6, fit_err7, fit_err8, semi1, semi2, semi3, semi4, final1, final2 : std_logic_vector (31 downto 0);
begin
    
    inst_linecalc1 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg(0),
        m           => m1,
        b           => b1,
        fit_err     => fit_err1,
        x           => x,
        y           => y
        );

    inst_linecalc2 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg(0),
        m           => m2,
        b           => b2,
        fit_err     => fit_err2,
        x           => x,
        y           => y
        );

    inst_linecalc3 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg(0),
        m           => m3,
        b           => b3,
        fit_err     => fit_err3,
        x           => x,
        y           => y
        );

    inst_linecalc4 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg(0),
        m           => m4,
        b           => b4,
        fit_err     => fit_err4,
        x           => x,
        y           => y
        );

    inst_linecalc5 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg(0),
        m           => m5,
        b           => b5,
        fit_err     => fit_err5,
        x           => x,
        y           => y
        );

    inst_linecalc6 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg(0),
        m           => m6,
        b           => b6,
        fit_err     => fit_err6,
        x           => x,
        y           => y
        );

    inst_linecalc7 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg(0),
        m           => m7,
        b           => b7,
        fit_err     => fit_err7,
        x           => x,
        y           => y
        );

    inst_linecalc8 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg(0),
        m           => m8,
        b           => b8,
        fit_err     => fit_err8,
        x           => x,
        y           => y
        );    
        --inst_linecalc : linecalc2 port map(
    --    
    --);
    --semi1 <= std_logic_vector(minimum(to_integer(unsigned(fit_err1)), to_integer(unsigned(fit_err2))));
     
    semi1 <= fit_err1 when (to_integer(unsigned(fit_err1)) < to_integer(unsigned(fit_err2))) else
            fit_err2;
    semi2 <= fit_err3 when (to_integer(unsigned(fit_err3)) < to_integer(unsigned(fit_err4))) else
            fit_err4;
    semi3 <= fit_err5 when (to_integer(unsigned(fit_err5)) < to_integer(unsigned(fit_err6))) else
            fit_err6;
    semi4 <= fit_err7 when (to_integer(unsigned(fit_err7)) < to_integer(unsigned(fit_err8))) else
            fit_err8;
    final1 <= semi1 when (to_integer(unsigned(semi1)) < to_integer(unsigned(semi2))) else
            semi2;
    final2 <= semi3 when (to_integer(unsigned(semi3)) < to_integer(unsigned(semi4))) else
            semi4;
    fit_err <= final1 when (to_integer(unsigned(final1)) < to_integer(unsigned(final2))) else
            final2;
    process (clk)
    begin
        if clk'event and clk='1' then
            if en_reg(1)='1' then
                x <= do_b(31 downto 16);
                y <= do_b(15 downto 0);
            end if;
            if oper="0001" then
                m1 <= do_a(31 downto 16);
                b1 <= do_a(15 downto 0);
            end if;
            if oper="0010" then
                m2 <= do_a(31 downto 16);
                b2 <= do_a(15 downto 0);
            end if;
            if oper="0011" then
                m3 <= do_a(31 downto 16);
                b3 <= do_a(15 downto 0);
            end if;
            if oper="0100" then
                m4 <= do_a(31 downto 16);
                b4 <= do_a(15 downto 0);
            end if;
            if oper="0101" then
                m5 <= do_a(31 downto 16);
                b5 <= do_a(15 downto 0);
            end if;
            if oper="0110" then
                m6 <= do_a(31 downto 16);
                b6 <= do_a(15 downto 0);
            end if;
            if oper="0111" then
                m7 <= do_a(31 downto 16);
                b7 <= do_a(15 downto 0);
            end if;
            if oper="1000" then
                m8 <= do_a(31 downto 16);
                b8 <= do_a(15 downto 0);
            end if;
        end if;
    end process;
end Behavioral;