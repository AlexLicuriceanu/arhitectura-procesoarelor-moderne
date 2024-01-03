`timescale 1ns / 1ps

module mux2_1(input [31:0] ina, inb,
              input sel,
              output [31:0] out);
              
    assign out = (ina & ~sel) | (inb & sel);
endmodule
