----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.11.2018 02:55:33
-- Design Name: 
-- Module Name: Register_File - Behavioral
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL; --use CONV_INTEGER

use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Register_File is
Port (

RF_out0: out std_logic_vector(31 downto 0);
RF_out1: out std_logic_vector(31 downto 0);
RF_out2: out std_logic_vector(31 downto 0);
RF_out3: out std_logic_vector(31 downto 0);
RF_out4: out std_logic_vector(31 downto 0);
RF_out5: out std_logic_vector(31 downto 0);
RF_out6: out std_logic_vector(31 downto 0);
RF_out7: out std_logic_vector(31 downto 0);
RF_out8: out std_logic_vector(31 downto 0);
RF_out9: out std_logic_vector(31 downto 0);
RF_out10: out std_logic_vector(31 downto 0);
RF_out11: out std_logic_vector(31 downto 0);
RF_out12: out std_logic_vector(31 downto 0);
RF_out13: out std_logic_vector(31 downto 0);
RF_out14: out std_logic_vector(31 downto 0);
RF_out15: out std_logic_vector(31 downto 0);
RF_out16: out std_logic_vector(31 downto 0);
RF_out17: out std_logic_vector(31 downto 0);
RF_out18: out std_logic_vector(31 downto 0);
RF_out19: out std_logic_vector(31 downto 0);
RF_out20: out std_logic_vector(31 downto 0);
RF_out21: out std_logic_vector(31 downto 0);
RF_out22: out std_logic_vector(31 downto 0);
RF_out23: out std_logic_vector(31 downto 0);
RF_out24: out std_logic_vector(31 downto 0);
RF_out25: out std_logic_vector(31 downto 0);
RF_out26: out std_logic_vector(31 downto 0);
RF_out27: out std_logic_vector(31 downto 0);
RF_out28: out std_logic_vector(31 downto 0);
RF_out29: out std_logic_vector(31 downto 0);
RF_out30: out std_logic_vector(31 downto 0);
RF_out31: out std_logic_vector(31 downto 0);
 
  
 RST: in std_logic;
 MIPS_CLK_RF: in std_logic; 
 Instr: in std_logic_vector(31 downto 0);
 WD3: in std_logic_vector(31 downto 0);  
 WriteData: out std_logic_vector(31 downto 0);
 
 PCPlus4_RF_read: in std_logic_vector(31 downto 0);
 PCBranch_RF_out: out std_logic_vector(31 downto 0);-- goes to the counter
 
  OPcode_register_file: out std_logic_vector(5 downto 0); 
  funct_register_file: out std_logic_vector(5 downto 0);  
  
  SrcA: out std_logic_vector(31 downto 0);
  SrcB: out std_logic_vector(31 downto 0); 
  
   RD1_Feedback: out std_logic_vector(31 downto 0);
   RD2_Feedback: out std_logic_vector(31 downto 0);
  
  JUMP_ADDRESS: out std_logic_vector(25 downto 0);
  
 WE3_RF_read: in std_logic;  
 RegDst_RF_read: in std_logic; -- for destination address mux.. controlled via control unit
 ALUSrc_RF_read: in std_logic 
 );
end Register_File;

architecture Behavioral of Register_File is

signal A1: std_logic_vector(4 downto 0);--source reg address
signal A2: std_logic_vector(4 downto 0);--reg2 address if rtype else destination address in i type
signal A3: std_logic_vector(4 downto 0);--destination address if r type
 
signal RD1: std_logic_vector(31 downto 0);
signal RD2: std_logic_vector(31 downto 0); 
  
Type Register_File is array (0 to 31) of std_logic_vector(31 downto 0);
signal RF: Register_File:=( 
        x"00000000", x"00000000", x"00000000", x"00000000",
        x"00000000", x"00000000", x"00000000", x"00000000",
        x"00000000", x"00000000", x"00000000", x"00000000",
        x"00000000", x"00000000", x"00000000", x"00000000",
        x"00000000", x"00000000", x"00000000", x"00000000",
        x"00000000", x"00000000", x"00000000", x"00000000",
        x"00000000", x"00000000", x"00000000", x"00000000",
        x"00000000", x"00000000", x"00000000", x"00000000"
    );                            
    
--signal Fresh_Write_Enable: std_logic;
--signal Fresh_data: std_logic_vector(31 downto 0);
--signal Fresh_destination: std_logic_vector (4 downto 0);

signal Sign_Extend: std_logic_vector(15 downto 0);
signal SignImm: std_logic_vector(31 downto 0);
begin
--    process(MIPS_CLK_RF)
--    begin
--    if (RST = '1') then
--    RF<=( 
--        x"00000000", x"00000000", x"00000000", x"00000000",
--        x"70F83B8A", x"284B8303", x"513E1454", x"F621ED22",
--        x"3125065D", x"11A83A5D", x"D427686B", x"713AD82D",
--        x"4B792F99", x"2799A4DD", x"A7901C49", x"DEDE871A",
--        x"36C03196", x"A7EFC249", x"61A78BB8", x"3B0A1D2B",
--        x"4DBFCA76", x"AE162167", x"30D76B0A", x"43192304",
--        x"F6CC1431", x"65046380", x"AAAAAAAA", x"BBBBBBBB",
--        x"CCCCCCCC", x"DDDDDDDD", x"EEEEEEEE", x"00000000"
--        ); 
--    elsif (rising_edge(MIPS_CLK_RF)) then    
--       if(WE3_RF_read = '1') then
--       RF(to_integer(unsigned(A3))) <= WD3;  
--       end if;        
--    end if;
--    end process; 

    process(MIPS_CLK_RF)
    begin
    if (RST = '1') then
    RF<=( 
        x"00000000", x"00000000", x"00000000", x"00000000",
        x"00000000", x"00000000", x"00000000", x"00000000",
        x"00000000", x"00000000", x"00000000", x"00000000",
        x"00000000", x"00000000", x"00000000", x"00000000",
        x"00000000", x"00000000", x"00000000", x"00000000",
        x"00000000", x"00000000", x"00000000", x"00000000",
        x"00000000", x"00000000", x"00000000", x"00000000",
        x"00000000", x"00000000", x"00000000", x"00000000"
        ); 
    elsif (rising_edge(MIPS_CLK_RF)) then 
           
       if(WE3_RF_read = '1') then
       RF(to_integer(unsigned(A3))) <= WD3;  
       end if;        
    end if;
    end process; 
   --REGISTER_SEVENval <= RF(7);
    OPcode_register_file <= Instr(31 downto 26); 
    funct_register_file <= Instr(5 downto 0);
    --rs_RF <= A1; rt_RF <= A2;
    A1 <= Instr(25 downto 21);
    A2 <= Instr(20 downto 16);
    A3 <= Instr(15 downto 11) when RegDst_RF_read = '1' else Instr(20 downto 16); 
    
    -----------------------------------------------------------------------------------------
    PCBranch_RF_out <= PCPlus4_RF_read + (SignImm(31 downto 2)& "00");   ---INVESTIGATE------ 
    -----------------------------------------------------------------------------------------
             
    RD1 <= x"00000000" when A1="00000" else RF(to_integer(unsigned(A1)));
    RD2 <= x"00000000" when A2="00000" else RF(to_integer(unsigned(A2)));
    RD1_feedback <= RD1;
    RD2_Feedback <= RD2;
    SrcA <= RD1;
    SrcB <= SignImm when ALUSrc_RF_read ='1' else RD2;
    WriteData <= RD2;
    JUMP_ADDRESS <= Instr(25 downto 0);
    Sign_Extend <= Instr(15 downto 0);
    SignImm <= "0000000000000000" & Sign_Extend when Sign_Extend(15) = '0'
            else "1111111111111111" & Sign_Extend;  
            
            
    RF_out0  <= RF(0);  
    RF_out1  <= RF(1);
    RF_out2  <= RF(2);
    RF_out3  <= RF(3);
    RF_out4  <= RF(4);
    RF_out5  <= RF(5);
    RF_out6  <= RF(6);
    RF_out7  <= RF(7);
    RF_out8  <= RF(8);
    RF_out9  <= RF(9);
    RF_out10  <= RF(10);
    RF_out11  <= RF(11);
    RF_out12  <= RF(12);
    RF_out13  <= RF(13);
    RF_out14  <= RF(14);
    RF_out15  <= RF(15);
    RF_out16  <= RF(16);
    RF_out17  <= RF(17);
    RF_out18  <= RF(18);
    RF_out19  <= RF(19);
    RF_out20  <= RF(20);
    RF_out21  <= RF(21);
    RF_out22  <= RF(22);
    RF_out23  <= RF(23);
    RF_out24  <= RF(24);
    RF_out25  <= RF(25);
    RF_out26  <= RF(26);
    RF_out27  <= RF(27);
    RF_out28  <= RF(28);
    RF_out29  <= RF(29);
    RF_out30  <= RF(30);
    RF_out31  <= RF(31);
         
end Behavioral;

