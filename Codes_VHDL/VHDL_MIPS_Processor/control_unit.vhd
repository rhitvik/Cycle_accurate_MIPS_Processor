library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Control_Unit is
port(
    rs: in std_logic_vector(31 downto 0);
    rt: in std_logic_vector(31 downto 0);
    
    opcode: in std_logic_vector(5 downto 0);
    funct: in std_logic_vector(5 downto 0);
    MemtoReg: out std_logic; Zero: in std_logic;
    MemWrite: out std_logic;  ALUSrc: out std_logic; 
    RegDst: out std_logic; RegWrite: out std_logic;
    JMP: out std_logic; PCSrc: out std_logic;
    ALUop: out std_logic_vector(2 downto 0);
    Halt: out std_logic;
    
    branch_Out_debug: out std_logic;
    branch1_BLT_BEQ_BNE_debug: out std_logic_vector(4 downto 0)
	);
end Control_Unit;

architecture Behavioral of Control_Unit is
signal ALUop1 : std_logic_vector ( 2 downto 0);
signal ALUop2 : std_logic_vector ( 2 downto 0);
signal opcode_and_funct: std_logic_vector(11 downto 0);
signal branch1: std_logic_vector(1 downto 0);
signal branch : std_logic;
signal Zero1: std_logic;
signal BLT: std_logic;
signal BEQ: std_logic;
signal BNE: std_logic;
signal branch1_BLT_BEQ_BNE: std_logic_vector(4 downto 0);

begin
    
 
    with opcode select
		RegWrite <= '0' when "001000"| "001001" |"001010"|"001011"|"001100"|"111111",
                    '1' when others;
	with opcode select
		MemtoReg <= '1' when "000111",
                    '0' when others;
	with opcode select
		MemWrite <= '1' when "001000",
                    '0' when others;
	with opcode select
		ALUSrc <= '1' when "000001"|"000010"|"000011"|"000111"|"001000"| "000100" | "000101",
                  '0' when others;	
	with opcode select
	   RegDst <= '1' when "000000",
                 '0' when others;	 
	with opcode select 
		JMP <= '1' when "001100",
               '0' WHEN others;
               
                    
   --branch1 <= "01" when (rs<rt)&(opcode = "001001");                   
        with opcode select
            branch1 <=  "01" when "001001",--BLT
                        "10" when "001010",--BEQ
                        "11" when "001011",--BNE
                        "00" when others;
        
        BLT <= '1' when rs<rt else '0'; --branch1_BLT_BEQ_BNE    01101
        BEQ <= '1' when rs=rt else '0'; --branch1_BLT_BEQ_BNE    10010
        BNE <= '1' when rs/=rt else '0'; --branch1_BLT_BEQ_BNE   11001 or 11101
         
        with branch1_BLT_BEQ_BNE select
            branch <= '1' when "01101"|"10010"|"11001"|"11101",
                      '0' when others;
                  
    --000add, 010sub, 100and, 101or, 011nor, 001shr 
    with funct select -- only if opcode = "000000"
         ALUop2 <= "000" when  "000001", -- add | funct = 1hex
                   "010" when  "000011", -- sub | funct = 3hex
                   "100" when  "000101", -- and | funct = 5hex
                   "101" when  "000111", --  OR | funct = 7hex
                   "011" when  "001001", -- nor | funct = 9hex
                   "000" when others;--"111" when others;
    with opcode select
         ALUop1 <= "000" when  "000001", --ADD imm | opcode = 1
                   "010" when  "000010", --SUB imm | opcode = 2
                   "100" when  "000011", --AND imm | opcode = 3
                   "101" when  "000100", -- OR imm | opcode = 4
                   "001" when  "000101", --SHR imm | opcode = 5
                   "000" when others; --"111" when others;
                   
         Halt <= '1' when opcode = "111111" else '0';
         
branch_Out_debug <= branch;
branch1_BLT_BEQ_BNE_debug <= branch1_BLT_BEQ_BNE; 
  
branch1_BLT_BEQ_BNE <= branch1 & BLT & BEQ & BNE;
zero1 <= zero;                
PCSrc <= Zero1 and Branch;
opcode_and_funct <= opcode&funct;   
ALUop <= ALUop2 when (opcode = "000000") else ALUop1;    
end Behavioral;