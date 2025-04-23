`timescale 1ns / 1ps

module AddressGenerator #(parameter IMAGE_SIZE = 16, KERNEL_SIZE = 3,EXP_SIZE = 5, MANT_SIZE = 10, DATA_WIDTH=8, ADDR_SIZE=4,MAX_ADDRESS=15, COLUMNS = 4, ROWS = 3)(
  
  input                        clk,
  input                        rst,
  input                        wr_en, 
  output reg [ADDR_SIZE - 1:0] address
);
/*
always @(posedge clk or negedge wr_en)
begin            
     if (!wr_en)
     begin                                    
        if (address != MAX_ADDRESS)     
           address <= address;                            
       else                                   
           address <= 0;                                      
     end                                                  
     else 
     begin                                           
          if (address == MAX_ADDRESS)
             address <= 0;                                  
          else                                              
             address <= address + 1;                        
     end                                                  
end        

endmodule
*/

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            address <= 4'b0000;
        end else begin
            if (wr_en) begin
                address <= address + 1;
            end
        end
    end

endmodule



