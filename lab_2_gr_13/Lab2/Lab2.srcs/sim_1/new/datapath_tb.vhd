library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity datapath_tb is
end datapath_tb;

architecture Behavioral of datapath_tb is

component datapath
    port ( 
    clk             : in std_logic;
    sw_out          : in std_logic;
    oper            : in std_logic_vector (2 downto 0);
    mem_in          : in std_logic_vector (31 downto 0);
    en_reg          : in std_logic_vector (5 downto 0); -- AR1[5], AR2[4], MR1[3], MR2[2], YTR[1], YTI[0], register enables.
    sel_load        : in std_logic_vector (1 downto 0);
    nr_out          : out std_logic_vector (31 downto 0);
    temp_val_Vi     : out std_logic_vector(27 downto 0);
    temp_val_Vr     : out std_logic_vector(27 downto 0));

end component;

    signal clk              : std_logic                         := '0';
    signal sw_out           : std_logic                         := '0';
    signal oper             : std_logic_vector (2 downto 0)     := "111";
    signal mem_in           : std_logic_vector (31 downto 0)    := x"00000000";
    signal en_reg           : std_logic_vector (5 downto 0)     := "00000"; -- AR1[5], AR2[4], MR1[3], MR2[2], YTR[1], YTI[0], register enables.
    signal sel_load         : std_logic_vector (1 downto 0)     := "00";
    
    signal nr_out           : std_logic_vector (31 downto 0);
    signal temp_val_Vi      : std_logic_vector(27 downto 0);
    signal temp_val_Vr      : std_logic_vector(27 downto 0);
    
    constant clk_period : time := 20 ns;
    constant p : time := 1200 ns; -- some buffer signal
    
begin
  uut : datapath port map (
    clk             => clk,
    sw_out          => sw_out,
    oper            => oper,
    mem_in          => mem_in,
    en_reg          => en_reg,      
    sel_load        => sel_load,
    
    nr_out          => nr_out,
    temp_val_Vi     => temp_val_Vi,
    temp_val_Vr     => temp_val_Vr
    );
    
-- Clock definition
  clk <= not clk after clk_period/2; -- 20ns

  -- Stimulus process
  stim_proc : process
  begin
    -- hold reset state for 100 ns.
    wait for 80 ns;
    -- insert stimulus here
    -- note that input signals should never change at the positive edge of the clock
    mem_in      <=  x"FFBA0A60" after 180 ns, -- Br,Bi,Mr,Mi
                    x"FFD7FFE9" after 200 ns, -- Xr,Xi [0]
                    x"00740069" after 300 ns, -- Xr,Xi [1]
                    x"00680064" after 400 ns, -- Xr,Xi [2]
                    x"003C0016" after 500 ns, -- Xr,Xi [3]
                    x"FFDDFFD2" after 600 ns, -- Xr,Xi [4]
                    x"FF9AFF89" after 700 ns, -- Xr,Xi [5]
                    x"FF820040" after 800 ns, -- Xr,Xi [6]
                    x"0008FF88" after 900 ns; -- Xr,Xi [7]
    wait;
  end process;  
    
   

end Behavioral;
