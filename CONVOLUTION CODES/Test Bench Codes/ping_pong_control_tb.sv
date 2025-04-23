`timescale 1ns / 1ps

module ping_pong_control_tb #(parameter IMAGE_SIZE = 16, KERNEL_SIZE = 3,EXP_SIZE = 5, MANT_SIZE = 10, DATA_SIZE=8, ADDR_SIZE=4,MAX_ADDRESS=15, COLUMNS = 4, ROWS = 3)();


    reg clk;
    reg rst;
    wire ping_wr_en;
    wire pong_wr_en;
    wire ping_rd_en;
    wire pong_rd_en;
    //wire [3:0]count;
    //wire [3:0]switch;        

ping_pong_control #(IMAGE_SIZE , KERNEL_SIZE ,EXP_SIZE , MANT_SIZE , DATA_SIZE, ADDR_SIZE,MAX_ADDRESS, COLUMNS, ROWS) CCT(
   clk,
   rst,
   ping_wr_en,
   pong_wr_en,
   ping_rd_en,
   pong_rd_en
   //count,
   //switch        
    );  
initial
begin
 clk=1;
 rst=0;

 #4 rst=1;
    
    #800;
    $finish;
end 

always 
#2 clk = ~clk;        
    
endmodule


