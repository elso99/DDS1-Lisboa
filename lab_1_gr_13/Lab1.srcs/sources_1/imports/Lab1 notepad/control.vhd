library IEEE;
use IEEE.STD_LOGIC_1164.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control is
  port (
    clk, sw_15 : in  std_logic;
    instr    : in  std_logic_vector (4 downto 0);
    en_r1, en_r2   : out std_logic;
    oper     : out std_logic_vector (2 downto 0);
    s_disp  : out std_logic);
end control;

architecture Behavioral of control is
  type fsm_states is (s_initial, s_end, s_load1, s_load2, s_add, s_xnor, s_mult, s_rtr, s_rst);
  signal currstate, nextstate : fsm_states;

begin
  state_reg : process (clk)
  begin
    if clk'event and clk = '1' then
       currstate <= nextstate;
    end if;
  end process;

  state_comb : process (currstate, instr, sw_15)
  begin  --  process
    nextstate <= currstate;
    -- by default, does not change the state.

    case currstate is
      when s_initial =>
        if instr = "00001" then
          nextstate <= s_load2;
        elsif instr = "00010" then
            if sw_15 = '1' then
                nextstate <= s_mult;
            else
                nextstate <= s_rtr;
            end if;
        elsif instr = "00100" then
          nextstate <= s_rst;
        elsif instr = "01000" then
            if sw_15 = '1' then
                nextstate <= s_add;
            else
                nextstate <= s_xnor;
            end if;
        elsif instr = "10000" then
            nextstate <= s_load1;
        end if;
        oper   <= "000";
        en_r1 <= '0';
        en_r2 <= '0';
        s_disp <= 'X';

      when s_add =>
        nextstate <= s_end;
        oper      <= "011";
        en_r1    <= '1';
        en_r2    <= '0';
        s_disp <= '0';

      when s_load1 =>
        nextstate <= s_end;
        oper      <= "001";
        en_r1    <= '1';
        en_r2    <= '0';
        s_disp <= '0';

      when s_load2 =>
        nextstate <= s_end;
        oper      <= "010";
        en_r1     <= '0';
        en_r2     <= '1';
        s_disp <= '1';

      when s_xnor =>
        nextstate <= s_end;
        oper      <= "110";
        en_r1     <= '1';
        en_r2     <= '0';
        s_disp <= '0';
        
      when s_mult =>
        nextstate <= s_end;
        oper      <= "100";
        en_r1     <= '1';
        en_r2     <= '0';
        s_disp <= '0';
        
      when s_rtr =>
        nextstate <= s_end;
        oper      <= "101";
        en_r1     <= '1';
        en_r2     <= '0';
        s_disp <= '0';
      
      when s_rst =>
        nextstate <= s_end;
        oper      <= "111";
        en_r1     <= '1';
        en_r2     <= '0';
        s_disp <= 'X';
      
      when s_end =>
        if instr = "00000" then
          nextstate <= s_initial;
        end if;
        oper   <= "000";
        en_r1  <= '0';
        en_r2  <= '0';
        s_disp <= 'X';

    end case;
  end process;

end Behavioral;