`timescale 1ns / 1ps

module mem_ping_pong
 #(parameter IMAGE_SIZE = 16, KERNEL_SIZE = 3,EXP_SIZE = 5, MANT_SIZE = 10, DATA_WIDTH=8, ADDR_SIZE=4,MAX_ADDRESS=15, COLUMNS = 4, ROWS = 3)(
  input  clk,           
  input  reset,         
  output reg write_enable_1,write_enable_2,
  output reg read_enable_1,read_enable_2,  
  input  [DATA_WIDTH-1:0] data_inputA1,data_inputA2,data_inputA3,data_inputB1,data_inputB2,data_inputB3, 
  output reg [DATA_WIDTH-1:0] data_output1,data_output2,data_output3,data_output4,data_output5,data_output6,data_output7,data_output8,data_output9

 // output reg [DATA_SIZE-1:0] memory_1 [0:ROWS - 1][0:COLUMNS - 1],
 // output reg [DATA_SIZE-1:0] memory_2 [0:ROWS - 1][0:COLUMNS - 1]
  //output reg [3:0] write_address_1,write_address_2, 
  //output reg [3:0] read_address_1,read_address_2  
);
reg [DATA_WIDTH-1:0] memory_1 [0:ROWS - 1][0:COLUMNS - 1] ;
reg [DATA_WIDTH-1:0] memory_2 [0:ROWS - 1][0:COLUMNS - 1] ;
reg [3:0] write_address_1,write_address_2; 
reg [3:0] read_address_1,read_address_2 ;    
ping_pong_control #(IMAGE_SIZE , KERNEL_SIZE ,EXP_SIZE , MANT_SIZE , DATA_WIDTH, ADDR_SIZE, MAX_ADDRESS, COLUMNS , ROWS )CCTT(
    clk,
    reset,
    write_enable_1,
    write_enable_2,
    read_enable_1,
    read_enable_2    
    ); 

always @(posedge clk or negedge reset) begin
  if (!reset) begin
    write_address_1 <= 0;
    for (int j= 0; j < COLUMNS; j++)
    begin
         for(int i = 0; i < ROWS; i++)
            begin
              memory_1 [i][j] <= 0;
              
            end
    end

    
    
    
    //write_address_2 <= 0;
    //read_address_2 <= 0;
  end else begin
 
    if (write_enable_1) begin
      memory_1 [0][write_address_1] <= data_inputA1;
      memory_1 [1][write_address_1] <= data_inputA2;
      memory_1 [2][write_address_1] <= data_inputA3;

      write_address_1 <= (write_address_1 + 1) % COLUMNS;
    end
   // if (write_enable_2) begin
   //   memory_2 [0][write_address_2] <= data_inputB1;
   //   memory_2 [1][write_address_2] <= data_inputB2;
   //   memory_2 [2][write_address_2] <= data_inputB3;
   //
   //   write_address_2 <= (write_address_2 + 1) % COLUMNS;
   // end
  end
end
always @(posedge clk or negedge reset) begin
  if (!reset) begin
    write_address_2 <= 0;
    for (int j= 0; j < COLUMNS; j++)
    begin
         for(int i = 0; i < ROWS; i++)
            begin
              memory_2 [i][j] <= 0;
              
            end
    end
    
  end else begin   
     if (write_enable_2) begin
       memory_2 [0][write_address_2] <= data_inputB1;
       memory_2 [1][write_address_2] <= data_inputB2;
       memory_2 [2][write_address_2] <= data_inputB3;
     
       write_address_2 <= (write_address_2 + 1) % COLUMNS;
     end
  end
end

always @(posedge clk or negedge reset)
begin

if(!reset)
begin
     read_address_1 <= 0;
     read_address_2 <= 0;
     data_output1 <= 0 ;
     data_output2 <= 0 ;
     data_output3 <= 0 ;
     data_output4 <= 0 ;
     data_output5 <= 0 ;
     data_output6 <= 0 ;
     data_output7 <= 0 ;
     data_output8 <= 0 ;
     data_output9 <= 0 ;
     
end

else
 begin
   if(read_enable_1)
   begin
         data_output1 <= memory_1 [0][(read_address_1    )%COLUMNS];
         data_output2 <= memory_1 [0][(read_address_1 + 1)%COLUMNS];
         data_output3 <= memory_1 [0][(read_address_1 + 2)%COLUMNS];
         data_output4 <= memory_1 [1][(read_address_1    )%COLUMNS];    
         data_output5 <= memory_1 [1][(read_address_1 + 1)%COLUMNS];
         data_output6 <= memory_1 [1][(read_address_1 + 2)%COLUMNS];
         data_output7 <= memory_1 [2][(read_address_1    )%COLUMNS];    
         data_output8 <= memory_1 [2][(read_address_1 + 1)%COLUMNS];
         data_output9 <= memory_1 [2][(read_address_1 + 2)%COLUMNS];
               
               if(read_address_1 < COLUMNS-1 )
                   read_address_1 <= (read_address_1 + 1);
               else 
                   read_address_1 <= 0;
    end
   if(read_enable_2)
   begin
         data_output1 <= memory_2 [0][(read_address_2    )%COLUMNS];
         data_output2 <= memory_2 [0][(read_address_2 + 1)%COLUMNS];
         data_output3 <= memory_2 [0][(read_address_2 + 2)%COLUMNS];
         data_output4 <= memory_2 [1][(read_address_2    )%COLUMNS];    
         data_output5 <= memory_2 [1][(read_address_2 + 1)%COLUMNS];
         data_output6 <= memory_2 [1][(read_address_2 + 2)%COLUMNS];
         data_output7 <= memory_2 [2][(read_address_2    )%COLUMNS];    
         data_output8 <= memory_2 [2][(read_address_2 + 1)%COLUMNS];
         data_output9 <= memory_2 [2][(read_address_2 + 2)%COLUMNS];
               
               if(read_address_2 < COLUMNS-1 )
                   read_address_2 <= (read_address_2 + 1);
               else 
                   read_address_2 <= 0;
    end    
  end
end
endmodule

