`timescale 1ns / 1ps

module conv_block #(parameter IMAGE_SIZE = 16, KERNEL_SIZE = 3,EXP_SIZE = 5, MANT_SIZE = 10, DATA_WIDTH=16, ADDR_SIZE=4,MAX_ADDRESS=15, COLUMNS = 4, ROWS = 3)
(
    input clk, rst,
    input  [DATA_WIDTH - 1:0] ImgP1, ImgP2, ImgP3, ImgP4, ImgP5, ImgP6, ImgP7, ImgP8, ImgP9,                              
                              KerW1, KerW2, KerW3, KerW4, KerW5, KerW6, KerW7, KerW8, KerW9,
    output [EXP_SIZE:0]out_exp,
    output [(2*MANT_SIZE):0]sum,
    output [(2*MANT_SIZE):0]f_sum                     
 );

reg  [DATA_WIDTH - 1:0] inputA1, inputA2, inputA3, inputA4, inputA5, inputA6, inputA7, inputA8, inputA9,
                        inputB1, inputB2, inputB3, inputB4, inputB5, inputB6, inputB7, inputB8, inputB9;
wire [MANT_SIZE:0] I1, I2, I3, I4, I5, I6, I7, I8, I9;
wire [MANT_SIZE:0] K1, K2, K3, K4, K5, K6, K7, K8, K9;
reg  [EXP_SIZE - 1:0] max_expI, max_expK; 
always@(posedge clk or negedge rst)
begin 
    if(!rst)
       begin
           inputA1 <=  0;
           inputA2 <=  0;
           inputA3 <=  0;
           inputA4 <=  0; 
           inputA5 <=  0;
           inputA6 <=  0;
           inputA7 <=  0;
           inputA8 <=  0;
           inputA9 <=  0;          
           inputB1 <=  0;
           inputB2 <=  0;
           inputB3 <=  0;
           inputB4 <=  0;
           inputB5 <=  0;
           inputB6 <=  0;
           inputB7 <=  0;
           inputB8 <=  0;
           inputB9 <=  0;
       end
    else
    begin
           inputA1 <=  ImgP1;
           inputA2 <=  ImgP2;
           inputA3 <=  ImgP3;
           inputA4 <=  ImgP4;
           inputA5 <=  ImgP5;
           inputA6 <=  ImgP6;
           inputA7 <=  ImgP7;
           inputA8 <=  ImgP8;
           inputA9 <=  ImgP9;
           inputB1 <=  KerW1;
           inputB2 <=  KerW2;
           inputB3 <=  KerW3;
           inputB4 <=  KerW4;
           inputB5 <=  KerW5;
           inputB6 <=  KerW6;
           inputB7 <=  KerW7;
           inputB8 <=  KerW8;
           inputB9 <=  KerW9;
    end    
end 

BFP_Normalizer #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) BFPI
(
    .A1(inputA1),.A2(inputA2),.A3(inputA3),.A4(inputA4),.A5(inputA5),.A6(inputA6),.A7(inputA7),.A8(inputA8),.A9(inputA9),
    .B1(I1)   ,.B2(I2)   ,.B3(I3)   ,.B4(I4)   ,.B5(I5)   ,.B6(I6)   ,.B7(I7)   ,.B8(I8)   ,.B9(I9),
    .max_exp(max_expI)
);

BFP_Normalizer #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) BFPK
(
    .A1(inputB1),.A2(inputB2),.A3(inputB3),.A4(inputB4),.A5(inputB5),.A6(inputB6),.A7(inputB7),.A8(inputB8),.A9(inputB9),
    .B1(K1)   ,.B2(K2)   ,.B3(K3)   ,.B4(K4)   ,.B5(K5)   ,.B6(K6)   ,.B7(K7)   ,.B8(K8)   ,.B9(K9),
    .max_exp(max_expK)
);

wire [(2*MANT_SIZE):0] sign_mant_p1,sign_mant_p2,sign_mant_p3,sign_mant_p4,sign_mant_p5,sign_mant_p6,sign_mant_p7,sign_mant_p8,sign_mant_p9;      
wire [(2*MANT_SIZE):0] S1,S2,S3,S4,S5,S6,S7,S8,S9;


mult_block #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) MB
(
    .I1(I1),.I2(I2),.I3(I3),.I4(I4),.I5(I5),.I6(I6),.I7(I7),.I8(I8),.I9(I9),
    .K1(K1),.K2(K2),.K3(K3),.K4(K4),.K5(K5),.K6(K6),.K7(K7),.K8(K8),.K9(K9),
    .sign_mant_p1(sign_mant_p1),.sign_mant_p2(sign_mant_p2),.sign_mant_p3(sign_mant_p3),.sign_mant_p4(sign_mant_p4),.sign_mant_p5(sign_mant_p5),
    .sign_mant_p6(sign_mant_p6),.sign_mant_p7(sign_mant_p7),.sign_mant_p8(sign_mant_p8),.sign_mant_p9(sign_mant_p9)         
);

gen_2s #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) G2C 
(
   // .clk(clk),.rst(rst),
    .A1(sign_mant_p1),.A2(sign_mant_p2),.A3(sign_mant_p3),.A4(sign_mant_p4),.A5(sign_mant_p5),
    .A6(sign_mant_p6),.A7(sign_mant_p7),.A8(sign_mant_p8),.A9(sign_mant_p9),.B1(S1)          ,
    .B2(S2)          ,.B3(S3)          ,.B4(S4)          ,.B5(S5)          ,.B6(S6)          ,
    .B7(S7)          ,.B8(S8)          ,.B9(S9)
);                      
   
assign sum = S1 + S2 + S3 + S4 + S5 + S6 + S7 + S8 + S9;
assign f_sum = (sum[(2*MANT_SIZE)]==0)?sum:((~sum)+1'b1);

assign out_exp = max_expI + max_expK ;  

endmodule
