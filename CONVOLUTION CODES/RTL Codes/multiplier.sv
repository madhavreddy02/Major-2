`timescale 1ns / 1ps

module  multiplier #(IMAGE_SIZE = 16, KERNEL_SIZE = 3,EXP_SIZE = 5, MANT_SIZE = 10, DATA_WIDTH=8, ADDR_SIZE=4,MAX_ADDRESS=15, COLUMNS = 4, ROWS = 3) (I, K, sign_mant_p);
input  [MANT_SIZE : 0]   I, K;
output [(2*MANT_SIZE):0] sign_mant_p;
 
wire [((2*MANT_SIZE)-1):0] mant_p;
wire                       sign_out;

assign sign_out = I[MANT_SIZE] ^ K[MANT_SIZE];
assign mant_p   = I[MANT_SIZE-1:0]*K[MANT_SIZE-1:0];

assign sign_mant_p = {{sign_out},{mant_p}};

endmodule
