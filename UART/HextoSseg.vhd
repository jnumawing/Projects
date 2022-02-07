----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2022 11:15:00 PM
-- Design Name: 
-- Module Name: HextoSseg - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HextoSseg is
    Port ( hex_in:in std_logic_vector(3 downto 0);
           Sseg: out std_logic_vector(6 downto 0)
          );
end HextoSseg;

architecture Behavioral of HextoSseg is
begin
    Conversion:process(hex_in)
    variable x: std_logic_vector(6 downto 0);
    begin 
        
        case hex_in is 
                when "0000" => x:="1000000";
                when "0001" =>x:="1111001"; 
                when "0010" =>x:="0100100"; 
                when "0011" =>x:="0110000"; 
                when "0100" =>x:="0011001";
                when "0101" =>x:="0010010"; 
                when "0110" =>x:="0000010"; 
                when "0111" =>x:="1111000";
                when "1000" =>x:="0000000"; 
                when "1001" =>x:="0010000";
                when "1010" =>x:="0001000";  --A
                when "1011" =>x:="0000011";  --B wrong 
                when "1100" =>x:="1000110";  --C
                when "1101" =>x:="0100001";  --D wrong 
                when "1110" =>x:="0000110";  --E
                when "1111" =>x:="0001110";  --F
                when others =>x:= (others=>'0'); 
         end case;
         Sseg<=x;
    end process;
end Behavioral;
