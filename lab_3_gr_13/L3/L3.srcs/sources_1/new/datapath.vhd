library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity datapath is
    port(
        clk : in std_logic;
        rst : in std_logic;
        en_reg : in std_logic;
        oper : in std_logic_vector(3 downto 0);
        reg_addr : in std_logic_vector(3 downto 0);
        do_a : in std_logic_vector(31 downto 0);
        do_b : in std_logic_vector(31 downto 0);
        fit_err : out std_logic_vector(31 downto 0);
        k   : out std_logic_vector(7 downto 0)
    );
end datapath;

architecture Behavioral of datapath is
   
    component linecalc
    Port ( 
        clk                        : in std_logic;
        rst                        : in std_logic;
        en_reg                     : in std_logic_vector(1 downto 0);
        m, b, x, y                 : in std_logic_vector (15 downto 0);
        line_err                   : out unsigned (31 downto 0)
        );
    end component;

        signal m1, m2, m3, m4, m5, m6, m7, m8, b1, b2, b3, b4, b5, b6, b7, b8, x1, y1, x2, y2 : std_logic_vector (15 downto 0);
        signal fit_err1, fit_err2, fit_err3, fit_err4, fit_err5, fit_err6, fit_err7, fit_err8, semi1, semi2, semi3, semi4, final1, final2 : std_logic_vector (31 downto 0);
        signal out11, out12, out21, out22, out31, out32, out41, out42, out51, out52, out61, out62, out71, out72, out81, out82 : unsigned (31 downto 0);
        signal line1, line2, line3, line4, line5, line6, line7, line8 : unsigned (31 downto 0);
        signal line1_reg, line2_reg, line3_reg, line4_reg, line5_reg, line6_reg, line7_reg, line8_reg : unsigned (31 downto 0);
        signal do_out1, do_out2, do_out3, do_out4, do_out5, do_out6, do_out7, do_out8 : unsigned (31 downto 0);
        signal do_out1_reg, do_out2_reg, do_out3_reg, do_out4_reg, do_out5_reg, do_out6_reg, do_out7_reg, do_out8_reg : unsigned(31 downto 0);
        signal k_temp, k_temp2, k_temp3 : std_logic_vector(7 downto 0);
        signal en_reg_in    : std_logic_vector (1 downto 0);
begin

    
    inst_linecalc1 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg_in,
        m           => m1,
        b           => b1,
        line_err     => out11,
        x           => x1,
        y           => y1
        );
    
    inst_linecalc1_2 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg_in,
        m           => m1,
        b           => b1,
        line_err     => out12,
        x           => x2,
        y           => y2
        );

    inst_linecalc2 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg_in,
        m           => m2,
        b           => b2,
        line_err     => out21,
        x           => x1,
        y           => y1
        );

    inst_linecalc2_2 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg_in,
        m           => m2,
        b           => b2,
        line_err     => out22,
        x           => x2,
        y           => y2
        );

    inst_linecalc3 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg_in,
        m           => m3,
        b           => b3,
        line_err     => out31,
        x           => x1,
        y           => y1
        );

    inst_linecalc3_2 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg_in,
        m           => m3,
        b           => b3,
        line_err     => out32,
        x           => x2,
        y           => y2
        );

    inst_linecalc4 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg_in,
        m           => m4,
        b           => b4,
        line_err     => out41,
        x           => x1,
        y           => y1
        );

    inst_linecalc4_2 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg_in,
        m           => m4,
        b           => b4,
        line_err     => out42,
        x           => x2,
        y           => y2
        );

    inst_linecalc5 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg_in,
        m           => m5,
        b           => b5,
        line_err    => out51,
        x           => x1,
        y           => y1
        );

    inst_linecalc5_2 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg_in,
        m           => m5,
        b           => b5,
        line_err    => out52,
        x           => x2,
        y           => y2
        );

    inst_linecalc6 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg_in,
        m           => m6,
        b           => b6,
        line_err    => out61,
        x           => x1,
        y           => y1
        );

    inst_linecalc6_2 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg_in,
        m           => m6,
        b           => b6,
        line_err    => out62,
        x           => x2,
        y           => y2
        );

    inst_linecalc7 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg_in,
        m           => m7,
        b           => b7,
        line_err    => out71,
        x           => x1,
        y           => y1
        );

    inst_linecalc7_2 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg_in,
        m           => m7,
        b           => b7,
        line_err    => out72,
        x           => x2,
        y           => y2
        );

    inst_linecalc8 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg_in,
        m           => m8,
        b           => b8,
        line_err    => out81,
        x           => x1,
        y           => y1
        );   
        
    inst_linecalc8_2 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en_reg_in,
        m           => m8,
        b           => b8,
       line_err     => out82,
        x           => x2,
        y           => y2
        ); 
        --inst_linecalc : linecalc2 port map(
    --    
    --);
    en_reg_in(0) <= en_reg;
    --semi1 <= std_logic_vector(minimum(to_integer(unsigned(fit_err1)), to_integer(unsigned(fit_err2))));
    line1 <= ("0000" & out11(31 downto 4)) + ("0000" & out12(31 downto 4)); -- Since it is 8 additions
    line2 <= ("0000" & out21(31 downto 4)) + ("0000" & out22(31 downto 4));
    line3 <= ("0000" & out31(31 downto 4)) + ("0000" & out32(31 downto 4));
    line4 <= ("0000" & out41(31 downto 4)) + ("0000" & out42(31 downto 4));
    line5 <= ("0000" & out51(31 downto 4)) + ("0000" & out52(31 downto 4));
    line6 <= ("0000" & out61(31 downto 4)) + ("0000" & out62(31 downto 4));
    line7 <= ("0000" & out71(31 downto 4)) + ("0000" & out72(31 downto 4));
    line8 <= ("0000" & out81(31 downto 4)) + ("0000" & out82(31 downto 4));
    
    do_out1  <=  do_out1_reg + line1_reg;
    do_out2  <=  do_out2_reg + line2_reg;
    do_out3  <=  do_out3_reg + line3_reg;
    do_out4  <=  do_out4_reg + line4_reg;
    do_out5  <=  do_out5_reg + line5_reg;
    do_out6  <=  do_out6_reg + line6_reg;
    do_out7  <=  do_out7_reg + line7_reg;
    do_out8  <=  do_out8_reg + line8_reg;

    fit_err1 <= std_logic_vector(do_out1_reg);
    fit_err2 <= std_logic_vector(do_out2_reg);
    fit_err3 <= std_logic_vector(do_out3_reg);
    fit_err4 <= std_logic_vector(do_out4_reg);
    fit_err5 <= std_logic_vector(do_out5_reg);
    fit_err6 <= std_logic_vector(do_out6_reg);
    fit_err7 <= std_logic_vector(do_out7_reg);
    fit_err8 <= std_logic_vector(do_out8_reg);

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

    k_temp(1 downto 0) <= "01" when (to_integer(unsigned(fit_err1)) < to_integer(unsigned(fit_err2))) else
            "10";
    k_temp(3 downto 2) <= "01" when (to_integer(unsigned(fit_err3)) < to_integer(unsigned(fit_err4))) else
            "10";
    k_temp(5 downto 4) <= "01" when (to_integer(unsigned(fit_err5)) < to_integer(unsigned(fit_err6))) else
            "10";
    k_temp(7 downto 6) <= "01" when (to_integer(unsigned(fit_err7)) < to_integer(unsigned(fit_err8))) else
            "10";
    k_temp2(3 downto 0) <=  "00" & k_temp(1 downto 0) when (to_integer(unsigned(semi1)) < to_integer(unsigned(semi2))) else
            k_temp(3 downto 2) & "00";
    k_temp2(7 downto 4) <= "00" & k_temp(5 downto 4) when (to_integer(unsigned(semi3)) < to_integer(unsigned(semi4))) else
            k_temp(7 downto 6) & "00";
    k_temp3 <= "0000" & k_temp2(3 downto 0) when (to_integer(unsigned(final1)) < to_integer(unsigned(final2))) else
            k_temp2(7 downto 4) & "0000";
    k <= k_temp3;
    
    reset : process (clk)
    begin
        if clk'event and clk='1' then
            
        end if;
    end process;
    
    process (clk)
    begin
        if clk'event and clk='1' then
            if oper = "0001" then -- load_mb
                en_reg_in(1) <= '0';
                if reg_addr="0001" then
                    m1 <= do_a(31 downto 16);
                    b1 <= do_a(15 downto 0);
                    m2 <= do_b(31 downto 16);
                    b2 <= do_b(15 downto 0);
                end if;
                if reg_addr="0010" then
                    m3 <= do_a(31 downto 16);
                    b3 <= do_a(15 downto 0);
                    m4 <= do_b(31 downto 16);
                    b4 <= do_b(15 downto 0);
                end if;
                if reg_addr="0100" then
                    m5 <= do_a(31 downto 16);
                    b5 <= do_a(15 downto 0);
                    m6 <= do_b(31 downto 16);
                    b6 <= do_b(15 downto 0);
                end if;
                if reg_addr="1000" then
                    m7 <= do_a(31 downto 16);
                    b7 <= do_a(15 downto 0);
                    m8 <= do_b(31 downto 16);
                    b8 <= do_b(15 downto 0);
                end if;
            elsif oper="0010" then -- oper = "0010" load_xy -might not need this
                en_reg_in(1) <= '1';
                x1 <= do_a(31 downto 16);
                y1 <= do_a(15 downto 0);
                x2 <= do_b(31 downto 16);
                y2 <= do_b(15 downto 0);
            end if;
            if en_reg='1' then -- oper = "0001"
                line1_reg <= line1;
                line2_reg <= line2;
                line3_reg <= line3;
                line4_reg <= line4;
                line5_reg <= line5;
                line6_reg <= line6;
                line7_reg <= line7;
                line8_reg <= line8;
                do_out1_reg <= do_out1;
                do_out2_reg <= do_out2;
                do_out3_reg <= do_out3;
                do_out4_reg <= do_out4;
                do_out5_reg <= do_out5;
                do_out6_reg <= do_out6;
                do_out7_reg <= do_out7;
                do_out8_reg <= do_out8;
            end if;     
            if rst = '1' then
                m1 <= (others => '0');
                m2 <= (others => '0');
                m3 <= (others => '0');
                m4 <= (others => '0');
                m5 <= (others => '0');
                m6 <= (others => '0');
                m7 <= (others => '0');
                m8 <= (others => '0'); 
                b1 <= (others => '0');                            
                b2 <= (others => '0');
                b3 <= (others => '0');
                b4 <= (others => '0');
                b5 <= (others => '0');
                b6 <= (others => '0');
                b7 <= (others => '0');
                b8 <= (others => '0');
                x1 <= (others => '0');
                x2 <= (others => '0');
                y1 <= (others => '0');
                y2 <= (others => '0');
                line1_reg <= (others => '0');
                line2_reg <= (others => '0');
                line3_reg <= (others => '0');
                line4_reg <= (others => '0');
                line5_reg <= (others => '0');
                line6_reg <= (others => '0');
                line7_reg <= (others => '0');
                line8_reg <= (others => '0');
                do_out1_reg <= (others => '0');
                do_out2_reg <= (others => '0');
                do_out3_reg <= (others => '0');
                do_out4_reg <= (others => '0');
                do_out5_reg <= (others => '0');
                do_out6_reg <= (others => '0');
                do_out7_reg <= (others => '0');
                do_out8_reg <= (others => '0');
           end if;
        end if;
    end process;
end Behavioral;