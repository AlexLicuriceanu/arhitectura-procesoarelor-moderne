`timescale 1ns / 1ps


module hazard_detection(input [4:0] rd,        //adresa registrului destinatie in etapa EX
                        input [4:0] rs1,       //adresa registrului sursa 1 decodificat in etapa ID
                        input [4:0] rs2,       //adresa registrului sursa 2 decodicat in etapa ID
                        input MemRead,         //semnalul de control MemRead din etapa EX
                        output reg PCwrite,    //semnalul PCwrite ce controleaza scrierea in registrul PC
                        output reg IF_IDwrite, //semnal ce controleaza scrierea in registrul de pipeline IF_ID
                        output reg control_sel //semnal transmis spre unitatea de control
                        );
                        
 always@(*) begin 
    if (MemRead && ((rd == rs1)||(rd == rs2)))  begin 
          PCwrite = 0;
          IF_IDwrite = 0;
          control_sel = 1;
    end
    else begin 
          PCwrite = 1;
          IF_IDwrite = 1;
          control_sel = 0;
    end  
end      
endmodule
