library IEEE;
use IEEE.STD_LOGIC_1164.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity circuito is
  port (
    clk, sw_15  : in  std_logic;
    instr     : in  std_logic_vector(4 downto 0);
    ent   : in  std_logic_vector(11 downto 0);
    disp : out std_logic_vector(11 downto 0)
    );
end circuito;

architecture Behavioral of circuito is
  component control
    port (
    clk, sw_15 : in  std_logic;
    instr    : in  std_logic_vector (4 downto 0);
    en_r1, en_r2   : out std_logic;
    oper     : out std_logic_vector (2 downto 0);
    s_disp  : out std_logic);
  end component;
  component datapath
    port ( 
    ent : in std_logic_vector (11 downto 0);
    oper : in std_logic_vector (2 downto 0);
    clk, en_r1, en_r2 : in std_logic;
    disp : out std_logic_vector (11 downto 0);
    s_disp  : in std_logic);
  end component;

  signal enable : std_logic_vector(1 downto 0);
  signal oper   : std_logic_vector(2 downto 0);
  signal st_disp : std_logic;

begin
  inst_control : control port map(
    clk    => clk,
    sw_15  => sw_15,
    instr  => instr,
    en_r1  => enable(0),
    en_r2  => enable(1),
    oper   => oper,
    s_disp => st_disp
    );
  inst_datapath : datapath port map(
    ent       => ent,
    oper      => oper,
    clk       => clk,
    en_r2     => enable(1),
    en_r1     => enable(0),
    disp      => disp,
    s_disp    => st_disp
    );

end Behavioral;