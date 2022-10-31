library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.all;

entity control is
    port(
    clk             : in std_logic;
    btnR            : in std_logic; --start button
    rst             : in std_logic; --reset button which is btnD
    sw0             : in std_logic; -- displays either LSB or MSB
    done            : out std_logic;
    oper            : out std_logic_vector (3 downto 0); --0000 -nothing 0001 load mb, 0010 load xy, 0100 calculate
    mem_addr        : out std_logic_vector (8 downto 0)); 
end control;

architecture Behavioral of control is

    type c_States is (s_load_mb, s_load_xy, s_calculate, s_wait);
    
    signal curr_state   : c_States := s_wait;

    signal addr_counter : std_logic_vector(8 downto 0) := "000000000";
    
    signal disp_led    : std_logic := '0';
    
    signal count    : integer range 0 to 10 := 0;
    
    signal mem_counter : integer range 0 to 15 := 0;
    
begin
    process(clk) is
    begin
        if clk'event and clk='1' then -- Synchronous since dependent of clock rising edge.
            if rst = '1' then -- reset
                curr_state <= s_wait;
                disp_led <= '0';
                mem_counter <= 0;
            end if;
            if btnR = '1' then -- begin
                curr_state <= s_load_mb;
                mem_counter <= 0;
                disp_led <= '0';
                oper <= "1000"; -- reset sign.
            end if;
            -- Default values
            mem_addr <= (others => '0');
            oper <= (others => '0');
            done <= disp_led;
            mem_addr <= std_logic_vector(to_unsigned(mem_counter, mem_addr'length));
            
            case curr_state is
                when s_wait =>
                    --do nothing
                    if sw0 = '1' then
                        oper <= "1100"; -- disp msb
                    else
                        oper <= "1000"; -- disp lsb
                    end if;
                when s_load_mb =>
                    oper <= "0001";
                    count <= count + 1;
                    mem_counter <= mem_counter + 1;
                    if count = x"4" then
                        count <= 0; 
                        curr_state <= s_load_xy;
                    end if;
                when s_load_xy =>
                    oper <= "0010";
                    count <= count + 1;
                    mem_counter <= mem_counter + 1;
                    if count = x"8" then
                        count <= 0; 
                        curr_state <= s_calculate;
                    end if;
                when s_calculate =>
                    oper <= "0000";
                    count <= count + 1;
                    if count = x"9" then
                        count <= 0; 
                        disp_led <= '1';
                        curr_state <= s_wait;
                    end if;                    
            end case;
        end if;
    end process;
end Behavioral;