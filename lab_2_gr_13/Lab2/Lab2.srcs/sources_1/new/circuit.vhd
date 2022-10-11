library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity circuit is
--  Port ( );
end circuit;

architecture Behavioral of circuit is
-- add components 
component memin 
    port (
    );
    end component;

component memout
    port (
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
    en_alu_reg1, en_alu_reg2, en_mult_reg1, en_mult_reg2, en_yti, en_ytr, sw_out : out std_logic);
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
signal cir_memout_we      : std_logic;
signal cir_memout_add      : std_logic_vector(8 downto 0);
signal cir_memin_add      : std_logic_vector(8 downto 0);
signal cir_sw       : std_logic;
begin
-- This is a way of saying that circuit is a top-module for control and datapath
inst_control : control port map(
    clk             => clk,
    rst             => rst,
    sel_set         => sel_set,
    mem_out_we      => cir_memout_we,
    mem_out_add     => cir_memout_add,
    mem_in_addr     => cir_memin_add,
    sel_load        => enables(1 downto 0),
    done            => done,
    oper            => cir_oper,
    en_alu_reg1     => enables(2),
    en_alu_reg2     => enables(3),
    en_mult_reg1    => enables(4),
    en_mult_reg2    => enables(5),
    en_yti          => enables(6),
    en_ytr          => enables(7),
    sw_out          => cir_sw
    -- connect wires
    );
inst_datapath : datapath port map(
    -- connect wires
    );
    
end Behavioral;