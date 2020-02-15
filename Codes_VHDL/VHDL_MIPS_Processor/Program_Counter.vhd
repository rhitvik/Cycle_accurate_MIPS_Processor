----------------------------------------------------------------------------------
-- Company:  
-- Engineer: 
-- 
-- Create Date: 16.11.2018 15:29:56
-- Design Name: 
-- Module Name: Program_Counter_module - Behavioral
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

entity Program_Counter_module is
 Port ( 
     PC_out_to_topModule: out std_logic_vector(31 downto 0);
     PCplus4: out std_logic_vector(31 downto 0);
     RST_PCmodule: in std_logic;
     PCSrc_of_PCmodule: in std_logic;
     PCBranch_of_PCmodule: in std_logic_vector(31 downto 0);
     MIPS_CLK_of_PCmodule: in STD_logic;
     Jump_Raw_Address: in std_logic_vector(25 downto 0);
     JmpBit: in std_logic;
     Haltbit: in std_logic
 );
end Program_Counter_module;

architecture Behavioral of Program_Counter_module is
    signal PC: std_logic_vector(31 downto 0);
    signal PC_Dash:  std_logic_vector(31 downto 0);
    signal PC_Dash2:  std_logic_vector(31 downto 0);   
    signal PC_Dash3:  std_logic_vector(31 downto 0);
    signal PCplus4_internal: std_logic_vector(31 downto 0);
    signal Jump: std_logic_vector(31 downto 0);
     
begin

    process(MIPS_CLK_of_PCmodule,RST_PCmodule)
    begin
    if(RST_PCmodule = '1') then PC <= x"00000000";
    elsif (rising_edge(MIPS_CLK_of_PCmodule)) then             
    PC <= PC_dash;
    end if;
    end process;
    
--    process(PCSrc_of_PCmodule, MIPS_CLK_of_PCmodule)
--    begin
--    if(rising_edge(MIPS_CLK_of_PCmodule)) then 
--        if(PCSrc_of_PCmodule = '1') then 
--        PC_dash <= PCBranch_of_PCmodule;
--        else PC_dash <= PCplus4_internal;
--        end if;
--    end if;
--    end process;
    
    
    Jump <= PCplus4_internal(31 downto 28) & Jump_Raw_Address(25 DOWNTO 0) & "00";
    PC_out_to_topModule <= PC;
    PCplus4_internal <= PC + 4;
    --PC_dash2 <= PCplus4_internal when (PCSrc_of_PCmodule = '0') else PCBranch_of_PCmodule;
    PCplus4 <= PCplus4_internal;
    --PC_Dash <= PC_dash2 when (JmpBit = '0') else Jump;
    -- PC_Dash3 <= PC_dash2 when (JmpBit = '0') else Jump;
   PC_Dash3 <= PC_dash2 when (haltBit = '0') else PC;
   PC_Dash2 <=  Jump when (JmpBit = '1') else PCplus4_internal;   
    PC_Dash <= PCBranch_of_PCmodule when (PCSrc_of_PCmodule = '1') else PC_Dash3;-- @@@@@temp
     --PC_Dash <= PCplus4_internal when (PCSrc_of_PCmodule = '0') else PCBranch_of_PCmodule;
    --PC_Dash <= PC_dash3 when (haltBit = '0') else PC;
end Behavioral;
