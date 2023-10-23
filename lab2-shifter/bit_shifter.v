`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2023 17:53:09
// Design Name: 
// Module Name: bit_shifter
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


module bit_shifter(
    input [3:0] in,
    input clk,
    input reset,
    input select,
    output reg [3:0] out
    );
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            out = 0;
            
        if (select)
            out = {in[0], in[3:1]};
        else
            out = {in[2:0], in[3]};           
    end 
endmodule
