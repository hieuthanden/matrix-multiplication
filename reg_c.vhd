----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2019 11:52:49 AM
-- Design Name: 
-- Module Name: reg_c - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.all;
USE IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_c is
    Port ( 
        clk: In std_logic;
        addr : IN std_logic_vector( 13 downto 0);
        value: IN std_logic_vector (31 downto 0);
        q    : OUT std_logic_vector (31 downto 0);
        w_e  : IN std_logic
  );
end reg_c;


architecture Behavioral of reg_c is
    TYPE mem is ARRAY ( 0 to 16383) of std_logic_vector( 31 downto 0);
    SIGNAL ram : mem;
    
begin
    process(clk, addr)
    begin
        q <= ram(TO_INTEGER(unsigned(addr)));
        if (rising_edge(clk)) then
            if (w_e = '1') then
                ram(TO_INTEGER(unsigned(addr))) <= value;
            end if;
        end if;
    end process;
end Behavioral;
