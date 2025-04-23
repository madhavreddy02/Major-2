`timescale 10ps/10ps

module mem_bank_element #(parameter IMAGE_SIZE = 16, KERNEL_SIZE = 3,EXP_SIZE = 5, MANT_SIZE = 10, DATA_WIDTH=8, ADDR_SIZE=4,MAX_ADDRESS=15, COLUMNS = 4, ROWS = 3)
                    (clk, wr_en, rd_en_1,rd_en_2, data_in, wr_addr, rd_addr_1,rd_addr_2, data_out_1,data_out_2);
input                       clk;
input                       wr_en;
input                       rd_en_1,rd_en_2;
input       [ADDR_SIZE-1:0] wr_addr;
input       [ADDR_SIZE-1:0] rd_addr_1,rd_addr_2;
input       [DATA_WIDTH-1:0] data_in;
output reg  [DATA_WIDTH-1:0] data_out_1,data_out_2;

reg [DATA_WIDTH-1:0] ram_mem [0:IMAGE_SIZE];  

always @(posedge clk)
begin
     if (wr_en==1'b1)
         ram_mem[wr_addr] <= data_in;
end
    
always @(posedge clk)
begin
     if( rd_en_1 )
         data_out_1 <= ram_mem[rd_addr_1];
     else
         data_out_1 <= 0;    
end

always @(posedge clk)
begin
     if( rd_en_2)
         data_out_2 <= ram_mem[rd_addr_2];     
     else
         data_out_2 <= 0;
end 
endmodule
