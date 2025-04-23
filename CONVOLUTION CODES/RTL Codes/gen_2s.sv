`timescale 1ns / 1ps

module gen_2s #(IMAGE_SIZE = 16, KERNEL_SIZE = 3,EXP_SIZE = 5, MANT_SIZE = 10, DATA_WIDTH=8, ADDR_SIZE=4,MAX_ADDRESS=15, COLUMNS = 4, ROWS = 3)
(
  input  [(2* MANT_SIZE):0] A1, A2, A3, A4, A5, A6, A7, A8, A9,
  output [(2* MANT_SIZE):0] B1, B2, B3, B4, B5, B6, B7, B8, B9
);

  assign B1 = (A1[2 * MANT_SIZE] == 0) ? A1 : (~A1 + 1);
  assign B2 = (A2[2 * MANT_SIZE] == 0) ? A2 : (~A2 + 1);
  assign B3 = (A3[2 * MANT_SIZE] == 0) ? A3 : (~A3 + 1);
  assign B4 = (A4[2 * MANT_SIZE] == 0) ? A4 : (~A4 + 1);
  assign B5 = (A5[2 * MANT_SIZE] == 0) ? A5 : (~A5 + 1);
  assign B6 = (A6[2 * MANT_SIZE] == 0) ? A6 : (~A6 + 1);
  assign B7 = (A7[2 * MANT_SIZE] == 0) ? A7 : (~A7 + 1);
  assign B8 = (A8[2 * MANT_SIZE] == 0) ? A8 : (~A8 + 1);
  assign B9 = (A9[2 * MANT_SIZE] == 0) ? A9 : (~A9 + 1);

endmodule


