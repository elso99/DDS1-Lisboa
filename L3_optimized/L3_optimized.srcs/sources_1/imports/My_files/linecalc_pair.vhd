library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity linecalc_pair is
    Port (
        clk             : in std_logic;
        rst             : in std_logic;
        en_mb           : in std_logic; -- reg_addr(x);
        en              : in std_logic; --en(1) = '1', when b delay reg is going to get data. and start calculations
        mb, xy1, xy2    : in std_logic_vector (31 downto 0);
        fit_err         : out std_logic_vector(31 downto 0)
    );
end linecalc_pair;

architecture Behavioral of linecalc_pair is

    component linecalc
        Port ( 
            clk         : in std_logic;
            rst         : in std_logic;
            en          : in std_logic;
            mb, xy      : in std_logic_vector (31 downto 0);
            line_err    : out signed (31 downto 0)
        );
    end component;
    
    signal reg_mb                   : std_logic_vector(31 downto 0);
    signal reg_sum, reg_accum       : signed(31 downto 0);
    signal b_abs_out_1, b_abs_out_2 : signed(31 downto 0); -- 'b' for bus
    signal do_sum, do_accum         : signed(31 downto 0); -- 'do' for a operation
    
begin
    inst_linecalc_1 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en          => en,
        mb          => reg_mb,
        xy          => xy1,
        line_err    => b_abs_out_1
    );
    
    inst_linecalc_2 : linecalc port map(
        clk         => clk,
        rst         => rst,
        en          => en,
        mb          => reg_mb,
        xy          => xy2,
        line_err    => b_abs_out_2
    );
        
    do_sum      <= ("0000" & b_abs_out_1(31 downto 4)) + ("0000" & b_abs_out_2(31 downto 4));
    do_accum    <= reg_sum + reg_accum;
    fit_err     <= std_logic_vector(reg_accum);

    process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                reg_mb      <= (others => '0');
                reg_sum     <= (others => '0');
                reg_accum   <= (others => '0');
            end if; 
            
            if en_mb = '1' then
                reg_mb      <= mb;
            end if;
            
            if en = '1' then
                reg_sum     <= do_sum;
                reg_accum   <= do_accum;
            end if;
        end if;
    end process;

end Behavioral;
