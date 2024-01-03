`timescale 1ns / 1ps

module RISC_V_IF_ID(input clk, 
                    input reset, 
                    
                    input IF_ID_write, 
                    input PCSrc, PC_write,
                    input [31:0] PC_Branch, 
                    input RegWrite_WB,
                    input [31:0] ALU_DATA_WB,
                    input [4:0] RD_WB,
                    
                    output [31:0] PC_ID, 
                    output [31:0] INSTRUCTION_ID,
                    output [31:0] IMM_ID,
                    output [31:0] REG_DATA1_ID,
                    output [31:0] REG_DATA2_ID,
                    
                    output [2:0] FUNCT3_ID,
                    output [6:0] FUNCT7_ID,
                    output [6:0] OPCODE_ID,
                    output [4:0] RD_ID,
                    output [4:0] RS1_ID,
                    output [4:0] RS2_ID);
    
    wire [31:0] Out_PC_IF, Out_INSTRUCTION_IF;
    
    IF IF(clk, reset, PCSrc, PC_write, PC_Branch, Out_PC_IF, Out_INSTRUCTION_IF);
    
    IF_ID_PIPE IF_ID_PIPE(clk, reset, IF_ID_write, Out_PC_IF, Out_INSTRUCTION_IF, PC_ID, INSTRUCTION_ID);
    
    ID ID(clk, PC_ID, INSTRUCTION_ID, RegWrite_WB, ALU_DATA_WB, RD_WB, IMM_ID, REG_DATA1_ID, REG_DATA2_ID,
        FUNCT3_ID, FUNCT7_ID, OPCODE_ID, RD_ID, RS1_ID, RS2_ID);
        
endmodule
