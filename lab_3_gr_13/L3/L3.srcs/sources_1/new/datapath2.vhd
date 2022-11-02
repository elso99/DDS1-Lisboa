library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity datapath2 is
    Port (
        clk         : in std_logic;
        rst         : in std_logic;
        en          : in std_logic_vector(1 downto 0); -- 01 for load mb, 10 for the rest, 00 for do nothing.
        oper        : in std_logic_vector(3 downto 0);
        reg_addr    : in std_logic_vector(3 downto 0);
        memIN_1     : in std_logic_vector(31 downto 0);
        memIN_2     : in std_logic_vector(31 downto 0);
        fit_err     : out std_logic_vector(31 downto 0);
        k           : out std_logic_vector(7 downto 0)
    );
end datapath2;

architecture Behavioral of datapath2 is

    component linecalc_pair
        Port (
            clk                         : in std_logic;
            rst                         : in std_logic;
            en                          : in std_logic_vector(1 downto 0);
            mb, xy1, xy2                : in std_logic_vector (31 downto 0);
            fit_err                     : out std_logic_vector(31 downto 0)
        );
    end component;
    
    signal err_1, err_2, err_3, err_4, err_5, err_6, err_7, err_8 : std_logic_vector(31 downto 0);
    signal quart_1, quart_2, quart_3, quart_4, semi_1, semi_2, final : std_logic_vector(31 downto 0);
    signal k_temp, k_temp2, k_temp3 : std_logic_vector(7 downto 0);
    
    signal reg_quart_1, reg_quart_2, reg_quart_3, reg_quart_4, reg_semi_1, reg_semi_2, reg_final : std_logic_vector(31 downto 0);
    signal reg_k_temp, reg_k_temp2, reg_k_temp3 : std_logic_vector(7 downto 0);
     
begin

inst_linecalc_pair1 : linecalc_pair port map(
        clk     => clk,
        rst     => rst,
        en(0)   => oper(0), -- en(0) = 1, when loading mb. We dont have xy registers, so have to calculate directly from memory. en(1) = '1' means calculate. 
        en(1)   => en(1),
        mb      => memIN_1, -- either 1 or 2, depends. Odd numbers, 1. 
        xy1     => memIN_1,
        xy2     => memIN_2,
        fit_err => err_1
);
inst_linecalc_pair2 : linecalc_pair port map(
        clk     => clk,
        rst     => rst,
        en(0)   => oper(0),
        en(1)   => en(1),
        mb      => memIN_2, -- either 1 or 2, depends.
        xy1     => memIN_1,
        xy2     => memIN_2,
        fit_err => err_2
);
inst_linecalc_pair3 : linecalc_pair port map(
        clk     => clk,
        rst     => rst,
        en(0)   => oper(1),
        en(1)   => en(1),
        mb      => memIN_1, -- either 1 or 2, depends.
        xy1     => memIN_1,
        xy2     => memIN_2,
        fit_err => err_3
);
inst_linecalc_pair4 : linecalc_pair port map(
        clk     => clk,
        rst     => rst,
        en(0)   => oper(1),
        en(1)   => en(1),
        mb      => memIN_2, -- either 1 or 2, depends.
        xy1     => memIN_1,
        xy2     => memIN_2,
        fit_err => err_4
);
inst_linecalc_pair5 : linecalc_pair port map(
        clk     => clk,
        rst     => rst,
        en(0)   => oper(2),
        en(1)   => en(1),
        mb      => memIN_1, -- either 1 or 2, depends.
        xy1     => memIN_1,
        xy2     => memIN_2,
        fit_err => err_5
);
inst_linecalc_pair6 : linecalc_pair port map(
        clk     => clk,
        rst     => rst,
        en(0)   => oper(2),
        en(1)   => en(1),
        mb      => memIN_2, -- either 1 or 2, depends.
        xy1     => memIN_1,
        xy2     => memIN_2,
        fit_err => err_6
);
inst_linecalc_pair7 : linecalc_pair port map(
        clk     => clk,
        rst     => rst,
        en(0)   => oper(3),
        en(1)   => en(1),
        mb      => memIN_1, -- either 1 or 2, depends.
        xy1     => memIN_1,
        xy2     => memIN_2,
        fit_err => err_7
);
inst_linecalc_pair8 : linecalc_pair port map(
        clk     => clk,
        rst     => rst,
        en(0)   => oper(3),
        en(1)   => en(1),
        mb      => memIN_2, -- either 1 or 2, depends.
        xy1     => memIN_1,
        xy2     => memIN_2,
        fit_err => err_8
);

--Finding the lowest error
quart_1 <= MINIMUM(err_1, err_2);
quart_2 <= MINIMUM(err_3, err_4);
quart_3 <= MINIMUM(err_5, err_6);
quart_4 <= MINIMUM(err_7, err_8);
semi_1  <= MINIMUM(quart_1, quart_2);
semi_2  <= MINIMUM(quart_3, quart_4);           
final   <= MINIMUM(semi_1, semi_2);

k_temp(1 downto 0) <= "01" when (err_1 < err_2) else
            "10";
k_temp(3 downto 2) <= "01" when (err_3 < err_4) else
            "10";
k_temp(5 downto 4) <= "01" when (err_5 < err_6) else
            "10";
k_temp(7 downto 6) <= "01" when (err_7 < err_8) else
            "10";
k_temp2(3 downto 0) <=  "00" & k_temp(1 downto 0) when (quart_1 < quart_2) else
            k_temp(3 downto 2) & "00";
k_temp2(7 downto 4) <= "00" & k_temp(5 downto 4) when (quart_3 < quart_4) else
            k_temp(7 downto 6) & "00";
k_temp3 <= "0000" & k_temp2(3 downto 0) when (semi_1 < semi_2) else
            k_temp2(7 downto 4) & "0000";
k <= reg_k_temp3;

fit_err <= reg_final;

reset : process (clk)
begin
    if rising_edge(clk) then
        if rst = '1' then
            reg_quart_1 <= (others => '0');
            reg_quart_2 <= (others => '0');
            reg_quart_3 <= (others => '0');
            reg_quart_4 <= (others => '0');
            reg_semi_1 <= (others => '0');
            reg_semi_2 <= (others => '0');
            reg_final <= (others => '0');
            reg_k_temp <= (others => '0');
            reg_k_temp2 <= (others => '0');
            reg_k_temp3 <= (others => '0');
        end if;
    end if;
end process;

compare : process (clk)
begin
    if clk'event and clk='1' then
        if en(1) = '1' then
            reg_quart_1 <= quart_1;
            reg_quart_2 <= quart_2;
            reg_quart_3 <= quart_3;
            reg_quart_4 <= quart_4;
            reg_semi_1 <= semi_1;
            reg_semi_2 <= semi_2;
            reg_final <= final;
            reg_k_temp <= k_temp;
            reg_k_temp2 <= k_temp2;
            reg_k_temp3 <= k_temp3;
        end if;
    end if;
end process;           
     
end Behavioral;