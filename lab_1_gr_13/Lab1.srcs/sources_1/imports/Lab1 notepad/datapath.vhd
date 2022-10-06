library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath is
    port ( 
    ent : in std_logic_vector (11 downto 0);
    oper : in std_logic_vector (2 downto 0);
    clk, en_r1, en_r2 : in std_logic;
    disp : out std_logic_vector (11 downto 0);
    s_disp : in std_logic);
end datapath;

architecture behavioral of datapath is
 signal do_rtr, do_xnor, res : std_logic_vector (11 downto 0);
 signal do_add : signed (11 downto 0);
 signal do_mult : signed (23 downto 0);
 signal register1, register2 : std_logic_vector (11 downto 0) := (others => '0');
 -- this signal initialization is only considered for simulation
Begin
 --ALU
 do_add <= signed(register1) + signed(register2);
 do_mult <= signed(register1) * signed(register2);
 do_rtr <= register1(0) & register1(11 downto 1);
 do_xnor <= register1 xnor register2;
 
 -- multiplexer
res <= std_logic_vector(do_add) when (oper="011") else
             std_logic_vector(do_mult(11 downto 0)) when (oper="100") else
             do_rtr when (oper="101") else
             do_xnor when (oper="110") else
             (others => '0') when (oper="111") else -- does this work?!?
             ent;
             
 
 -- register R1 and R2
 process (clk)
 begin
 if clk'event and clk='1' then
    if en_r1 = '1' then
        register1 <= res;
    end if;
    if en_r2 = '1' then
        register2 <= ent;
    end if;
 end if;
 end process;
 -- output
 -- multiplexer
 disp <= register2 when (s_disp='1') else
         register1;
 
end behavioral;