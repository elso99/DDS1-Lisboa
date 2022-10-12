library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity control is

    port(
    clk             : in std_logic;
    rst             : in std_logic;
    sel_set         : in  std_logic_vector (1 downto 0); -- the 4 different memory addresses used for computation.
    mem_out_we      : out std_logic;
    mem_out_addr    : out std_logic_vector (8 downto 0);
    mem_in_addr     : out std_logic_vector (8 downto 0);
    sel_load        : out std_logic_vector (1 downto 0); -- 00 nothing, 01 M & B, 10 Xr & Xi.
    done            : out std_logic;
    oper            : out std_logic_vector (2 downto 0);
    en_reg          : out std_logic_vector (5 downto 0);
    sw_out : out std_logic);
end control;

architecture Behavioral of control is

    type c_States is (state_idle, state_load_m_b, state_load_x, state_op_1, state_op_2, state_op_3, state_op_4, state_op_5, state_disp_i, state_disp_r, state_end);
    
    signal curr_state : c_States;

    signal addr_counter : std_logic_vector(8 downto 0);

    signal sign_done : std_logic;
    
begin

    process(clk) is
    begin
        if clk'event and clk='1' then -- Synchronous since dependent of clock.
            if rst = '1' then
                -- reset values
                sign_done <= '0';
                mem_out_addr <= (others => 'X');
                mem_out_we <= '0';
                sel_load <= "00";
                -- en_alu_reg1 & en_alu_reg2 & en_mult_reg1 & en_mult_reg2 & en_yti & en_ytr <= '0'&'0'&'0'&'0'&'0'&'0';
                en_reg <= "000000";
                oper <= "111"; --rst output mem from datapath
                sw_out <= 'X';
                curr_state <= state_idle;
            else -- when rst is 0
                case curr_state is
                    when state_idle =>
                        mem_out_addr <= (others => 'X');
                        mem_out_we <= '0';
                        sel_load <= "00";
                        oper <= "000";
                        sw_out <= 'X';
                        mem_out_we <= '0'; 
                        if sel_set = "00" then
                                addr_counter <= "000000000"; -- 0x00
                        elsif sel_set = "01" then
                                addr_counter <= "000010000"; -- 0x10
                        elsif sel_set = "10" then
                                addr_counter <= "000100000"; -- 0x20
                        else
                                addr_counter <= "000110000"; -- 0x30
                        end if;
                        curr_state <= state_load_m_b; 
                    when state_load_m_b =>
                        mem_out_addr <= (others => 'X');
                        mem_out_we <= '0';
                        sel_load <= "01";
                        --(en_alu_reg1, en_alu_reg2, en_mult_reg1, en_mult_reg2, en_yti, en_ytr) <= '0'&'0'&'0'&'0'&'0'&'0';
                        en_reg <= "000000";
                        oper <= "000";
                        sw_out <= 'X';
                        mem_out_we <= '0';
                        curr_state <= state_load_x;

                    -- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    
                    -- UNDER HERE IT IS A LOOP
                    when state_load_x =>
                        mem_out_addr <= (others => 'X');
                        mem_out_we <= '0';
                        sel_load <= "10";
                        --(en_alu_reg1, en_alu_reg2, en_mult_reg1, en_mult_reg2, en_yti, en_ytr) <= '0'&'0'&'0'&'0'&'0'&'0';
                        en_reg <= "000000";
                        oper <= "000";
                        sw_out <= 'X';
                        mem_out_we <= '0';
                        curr_state <= state_op_1;
                        
                    when state_op_1 =>
                        mem_out_addr <= (others => 'X');
                        mem_out_we <= '0';
                        sel_load <= "00";
                        --(en_alu_reg1, en_alu_reg2, en_yti, en_ytr) <= '0'&'0'&'0'&'0';
                        en_reg <= "001100";
                        --(en_mult_reg1, en_mult_reg2) <= '1'&'1';
                        oper <= "010";
                        sw_out <= 'X';
                        mem_out_we <= '0';
                        curr_state <= state_op_2;
                        
                    when state_op_2 =>
                        mem_out_addr <= (others => 'X'); 
                        mem_out_we <= '0';  
                        sel_load <= "00";
                        --(en_alu_reg2, en_yti, en_ytr) <= '0'&'0'&'0';
                        en_reg <= "101100";
                        --(en_alu_reg1, en_mult_reg1, en_mult_reg2) <= '1'&'1'&'1';
                        oper <= "011";
                        sw_out <= 'X';
                        mem_out_we <= '0';
                        curr_state <= state_op_3;
        
                    when state_op_3 =>
                        mem_out_addr <= (others => 'X'); 
                        mem_out_we <= '0';
                        sel_load <= "00";
                        --(en_mult_reg1, en_mult_reg2, en_yti, en_ytr) <= '0'&'0'&'0'&'0'&'0';
                        en_reg <= "110000";
                        --(en_alu_reg1, en_alu_reg2) <= '1'&'1';
                        oper <= "100";
                        sw_out <= 'X';
                        mem_out_we <= '0';
                        curr_state <= state_op_4;
 
                    when state_op_4 =>
                        mem_out_addr <= (others => 'X');
                        mem_out_we <= '0';
                        sel_load <= "00";
                        --(en_mult_reg1,en_mult_reg2,en_yti,en_ytr,en_alu_reg1) <= '0'&'0'&'0'&'0'&'0'&'0';
                        en_reg <= "000100";
                        --en_alu_reg2 <= '1';  
                        oper <= "101";
                        sw_out <= 'X';
                        mem_out_we <= '0';
                        curr_state <= state_op_5;
   
                    when state_op_5 =>
                        mem_out_addr <= (others => 'X');
                        mem_out_we <= '0';
                        sel_load <= "00";
                        --(en_alu_reg1, en_alu_reg2, en_mult_reg1, en_mult_reg2) <= '0'&'0'&'0'&'0'&'0';
                        en_reg <= "000011";
                        --(en_yti, en_ytr) <= '1'&'1';
                        oper <= "110";
                        sw_out <= 'X';
                        mem_out_we <= '0';
                        if addr_counter(3 downto 0) = "1000" then
                            curr_state <= state_disp_i; --breaks loop
                        else
                            addr_counter <= addr_counter + 1;
                            curr_state <= state_load_x; --loop
                        end if;
                    -- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 
                    when state_disp_i =>
                        mem_out_addr <= "000000000";
                        mem_out_we <= '1';   
                        sel_load <= "00";
                        --(en_alu_reg1, en_alu_reg2, en_mult_reg1, en_mult_reg2, en_yti, en_ytr) <= '0'&'0'&'0'&'0'&'0'&'0';
                        en_reg <= "000000";
                        oper <= "000";
                        sw_out <= '0'; -- 0 imaginary, 1 real 
                        mem_out_we <= '1';
                        curr_state <= state_disp_r;

                    when state_disp_r =>
                        mem_out_addr <= "000000001";
                        mem_out_we <= '1';  
                        sel_load <= "00";
                        --(en_alu_reg1, en_alu_reg2, en_mult_reg1, en_mult_reg2, en_yti, en_ytr) <= '0'&'0'&'0'&'0'&'0'&'0';
                        en_reg <= "000000";
                        oper <= "000";
                        sw_out <= '1'; -- 0 imaginary, 1 real 
                        mem_out_we <= '1';
                        curr_state <= state_end;
                        
                    when state_end =>
                        mem_out_addr <= (others => 'X');
                        mem_out_we <= '0';
                        sel_load <= "00";
                        --(en_alu_reg1, en_alu_reg2, en_mult_reg1, en_mult_reg2, en_yti, en_ytr) <= '0'&'0'&'0'&'0'&'0'&'0';
                        en_reg <= "000000";
                        oper <= "000";
                        sw_out <= 'X';
                        mem_out_we <= '0';
                        curr_state <= state_idle;
                        sign_done <= '1';
                                         
                end case;
            end if;
        end if;
    end process;

    mem_in_addr <= addr_counter;
    done <= sign_done;

end Behavioral;
