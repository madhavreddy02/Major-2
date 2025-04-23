`timescale 1ns / 1ps


module top_design #(parameter IMAGE_SIZE = 16, KERNEL_SIZE = 3,EXP_SIZE = 5, MANT_SIZE = 10, DATA_WIDTH=16, ADDR_SIZE=4,MAX_ADDRESS=15, COLUMNS = 4, ROWS = 3)(
input                       clk, rst, ready, input_wr_en,                                                                                                           
input     [DATA_WIDTH - 1:0] data_in [0:IMAGE_SIZE-1], 
input ping_pong_enable,                                                                                                              
output  write_enable_1,write_enable_2,                                                                                                                              
output     [3:0]            switch,                                                                                                                                 
output reg                  start,                                                                                                                                  
output reg [9:0]            counter ,
output reg [DATA_WIDTH - 1:0]out1_1, out1_2, out1_3, out2_1, out2_2, out2_3,                                                                                                                               
output  reg   ping_wr_en, pong_wr_en,                                                                                                                               
output reg ping_rd_en, pong_rd_en,                                                                                                                                  
output reg [DATA_WIDTH-1:0] data_output1,data_output2,data_output3,data_output4,data_output5,data_output6,data_output7,data_output8,data_output9 ,                   
//input conv_en,
input  [DATA_WIDTH - 1:0] KerW1, KerW2, KerW3, KerW4, KerW5, KerW6, KerW7, KerW8, KerW9,
output [EXP_SIZE:0]out_exp,
output [(2*MANT_SIZE):0]sum,
output [(2*MANT_SIZE):0]f_sum 
    );

mem_bank #(IMAGE_SIZE , KERNEL_SIZE ,EXP_SIZE , MANT_SIZE , DATA_WIDTH, ADDR_SIZE, MAX_ADDRESS, COLUMNS , ROWS) EXTRN_MEM
(
  .clk(clk), .rst(rst), .ready(ready), .wr_en(input_wr_en),
  .data_in(data_in), 
  .ping_wr_en(write_enable_1), .pong_wr_en(write_enable_2), 
  .switch(switch),
  .out1_1(out1_1), .out1_2(out1_2), .out1_3(out1_3), .out2_1(out2_1), .out2_2(out2_2), .out2_3(out2_3) , 
  .start(start),
 .counter(counter)   
);


mem_ping_pong #(IMAGE_SIZE, KERNEL_SIZE, EXP_SIZE , MANT_SIZE , DATA_WIDTH, ADDR_SIZE, MAX_ADDRESS, COLUMNS, ROWS) MMPP
 (
  .clk(clk),           
  .reset(ping_pong_enable),         
  .write_enable_1(ping_wr_en),.write_enable_2(pong_wr_en),
  .read_enable_1(ping_rd_en),.read_enable_2(pong_rd_en),  
  .data_inputA1(out1_1),.data_inputA2(out1_2),.data_inputA3(out1_3),.data_inputB1(out2_1),.data_inputB2(out2_2),.data_inputB3(out2_3), 
  .data_output1(data_output1),
  .data_output2(data_output2),
  .data_output3(data_output3),
  .data_output4(data_output4),
  .data_output5(data_output5),
  .data_output6(data_output6),
  .data_output7(data_output7),
  .data_output8(data_output8),
  .data_output9(data_output9)

);


conv_block #(IMAGE_SIZE , KERNEL_SIZE ,EXP_SIZE , MANT_SIZE , DATA_WIDTH, ADDR_SIZE, MAX_ADDRESS, COLUMNS , ROWS)CB
(
    .clk(clk), 
   // .rst(conv_en),
    .rst(rst),
    .ImgP1(data_output1), .ImgP2(data_output2), .ImgP3(data_output3), .ImgP4(data_output4), .ImgP5(data_output5), .ImgP6(data_output6), .ImgP7(data_output7), .ImgP8(data_output8), .ImgP9(data_output9),                              
    .KerW1(KerW1), .KerW2(KerW2), .KerW3(KerW3), .KerW4(KerW4), .KerW5(KerW5), .KerW6(KerW6), .KerW7(KerW7), .KerW8(KerW8), .KerW9(KerW9),
    .out_exp(out_exp),
    .sum(sum),
    .f_sum(f_sum)                     
 );
endmodule


