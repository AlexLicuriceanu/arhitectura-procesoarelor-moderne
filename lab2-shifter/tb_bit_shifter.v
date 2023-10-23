`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2023 17:53:24
// Design Name: 
// Module Name: tb_bit_shifter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_bit_shifter;
    reg [3:0] in;
    reg clk, reset, select;
    wire [3:0] out;
    
    bit_shifter uut (
        .in(in),
        .clk(clk),
        .reset(reset),
        .select(select),
        .out(out)
    );
    
    initial begin
        in = 4'b0000;
        clk = 0;
        reset = 0;
        select = 0;
        #100;
        
        in = 4'b1011;
        select = 1;
        #100;
        
        in = 4'b1000;
        select = 0;
        #100;
        
        $finish;
    end 
    
    always #5 clk = ~clk;
endmodule
