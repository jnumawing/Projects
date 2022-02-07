----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2022 10:46:43 PM
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port (
          clk : in STD_LOGIC;
          rst : in STD_LOGIC;
          rx : in STD_LOGIC;
          rx_done : out STD_LOGIC;
          Sseg_out : out STD_LOGIC_VECTOR (6 downto 0);
          en : out STD_LOGIC_VECTOR (7 downto 0)
          );
end top;

architecture Behavioral of top is

--component declaration
--BAUD Generator declaration
component Baud_Gen
    Port (
          clk: in std_logic;
          rst: in std_logic;
          baud_tick: out std_logic
          );
end component;  
--UART Receiver declaration
component UART_RX
    Generic (
            constant DATA_WIDTH : positive := 8;
            constant SAMPLE_AMT : positive := 16
            );
    Port (
          clk : in std_logic;
          rst : in std_logic;
          baud : in std_logic;
          rx : in std_logic;
          rx_done : out std_logic;
          rx_data : out std_logic_vector(DATA_WIDTH - 1 downto 0)
         );
end component;

--Display Circuit 
--20 bit counter
component counter20
    Port (clk:  in std_logic;
          count: out std_logic_vector(19 downto 0)
          );
end component;
--Decoder
component Decoder
      Port (
            s: in std_logic_vector(2 downto 0);
            p: out std_logic_vector(7 downto 0) 
             );
end component;
--Multiplexer
component Mux
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
end component;
--Hex to 7 Segment Decoder
component HextoSseg
    Port ( 
          hex_in:in std_logic_vector(3 downto 0);
          Sseg: out std_logic_vector(6 downto 0)
         );
end component;

--signals declaration
--UART signals
signal baud_tick: std_logic;
signal rx_data : std_logic_vector(7 downto 0);
--signal rx_done : std_logic;
--Display Circuit Signals
signal count20: std_logic_vector(19 downto 0);
signal sel: std_logic_vector(2 downto 0);
signal dec_out: std_logic_vector(7 downto 0);
signal sel_conv: std_logic_vector(3 downto 0);
signal data_out: std_logic_vector(7 downto 0);

begin
sel <= count20(19 downto 17);
--UART
UART_BAUD: Baud_Gen
    port map(
             clk => clk,
             rst => rst,
             baud_tick => baud_tick
            );
UART_RECEIVER: UART_RX
    generic map (DATA_WIDTH => 8, SAMPLE_AMT => 16)
    port map(
             clk => clk,
             rst => rst,
             baud => baud_tick,
             rx => rx,
             rx_done => rx_done,
             rx_data => rx_data
            );
--display circuit
CLK_COUNT: counter20
    port map(
            clk => clk,
            count => count20
            );

ANODE_SEL: Decoder
    port map(
            s => sel,
            p => en
            );

OUT_SEL: MUX
    port map(
            mux_sel => sel,
            mux_input1 => rx_data(3 downto 0),
            mux_input2 => rx_data(7 downto 4),
            mux_input3 => "0000",
            mux_input4 => "0000",
            mux_input5 => "0000",
            mux_input6 => "0000",
            mux_input7 => "0101",
            mux_input8 => "1010",
            mux_out => sel_conv
            );

DISP: HextoSseg
    port map(
            hex_in => sel_conv,
            Sseg => Sseg_out
            );
end Behavioral;
