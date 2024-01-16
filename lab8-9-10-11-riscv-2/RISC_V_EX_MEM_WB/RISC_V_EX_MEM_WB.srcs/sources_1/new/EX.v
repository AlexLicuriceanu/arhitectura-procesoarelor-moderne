`timescale 1ns / 1ps

module EX(input [31:0] IMM_EX,           //valoarea immediate in EX      
          input [31:0] REG_DATA1_EX,    //valoarea registrului sursa 1
          input [31:0] REG_DATA2_EX,     //valoarea registrului sursa 2
          input [31:0] PC_EX,           //adresa instructiunii curente in EX
          input [2:0] FUNCT3_EX,         //funct3 pentru instructiunea din EX
          input [6:0] FUNCT7_EX,        //funct7 pentru instructiunea din EX
          input [4:0] RD_EX,            //adresa registrului destinatie
          input [4:0] RS1_EX,           //adresa registrului sursa 1
          input [4:0] RS2_EX,           //adresa registrului sursa 2
          input RegWrite_EX,            //semnal de scriere in bancul de registrii
          input MemtoReg_EX,
          input MemRead_EX,             //semnal pentru activarea citirii in memorie
          input MemWrite_EX,            //semnal pentru activarea scrierii in memorie
          input [1:0] ALUop_EX,         //semnal de control ALUop
          input ALUSrc_EX,               //semnal de selectie intre RS2 si valoarea imediata
          input Branch_EX,               //semnal identificare instructiunilor de tip branch
          input [1:0] forwardA, forwardB, //semnale de selectie pentru multiplexoarele de forwarding
          input [31:0] ALU_DATA_WB,      //valoarea calculata de ALU, prezenta in WB
          input [31:0] ALU_OUT_MEM,      //valoarea calculata de ALU, prezenta in MEM    
          output ZERO_EX,               //flag-ul ZERO calculat de ALU
          output [31:0] ALU_OUT_EX,     //rezultat calculat de ALU in EX
          output [31:0] PC_Branch_EX,   //adresa de salt calculata in EX
          output [31:0] REG_DATA2_EX_OUT);  //valoarea registrului sursa 2 selectata dintre valorile
                                            //prezentate in etapele EX, MEM, WB
wire [31:0] mux1_out, mux2_out, mux3_out, add_out_EX;
wire [3:0] ALU_control_out;
    
mux41 mux41_1(REG_DATA1_EX, ALU_DATA_WB, ALU_OUT_MEM, 0, forwardA, mux1_out); 

mux41 mux41_2(REG_DATA2_EX, ALU_DATA_WB, ALU_OUT_MEM, 0, forwardB, mux2_out);    
assign REG_DATA2_EX_OUT = mux2_out;

mux2_1 mux21_1(mux2_out, IMM_EX,  ALUSrc_EX, mux3_out);

ALUcontrol alu_control(ALUop_EX, FUNCT7_EX, FUNCT3_EX,  ALU_control_out);

ALU alu( ALU_control_out, mux1_out, mux3_out, ZERO_EX, ALU_OUT_EX);
 
adder adder_1(PC_EX, IMM_EX, PC_Branch_EX);
endmodule
