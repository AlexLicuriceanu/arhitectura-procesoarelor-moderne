`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2023 17:27:48
// Design Name: 
// Module Name: tb_mux_8_1
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


module tb_mux_8_1;

    reg [7:0] in;
    reg [3:0] select;
    wire out;
    
    mux_8_1 uut (
        .in(in),
        .select(select),
        .out(out)
    );
    
    initial begin
        in = 1;
        select = 0;
        #100;

        in = 8'b10101010;
        select = 3'b100;
        #100;
        
        in = 8'b10010011;
        select = 3'b100;
        #100;
        $finish;
    end
endmodule
