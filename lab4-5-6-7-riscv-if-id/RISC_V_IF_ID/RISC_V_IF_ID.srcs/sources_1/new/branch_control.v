module branch_control(input ZERO, ALU_OUT, BRANCH,
                      input [2:0] FUNCT3,
                      output PCSrc);

wire beq; assign beq = ZERO & (~FUNCT3[2]) & (~FUNCT3[1]) & (~FUNCT3[0]);
wire bne; assign bne = (~ZERO) & (~FUNCT3[2]) & (~FUNCT3[1]) & FUNCT3[0];
wire blt; assign blt = ALU_OUT & FUNCT3[2] & (~FUNCT3[0]);
wire bge; assign bge = (~ALU_OUT) & FUNCT3[2] & FUNCT3[0];

assign PCSrc = BRANCH & (beq|bne|blt|bge); 

endmodule