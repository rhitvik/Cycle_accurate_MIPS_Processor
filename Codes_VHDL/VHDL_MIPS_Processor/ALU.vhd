----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2018 03:04:24
-- Design Name: 
-- Module Name: ALU_module - Behavioral
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; -- vhdl\synopsys\syn_arit.vhd 

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
Port (
Zero: out std_logic;
SrcA : in STD_LOGIC_VECTOR(31 DOWNTO 0);--srcA
SrcB : in STD_LOGIC_VECTOR(31 DOWNTO 0);--srcB
ALUControl : in STD_LOGIC_vector(2 DOWNTO 0);--ALUcontrol
ALUResult : out STD_LOGIC_VECTOR(31 DOWNTO 0)
);
end ALU;

architecture Behavioral of ALU is
    --000add, 010sub, 100and, 101or, 011nor, 001shr 
signal Shift_right_result: std_logic_vector(31 downto 0);
signal ALUResult_Signal : STD_LOGIC_VECTOR(31 DOWNTO 0);

begin

with ALUControl select
ALUResult_Signal <= SrcA + SrcB when "000",
             SrcA - SrcB when "010",
             SrcA and SrcB when "100",
             SrcA or SrcB when "101",
             SrcA nor SrcB when "011",
             Shift_right_result when "001",
             SrcA + SrcB when others; -- 0 when othrs??
 
 Zero <= '1'; --when ALUResult_Signal = x"00000000" else '0'; 
 
 WITH SrcB(4 DOWNTO 0) SELECT
 Shift_right_result <=     
 "0" & SrcA(31 DOWNTO 1) WHEN "00001",
 "00" & SrcA(31 DOWNTO 2) WHEN "00010", 
 "000" & SrcA(31 DOWNTO 3) WHEN "00011",
 "0000" & SrcA(31 DOWNTO 4) WHEN "00100",
 "00000" & SrcA(31 DOWNTO 5) WHEN "00101",
 "000000" & SrcA(31 DOWNTO 6) WHEN "00110",
 "0000000" & SrcA(31 DOWNTO 7) WHEN "00111",
 "00000000" & SrcA(31 DOWNTO 8) WHEN "01000",
 "000000000" & SrcA(31 DOWNTO 9) WHEN "01001",
 "0000000000" & SrcA(31 DOWNTO 10) WHEN "01010",
 "00000000000" & SrcA(31 DOWNTO 11) WHEN "01011",
 "000000000000" & SrcA(31 DOWNTO 12) WHEN "01100",
 "0000000000000" & SrcA(31 DOWNTO 13) WHEN "01101",
 "00000000000000" & SrcA(31 DOWNTO 14) WHEN "01110",
 "000000000000000" & SrcA(31 DOWNTO 15) WHEN "01111",
 "0000000000000000" & SrcA(31 DOWNTO 16) WHEN "10000",
 "00000000000000000" & SrcA(31 DOWNTO 17) WHEN "10001",
 "000000000000000000" & SrcA(31 DOWNTO 18) WHEN "10010",
 "0000000000000000000" & SrcA(31 DOWNTO 19) WHEN "10011",
 "00000000000000000000" & SrcA(31 DOWNTO 20) WHEN "10100",
 "000000000000000000000" & SrcA(31 DOWNTO 21) WHEN "10101",
 "0000000000000000000000" & SrcA(31 DOWNTO 22) WHEN "10110",
 "00000000000000000000000" & SrcA(31 DOWNTO 23) WHEN "10111",
 "000000000000000000000000" & SrcA(31 DOWNTO 24) WHEN "11000",
 "0000000000000000000000000" & SrcA(31 DOWNTO 25) WHEN "11001",
 "00000000000000000000000000" & SrcA(31 DOWNTO 26) WHEN "11010",
 "000000000000000000000000000" & SrcA(31 DOWNTO 27) WHEN "11011",
 "0000000000000000000000000000" & SrcA(31 DOWNTO 28) WHEN "11100",
 "00000000000000000000000000000" & SrcA(31 DOWNTO 29) WHEN "11101",
 "000000000000000000000000000000" & SrcA(31 DOWNTO 30) WHEN "11110",
 "0000000000000000000000000000000" & SrcA(31)           WHEN "11111",
 SrcA WHEN OTHERS; 
    
    ALUResult <= ALUResult_Signal;
    
end Behavioral;
