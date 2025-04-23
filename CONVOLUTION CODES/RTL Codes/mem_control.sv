`timescale 1ns / 1ps

module mem_control #(parameter IMAGE_SIZE = 16, KERNEL_SIZE = 3,EXP_SIZE = 5, MANT_SIZE = 10, DATA_WIDTH=8, ADDR_SIZE=4,MAX_ADDRESS=15, COLUMNS = 4, ROWS = 3)(

    input                     clk,
    input                     rst,
    input                     ready,
    output reg                ping_wr_en,
    output reg                pong_wr_en,
    output reg [ADDR_SIZE-1:0]count,
    output reg [3:0]          switch ,
    output reg [ADDR_SIZE-1:0]addr1,addr2,
    output reg                start,
    output reg [9:0]          counter       
    );
 //reg [3:0]count ;
 //reg [3:0]switch ;     

   
reg  [3:0] current_state,next_state;  
//reg  [3:0]a; 
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
        start <= 0;     
    end
    else if(ready)
    begin
        case(current_state)
            s0: if (count == 0)
                    begin
                         current_state <= s0;
                         count <= count + 1; 
                         start <= 0;
                    end
                else 
                    begin 
                         start <= 1; 
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

            s2: if (count < IMAGE_SIZE-(KERNEL_SIZE/*+1*/)) //
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
            s3: if (count < IMAGE_SIZE-(KERNEL_SIZE/*+1*/)) //
                    begin
                         current_state <= s3;
                         count <= count + 1;
                    end 
                else  
                    begin
                         if(switch >1 && switch < (2 + IMAGE_SIZE - KERNEL_SIZE)) begin
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
always@(current_state, switch, count,ready)
begin
     case(current_state)
             s0:
             begin
                  ping_wr_en = 0;
                  pong_wr_en = 0;
             end
             s1:
              begin
                 if(ready)
                      ping_wr_en = 1;
                 else
                      ping_wr_en = 1; 
                  pong_wr_en = 0;
             end
             s2:
              begin
                  if(count < IMAGE_SIZE-KERNEL_SIZE)
                      ping_wr_en = 1;
                  else
                      ping_wr_en = 0;
                  if(count < KERNEL_SIZE  && (switch != 15))    
                  pong_wr_en = 1;
                  else
                  pong_wr_en = 0;     
             end
             s3:
              begin
                  if(count < IMAGE_SIZE-KERNEL_SIZE)
                      pong_wr_en = 1;
                  else
                      pong_wr_en = 0;
                  if(count < KERNEL_SIZE && (switch != 15))    
                  ping_wr_en = 1;
                  else
                  ping_wr_en = 0;
             end
             default:
                    begin
                    ping_wr_en = 0;
                    pong_wr_en = 0;
                    end
         endcase                   
end
AddressGenerator  #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE), .MANT_SIZE(MANT_SIZE), .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS),  .COLUMNS(COLUMNS), .ROWS(ROWS)) ADR1(.clk(clk), .rst(rst), .wr_en(ping_wr_en), .address(addr1));
AddressGenerator  #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE), .MANT_SIZE(MANT_SIZE), .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) ADR2(.clk(clk), .rst(rst), .wr_en(pong_wr_en), .address(addr2));
counter #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE), .MANT_SIZE(MANT_SIZE), .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) CC(
    .clk(clk),  
    .start(start),  
    .counter(counter) 
);

endmodule


