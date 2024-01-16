`timescale 1ns / 1ps

module ALU(input [3:0] ALUop,       //ALUinput ce selecteaza operatia
           input [31:0] ina, inb,    //operanzii ce iau parte la operatie
           output zero,             //semnal ce verifica daca rezultatul este 0
           output reg [31:0] out);  //rezultatul operatiei
           
   always@(*)
    begin 
        case(ALUop)
            4'b0000: out <= ina & inb; 
            4'b0001: out <= ina | inb; 
            4'b0010: out <= ina + inb;
            4'b0011: out <= ina ^ inb;
            4'b0100: out <= ina << inb;
            4'b0101: out <= ina >> inb;
            4'b0110: out <= ina - inb;
            4'b0111: out <= (ina < inb) ? 32'b1 : 32'b0;
            4'b1000: out <= ($signed(ina) < $signed(inb)) ? 32'b1 : 32'b0;
            4'b1001: out <= ina >>> inb[4:0];
            default: out <= 32'b0;
        endcase 
    end        
    
    assign zero = (out == 32'b0)? 1'b1 : 1'b0;    
endmodule
