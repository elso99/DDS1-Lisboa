library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity control is
    port(
    clk             : in std_logic;
    rst             : in std_logic;
    sel_set         : in std_logic_vector (1 downto 0); -- the 4 different memory addresses used for computation.
    done            : out std_logic;
    sw_out          : out std_logic;  -- choose who of VTr & VTi in datapa that write to RAMB16
    mem_out_we      : out std_logic;
    mem_out_addr    : out std_logic_vector (8 downto 0);
    mem_in_addr     : out std_logic_vector (8 downto 0);
    sel_load        : out std_logic_vector (1 downto 0); -- 00 nothing, 01 M & B, 10 Xr & Xi.
    oper            : out std_logic_vector (2 downto 0);
    en_reg          : out std_logic_vector (5 downto 0)); -- AR1[5], AR2[4], MR1[3], MR2[2], YTR[1], YTI[0]
end control;

architecture Behavioral of control is

    type c_States is (state_wait, state_begin, state_load_m_b, state_load_x, state_op_1, state_op_2, state_op_3, state_op_4, state_op_5, state_load_i, state_disp_i, state_load_r, state_disp_r, state_end);
    
    signal curr_state   : c_States := state_wait;

    signal addr_counter : std_logic_vector(8 downto 0) := "000000000";
    
    signal done_sign    : std_logic := '0';
    
    signal clk_count    : integer range 0 to 10 := 0;
    
begin
    process(clk) is
    begin
        if clk'event and clk='1' then -- Synchronous since dependent of clock rising edge.
            if rst = '1' then
                done_sign       <= '0';
                done            <= '0';
                sw_out          <= '0'; -- Only care when mem_out_we is true
                mem_out_we      <= '0';
                mem_out_addr    <= (others => 'X');
                mem_in_addr     <= (others => 'X');
                if sel_set = "00" then
                    addr_counter <= "000000000"; -- 0x00
                elsif sel_set = "01" then
                    addr_counter <= "000010000"; -- 0x10
                elsif sel_set = "10" then
                    addr_counter <= "000100000"; -- 0x20
                else
                    addr_counter <= "000110000"; -- 0x30
                end if;
                sel_load        <= "00";
                oper            <= "111"; -- Do NO operation in datapath
                en_reg          <= "000000";
                curr_state  <= state_begin;
            else
                -- Default values here:
                done            <= done_sign;
                sw_out          <= '0'; -- Only care when mem_out_we is true
                mem_out_we      <= '0';
                mem_out_addr    <= (others => 'X');
                mem_in_addr     <= addr_counter;
                sel_load        <= "00";
                oper            <= "000"; -- Do NO operation in datapath
                en_reg          <= "000000";
            
                case curr_state is
                    when state_wait =>
                        if rst = '1' then
                                curr_state  <= state_begin;
                        end if;
                        --do nothing
                    when state_begin =>
                        addr_counter <= addr_counter + 1;
                        curr_state  <= state_load_m_b;
                            
                    when state_load_m_b =>
                        sel_load        <= "01";
                        mem_in_addr     <= addr_counter;
                        curr_state      <= state_load_x;
        
                    -- BEGINS LOOP --
                    when state_load_x =>
                        mem_in_addr <= addr_counter; --SET1 ~00000 0001 => 0: 0001, 1: 0010, 2: 0011, 3: 0100, 4: 0101, 5: 0110, 6: 0111, 7: 1000 (LOOP:ADDR)
                        sel_load    <= "10";
                        curr_state  <= state_op_1;  
                        
                    when state_op_1 =>
                        en_reg      <= "001100";
                        curr_state  <= state_op_2;  
                        oper        <= "010"; -- M1, M2
                        addr_counter <= addr_counter + 1;                    
                        
                    when state_op_2 =>
                        en_reg      <= "101100";
                        curr_state  <= state_op_3;
                        oper        <= "011"; -- M1, M2, -A1
                        mem_in_addr <= addr_counter;
                        
                    when state_op_3 =>
                        en_reg      <= "110000";
                        curr_state  <= state_op_4;
                        oper        <= "100"; -- +A1, +A2
                        
                    when state_op_4 =>
                        en_reg      <= "010000"; 
                        curr_state  <= state_op_5;
                        oper        <= "101"; -- +A2
                        
                    when state_op_5 =>
                        en_reg      <= "000011";
                        oper        <= "110"; -- +A1, +A2
                        
                        if addr_counter(3 downto 0) = "1001" then -- When reaching N = 8, then stop. This value must be tested!!!! Can be a cause of error. think its either 1000 ~8 or 0111 ~7
                            curr_state      <= state_load_i; --breaks loop
                        else
                            curr_state  <= state_load_x; --loop
                        end if;
                    -- ENDS LOOP --
                    when state_load_i =>
                        sw_out <= '1';
                        curr_state <= state_disp_i;
                        
                    when state_disp_i =>
                        mem_out_addr    <= "000000001";
                        mem_out_we      <= '1';
                        sw_out          <= '1'; -- 0 imaginary, 1 real
                        curr_state <= state_load_r;
                        
                    when state_load_r =>
                        curr_state <= state_disp_r;
                        sw_out <= '0';
                        
                    when state_disp_r =>
                        mem_out_addr    <= "000000010";
                        mem_out_we      <= '1';
                        sw_out          <= '0'; -- 0 imaginary, 1 real
                        curr_state      <= state_end;
                        done_sign       <= '1';  
                         
                    when state_end => 
                        addr_counter    <= "000000000"; 
                        done <= done_sign;
                        curr_state      <= state_wait;
                                           
                end case;
            end if;
        end if;
    end process;
end Behavioral;