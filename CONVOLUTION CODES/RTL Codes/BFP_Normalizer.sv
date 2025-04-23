`timescale 1ns / 1ps

module BFP_Normalizer #(IMAGE_SIZE = 16, KERNEL_SIZE = 3,EXP_SIZE = 5, MANT_SIZE = 10, DATA_WIDTH=16, ADDR_SIZE=4,MAX_ADDRESS=15, COLUMNS = 4, ROWS = 3)
(
input      [DATA_WIDTH - 1 :0] A1, A2, A3, A4, A5, A6, A7, A8, A9,
output reg [MANT_SIZE      :0] B1, B2, B3, B4, B5, B6, B7, B8, B9,
//output  [EXP_SIZE  - 1:0]  exp[0:8],
output reg [EXP_SIZE - 1   :0] max_exp
);

wire [MANT_SIZE - 1:0]  mant       [0:8];
reg  [EXP_SIZE  - 1:0]  exp_diff   [0:8];

reg  [MANT_SIZE - 1:0]  align_mant [0:8];         
reg  [EXP_SIZE  - 1:0]  current_max;
wire [EXP_SIZE  - 1:0]  exp[0:8];

assign exp[0] = A1 [DATA_WIDTH - 2: MANT_SIZE];
assign exp[1] = A2 [DATA_WIDTH - 2: MANT_SIZE];
assign exp[2] = A3 [DATA_WIDTH - 2: MANT_SIZE];
assign exp[3] = A4 [DATA_WIDTH - 2: MANT_SIZE];
assign exp[4] = A5 [DATA_WIDTH - 2: MANT_SIZE];
assign exp[5] = A6 [DATA_WIDTH - 2: MANT_SIZE];
assign exp[6] = A7 [DATA_WIDTH - 2: MANT_SIZE];
assign exp[7] = A8 [DATA_WIDTH - 2: MANT_SIZE];
assign exp[8] = A9 [DATA_WIDTH - 2: MANT_SIZE];

assign mant[0] = A1 [MANT_SIZE - 1: 0];
assign mant[1] = A2 [MANT_SIZE - 1: 0];
assign mant[2] = A3 [MANT_SIZE - 1: 0];
assign mant[3] = A4 [MANT_SIZE - 1: 0];
assign mant[4] = A5 [MANT_SIZE - 1: 0];
assign mant[5] = A6 [MANT_SIZE - 1: 0];
assign mant[6] = A7 [MANT_SIZE - 1: 0];
assign mant[7] = A8 [MANT_SIZE - 1: 0];
assign mant[8] = A9 [MANT_SIZE - 1: 0];
            
always @(*) 
begin
  current_max = 0;
  for (int i = 0; i < 9; i = i + 1) 
  begin
    if (exp[i] > current_max)
        begin
             current_max = exp[i];
        end
  end
  max_exp = current_max;
end

always@(*)
begin
   for( int i = 0; i < 9 ; i = i+1 )
   begin
      exp_diff[i] = max_exp - exp[i];
   end    
end

always@(*)
for (int i=0; i< 9; i = i+1)
begin
      align_mant[i] = (mant[i] >> exp_diff[i]);
end

always@(*)
begin
 B1={{ A1 [DATA_WIDTH - 1] },{ align_mant[0] }};
 B2={{ A2 [DATA_WIDTH - 1] },{ align_mant[1] }};
 B3={{ A3 [DATA_WIDTH - 1] },{ align_mant[2] }};
 B4={{ A4 [DATA_WIDTH - 1] },{ align_mant[3] }};
 B5={{ A5 [DATA_WIDTH - 1] },{ align_mant[4] }};
 B6={{ A6 [DATA_WIDTH - 1] },{ align_mant[5] }};
 B7={{ A7 [DATA_WIDTH - 1] },{ align_mant[6] }};
 B8={{ A8 [DATA_WIDTH - 1] },{ align_mant[7] }};
 B9={{ A9 [DATA_WIDTH - 1] },{ align_mant[8] }};
end   
endmodule

