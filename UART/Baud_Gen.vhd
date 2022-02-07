----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2022 08:47:26 PM
-- Design Name: 
-- Module Name: Baud_Gen - Behavioral
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

entity Baud_Gen is
    --Divisor: 100MHz/(16(samples/bit) * Baud Rate)
    --Divisor = 651
    Generic (constant divisor: positive := 651);
    Port (
          clk: in STD_LOGIC;
          rst: in STD_LOGIC;
          baud_tick: out STD_LOGIC 
          );
end Baud_Gen;

architecture Behavioral of Baud_Gen is
    --tick_count and count_reg are 12 bit registers 
    signal tick_count : integer := divisor;
    signal count_reg : integer range 0 to 4095;

begin

BAUD: process(clk, rst)
begin
    --Synchronous Reset
    if clk = '1' and clk'event then
        if(rst = '1') then
            baud_tick <= '0'; 
            count_reg <= 0;
        else
            if(count_reg = tick_count - 1) then
                count_reg <= 0;
                baud_tick <= '1';
            else
                count_reg <= count_reg + 1;
                baud_tick <= '0';
            end if;
        end if;
    end if;       
end process;
end Behavioral;
