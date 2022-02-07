----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2022 11:09:03 PM
-- Design Name: 
-- Module Name: Decoder - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decoder is
      Port (
            s: in std_logic_vector(2 downto 0);  -- Input ports (Same category) 
            p: out std_logic_vector(7 downto 0)  --  Output ports (Same Categrory) 
             );
end Decoder;

architecture Behavioral of Decoder is

begin
DECOD: process(s)
       variable x: std_logic_vector(7 downto 0):=x"00"; --4'h, 4'b, .....

       begin 
          
       case s is 
            when "000" => x(0) := '0'; x(7 downto 1) := (others =>'1');
            when "001" => x(1) := '0'; x(0) := '1'; x(7 downto 2) :=(others =>'1'); 
            when "010" => x(2) := '0'; x(1 downto 0) := (others =>'1');  x(7 downto 3) := (others =>'1'); 
            when "011" => x(3) := '0'; x(2 downto 0) := (others =>'1');  x(7 downto 4) := (others =>'1');
            when "100" => x(4) := '0'; x(3 downto 0) := (others =>'1');  x(7 downto 5) := (others =>'1');
            when "101" => x(5) := '0'; x(4 downto 0) := (others =>'1');  x(7 downto 6) := (others =>'1');
            when "110" => x(6) := '0'; x(5 downto 0) := (others =>'1');  x(7) := '1';
            when "111" => x(7) := '0'; x(6 downto 0) := (others =>'1');          
            when others => x :=  (others=>'1');  --"ZZZZZZZZ";           
        end case; 
           p <=x; 
       end process;  
end Behavioral;
