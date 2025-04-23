`timescale 1ns / 1ps

module ping_pong_control#(parameter IMAGE_SIZE = 16, KERNEL_SIZE = 3,EXP_SIZE = 5, MANT_SIZE = 10, DATA_SIZE=8, ADDR_SIZE=4,MAX_ADDRESS=15, COLUMNS = 4, ROWS = 3)(

    input clk,
    input rst,
    output reg ping_wr_en,
    output reg pong_wr_en,
    output reg ping_rd_en,
    output reg pong_rd_en
//    output reg [3:0]count,
//    output reg [3:0]switch        
    );  
reg [3:0]count;  
reg [3:0]switch;  
     
    
reg  [3:0] current_state,next_state;  

localparam [1:0] s0= 2'b00;
localparam [1:0] s1= 2'b01;
localparam [1:0] s2= 2'b10;
localparam [1:0] s3= 2'b11;    

always @(posedge clk or negedge rst)
begin
    if (!rst) 
    begin
        current_state <= s0;
        count <= 0;
        switch <= 0;     
    end
    else
    begin
        case(current_state)
            s0: if (count == 0)
                    begin
                         current_state <= s0;
                         count <= count + 1; 
                    end
                else 
                    begin  
                         current_state <= s1;
                         count <= 0;
                         switch <= switch + 1;
                         
                    end

            s1: if (count < KERNEL_SIZE-1)
                    begin
                         current_state <= s1;
                         count <= count + 1;
                    end 
                else  
                    begin
                         current_state <= s2;
                         count <= 0;
                         switch <= switch + 1;
                    end

            s2: if (count < IMAGE_SIZE-KERNEL_SIZE) 
                    begin
                         current_state <= s2;
                         count <= count + 1;
                    end 
                else  
                    begin
                      if(switch >1 && switch < (2+IMAGE_SIZE-KERNEL_SIZE)) begin
                         current_state <= s3;
                         count <= 0;
                         switch <= switch + 1;  end
                      else  begin
                         current_state <= s0;
                         switch <= 0;   end 
                    end
            s3: if (count < IMAGE_SIZE-KERNEL_SIZE) 
                    begin
                         current_state <= s3;
                         count <= count + 1;
                    end 
                else  
                    begin
                         if(switch >1 && switch < (2+IMAGE_SIZE-KERNEL_SIZE)) begin
                         current_state <= s2;
                         count <= 0;
                         switch <= switch + 1;  end
                      else 
                      begin
                         current_state <= s0;
                         switch <= 0; end
                    end                        
            default: current_state <= s0;      
        endcase         
    end     
end
always@(current_state, switch, count, rst)
begin
     case(current_state)
             s0:
             begin
                  ping_wr_en = 0;
                  pong_wr_en = 0;
                  ping_rd_en = 0;
                  pong_rd_en = 0;
             end
             s1:
              begin
                 if(!rst)
                 begin
                  ping_wr_en = 0;
                  pong_wr_en = 0;
                  ping_rd_en = 0;
                  pong_rd_en = 0;
                 end     
         
                 else if(count < KERNEL_SIZE)
                 begin
                      ping_wr_en = 1; 
                      pong_wr_en = 0;
                      ping_rd_en = 0;
                      pong_rd_en = 0;
                 end 
                 else
                    begin
                     ping_wr_en = 0;
                     pong_wr_en = 0;
                     ping_rd_en = 0;
                     pong_rd_en = 0;
                    end    
             end
             s2:
              begin
                  pong_rd_en = 0;
                  if(count < IMAGE_SIZE-KERNEL_SIZE)
                      ping_wr_en = 1;
                  else
                      ping_wr_en = 0;
                  if((count < KERNEL_SIZE) && (switch != 15) )    
                  pong_wr_en = 1;
                  else
                  pong_wr_en = 0;
                  if(count <(1+IMAGE_SIZE-KERNEL_SIZE))
                  ping_rd_en = 1;
                  else
                  ping_rd_en = 0;     
             end
             s3:
              begin
                  ping_rd_en = 0;
                  if(count < IMAGE_SIZE-KERNEL_SIZE)
                      pong_wr_en = 1;
                  else
                      pong_wr_en = 0;
                  if((count < KERNEL_SIZE)  &&  (switch!=15))    
                  ping_wr_en = 1;
                  else
                  ping_wr_en = 0;
                  if(count <(1+IMAGE_SIZE-KERNEL_SIZE))
                  pong_rd_en = 1;
                  else
                  pong_rd_en = 0;
             end
             default:
                    begin
                    ping_wr_en = 0;
                    pong_wr_en = 0;
                    ping_rd_en = 0;
                    pong_rd_en = 0;
                    end
         endcase                   
end
endmodule



