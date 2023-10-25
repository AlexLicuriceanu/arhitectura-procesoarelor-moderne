`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2023 18:21:30
// Design Name: 
// Module Name: detector
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


 module detector(
    input in, clk, reset,
    output reg out
    );

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;
    reg [1:0] state, next_state;
    
    always @(posedge clk or posedge reset)
       if (reset)
         state <= S0;  
       else
         state <= next_state;
       
    always @(posedge clk or posedge reset)
       if (reset)
         out <= 0;
       else
         out <= (state == S3) && in;
     
    always @(*) begin
        case(state)
            S0 : next_state = in ? S1 : S0 ;
            S1 : next_state = in ? S1 : S2 ;
            S2 : next_state = in ? S3 : S0 ;
            S3 : next_state = in ? S1 : S2 ;
        endcase
     end
 endmodule
