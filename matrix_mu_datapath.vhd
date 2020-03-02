

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use work.pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity matrix_mu_datapath is
  Port ( 
        clk: IN std_logic;
        go: In std_logic;
        addr_a_in: IN std_logic_vector ( 13 downto 0);
        addr_b_in: IN std_logic_vector ( 13 downto 0);
        addr_c_in: IN std_logic_vector ( 13 downto 0);
        val_a_in: IN std_logic_vector ( 15 downto 0);
        val_b_in: IN std_logic_vector ( 15 downto 0);
        val_c_out: OUT std_logic_vector ( 31 downto 0);
        state_out: OUT std_logic_vector (2 downto 0);
        w_e_a: IN std_logic;
        w_e_b: IN std_logic;
        add_a_check: OUT std_logic_vector ( 13 downto 0)
          );
end matrix_mu_datapath;

architecture Behavioral of matrix_mu_datapath is
 
    component matrix_mul is
    Port ( clk: IN std_logic;
           go: IN std_logic;
           a_addr: out std_logic_vector( 13 downto 0);
           b_addr: out std_logic_vector( 13 downto 0);
           c_addr: out std_logic_vector( 13 downto 0);
           a_value: in std_logic_vector( 15 downto 0);
           b_value: in std_logic_vector( 15 downto 0);
           c_value: out std_logic_vector( 31 downto 0);
           state: OUT std_logic_vector (2 downto 0)     
    );
    end component;
    
    component reg_a is
    Port ( 
        clk  : IN std_logic;
        addr : IN std_logic_vector(13 downto 0);
        value: IN std_logic_vector (15 downto 0);
        w_e: IN std_logic;
        q  : OUT std_logic_vector (15 downto 0)
    );
    end component;
    
    component reg_b is
    Port ( 
        clk  : IN std_logic;
        addr : IN std_logic_vector(13 downto 0);
        value: IN std_logic_vector (15 downto 0);
        w_e: IN std_logic;
        q  : OUT std_logic_vector (15 downto 0)
  );
    end component;
    
    component reg_c is
    Port ( 
        clk: In std_logic;
        addr : IN std_logic_vector( 13 downto 0);
        value: IN std_logic_vector (31 downto 0);
        q    : OUT std_logic_vector (31 downto 0);
        w_e  : IN std_logic
  );
    end component;
    
 -- Signal declaration
    SIGNAL addr_a, addr_b, addr_c: std_logic_vector (13 downto 0);
    SIGNAL addr_a_f, addr_b_f, addr_c_f: std_logic_vector (13 downto 0);
    SIGNAL q_a, q_b : std_logic_vector (15 downto 0);
    SIGNAL val_c : std_logic_vector( 31 downto 0);
    SIGNAL state_s: std_logic_vector (2 downto 0);

        
begin
    
    state_out <= state_s;
    addr_a <= addr_a_in when (go = '0') else addr_a_f;
    addr_b <= addr_b_in when (go = '0') else addr_b_f;
    addr_c <= addr_c_in when (go = '0') else addr_c_f;
    add_a_check <= addr_a_f;
    
    matrix_com: matrix_mul PORT MAP (
        clk => clk,
        go => go,
        a_addr => addr_a_f, b_addr => addr_b_f, c_addr => addr_c_f,
        a_value => q_a, b_value => q_b, c_value => val_c,
        state =>  state_s);
    reg_a_com: reg_a PORT MAP (
        clk => clk, addr => addr_a, value => val_a_in, w_e => w_e_a, q => q_a);
    reg_b_com: reg_b PORT MAP (
        clk => clk, addr => addr_b, value => val_b_in, w_e => w_e_b, q => q_b);
    reg_c_com: reg_c PORT MAP (
        clk => clk, addr => addr_c, value => val_c, w_e => go, q => val_c_out); 
    
end Behavioral;
