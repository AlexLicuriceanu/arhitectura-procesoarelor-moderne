`timescale 1ns / 1ps

module  forwarding(input [4:0] rs1,       //adresa registrului sursa 1 in etapa EX
                   input [4:0] rs2,       //adresa registrului sursa 2 in etapa EX
                   input [4:0] ex_mem_rd, //adresa registrului destinatie in etapa MEM
                   input [4:0] mem_wb_rd, //adresa registrului destinatie in etapa WB
                   input ex_mem_regwrite, //semnalul de control RegWrite in etapa MEM
                   input mem_wb_regwrite, //semnal de control RegWrite in etapa WB
                   output reg [1:0] forwardA,forwardB //semnalele de selectie ale multiplexoarelor
                  );                                  //ce vor alege valoarea ce trebuie byoassata
always @(*) begin
    if (ex_mem_regwrite && (ex_mem_rd != 0) && (ex_mem_rd == rs1)) 
            forwardA = 2'b10; //hazard EX
    else begin 
         if (mem_wb_regwrite && (mem_wb_rd != 0) 
         && !(ex_mem_regwrite && (ex_mem_rd != 0) 
         && (ex_mem_rd == rs1)) && (mem_wb_rd == rs1))
            forwardA = 2'b01; // hazard MEM
         else
             forwardA = 2'b00;
    end
        
    if ((ex_mem_regwrite) && (ex_mem_rd != 0) && (ex_mem_rd == rs2)) 
            forwardB = 2'b10; //hazard EX
    else begin 
        if (mem_wb_regwrite && (mem_wb_rd != 0) && 
           !(ex_mem_regwrite && (ex_mem_rd != 0) && 
           (ex_mem_rd == rs2)) && (mem_wb_rd == rs2))
                forwardB = 2'b01; // hazard MEM
        else
                forwardB = 2'b00;
    end
end                  
endmodule
