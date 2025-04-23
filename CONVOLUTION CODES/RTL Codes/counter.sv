`timescale 1ns / 1ps

module counter #(parameter IMAGE_SIZE = 16, KERNEL_SIZE = 3,EXP_SIZE = 5, MANT_SIZE = 10, DATA_WIDTH=8, ADDR_SIZE=4,MAX_ADDRESS=15, COLUMNS = 4, ROWS = 3)
(
    input  clk,  
    input  start,  
    output reg [9:0] counter 
);
always @(posedge clk or negedge start)
begin
     if (!start) 
     begin
          counter <= 10'b0000000000;
     end 
     else 
     begin
          if (counter == 199)
              counter <= 0;
          else
              counter <= counter + 1;
     end
end
endmodule
