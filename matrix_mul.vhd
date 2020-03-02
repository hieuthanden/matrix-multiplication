

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;
use work.pkg.all;


entity matrix_mul is

    Port ( clk: IN std_logic;
           go: IN std_logic;
           a_addr: out std_logic_vector( 13 downto 0);
           b_addr: out std_logic_vector( 13 downto 0);
           c_addr: out std_logic_vector( 13 downto 0);
           a_value: in std_logic_vector( 15 downto 0);
           b_value: in std_logic_vector( 15 downto 0);
           c_value: out std_logic_vector( 31 downto 0);
           state: out std_logic_vector(2 downto 0)
    );
end matrix_mul;

architecture Behavioral of matrix_mul is

    signal a_addr_out: integer := 0;
    signal add_v: integer := 0;
    signal index: integer :=0;

begin
    a_addr <= std_logic_vector(to_unsigned(a_addr_out, 14));
    b_addr <= std_logic_vector(to_unsigned((a_addr_out rem 100) , 14));
    c_addr <= std_logic_vector(to_unsigned(((a_addr_out-1) / 100), 14));
    c_value <= std_logic_vector(to_unsigned(add_v, 32));

    mainProcess: Process (clk)
    begin
    if (rising_edge(clk)) then
        if (go = '1') then
            if (index < 10000) then
                a_addr_out <= a_addr_out + 1;
                if((index rem 100) /= 0) then
                    add_v <= add_v + (to_integer(unsigned(a_value)) * to_integer(unsigned(b_value)));
                else
                    add_v <= 0;
                end if;
                index <= index + 1;
            end if;
        else   
            add_v <= 0;
            a_addr_out <= 0;
            index <= 0;
        end if;
    end if;
    END PROCESS;
end Behavioral;
