library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity circuit is
    Port (
        clk         : in std_logic;
        rst         : in std_logic;
        sel_set     : in std_logic_vector (1 downto 0);
        done        : out std_logic;
        nr_output   : out std_logic_vector (31 downto 0);
        addr_memIN  : out std_logic_vector (4 downto 0);
        addr_memOut : out std_logic_vector (1 downto 0);
        we          : out std_logic;
        temp_val_Vi     : out std_logic_vector(27 downto 0);
        temp_val_Vr     : out std_logic_vector(27 downto 0);
        in_val          : out std_logic_vector(31 downto 0) -- The value that is outputted from memIN at every moment
        );
end circuit;

architecture Behavioral of circuit is
    -- add components 
    component MemIN 
        port (
        clk          : in  std_logic;
        addr_memIN   : in  std_logic_vector(8 downto 0);
        Xr, Xi       : out std_logic_vector(15 downto 0));
    end component;
    
    component MemOUT
        port (
        addr_memOut : in  std_logic_vector(8 downto 0);
        we          : in  std_logic;
        dataIN      : in  std_logic_vector(31 downto 0);
        dataOUT     : out std_logic_vector(31 downto 0);
        clk         : in  std_logic);
    end component;
    
    component control
        port (
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
        en_reg          : out std_logic_vector (5 downto 0)); -- AR1[5], AR2[4], MR1[3], MR2[2], YTR[1], YTI[0]);
    end component;
      
    component datapath
        port (
        clk             : in std_logic;
        sw_out          : in std_logic;
        oper            : in std_logic_vector (2 downto 0);
        mem_in          : in std_logic_vector (31 downto 0);
        en_reg          : in std_logic_vector (5 downto 0);
        sel_load        : in std_logic_vector (1 downto 0);
        nr_out          : out std_logic_vector (31 downto 0);
        temp_val_Vi    : out std_logic_vector(27 downto 0);
        temp_val_Vr    : out std_logic_vector(27 downto 0)
        );
    end component;
     
    signal cir_oper     : std_logic_vector(2 downto 0);
    signal enables      : std_logic_vector(7 downto 0);
    signal cir_sw       : std_logic;
    signal cir_memin    : std_logic_vector(31 downto 0);
    signal cir_dataout  : std_logic_vector(31 downto 0);
    signal cir_addr_memIN   : std_logic_vector (8 downto 0); -- instead of an inout
    signal cir_addr_memOut  : std_logic_vector (8 downto 0); -- instead of an inout
    signal cir_we           : std_logic; -- instead of an inout
    
    begin
    -- This is a way of saying that circuit is a top-module for control and datapath -- [component-port] => [circuit-port/signal]
    inst_MemOUT : MemOUT port map(
        clk             => clk,
        addr_memOut     => cir_addr_memOut,
        we              => cir_we,
        dataIN          => cir_dataout,
        dataOUT         => nr_output
        );
    
    inst_MemIN  : MemIN port map(
        clk             => clk,
        addr_memIN      => cir_addr_memIN,
        Xr              => cir_memin(31 downto 16),
        Xi              => cir_memin(15 downto 0)
        );
    
    inst_control : control port map(
        clk             => clk,
        rst             => rst,
        sel_set         => sel_set,
        mem_out_we      => cir_we,
        mem_out_addr    => cir_addr_memOut,
        mem_in_addr     => cir_addr_memIN,
        sel_load        => enables(1 downto 0),
        done            => done,
        oper            => cir_oper,
        en_reg          => enables(7 downto 2),
        sw_out          => cir_sw
        );
        
    inst_datapath : datapath port map(
        clk             => clk,
        oper            => cir_oper,
        mem_in          => cir_memin,
        sel_load        => enables(1 downto 0),
        en_reg(5)       => enables(7),
        en_reg(4)       => enables(6),
        en_reg(3)       => enables(5),
        en_reg(2)       => enables(4),
        en_reg(1)       => enables(3),
        en_reg(0)       => enables(2),
        sw_out          => cir_sw,
        nr_out          => cir_dataout,
        temp_val_Vi     => temp_val_Vi,
        temp_val_Vr     => temp_val_Vr
        );
        
    addr_memIN <= cir_addr_memIN(4 downto 0);
    addr_memOut <= cir_addr_memOut(1 downto 0);
    we <= cir_we;
    in_val <= cir_memin;
end Behavioral;