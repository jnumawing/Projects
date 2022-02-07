----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2022 11:12:30 PM
-- Design Name: 
-- Module Name: Mux - Behavioral
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
entity Mux is
     port(
            mux_sel:    in std_logic_vector(2 downto 0);
            mux_input1: in std_logic_vector(3 downto 0);
            mux_input2: in std_logic_vector(3 downto 0);
            mux_input3: in std_logic_vector(3 downto 0);
            mux_input4: in std_logic_vector(3 downto 0);
            mux_input5: in std_logic_vector(3 downto 0);
            mux_input6: in std_logic_vector(3 downto 0);
            mux_input7: in std_logic_vector(3 downto 0);
            mux_input8: in std_logic_vector(3 downto 0);
            mux_out:    out std_logic_vector(3 downto 0)  
           );
end Mux;

architecture Behavioral of mux is
begin
DECOD: process(mux_sel,mux_input1,mux_input2,mux_input3,mux_input4,mux_input5,mux_input6,mux_input7,mux_input8)
       variable x: std_logic_vector(3 downto 0); --4'h, 4'b, .....

       begin 
          
       case mux_sel is 
            when "000" => x := mux_input1;
            when "001" => x := mux_input2; 
            when "010" => x := mux_input3; 
            when "011" => x := mux_input4;
            when "100" => x := mux_input5;
            when "101" => x := mux_input6;
            when "110" => x := mux_input7;
            when "111" => x := mux_input8;          
            when others => x :=  (others=>'Z');  --"ZZZZZZZZ";
            
        end case; 

           mux_out <=x; 
       end process;  

end Behavioral;