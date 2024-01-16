`timescale 1ns / 1ps


module mux41(input[31:0] ina,inb,inc,ind,
             input[1:0] sel,
             output reg[31:0] out);

always@(*) begin
    case(sel)
      2'b00: out = ina;
      2'b01: out = inb;
      2'b10: out = inc;
      2'b11: out = ind;
    endcase
  end
  
endmodule
