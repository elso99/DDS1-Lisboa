library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity circuit is
    Port (
        clk         : in std_logic;
        rst         : in std_logic;
        sel_set     : in std_logic_vector (1 downto 0);
        done        : out std_logic;
        nr_output   : out std_logic_vector (31 downto 0);
        addr_memIN  : inout std_logic_vector (8 downto 0);
        addr_memOut : inout std_logic_vector (8 downto 0);
        we          : inout std_logic
     );
end circuit;

architecture Behavioral of circuit is
-- add components 
component MemIN 
    port (
    clk          : in  std_logic;
    addr_memIN   : in  std_logic_vector(8 downto 0);
    Xr, Xi       : out std_logic_vector(15 downto 0)
    );
    end component;

component MemOUT
    port (
    addr_memOut : in  std_logic_vector(8 downto 0);
    we          : in  std_logic;
    dataIN      : in  std_logic_vector(31 downto 0);
    dataOUT     : out std_logic_vector(31 downto 0);
    clk         : in  std_logic
    );
    end component;

component control
    port (
    clk             : in std_logic;
    rst             : in std_logic;
    sel_set         : in  std_logic_vector (1 downto 0); -- the 4 different memory addresses used for computation.
    mem_out_we      : out std_logic;
    mem_out_addr    : out std_logic_vector (8 downto 0);
    mem_in_addr    : out std_logic_vector (8 downto 0);
    sel_load        : out std_logic_vector (1 downto 0); -- 00 nothing, 01 M & B, 10 Xr & Xi.
    done            : out std_logic;
    oper            : out std_logic_vector (2 downto 0);
    en_reg          : out std_logic_vector (5 downto 0);
    sw_out : out std_logic);
  end component;
  
  component datapath
    port (
    oper : in std_logic_vector (2 downto 0);
    mem_in : in std_logic_vector (31 downto 0);
    clk, en_alu_reg1, en_alu_reg2, en_mult_reg1, en_mult_reg2, en_yti, en_ytr, sw_out : in std_logic;
    sel_load : in std_logic_vector (1 downto 0);
    nr_out : out std_logic_vector (31 downto 0));
  end component;
-- add signals 
signal cir_oper     : std_logic_vector(2 downto 0);
signal enables      : std_logic_vector(7 downto 0);
signal cir_sw       : std_logic;
signal cir_memin    : std_logic_vector(31 downto 0);
signal cir_dataout  : std_logic_vector(31 downto 0);
begin
-- This is a way of saying that circuit is a top-module for control and datapath
inst_MemOUT : MemOUT port map(
    clk             => clk,
    addr_memOut     => addr_memOut,
    we              => we,
    dataIN          => cir_dataout,
    dataOUT         => nr_output
    );

inst_MemIN  : MemIN port map(
    clk             => clk,
    addr_memIN      => addr_memIN,
    Xr              => cir_memin(31 downto 16),
    Xi              => cir_memin(15 downto 0)
    );

inst_control : control port map(
    clk             => clk,
    rst             => rst,
    sel_set         => sel_set,
    mem_out_we      => we,
    mem_out_addr    => addr_memOut,
    mem_in_addr     => addr_memIN,
    sel_load        => enables(1 downto 0),
    done            => done,
    oper            => cir_oper,
    en_reg          => enables(7 downto 2),
    sw_out          => cir_sw
    -- connect wires
    );
inst_datapath : datapath port map(
    clk             => clk,
    oper            => cir_oper,
    mem_in          => cir_memin,
    sel_load        => enables(1 downto 0),
    en_alu_reg1     => enables(7),
    en_alu_reg2     => enables(6),
    en_mult_reg1    => enables(5),
    en_mult_reg2    => enables(4),
    en_ytr          => enables(3),
    en_yti          => enables(2),
    sw_out          => cir_sw,
    nr_out          => cir_dataout
    -- connect wires
    );
    
end Behavioral;