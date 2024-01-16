//////////////////////////////////////////////RISC-V_MODULE///////////////////////////////////////////////////
module  RISC_V(input clk, //semnal de ceas global
              input reset, //semnal de reset global
              output [31:0] PC_EX, //adresa PC in etapa EX
              output [31:0] ALU_OUT_EX, //valoarea calculata de ALU in etapa EX
              output [31:0] PC_MEM, //adresa de salt calculata
              output PCSrc, //semnal de selectie pentru PC
              output [31:0] DATA_MEMORY_MEM, //valoarea citita din memoria de date in MEM
              output [31:0] ALU_DATA_WB, //valoarea finala scrisa in etapa WB
              output [1:0] forwardA, forwardB, //semnale forwarding
              output pipeline_stall); //semnal de stall la detectia de hazarduri

  wire [31:0] PC_Branch;
  wire PC_write, control_sel,IF_ID_write;
    
  wire RegWrite_ID,MemtoReg_ID,MemRead_ID,MemWrite_ID;
  wire [1:0] ALUop_ID;
  wire ALUSrc_ID, Branch_ID;
  wire [31:0] PC_ID, INSTRUCTION_ID, IMM_ID, REG_DATA1_ID, REG_DATA2_ID;
  wire [2:0] FUNCT3_ID; 
  wire [6:0] FUNCT7_ID, OPCODE_ID; 
  wire [4:0] RD_ID,  RS1_ID, RS2_ID;
  
  wire [31:0] PC_IF, INSTRUCTION_IF, IMM_EX, REG_DATA1_EX,REG_DATA2_EX;
  wire [2:0] FUNCT3_EX;
  wire [6:0] FUNCT7_EX, OPCODE_EX;
  wire [4:0] RD_EX, RS1_EX, RS2_EX;

  wire RegWrite_EX,MemtoReg_EX,MemRead_EX,MemWrite_EX, ALUSrc_EX, Branch_EX,ZERO_EX;
  wire [1:0] ALUop_EX,  forwardA,forwardB;
  wire [31:0] PC_Branch_EX, REG_DATA2_EX_FINAL;

  wire ZERO_MEM, RegWrite_MEM, MemtoReg_MEM, MemRead_MEM, MemWrite_MEM,ALUSrc_MEM, Branch_MEM;
  wire [31:0] ALU_OUT_MEM, PC_Branch_MEM, REG_DATA2_MEM_FINAL;
  wire [4:0] RD_MEM;
  wire [1:0] ALUop_MEM;
  
  wire [31:0] read_data_WB, address_WB;
  wire [4:0] RD_WB;
  wire RegWrite_WB, MemtoReg_WB;
  
 
 /////////////////////////////////////IF Module/////////////////////////////////////
IF instruction_fetch(clk, reset, 
                      PCSrc, PC_write,
                      PC_Branch_MEM,
                      PC_IF,INSTRUCTION_IF);
  
IF_ID_reg IF_ID_REGISTER(clk,reset,
                          IF_ID_write,
                          PC_IF,INSTRUCTION_IF,
                          PC_ID,INSTRUCTION_ID);
  
ID instruction_decode(clk, control_sel,
                       PC_ID,INSTRUCTION_ID,
                       RegWrite_WB, 
                       ALU_DATA_WB,
                       RD_WB,
                       IMM_ID,
                       REG_DATA1_ID,REG_DATA2_ID,
                       RegWrite_ID,MemtoReg_ID,MemRead_ID,MemWrite_ID,
                       ALUop_ID,
                       ALUSrc_ID,
                       Branch_ID);

wire write = 1'b1;
assign FUNCT3_ID = INSTRUCTION_ID[14:12];
assign FUNCT7_ID = INSTRUCTION_ID[31:25];
assign OPCODE_ID = INSTRUCTION_ID[6:0];
assign RD_ID = INSTRUCTION_ID[11:7];
assign RS1_ID = INSTRUCTION_ID[19:15];
assign RS2_ID = INSTRUCTION_ID[24:20];

ID_EX ID_EX_register(clk,reset, write,
                      IMM_ID,
                      REG_DATA1_ID,REG_DATA2_ID,
                      PC_ID,
                      FUNCT3_ID,FUNCT7_ID,
                      RD_ID,RS1_ID,RS2_ID,
                      RegWrite_ID,MemtoReg_ID,MemRead_ID,MemWrite_ID,
                      ALUop_ID, ALUSrc_ID, Branch_ID, 
                      IMM_EX,   
                      REG_DATA1_EX, REG_DATA2_EX,
                      PC_EX,
                      FUNCT3_EX, FUNCT7_EX,  
                      RD_EX,RS1_EX, RS2_EX, 
                      RegWrite_EX, MemtoReg_EX,MemRead_EX, MemWrite_EX, 
                      ALUop_EX, ALUSrc_EX, Branch_EX); 
                      
EX instruction_execute(IMM_EX,         
                      REG_DATA1_EX,
                      REG_DATA2_EX,
                      PC_EX,
                      FUNCT3_EX,
                      FUNCT7_EX,
                      RD_EX,
                      RS1_EX,
                      RS2_EX,
                      RegWrite_EX,
                      MemtoReg_EX,
                      MemRead_EX,
                      MemWrite_EX,
                      ALUop_EX,
                      ALUSrc_EX,
                      Branch_EX,
                      forwardA,forwardB,
                      ALU_DATA_WB,
                      ALU_OUT_MEM,
                      ZERO_EX,
                      ALU_OUT_EX,
                      PC_Branch_EX,
                      REG_DATA2_EX_FINAL);

EX_MEM ex_mem_reg(clk,
                reset,
                write,
                ZERO_EX,
                ALU_OUT_EX,
                PC_Branch_EX,
                REG_DATA2_EX_FINAL,
                RD_EX,
                RegWrite_EX,
                MemtoReg_EX,
                MemRead_EX,
                MemWrite_EX,
                ALUop_EX,
                ALUSrc_EX,
                Branch_EX,
                ZERO_MEM,
                ALU_OUT_MEM,
                PC_Branch_MEM,
                REG_DATA2_MEM_FINAL,
                RD_MEM,
                RegWrite_MEM,
                MemtoReg_MEM,
                MemRead_MEM,
                MemWrite_MEM,
                ALUop_MEM,
                ALUSrc_MEM,
                Branch_MEM);

data_memory data_memory_inst(clk,       
                  MemRead_MEM,
                  MemWrite_MEM,
                  ALU_OUT_MEM,
                  REG_DATA2_MEM_FINAL,
                  DATA_MEMORY_MEM);        
  
and_gate and_inst(ZERO_MEM,Branch_MEM, PCSrc);

forwarding forwarding_inst(RS1_EX,
                RS2_EX,
                RD_MEM,
                RD_WB,
                RegWrite_MEM,
                RegWrite_WB,
                forwardA,forwardB);      
               
  
MEM_WB mem_wb_reg(clk,
                reset,
                write,
                DATA_MEMORY_MEM,
                ALU_OUT_MEM,
                RD_MEM,
                RegWrite_MEM,
                MemtoReg_MEM,
                read_data_WB,
                address_WB,
                RD_WB,
                RegWrite_WB,
                MemtoReg_WB);
               
mux2_1 mux(address_WB,
              read_data_WB,
              MemtoReg_WB,
              ALU_DATA_WB);
  
hazard_detection hazard_detection_inst(RD_EX,
                        RS1_ID,
                        RS2_ID,
                        MemRead_EX,
                        PC_write,
                        IF_ID_write,
                        control_sel);    
                         
assign PC_MEM = PC_Branch_MEM;
assign pipeline_stall = control_sel;        

endmodule