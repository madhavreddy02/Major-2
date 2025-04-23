`timescale 1ns / 1ps

module mem_bank #(IMAGE_SIZE = 16, KERNEL_SIZE = 3,EXP_SIZE = 5, MANT_SIZE = 10, DATA_WIDTH=8, ADDR_SIZE=4,MAX_ADDRESS=15, COLUMNS = 4, ROWS = 3)
(
  input                       clk, rst, ready, wr_en,
  input      [DATA_WIDTH - 1:0]data_in [0:IMAGE_SIZE-1], 
  output                      ping_wr_en, pong_wr_en, 
  output     [3:0]            switch,
  output reg [DATA_WIDTH - 1:0]out1_1, out1_2, out1_3, out2_1, out2_2, out2_3,  
  output reg                  start,
  output reg [9:0]            counter,
  output reg [ADDR_SIZE - 1:0] wr_addr,             
  output reg [ADDR_SIZE - 1:0] rd_addr_1, rd_addr_2   
);
//wire [3:0] switch;
//reg start;
//reg [9:0] counter;
reg [DATA_WIDTH - 1:0] data_out_1 [0:IMAGE_SIZE - 1];
reg [DATA_WIDTH - 1:0] data_out_2 [0:IMAGE_SIZE - 1];
//reg [ADDR_SIZE - 1:0] wr_addr;             
//reg [ADDR_SIZE - 1:0] rd_addr_1, rd_addr_2;
reg [3:0]count;

mem_control  #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) CNTL (clk, rst, ready, ping_wr_en, pong_wr_en, count, switch , rd_addr_1, rd_addr_2,start, counter);

AddressGenerator #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) ADR (.clk(clk), .rst(rst), .wr_en(wr_en), .address(wr_addr)); 

mem_bank_element #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) MB1 (clk, wr_en, ping_wr_en, pong_wr_en, data_in[0 ], wr_addr, rd_addr_1, rd_addr_2, data_out_1[0 ], data_out_2[0 ]);    
mem_bank_element #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) MB2 (clk, wr_en, ping_wr_en, pong_wr_en, data_in[1 ], wr_addr, rd_addr_1, rd_addr_2, data_out_1[1 ], data_out_2[1 ]);    
mem_bank_element #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) MB3 (clk, wr_en, ping_wr_en, pong_wr_en, data_in[2 ], wr_addr, rd_addr_1, rd_addr_2, data_out_1[2 ], data_out_2[2 ]);
mem_bank_element #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) MB4 (clk, wr_en, ping_wr_en, pong_wr_en, data_in[3 ], wr_addr, rd_addr_1, rd_addr_2, data_out_1[3 ], data_out_2[3 ]);    
mem_bank_element #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) MB5 (clk, wr_en, ping_wr_en, pong_wr_en, data_in[4 ], wr_addr, rd_addr_1, rd_addr_2, data_out_1[4 ], data_out_2[4 ]);    
mem_bank_element #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) MB6 (clk, wr_en, ping_wr_en, pong_wr_en, data_in[5 ], wr_addr, rd_addr_1, rd_addr_2, data_out_1[5 ], data_out_2[5 ]);
mem_bank_element #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) MB7 (clk, wr_en, ping_wr_en, pong_wr_en, data_in[6 ], wr_addr, rd_addr_1, rd_addr_2, data_out_1[6 ], data_out_2[6 ]);    
mem_bank_element #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) MB8 (clk, wr_en, ping_wr_en, pong_wr_en, data_in[7 ], wr_addr, rd_addr_1, rd_addr_2, data_out_1[7 ], data_out_2[7 ]);    
mem_bank_element #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) MB9 (clk, wr_en, ping_wr_en, pong_wr_en, data_in[8 ], wr_addr, rd_addr_1, rd_addr_2, data_out_1[8 ], data_out_2[8 ]);
mem_bank_element #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) MB10(clk, wr_en, ping_wr_en, pong_wr_en, data_in[9 ], wr_addr, rd_addr_1, rd_addr_2, data_out_1[9 ], data_out_2[9 ]);    
mem_bank_element #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) MB11(clk, wr_en, ping_wr_en, pong_wr_en, data_in[10], wr_addr, rd_addr_1, rd_addr_2, data_out_1[10], data_out_2[10]);    
mem_bank_element #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) MB12(clk, wr_en, ping_wr_en, pong_wr_en, data_in[11], wr_addr, rd_addr_1, rd_addr_2, data_out_1[11], data_out_2[11]);
mem_bank_element #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) MB13(clk, wr_en, ping_wr_en, pong_wr_en, data_in[12], wr_addr, rd_addr_1, rd_addr_2, data_out_1[12], data_out_2[12]);    
mem_bank_element #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) MB14(clk, wr_en, ping_wr_en, pong_wr_en, data_in[13], wr_addr, rd_addr_1, rd_addr_2, data_out_1[13], data_out_2[13]);    
mem_bank_element #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) MB15(clk, wr_en, ping_wr_en, pong_wr_en, data_in[14], wr_addr, rd_addr_1, rd_addr_2, data_out_1[14], data_out_2[14]);
mem_bank_element #(.IMAGE_SIZE(IMAGE_SIZE), .KERNEL_SIZE(KERNEL_SIZE),.EXP_SIZE(EXP_SIZE) , .MANT_SIZE(MANT_SIZE) , .DATA_WIDTH(DATA_WIDTH), .ADDR_SIZE(ADDR_SIZE), .MAX_ADDRESS(MAX_ADDRESS), .COLUMNS(COLUMNS), .ROWS(ROWS)) MB16(clk, wr_en, ping_wr_en, pong_wr_en, data_in[15], wr_addr, rd_addr_1, rd_addr_2, data_out_1[15], data_out_2[15]);
                                                                                                                                
always@(*)
begin
      if(counter == 0)
      begin
         out1_1 = 0;                                       
         out1_2 = 0;                                       
         out1_3 = 0;                                       
                                                           
         out2_1 = 0;                                       
         out2_2 = 0;                                       
         out2_3 = 0;                                       
      end                                                  
      else if(counter > 0 && counter < 17)                 
      begin          //ping:13 ; pong:3                    
        out1_1 = data_out_1[0];                           
        out1_2 = data_out_1[1];                           
        out1_3 = data_out_1[2];                           
                                                          
        out2_1 = data_out_2[1];                           
        out2_2 = data_out_2[2];                           
        out2_3 = data_out_2[3];                           
         
      end      
      else if(counter > 16 && counter < 31 )
      begin          //ping:3 ; pong:13
        out1_1 = data_out_1[2];
        out1_2 = data_out_1[3];
        out1_3 = data_out_1[4];  //
     
        out2_1 = data_out_2[1];
        out2_2 = data_out_2[2];
        out2_3 = data_out_2[3]; 
         
      end
      else if(counter > 30 && counter < 45)
      begin          //ping:13 ; pong:3
        out1_1 = data_out_1[2];                
        out1_2 = data_out_1[3];                
        out1_3 = data_out_1[4];                
                                               
        out2_1 = data_out_2[3] ;               
        out2_2 = data_out_2[4] ;               
        out2_3 = data_out_2[5] ;     //        
                                                
      end                                       
      else if(counter > 44 && counter < 59)     
      begin           //ping:3 ; pong:13        
        out1_1 = data_out_1[4];                
        out1_2 = data_out_1[5];                
        out1_3 = data_out_1[6];                
                                               
        out2_1 = data_out_2[3];                
        out2_2 = data_out_2[4];                
        out2_3 = data_out_2[5];                
      end
      else if(counter > 58 && counter < 73)
      begin          //ping:13 ; pong:3
        out1_1 = data_out_1[4];
        out1_2 = data_out_1[5];
        out1_3 = data_out_1[6]; 
       
        out2_1 = data_out_2[5];
        out2_2 = data_out_2[6];
        out2_3 = data_out_2[7];
         
      end      
      else if(counter > 72 && counter < 87)
      begin          //ping:3 ; pong:13
       out1_1 = data_out_1[6];
       out1_2 = data_out_1[7];
       out1_3 = data_out_1[8];
                          
       out2_1 = data_out_2[5];
       out2_2 = data_out_2[6];
       out2_3 = data_out_2[7];  
      end
      else if(counter > 86 && counter < 101)
      begin          //ping:13 ; pong:3
        out1_1 = data_out_1[6];
        out1_2 = data_out_1[7];
        out1_3 = data_out_1[8];
                           
        out2_1 = data_out_2[7];
        out2_2 = data_out_2[8];
        out2_3 = data_out_2[9];
           
      end
      else if(counter > 100 && counter < 115)
      begin           //ping:3 ; pong:13
        out1_1 = data_out_1[8];
        out1_2 = data_out_1[9];
        out1_3 = data_out_1[10];
                           
        out2_1 = data_out_2[7];
        out2_2 = data_out_2[8];
        out2_3 = data_out_2[9];
      end
      else if(counter > 114 && counter < 129)
      begin           //ping:13 ; pong:3
       out1_1 = data_out_1[8];
       out1_2 = data_out_1[9];
       out1_3 = data_out_1[10];
                          
       out2_1 = data_out_2[9];
       out2_2 = data_out_2[10];
       out2_3 = data_out_2[11];
         
      end      
      else if(counter > 128 && counter < 143)
      begin          //ping:3 ; pong:13
       out1_1 = data_out_1[10];
       out1_2 = data_out_1[11];
       out1_3 = data_out_1[12];
                          
       out2_1 = data_out_2[9];
       out2_2 = data_out_2[10];
       out2_3 = data_out_2[11];  
      end
      else if(counter > 142 && counter < 157)
      begin          //ping:13 ; pong:3
        out1_1 = data_out_1[10];
        out1_2 = data_out_1[11];
        out1_3 = data_out_1[12];
                           
        out2_1 = data_out_2[11];
        out2_2 = data_out_2[12];
        out2_3 = data_out_2[13];
           
      end
      else if(counter > 156 && counter < 171)
      begin           //ping:3 ; pong:13
        out1_1 = data_out_1[12];
        out1_2 = data_out_1[13];
        out1_3 = data_out_1[14];
                           
        out2_1 = data_out_2[11];
        out2_2 = data_out_2[12];
        out2_3 = data_out_2[13];
      end
      else if(counter > 170 && counter < 185)
              begin          //ping:13 ; pong:3
               out1_1 = data_out_1[12];
               out1_2 = data_out_1[13];
               out1_3 = data_out_1[14];
                                  
               out2_1 = data_out_2[13];
               out2_2 = data_out_2[14];
               out2_3 = data_out_2[15];
                  
              end
      else if(counter > 184 && counter < 200)
      begin           
       out1_1 = 0;
       out1_2 = 0;
       out1_3 = 0;
      
       out2_1 = data_out_2[13];
       out2_2 = data_out_2[14];
       out2_3 = data_out_2[15];
      end 
      else
      begin
      out1_1  = 0;           
      out1_2  = 0;           
      out1_3  = 0;           
                             
       out2_1 = 0 ; 
       out2_2 = 0 ;
       out2_3 = 0 ;
      end 
                         
end   
endmodule
