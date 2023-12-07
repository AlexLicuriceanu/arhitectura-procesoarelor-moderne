`timescale 1ns / 1ps

module imm_gen(input [31:0] in,
               output reg [31:0] out);
    
    always @(in) begin
        case (in[6:0])
            7'b0100011:
                out = {{20{in[31]}}, in[30:25], in[11:7]};   // S-TYPE
            7'b0000011,
            7'b0010011:
                out = {{20{in[31]}}, in[30:20]}; // I-TYPE
            7'b1100011:
                out = {{19{in[31]}}, in[7],in[30:25],in[11:8],1'b0}; // B-tYPE
            
            default:
                out = 32'b0;
        endcase
    end
endmodule 
