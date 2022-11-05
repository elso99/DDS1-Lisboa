library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity circuit is
    port( 
        clk                 : in std_logic;
        btnR                : in std_logic;
        rst                 : in std_logic; -- btnD
        done                : out std_logic;
        fit_error           : out std_logic_vector(31 downto 0);
        k                   : out std_logic_vector(7 downto 0) --to control what led from 0 to 7 that should light up.
    );
end circuit;

architecture Behavioral of circuit is

    component control
        port(
            clk                     : in std_logic;
            btnR                   : in std_logic; --start button
            rst                     : in std_logic; --reset button which is btnD
            done                    : out std_logic; --disp led
            reg_addr                : out std_logic_vector (3 downto 0);
            en                      : out std_logic;
            mem_addr_a, mem_addr_b  : out std_logic_vector (9 downto 0) 
        );
    end component;
    
    component MemIN
        port(
            clk             : in  std_logic;
            addr_a          : in  std_logic_vector(9 downto 0);
            addr_b          : in  std_logic_vector(9 downto 0);
            do_a            : out std_logic_vector(31 downto 0);
            do_b            : out std_logic_vector(31 downto 0)
        );
    end component;
    
    component datapath2
        port(
            clk         : in std_logic;
            rst         : in std_logic;
            en          : in std_logic; -- 01 for load mb, 10 for the rest, 00 for do nothing.
            reg_addr    : in std_logic_vector(3 downto 0);
            memIN_1     : in std_logic_vector(31 downto 0);
            memIN_2     : in std_logic_vector(31 downto 0);
            fit_err     : out std_logic_vector(31 downto 0);
            k           : out std_logic_vector(7 downto 0)
        );
    
    end component;
    
    signal en                       : std_logic;
    signal reg_addr                 : std_logic_vector (3 downto 0);
    signal mem_addr_a, mem_addr_b   : std_logic_vector (9 downto 0);
    signal mem_out_a, mem_out_b     : std_logic_vector (31 downto 0);

begin
    
    inst_control : control port map(
        clk         => clk,
        btnR        => btnR,
        rst         => rst,
        done        => done,
        reg_addr    => reg_addr,
        en          => en,
        mem_addr_a  => mem_addr_a,
        mem_addr_b  => mem_addr_b
    );
    
    inst_MemIN : MemIN port map(
        clk         => clk,
        addr_a      => mem_addr_a,
        addr_b      => mem_addr_b,
        do_a        => mem_out_a,
        do_b        => mem_out_b
    );
    
    inst_datapath : datapath2 port map(
        clk         => clk,
        rst         => rst, --should it come from control or just the button?
        en          => en,
        reg_addr    => reg_addr,
        memIN_1     => mem_out_a,
        memIN_2     => mem_out_b,
        fit_err     => fit_error,
        k           => k
    );

end Behavioral;
