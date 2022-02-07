----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2022 11:06:40 PM
-- Design Name: 
-- Module Name: counter20 - Behavioral
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
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter20 is
    Port (clk:  in std_logic;
          count: out std_logic_vector(19 downto 0)
          );
end counter20;

architecture Behavioral of counter20 is

begin
GEN_COUNT:process(clk)
variable v_count: std_logic_vector(19 downto 0):="00000000000000000000";

begin

if(rising_edge(clk))then
        v_count:=v_count+1;  
    end if;
  
    count<= v_count;
end process;

end Behavioral;
