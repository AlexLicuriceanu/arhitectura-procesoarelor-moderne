`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2023 18:21:42
// Design Name: 
// Module Name: tb_detector
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


module tb_detector;

    reg my_input, clk, reset;
    wire my_output;
    
    detector uut(
        my_input,
        clk,
        reset,
        my_output);
    
    always #5 clk = ~clk;
    
    initial begin
        fork
            clk = 1'b0; reset = 1'b1;
            #15 reset = 1'b0;
            begin
                #12 my_input=0; #10 my_input=0; #10 my_input=1; #10 my_input=0;
                #12 my_input=1; #10 my_input=1; #10 my_input=0; #10 my_input=1;
                #12 my_input=1; #10 my_input=0; #10 my_input=0; #10 my_input=1;
                #12 my_input=0; #10 my_input=1; #10 my_input=1; #10 my_input=0;
                #10 $finish;
            end
        join
    end
endmodule
