----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2018 19:05:03
-- Design Name: 
-- Module Name: datamem - Behavioral
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
 
entity datamem is
  PORT ( 
     
  Dmem_out0: out std_logic_vector(31 downto 0);
  Dmem_out1: out std_logic_vector(31 downto 0);
  Dmem_out2: out std_logic_vector(31 downto 0);
  Dmem_out3: out std_logic_vector(31 downto 0);
  Dmem_out4: out std_logic_vector(31 downto 0);
  Dmem_out5: out std_logic_vector(31 downto 0);
  Dmem_out6: out std_logic_vector(31 downto 0);
  Dmem_out7: out std_logic_vector(31 downto 0);
  Dmem_out8: out std_logic_vector(31 downto 0);
  Dmem_out9: out std_logic_vector(31 downto 0);
  Dmem_out10: out std_logic_vector(31 downto 0);
  Dmem_out11: out std_logic_vector(31 downto 0);
  Dmem_out12: out std_logic_vector(31 downto 0);
  Dmem_out13: out std_logic_vector(31 downto 0);
  Dmem_out14: out std_logic_vector(31 downto 0);
  Dmem_out15: out std_logic_vector(31 downto 0);
  Dmem_out16: out std_logic_vector(31 downto 0);
  Dmem_out17: out std_logic_vector(31 downto 0);
  Dmem_out18: out std_logic_vector(31 downto 0);
  Dmem_out19: out std_logic_vector(31 downto 0);
  Dmem_out20: out std_logic_vector(31 downto 0);
  Dmem_out21: out std_logic_vector(31 downto 0);
  Dmem_out22: out std_logic_vector(31 downto 0);
  Dmem_out23: out std_logic_vector(31 downto 0);
  Dmem_out24: out std_logic_vector(31 downto 0);
  Dmem_out25: out std_logic_vector(31 downto 0);
  Dmem_out26: out std_logic_vector(31 downto 0);
  Dmem_out27: out std_logic_vector(31 downto 0);
  Dmem_out28: out std_logic_vector(31 downto 0);
  Dmem_out29: out std_logic_vector(31 downto 0);
  Dmem_out30: out std_logic_vector(31 downto 0);
  Dmem_out31: out std_logic_vector(31 downto 0);
     
     MIPS_CLK_Dem: in std_logic;  -- Clock signal
     ALU_result: in std_logic_vector(31 DOWNTO 0);--32-bit address
     WD: in std_logic_vector (31 DOWNTO 0);--32-bit input
     WE: in std_logic; --Write Enable
     Result: out std_logic_vector(31 DOWNTO 0);-- read data
     MemtoReg: in std_logic;
     
     RD_out: out std_logic_vector(31 downto 0);
     readAddress_out: out std_logic_vector(6 downto 0)
     ); 
end datamem;

architecture Behavioral of datamem is 

TYPE datamem_ARRAY IS ARRAY (0 to 131) OF STD_LOGIC_VECTOR(7 DOWNTO 0); -- (0 TO 2**A'length)     
signal Data_Memory : datamem_ARRAY:=( 
x"00",x"00",x"00",x"00", 
x"00",x"00",x"00",x"00", 
x"46",x"F8",x"E8",x"C5", 
x"46",x"0C",x"60",x"85",
x"70",x"F8",x"3B",x"8A", 
x"28",x"4B",x"83",x"03", 
x"51",x"3E",x"14",x"54", 
x"F6",x"21",x"ED",x"22",
x"31",x"25",x"06",x"5D", 
x"11",x"A8",x"3A",x"5D", 
x"D4",x"27",x"68",x"6B", 
x"71",x"3A",x"D8",x"2D",
x"4B",x"79",x"2F",x"99", 
x"27",x"99",x"A4",x"DD", 
x"A7",x"90",x"1C",x"49", 
x"DE",x"DE",x"87",x"1A",
x"36",x"C0",x"31",x"96", 
x"A7",x"EF",x"C2",x"49", 
x"61",x"A7",x"8B",x"B8", 
x"3B",x"0A",x"1D",x"2B",
x"4D",x"BF",x"CA",x"76", 
x"AE",x"16",x"21",x"67", 
x"30",x"D7",x"6B",x"0A", 
x"43",x"19",x"23",x"04",
x"F6",x"CC",x"14",x"31", 
x"65",x"04",x"63",x"80",
x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00"

--x"00",x"00",x"00",x"00", 
--x"00",x"00",x"00",x"00", 
--x"f4",x"50",x"44",x"d5", 
--x"92",x"87",x"be",x"8e", 
--x"30",x"bf",x"38",x"47", 
--x"ce",x"f6",x"b2",x"00",
--x"6d",x"2e",x"2b",x"b9", 
--x"0b",x"65",x"a5",x"72", 
--x"a9",x"9d",x"1f",x"2b", 
--x"47",x"d4",x"98",x"e4", 
--x"e6",x"0c",x"12",x"9d", 
--x"84",x"43",x"8c",x"56",
--x"22",x"7b",x"06",x"0f", 
--x"c0",x"b2",x"7f",x"c8", 
--x"5e",x"e9",x"f9",x"81", 
--x"fd",x"21",x"73",x"3a", 
--x"9b",x"58",x"ec",x"f3", 
--x"39",x"90",x"66",x"ac",
--x"d7",x"c7",x"e0",x"65", 
--x"75",x"ff",x"5a",x"1e", 
--x"14",x"36",x"d3",x"d7", 
--x"b2",x"6e",x"4d",x"90", 
--x"50",x"a5",x"c7",x"49", 
--x"ee",x"dd",x"41",x"02",
--x"8d",x"14",x"ba",x"bb",
--x"2b",x"4c",x"34",x"74",
--x"00",x"00",x"00",x"00", 
--x"00",x"00",x"00",x"00", 
--x"00",x"00",x"00",x"00", 
--x"00",x"00",x"00",x"00", 
--x"00",x"00",x"00",x"00", 
--x"00",x"00",x"00",x"00",
--x"00",x"00",x"00",x"00"


--x"b7",x"e1",x"51",x"63", 
--x"56",x"18",x"cb",x"1c", 
--x"f4",x"50",x"44",x"d5", 
--x"92",x"87",x"be",x"8e", 
--x"30",x"bf",x"38",x"47", 
--x"ce",x"f6",x"b2",x"00",
--x"6d",x"2e",x"2b",x"b9", 
--x"0b",x"65",x"a5",x"72", 
--x"a9",x"9d",x"1f",x"2b", 
--x"47",x"d4",x"98",x"e4", 
--x"e6",x"0c",x"12",x"9d", 
--x"84",x"43",x"8c",x"56",
--x"22",x"7b",x"06",x"0f", 
--x"c0",x"b2",x"7f",x"c8", 
--x"5e",x"e9",x"f9",x"81", 
--x"fd",x"21",x"73",x"3a", 
--x"9b",x"58",x"ec",x"f3", 
--x"39",x"90",x"66",x"ac",
--x"d7",x"c7",x"e0",x"65", 
--x"75",x"ff",x"5a",x"1e", 
--x"14",x"36",x"d3",x"d7", 
--x"b2",x"6e",x"4d",x"90", 
--x"50",x"a5",x"c7",x"49", 
--x"ee",x"dd",x"41",x"02",
--x"8d",x"14",x"ba",x"bb",
--x"2b",x"4c",x"34",x"74",
--x"00",x"00",x"00",x"00", 
--x"00",x"00",x"00",x"00", 
--x"00",x"00",x"00",x"00", 
--x"00",x"00",x"00",x"00", 
--x"00",x"00",x"00",x"00", 
--x"00",x"00",x"00",x"00",
--x"00",x"00",x"00",x"00"
);

signal RD: std_logic_vector(31 DOWNTO 0);-- read data
signal A: std_logic_vector(31 DOWNTO 0);
signal ReadAddress:std_logic_vector(6 downto 0); 
begin

    process (MIPS_CLK_Dem)  
    begin
    if (rising_edge(MIPS_CLK_Dem)) then
         if (WE = '1') then
          Data_Memory(to_integer(unsigned(ReadAddress)))    <= WD(31 downto 24);
          Data_Memory((to_integer(unsigned(ReadAddress))) + 1)<= WD(23 downto 16);
          Data_Memory((to_integer(unsigned(ReadAddress))) + 2)<= WD(15 downto 8);
          Data_Memory((to_integer(unsigned(ReadAddress))) + 3)<= WD(7 downto 0);
             end if;           
        end if;                                
     end process;  
         
-- PROCESS(MEMtoReg)
-- begin
-- if (MemtoReg = '1') then
  RD  <= Data_Memory(to_integer ( unsigned(ReadAddress)))&
                                Data_Memory(to_integer ((unsigned(ReadAddress))) + 1)&
                                Data_Memory(to_integer ((unsigned(ReadAddress))) + 2)&
                                Data_Memory(to_integer ((unsigned(ReadAddress))) + 3);
--          else RD <= "00000000000000000000000000000000";
--          end if;
-- END PRocess;
                 
        RD_out <= RD;
        Result <= RD when (MemtoReg = '1') else A;  
        A <= ALU_Result;  
        readAddress_out <= ReadAddress;
        ReadAddress <= A(6 downto 0);  
        
        Dmem_out0         <= Data_Memory(0)&Data_Memory(1)&Data_Memory(2)&Data_Memory(3);
        Dmem_out1         <= Data_Memory(4)&Data_Memory(5)&Data_Memory(6)&Data_Memory(7);
        Dmem_out2         <= Data_Memory(8)&Data_Memory(9)&Data_Memory(10)&Data_Memory(11);
        Dmem_out3         <= Data_Memory(12)&Data_Memory(13)&Data_Memory(14)&Data_Memory(15);
        Dmem_out4         <= Data_Memory(16)&Data_Memory(17)&Data_Memory(18)&Data_Memory(19);
        Dmem_out5         <= Data_Memory(20)&Data_Memory(21)&Data_Memory(22)&Data_Memory(23);
        Dmem_out6         <= Data_Memory(24)&Data_Memory(25)&Data_Memory(26)&Data_Memory(27);
        Dmem_out7         <= Data_Memory(28)&Data_Memory(29)&Data_Memory(30)&Data_Memory(31);
        Dmem_out8         <= Data_Memory(32)&Data_Memory(33)&Data_Memory(34)&Data_Memory(35);
        Dmem_out9         <= Data_Memory(36)&Data_Memory(37)&Data_Memory(38)&Data_Memory(39);
        Dmem_out10         <= Data_Memory(40)&Data_Memory(41)&Data_Memory(42)&Data_Memory(43);
        Dmem_out11         <= Data_Memory(44)&Data_Memory(45)&Data_Memory(46)&Data_Memory(47);
        Dmem_out12         <= Data_Memory(48)&Data_Memory(49)&Data_Memory(50)&Data_Memory(51);
        Dmem_out13         <= Data_Memory(52)&Data_Memory(53)&Data_Memory(54)&Data_Memory(55);
        Dmem_out14         <= Data_Memory(56)&Data_Memory(57)&Data_Memory(58)&Data_Memory(59);
        Dmem_out15         <= Data_Memory(60)&Data_Memory(61)&Data_Memory(62)&Data_Memory(63);
        Dmem_out16         <= Data_Memory(64)&Data_Memory(65)&Data_Memory(66)&Data_Memory(67);
        Dmem_out17         <= Data_Memory(68)&Data_Memory(69)&Data_Memory(70)&Data_Memory(71);
        Dmem_out18         <= Data_Memory(72)&Data_Memory(73)&Data_Memory(74)&Data_Memory(75);
        Dmem_out19         <= Data_Memory(76)&Data_Memory(77)&Data_Memory(78)&Data_Memory(79);
        Dmem_out20         <= Data_Memory(80)&Data_Memory(81)&Data_Memory(82)&Data_Memory(83);
        Dmem_out21         <= Data_Memory(84)&Data_Memory(85)&Data_Memory(86)&Data_Memory(87);
        Dmem_out22         <= Data_Memory(88)&Data_Memory(89)&Data_Memory(90)&Data_Memory(91);
        Dmem_out23         <= Data_Memory(92)&Data_Memory(93)&Data_Memory(94)&Data_Memory(95);
        Dmem_out24         <= Data_Memory(96)&Data_Memory(97)&Data_Memory(98)&Data_Memory(99);
        Dmem_out25         <= Data_Memory(100)&Data_Memory(101)&Data_Memory(102)&Data_Memory(103);
        Dmem_out26         <= Data_Memory(104)&Data_Memory(105)&Data_Memory(106)&Data_Memory(107);
        Dmem_out27         <= Data_Memory(108)&Data_Memory(109)&Data_Memory(110)&Data_Memory(111);
        Dmem_out28         <= Data_Memory(112)&Data_Memory(113)&Data_Memory(114)&Data_Memory(115);
        Dmem_out29         <= Data_Memory(116)&Data_Memory(117)&Data_Memory(118)&Data_Memory(119);
        Dmem_out30         <= Data_Memory(120)&Data_Memory(121)&Data_Memory(122)&Data_Memory(123);
        Dmem_out31         <= Data_Memory(124)&Data_Memory(125)&Data_Memory(126)&Data_Memory(127);
        
        
     
end Behavioral;


--        if WE = '1' then

--        end if;
--        Read_Address <= A;

--    process (MIPS_CLK_Dem)  
--    begin
--        if rising_edge(MIPS_CLK_Dem) then
--            if (WE = '1') then
--              Data_Memory(to_integer(unsigned(ReadAddress)))    <= WD(31 downto 24);
--              Data_Memory(to_integer(unsigned(ReadAddress)) + 1)<= WD(23 downto 16);
--              Data_Memory(to_integer(unsigned(ReadAddress)) + 2)<= WD(15 downto 8);
--              Data_Memory(to_integer(unsigned(ReadAddress)) + 3)<= WD(7 downto 0);
--            end if;  
                            
--            end if;
--    end process;

--x"00",x"00",x"00",x"00", 
--x"46",x"F8",x"E8",x"C5", 
--x"46",x"0C",x"60",x"85",
--x"70",x"F8",x"3B",x"8A", 
--x"28",x"4B",x"83",x"03", 
--x"51",x"3E",x"14",x"54", 
--x"F6",x"21",x"ED",x"22",
--x"31",x"25",x"06",x"5D", 
--x"11",x"A8",x"3A",x"5D", 
--x"D4",x"27",x"68",x"6B", 
--x"71",x"3A",x"D8",x"2D",
--x"4B",x"79",x"2F",x"99", 
--x"27",x"99",x"A4",x"DD", 
--x"A7",x"90",x"1C",x"49", 
--x"DE",x"DE",x"87",x"1A",
--x"36",x"C0",x"31",x"96", 
--x"A7",x"EF",x"C2",x"49", 
--x"61",x"A7",x"8B",x"B8", 
--x"3B",x"0A",x"1D",x"2B",
--x"4D",x"BF",x"CA",x"76", 
--x"AE",x"16",x"21",x"67", 
--x"30",x"D7",x"6B",x"0A", 
--x"43",x"19",x"23",x"04",
--x"F6",x"CC",x"14",x"31", 
--x"65",x"04",x"63",x"80",
--x"00",x"00",x"00",x"00",
--x"00",x"00",x"00",x"00",
--x"00",x"00",x"00",x"00",
--x"00",x"00",x"00",x"00",
--x"00",x"00",x"00",x"00",
--x"00",x"00",x"00",x"00"
--CONSTANT Data_Memory: datamem_ARRAY := ("00000000","11001100","10101010", "11101110","11111111","00010001", "00110011","00000000",
 --                                       "11111111","11101110", "00110011","11111111","01010101", "11001100","11001100","11111111",
--                                        "00000000","11001100","10101010", "11101110","11111111","00010001", "00110011","00000000",
 --                                       "11111111","11101110", "00110011","11111111","01010101", "11001100","11001100","11111111",
  --                                      "00000000","11001100","10101010", "11101110","11111111","00010001", "00110011","00000000",
 --                                       "11111111","11101110", "00110011","11111111","01010101", "11001100","11001100","11111111",
  --                                      "00000000","11001100","10101010", "11101110","11111111","00010001", "00110011","00000000",
 --                                       "11111111","11101110", "00110011","11111111","01010101", "11001100","11001100","11111111",
    --                                    "00000000","11001100","10101010", "11101110","11111111","00010001", "00110011","00000000",
    --                                    "11111111","11101110", "00110011","11111111","01010101", "11001100","11001100","11111111",
    --                                    "00000000","11001100","10101010", "11101110","11111111","00010001", "00110011","00000000",
     --                                   "11111111","11101110", "00110011","11111111","01010101", "11001100","11001100","11111111",
       --                                 "00000000","11001100","10101010", "11101110","11111111","00010001", "00110011","00000000",
      --                                  "11111111","11101110", "00110011","11111111","01010101", "11001100","11001100","11111111",
     --                                   "00000000","11001100","10101010", "11101110","11111111","00010001", "00110011","00000000",
    --                                    "11111111","11101110", "00110011","11111111","01010101", "11001100","11001100","11111111");
    
    
--        x"00",x"11",x"22",x"33",
--        x"FF",x"EE",x"FF",x"EE",
--        x"46",x"F8",x"E8",x"C5",
--        x"46",x"0C",x"60",x"85",
--        x"70",x"F8",x"3B",x"8A",
--        x"28",x"4B",x"83",x"03",
--        x"51",x"3E",x"14",x"54",
--        x"F6",x"21",x"ED",x"22",
--        x"31",x"25",x"06",x"5D",
--        x"11",x"A8",x"3A",x"5D",
--        x"D4",x"27",x"68",x"6B",
--        x"71",x"3A",x"D8",x"2D",
--        x"4B",x"79",x"2F",x"99",
--        x"27",x"99",x"A4",x"DD",
--        x"A7",x"90",x"1C",x"49",
--        x"DE",x"DE",x"87",x"1A",
--        x"36",x"C0",x"31",x"96",
--        x"A7",x"EF",x"C2",x"49",
--        x"61",x"A7",x"8B",x"B8",
--        x"3B",x"0A",x"1D",x"2B",
--        x"4D",x"BF",x"CA",x"76",
--        x"AE",x"16",x"21",x"67",
--        x"30",x"D7",x"6B",x"0A",
--        x"43",x"19",x"23",x"04",
--        x"00",x"00",x"00",x"00", 
--        x"00",x"00",x"00",x"00", 
--        x"00",x"00",x"00",x"00",
--        x"00",x"00",x"00",x"00",
--        x"00",x"00",x"00",x"00",
--        x"00",x"00",x"00",x"00",
--        x"00",x"00",x"00",x"00",
--        x"00",x"00",x"00",x"00"
    
    
--        if rising_edge(MIPS_CLK_Dem) then
--         if (WE = '1') then
--          Data_Memory(to_integer(unsigned(ReadAddress)))    <= WD(31 downto 24);
--          Data_Memory(to_integer(unsigned(ReadAddress)) + 1)<= WD(23 downto 16);
--          Data_Memory(to_integer(unsigned(ReadAddress)) + 2)<= WD(15 downto 8);
--          Data_Memory(to_integer(unsigned(ReadAddress)) + 3)<= WD(7 downto 0);
     
--        end if; 
          
--      end if;                                
--     end process;  
          
--    RD <= Data_Memory(to_integer(unsigned(ReadAddress)))&
--                   Data_Memory(to_integer(unsigned(ReadAddress) + 1))&
--                   Data_Memory(to_integer(unsigned(ReadAddress)+ 2)) &
--                   Data_Memory(to_integer(unsigned(ReadAddress) + 3));
--    RD_out <= RD;
               
--    Result <= RD when (MemtoReg = '1') else ALU_Result;  