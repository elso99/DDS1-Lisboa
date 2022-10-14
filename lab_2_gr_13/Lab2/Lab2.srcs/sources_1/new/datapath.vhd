library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath is
    port ( 
    clk         : in std_logic;
    sw_out      : in std_logic;
    oper        : in std_logic_vector (2 downto 0);
    mem_in      : in std_logic_vector (31 downto 0); -- from memIN based on mem_in_addr in control.vhd
    en_reg      : in std_logic_vector (5 downto 0); -- AR1[5], AR2[4], MR1[3], MR2[2], YTR[1], YTI[0], register enables.
    sel_load    : in std_logic_vector (1 downto 0);
    nr_out      : out std_logic_vector (31 downto 0);
    temp_val_Vi    : out std_logic_vector(27 downto 0);
    temp_val_Vr    : out std_logic_vector(27 downto 0)
    );
end datapath;

architecture behavioral of datapath is

    signal Xr, Xi                   : signed (15 downto 0);
    signal Mr, Mi                   : signed (7 downto 0); 
    signal Br, Bi                   : signed (27 downto 0);
    signal mult1_in1, mult2_in1     : signed (7 downto 0);
    signal mult1_in2, mult2_in2     : signed (15 downto 0);
    signal mult_reg_1, mult_reg_2   : signed (23 downto 0); 
    signal do_mult_1, do_mult_2     : signed (23 downto 0); 
    signal do_div_yti, do_div_ytr   : signed (31 downto 0);
    signal alu_reg_1, alu_reg_2, yti, ytr, alu1_in1, alu1_in2, alu2_in1, alu2_in2, do_alu_1, do_alu_2  : signed(27 downto 0);
 -- this signal initialization is only considered for simulation
Begin
-- Mux for mult_1
mult1_in1   <=  Mr;
mult1_in2   <=  Xr when (oper="010") else
                Xi;               
-- Mux for mult_2            
mult2_in1   <=  Mi;
mult2_in2   <=  Xi when (oper="010") else
                Xr;
-- Mux for ALU_1              
alu1_in1    <=  resize(mult_reg_1, alu1_in1'length) when (oper="011") else
                alu_reg_1;                
alu1_in2    <=  resize(mult_reg_2, alu1_in2'length) when (oper="011") else
                Br when (oper="100") else
                ytr;
-- Mux for ALU_2                 
alu2_in1    <=  resize(mult_reg_2, alu2_in1'length) when (oper="100") else
                alu_reg_2;                
alu2_in2    <=  resize(mult_reg_1, alu2_in2'length) when (oper="100") else
                Bi when (oper="101") else
                yti;
                
-- Mux for choosing who of YAr and YAi to go to memOUT.                
nr_out      <=  std_logic_vector(do_div_ytr) when (sw_out='1') else
                std_logic_vector(do_div_yti);
                
temp_val_Vr <=  std_logic_vector(ytr);
temp_val_Vi <=  std_logic_vector(yti);  
 --Arithemtic operations
do_alu_1    <=  alu1_in1 - alu1_in2 when (oper="011") else
                alu1_in1 + alu1_in2;                                
do_alu_2    <=  alu2_in1 + alu2_in2;
do_mult_1   <=  mult1_in1 * mult1_in2;
do_mult_2   <=  mult2_in1 * mult2_in2;
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
            mult_reg_1 <= (others => '0');
            mult_reg_2 <= (others => '0');
            alu_reg_1 <= (others => '0');
            alu_reg_2 <= (others => '0');
            Xr <= (others => '0');
            Xi <= (others => '0');
            Mr <= (others => '0');
            Mi <= (others => '0');
            Br <= (others => '0');
            Bi <= (others => '0');
        end if;
        if en_reg(5)='1' then  --en_alu_reg1
            alu_reg_1 <= do_alu_1;
        end if;
        if en_reg(4)='1' then --en_alu_reg2
            alu_reg_2 <= do_alu_2;
        end if;
        if en_reg(3)='1' then --en_mult_reg1
            mult_reg_1 <= do_mult_1;
        end if;
        if en_reg(2)='1' then --en_mult_reg2
            mult_reg_2 <= do_mult_2;
        end if;
        if en_reg(1)='1' then --en_ytr
            ytr <= do_alu_1;
        end if;
        if en_reg(0)='1' then --en_yti
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