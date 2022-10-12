library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity datapath is
    port ( 
    oper : in std_logic_vector (2 downto 0);
    mem_in : in std_logic_vector (31 downto 0);
    clk, en_alu_reg1, en_alu_reg2, en_mult_reg1, en_mult_reg2, en_yti, en_ytr, sw_out : in std_logic;
    sel_load : in std_logic_vector (1 downto 0);
    nr_out : out std_logic_vector (31 downto 0));
end datapath;
architecture behavioral of datapath is
 signal Xr, Xi : signed (15 downto 0);
 signal Mr, Mi : signed (7 downto 0); 
 signal Br, Bi : signed (27 downto 0);
 signal mult1_in1, mult2_in1 : signed (7 downto 0);
 signal mult1_in2, mult2_in2 : signed (15 downto 0);
 signal mult_reg_1, mult_reg_2 : signed (23 downto 0);
 signal alu_reg_1, alu_reg_2, yti, ytr, alu1_in1, alu1_in2, alu2_in1, alu2_in2, do_alu_1, do_alu_2  : signed(27 downto 0); 
 signal do_mult_1, do_mult_2 : signed (23 downto 0); 
 signal do_div_yti, do_div_ytr : signed (31 downto 0);
 -- this signal initialization is only considered for simulation
Begin
-- Mux
mult1_in1 <= Mr;
mult1_in2 <= Xr when (oper="010") else
                Xi;
mult2_in1 <= Mi;
mult2_in2 <= Xi when (oper="010") else
                Xr;
alu1_in1 <= "1111"&mult_reg_1 when (oper="011" and mult_reg_1(23)='1') else
            "0000"&mult_reg_1 when (oper="011" and mult_reg_1(23)='0') else
            alu_reg_1;
alu1_in2 <= "1111"&mult_reg_2 when (oper="011" and mult_reg_2(23)='1') else
            "0000"&mult_reg_2 when (oper="011" and mult_reg_2(23)='0') else
            Br when (oper="100") else
            ytr;
alu2_in1 <= "1111"&mult_reg_2 when (oper="011" and mult_reg_2(23)='1') else
            "0000"&mult_reg_2 when (oper="011" and mult_reg_2(23)='0') else
            alu_reg_2;
alu2_in2 <= "1111"&mult_reg_1 when (oper="011" and mult_reg_1(23)='1') else
            "0000"&mult_reg_1 when (oper="011" and mult_reg_1(23)='0') else
            Bi when (oper="101") else
            yti;
nr_out <= std_logic_vector(do_div_ytr) when (sw_out='1') else
            std_logic_vector(do_div_yti);
 --ALU
do_alu_1 <= alu1_in1 - alu1_in2 when (oper="011") else
            alu1_in1 + alu1_in2;
do_alu_2 <= alu2_in1 + alu2_in2;
do_mult_1 <= mult1_in1 * mult1_in2;
do_mult_2 <= mult2_in1 * mult2_in2;

--Divider, right shift by 3 bits since N = 8
process (clk)
begin
    if clk'event and clk='1' then
        if yti(27)='1' then
            do_div_yti(31 downto 25) <= (others =>'1');
        else
            do_div_yti(31 downto 25) <= (others =>'0');
        end if;
        if ytr(27)='1' then
            do_div_ytr(31 downto 25) <= (others =>'1');
        else
            do_div_ytr(31 downto 25) <= (others =>'0');
        end if;
        do_div_yti(24 downto 0) <= yti(27 downto 3);
        do_div_ytr(24 downto 0) <= ytr(27 downto 3);
    end if;
end process;
-- Registers
process (clk)
begin
    if clk'event and clk='1' then
        if oper="111" then
            ytr <= (others => '0');
            yti <= (others => '0');
        end if;
        if en_mult_reg1='1' then
            mult_reg_1 <= do_mult_1;
        end if;
        if en_mult_reg2='1' then
            mult_reg_2 <= do_mult_2;
        end if;
        if en_alu_reg1='1' then
            alu_reg_1 <= do_alu_1;
        end if;
        if en_alu_reg2='1' then
            alu_reg_2 <= do_alu_2;
        end if;
        if en_ytr='1' then
            ytr <= do_alu_1;
        end if;
        if en_yti='1' then
            yti <= do_alu_2;
        end if;
        if sel_load(1)='1' then
            Xr <= signed(mem_in(31 downto 16));
            Xi <= signed(mem_in(15 downto 0));
        end if;
        if sel_load(0)='1' then
            Mr <= signed(mem_in(31 downto 24));
            Mi <= signed(mem_in(23 downto 16));
            Br(7 downto 0) <= signed(mem_in(15 downto 8));
            if mem_in(15)='1' then
                Br(27 downto 8) <= (others => '1');
            else
                Br(27 downto 8) <= (others => '0');
            end if;
            Bi(7 downto 0) <= signed(mem_in(7 downto 0));
            if mem_in(7)='1' then
                Bi(27 downto 8) <= (others => '1');
            else
                Bi(27 downto 8) <= (others => '0');
            end if;
        end if;
    end if;
end process;

end behavioral;