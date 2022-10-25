library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity control is
    port(
    clk             : in std_logic;
    btnR            : in std_logic; --start button
    sel_load        : in std_logic; --selecting m&b or x&y
    rst             : in std_logic; --reset button which is btnD
    sw0             : in std_logic; -- displays either LSB or MSB
    en_reg          : in std_logic_vector(1 downto 0);
    sel_load        : out std_logic_vector (1 downto 0); -- 00 nothing, 01 M & B, 10 x & y.
    mem_addr        : out std_logic_vector (8 downto 0);
    result          : out std_logic_vector (31 downto 0)); 
end control;

architecture Behavioral of control is

    type c_States is (s_load_mbk_xy1, state_load_xy, state_calculate, state_wait);
    
    signal curr_state   : c_States := state_wait;

    signal addr_counter : std_logic_vector(8 downto 0) := "000000000";
    
    signal done_sign    : std_logic := '0';
    
    signal clk_count    : integer range 0 to 10 := 0;
    
begin
    process(clk) is
    begin
        if clk'event and clk='1' then -- Synchronous since dependent of clock rising edge.
            if rst = '1' then
                done_sign   <= '0';
                btnR        <= '0';
                sel_load    <= "00";
                mem_addr    <= (others => 'X');
                if sel_set = '0' then
                    addr_counter <= (others => '0');
                elsif sel_set = '1' then
                    addr_counter <= "000100000"; -- 0x010
                end if;
            else
                -- Default values
                done        <= done_sign;
                mem_addr    <= (others => 'X');
            else
                case curr_state is
                    when state_wait =>
                        if btnR = '1' then
                                curr_state  <= state_load_mb;
                        end if;
                        --do nothing
                    when state_load_mb =>
                            sel_load <= "01"
                    when state_load_xy =>

                    when state_calculate =>
                                           
                end case;
            end if;
        end if;
    end process;
end Behavioral;