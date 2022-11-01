library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity circuit is
    port( 
        clk                 : in std_logic;
        --sw0                 : in std_logic;
        btnR                : in std_logic;
        rst                 : in std_logic; -- btnC
        fit_error           : out std_logic_vector(31 downto 0);
        k                   : out std_logic_vector(7 downto 0) --to control what led from 0 to 7 that should light up.
    );
end circuit;

architecture Behavioral of circuit is

    component control
        port(
            clk             : in std_logic;
            btnR            : in std_logic; --start button
            rst             : in std_logic; --reset button which is btnD
            --sw0             : in std_logic; -- displays either LSB or MSB
            done            : out std_logic;
            reg_counter       : out std_logic_vector (3 downto 0);
            oper            : out std_logic_vector (3 downto 0); --0000 -nothing 0001 load mb, 0010 load xy, 0100 calculate
            mem_addr_a      : out std_logic_vector (9 downto 0);
            mem_addr_b      : out std_logic_vector (9 downto 0) 
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
    
    component datapath
        port(
            clk : in std_logic;
            rst : in std_logic;
            oper : in std_logic_vector(3 downto 0);
            reg_counter : in std_logic_vector(3 downto 0);
            --en_reg : in std_logic_vector(1 downto 0);
            do_a : in std_logic_vector(31 downto 0);
            do_b : in std_logic_vector(31 downto 0);
            fit_err : out std_logic_vector(31 downto 0);
            k   : out std_logic_vector(7 downto 0)
        );
    
    end component;
    
    signal done                     : std_logic;
    signal oper                     : std_logic_vector (3 downto 0);
    signal reg_counter              : std_logic_vector (3 downto 0);
    signal mem_addr_a, mem_addr_b   : std_logic_vector (9 downto 0);
    signal mem_out_a, mem_out_b     : std_logic_vector (31 downto 0);

begin

    reg_counter <= mem_addr_a(3 downto 0); 
    
    inst_control : control port map(
        clk         => clk,
        btnR        => btnR,
        rst         => rst,
        --sw0         => sw0,
        done        => done,
        oper        => oper,
        reg_counter   => reg_counter,
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
    
    inst_datapath : datapath port map(
        clk         => clk,
        rst         => rst, --should it come from control or just the button?
        oper        => oper,
        reg_counter => reg_counter,
        --en_reg : in std_logic_vector(1 downto 0);
        do_a        => mem_out_a,
        do_b        => mem_out_b,
        fit_err     => fit_error,
        k           => k
    );

end Behavioral;
