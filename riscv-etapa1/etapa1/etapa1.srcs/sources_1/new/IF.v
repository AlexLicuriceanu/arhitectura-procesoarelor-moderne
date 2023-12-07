`timescale 1ns / 1ps

module IF(input clk, reset,
          input PCSrc, PC_write,
          input [31:0] PC_Branch,
          output [31:0] PC_IF, INSTRUCTION_IF);
    
    wire [31:0] out_mux;
    wire [31:0] out_PC;
    wire [31:0] out_addr;
    wire [31:0] out_inst;
    
    wire [31:0] four;
    assign four = 4;

    mux2_1 mux(out_addr, PC_Branch, PCSrc, out_mux);
    PC pc(clk, reset, PC_write, out_mux, out_PC);
    adder add(out_PC, four, out_addr);
    
    instruction_memory mem(out_PC[11:2], out_inst);
  
    assign PC_IF = out_PC;
    assign INSTRUCTION_IF = out_inst;

endmodule
