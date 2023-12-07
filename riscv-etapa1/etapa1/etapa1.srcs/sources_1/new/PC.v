`timescale 1ns / 1ps

module PC(input clk, res, write,
          input [31:0] in,
          output reg [31:0] out);

    always @(posedge clk ) begin
        if (res == 1)
            out = 0;
        else if (write == 1)
            out = in;
    end
endmodule
