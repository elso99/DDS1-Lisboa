library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity linecalc_pair is
    Port (
        clk                         : in std_logic;
        rst                         : in std_logic;
        en                          : in std_logic_vector(1 downto 0);
        mb, xy1, xy2                : in std_logic_vector (31 downto 0);
        fit_err                     : out std_logic_vector(31 downto 0)
    );
end linecalc_pair;

architecture Behavioral of linecalc_pair is
    component linecalc
        Port ( 
            clk                        : in std_logic;
            rst                        : in std_logic;
            en_reg                     : in std_logic;
            m, b, x, y                 : in std_logic_vector (15 downto 0);
            line_err                   : out unsigned (31 downto 0)
        );
    end component;
    
    signal reg_mb : std_logic_vector(31 downto 0);
    signal reg_sum, reg_accum : unsigned(31 downto 0);
    signal b_abs_out_1, b_abs_out_2 : unsigned(31 downto 0); -- 'b' for bus
    signal do_sum, do_accum : unsigned(31 downto 0); -- 'do' for a operation
begin
    inst_linecalc_1 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en(1),
        m           => reg_mb(31 downto 16),
        b           => reg_mb(15 downto 0),
        x           => xy1(31 downto 16),
        y           => xy1(15 downto 0),
        line_err    => b_abs_out_1
        );
    
    inst_linecalc_2 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en_reg      => en(1),
        m           => reg_mb(31 downto 16),
        b           => reg_mb(15 downto 0),
        x           => xy2(31 downto 16),
        y           => xy2(15 downto 0),
        line_err    => b_abs_out_2
        );
        
    do_sum <= ("0000" & b_abs_out_1(31 downto 4)) + ("0000" & b_abs_out_2(31 downto 4));
    do_accum <= reg_sum + reg_accum;
    fit_err <= std_logic_vector(reg_accum);
    
    reset : process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                reg_mb      <= (others => '0');
                reg_sum     <= (others => '0');
                reg_accum   <= (others => '0');
            end if; 
        end if;
    end process;
    
    comb : process (clk)
    begin
        if clk'event and clk='1' then
            if en(1) = '1' then
                reg_sum <= do_sum;
                reg_accum <= do_accum;
            end if;
        end if;
    end process;
    
    load_mb : process (clk)
    begin
        if clk'event and clk='1' then
            if en(0) = '1' then
                reg_mb <= mb;
            end if;
        end if;
    end process;

end Behavioral;
