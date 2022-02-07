----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/22/2022 07:33:02 PM
-- Design Name: 
-- Module Name: UART_RX - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UART_RX is
    Generic (constant DATA_WIDTH : positive := 8;
             constant SAMPLE_AMT : positive := 16); --higher sample amount to sample closer to the middle of the bit
    Port (
          clk : in STD_LOGIC;
          rst : in STD_LOGIC;
          baud : in STD_LOGIC;
          rx : in STD_LOGIC;
          rx_done : out STD_LOGIC;
          rx_data : out STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0)
          );
end UART_RX;

architecture Behavioral of UART_RX is

    type state_type is (idle, start, data, stop);
    signal state :state_type := idle;
    
    signal count_reg : integer range 0 to 15;
    signal bit_count : integer range 0 to 7;
    
    signal data_reg : STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
    
begin
--IFL
fsm: process(clk, rst)
begin
    --Synchronous Reset
    if clk = '1' and clk'event then
        if(rst = '1') then 
            state <= idle;
            count_reg <= SAMPLE_AMT-1;
            bit_count <= DATA_WIDTH - 1;        
    else
        case state is
            when idle => if rx = '0' then
                         state <= start;
                         count_reg <= SAMPLE_AMT/2 - 1;
                         bit_count <= DATA_WIDTH - 1;
                         end if;
            
            when start => if baud = '1' then
                            if count_reg = 0 then
                                state <= data;
                                count_reg <= SAMPLE_AMT - 1;
                            else
                                state <= start;
                                count_reg <= count_reg - 1;
                            end if;
                          else
                            state <= state;
                            count_reg <= count_reg;
                            --bit_count <= bit_count;
                          end if;
                          bit_count <= DATA_WIDTH -1;
            
            when data => if baud = '1' then
                            if count_reg = 0 then
                                if bit_count = 0 then
                                    state <= stop;
                                    count_reg <= SAMPLE_AMT/2 - 1;
                                    bit_count <= DATA_WIDTH - 1;
                                else
                                    state <= data;
                                    count_reg <= SAMPLE_AMT - 1;
                                    bit_count <= bit_count - 1;
                                end if;
                            else
                                state <= data;
                                count_reg <= count_reg - 1;
                                bit_count <= bit_count;
                            end if;
                         else
                            state <= state;
                            count_reg <= count_reg;
                            bit_count <= bit_count;
                         end if;                         
            
            when stop => if baud = '1' then
                            if count_reg = 0 then
                                state <= idle;
                                count_reg <= SAMPLE_AMT/2 - 1;
                            else
                                state <= stop;
                                count_reg <= count_reg - 1;
                            end if;
                            bit_count <= DATA_WIDTH - 1;
                         else
                            state <= state;
                            count_reg <= count_reg;
                            bit_count <= bit_count;  
                         end if;
            
            when others => state <= idle;              
        end case;
      end if;
    end if;
end process;

--OFL
OFL: process(clk, rst)
begin
--Synchronous reset
    if clk = '1' and clk'event then
        if rst = '1' then
            rx_done <= '0';
            data_reg <= "00000000";
            rx_data <= "00000000";
        else
            case state is
               
                when data => rx_done <= '0';
                             if baud = '1' then
                                if count_reg = 0 then
                                    data_reg <= rx & data_reg(DATA_WIDTH - 1 downto 1);
                                else
                                    data_reg <= data_reg;
                                end if;
                             end if;
                
                when stop => rx_done <= '1';
                             data_reg <= data_reg;
                             rx_data <= data_reg;
                
                when others => rx_done <= '0';
                               data_reg <= data_reg;  
            end case;
        end if;        
    end if;
end process;

end Behavioral;
