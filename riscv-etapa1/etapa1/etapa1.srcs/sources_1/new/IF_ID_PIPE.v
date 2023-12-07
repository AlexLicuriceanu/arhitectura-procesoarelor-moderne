`timescale 1ns / 1ps

module IF_ID_PIPE(input clk, input reset, input IF_ID_write, input [31:0] PC_IF, INSTR_IF, 
                  output reg [31:0] PC_IF_out, INSTR_IF_out);

   always @(posedge clk) begin
        if (reset == 1) begin
            PC_IF_out = 0;
            INSTR_IF_out = 0;
        end
        else if (IF_ID_write == 1) begin
            PC_IF_out = PC_IF;
            INSTR_IF_out = INSTR_IF;
        end
    end
endmodule
