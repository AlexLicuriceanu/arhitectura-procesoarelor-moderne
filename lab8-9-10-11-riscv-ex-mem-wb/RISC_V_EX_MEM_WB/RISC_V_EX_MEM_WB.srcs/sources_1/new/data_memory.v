`timescale 1ns / 1ps

module data_memory(input clk,       
                   input mem_read,             //semnal de actvivare a citirii din memorie
                   input mem_write,            //semnal de activare a scrierii in memorie
                   input [31:0] address,       //adresa de scriere/citire
                   input [31:0] write_data,    //valoare scrisa in memorie
                   output reg [31:0] read_data //valoarea citita din memorie
                   );
                   
reg [31:0] dataMemory [0:1023];
wire [9:0] instruction_address = address[11:2];
integer i;

 initial begin
    for (i = 0; i< 1024; i = i + 1) begin 
        dataMemory[i] = 32'b0; 
    end
 end 
     
 always@(posedge clk) begin
    if(mem_write)
         dataMemory[instruction_address] <= write_data;
end
    
always@(*) begin
      if (mem_read) 
          read_data <= dataMemory[instruction_address];
end  
endmodule
