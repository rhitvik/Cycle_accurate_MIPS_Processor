# Cycle Accurate MIPS Processor
 
Here, we will implement a 32-bit processor in VHDL, called NYU-6463 Processor, which can execute programs. The processor should support the instruction set specified in the next section.

## Design Specification Instructions

Every instruction has 32 bits that define the type of instruction as well as the operands and the destination of the result. The NYU-6463 Processor has three instruction types: 
1. R-Type for arithmetic instructions
2. I-Type for immediate value operations, load and store instructions
3. J-Type for jump instructions. The instruction content for these three types is shown in [Figure 1](https://github.com/rhitvik/Cycle_accurate_MIPS_Processor/blob/master/Project_Report/ACHD-Final_Project_V3_Objective.pdf). A description of each of the fields used in the three different instruction types is provided in [Table 1](https://github.com/rhitvik/Cycle_accurate_MIPS_Processor/blob/master/Project_Report/ACHD-Final_Project_V3_Objective.pdf).

## Processor Architecture
![](https://github.com/rhitvik/Cycle_accurate_MIPS_Processor/blob/master/Images_and_Screenshots/MIPS_arcitecture.PNG)

## Processor Components
* Program counter (PC) register: This is a 32 -bit register that contains the address of the next instruction to be executed by the processor.
* Decode Unit: This block takes as input some or all of the 32 bits of the instruction, and computes the proper control signals to be utilized for other blocks. These signals are generated based on the type and the content of the instruction being executed.
* Register File: This block contains 32 32-bit registers. The register file supports two independent register reads and one register write in one clock cycle. 5 bits are used to address the register file.
* ALU: This block performs operations such as addition, subtraction, comparison, etc. It uses the control signals generated by the Decode Unit, as well as the data from the registers or from the instruction directly. It computes data that can be written into one of the registers (including PC). You will implement this block by referring to the instruction set.
* Instruction and Data Memory( Word-addressable or Byte-addressable): The instruction memory is initialized to contain the program to be executed. The data memory stores the data and is accessed using load word and store word instructions.

## Processor Operation
The NYU-6463 Processor performs the tasks of instruction fetch, instruction decode, execution, memory access and write-back all in one clock cycle. First, the PC value is used as an address to index the instruction memory which supplies a 32-bit value of the next instruction to be executed. This instruction is then divided into the different fields shown in Table 1 (for NYU- 6463 Processor, the shamt field is not used). The instructions’ opcode field bits [31-26] are sent to the decode unit to determine the type of instruction to execute. The type of instruction then determines which control signals are to be asserted and what function the ALU is to perform, therefore, decoding the instruction. The instruction register address fields Rs bits [25 - 21], Rt bits [20 - 16], and Rd bits [15-11] are used to address the register file. The register file reads in the requested addresses and outputs the data values contained in these registers. These data values can then be operated on by the ALU whose operation is determined by the control unit to either compute a memory address (e.g. load or store), compute an arithmetic result (e.g. add, and or sub), or perform a compare (e.g. branch). If the instruction decoded is arithmetic, the ALU result must be written to a register. If the instruction decoded is a load or a store, the ALU result is then used to address the data memory. The final step writes the ALU result or memory value back to the register file.

## Xilinx Basys3 (Atrix-7 FPGA)
![]((https://github.com/rhitvik/Cycle_accurate_MIPS_Processor/blob/master/Images_and_Screenshots/Basys3.jpg)

## Objective
1. Implement the NYU-6463 Processor with the specification described above. We encourage you to write your programs and check your design for different cases. NOTE: You need to
implement only the instructions described in Table 2. You cannot add additional instructions.
2. Do a performance (max speed of your processor) and area (number of gates you used from each type) analysis. Explain your analysis comprehensively.
3. Implement your design on FPGA. You should be able to show the result of the execution of the program after every cycle. (Both single instruction stepping and complete program execution should be supported).
4. Write a program to implement the RC5 block cipher as well as round key generation using only the instructions from [Table 1](https://github.com/rhitvik/Cycle_accurate_MIPS_Processor/blob/master/Project_Report/ACHD-Final_Project_V3_Objective.pdf). You should read the key and plaintext from the memory and write the ciphertext back to memory. Run your program on your designed processor and show that it works properly.
    * Describe how many cycles are required to complete RC5 encryption and decryption on
    NYU-6463 Processor.
    * Draw you program’s flow chart
    * Support changing the program while your processor is running on the FPGA.
5. Your report in pdf format including your
    * design block diagram
    * simulation screenshots
    * performance and area analysis of design
    * description of RC5 implementation in assembly
    * description of processor interfaces (how do you provide inputs and display results)
    * details about how you verified your overall design

## Codes
[MIPS_Processor_in_VHDL](https://github.com/rhitvik/Cycle_accurate_MIPS_Processor/tree/master/Codes_VHDL)

## Report
[MIPS_Processor_Report](https://github.com/rhitvik/Cycle_accurate_MIPS_Processor/blob/master/Project_Report/Project_Report.pdf)
