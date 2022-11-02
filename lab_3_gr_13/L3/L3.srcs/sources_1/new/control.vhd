library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity control is
    port(
    clk                     : in std_logic;
    btnR                    : in std_logic; --start button
    rst                     : in std_logic; --reset button which is btnD
    done                    : out std_logic;
    oper                    : out std_logic_vector (3 downto 0); --0000 -nothing 0001 load mb, 0010 load xy, 0100 calculate
    reg_addr            : out std_logic_vector (3 downto 0);
    en_reg              : out std_logic;
    mem_addr_a, mem_addr_b  : out std_logic_vector (9 downto 0)); 
end control;

architecture Behavioral of control is

    type c_States is (s_load_mb, s_load_xy, s_calculate, s_comp, s_wait);
    
    signal curr_state, next_state  : c_States := s_wait;

    signal addr_counter : std_logic_vector(8 downto 0);
    
    signal disp_led    : std_logic;
    
    signal state_count    : integer range 0 to 10; --Duration of a state
    
    signal mem_counter : integer range 0 to 30;
    
    signal sign_reg_count : integer range 0 to 15; 

    signal cnt_rst, cnt_en, mem_cnt_rst, mem_cnt_en, mem_start_xy   : std_logic;
    
begin
    -- reg_counter   <= std_logic_vector(to_unsigned(sign_reg_count, reg_counter'length));
    mem_addr_a  <= std_logic_vector(to_unsigned(mem_counter, mem_addr_a'length));
    mem_addr_b  <= std_logic_vector(to_unsigned(mem_counter + 1, mem_addr_a'length));

    reg_assert : process(clk, sign_reg_count)
    begin
        if sign_reg_count=1 then
            reg_addr <= "0001";
        elsif sign_reg_count=2 then
            reg_addr <= "0010";
        elsif sign_reg_count=3 then
            reg_addr <= "0100";
        elsif sign_reg_count=4 then
            reg_addr <= "1000";
        else 
            reg_addr <= "0000";
        end if;
    end process;
    
    count_mb : process(clk) is
    begin
        if rising_edge(clk) then
            if cnt_rst = '1' then
                sign_reg_count <= 0;
            elsif cnt_en = '1' then
                sign_reg_count <= sign_reg_count + 1;
            end if;
        end if;
    end process;

    count_mem : process(clk) is
    begin
        if rising_edge(clk) then
            if mem_cnt_rst = '1' then
                mem_counter <= 0;
            elsif mem_start_xy = '1' then
                mem_counter <= 16;
            elsif mem_cnt_en = '1' then
                mem_counter <= mem_counter + 2;
            end if;
        end if;
    end process;

    
    fsm_comb : process(clk)
    begin
        if rising_edge(clk) then -- Synchronous since dependent of clock rising edge.
            if rst = '1' then -- reset
                next_state <= s_wait;
                disp_led <= '0';
                mem_cnt_rst <= '1';
                cnt_rst <= '1';

            elsif btnR = '1' then
                next_state <= s_load_mb;
                mem_cnt_rst <= '1';
                cnt_rst <= '1';
                disp_led <= '0';

            else
                -- Default values
                curr_state <= next_state;
                state_count <= state_count + 1;
                oper <= "1000";
                
                mem_cnt_en <= '0';
                mem_cnt_rst <= '0';
                mem_start_xy <= '0';
                cnt_en <= '0';
                cnt_rst <= '0';
                en_reg <= '0';
                
                oper <= (others => '0');
                done <= disp_led;
                
                
                case curr_state is
                    when s_wait =>
                        state_count <= 0;
                        mem_cnt_rst <= '1';
                        --cnt_rst <= '1';
                    when s_load_mb => -- load 2x4=8 pairs in 4 cycles.
                        oper <= "0001";
                        en_reg <= '1';
                        cnt_en <= '1';
                        mem_cnt_en <= '1';
                        if state_count = 4 then
                            state_count <= 0;
                            cnt_rst <= '1'; 
                            mem_start_xy <= '1';
                            next_state <= s_load_xy;
                        end if;
                    when s_load_xy => -- starts calculating here. load 2x8=16 pairs in 8 cycles.
                        oper <= "0010";
                        en_reg <= '1';
                        mem_cnt_en <= '1';
                        if state_count = 8 then
                            state_count <= 0;
                            mem_cnt_rst <= '0';
                            next_state <= s_calculate;
                        end if;
                    when s_calculate => -- mult, add, sub, abs, add(two lines of the same k value -- 5 cycles calc ends after this one, cause the last XY pair got to finish.
                        oper <= "0011";
                        en_reg <= '1';
                        if state_count = 5 then
                            state_count <= 0;
                            next_state <= s_comp;
                            en_reg <= '0';
                        end if;
                    when s_comp => -- compare
                        oper <= "0100";
                        
                        --if state_count = 1 then
                            state_count <= 0; 
                            disp_led <= '1';
                            next_state <= s_wait;
                        --end if;                      
                end case;
            end if;
        end if;
    end process;
end Behavioral;