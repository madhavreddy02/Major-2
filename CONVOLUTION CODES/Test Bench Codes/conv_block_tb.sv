`timescale 1ns / 1ps

module conv_block_tb #(parameter IMAGE_SIZE = 16, KERNEL_SIZE = 3,EXP_SIZE = 5, MANT_SIZE = 10, DATA_WIDTH=16, ADDR_SIZE=4,MAX_ADDRESS=15, COLUMNS = 4, ROWS = 3)();
reg clk;
reg rst;
reg [DATA_WIDTH-1:0]  ImgP1,ImgP2,ImgP3,ImgP4,ImgP5,ImgP6,ImgP7,ImgP8,ImgP9,                              
                      KerW1,KerW2,KerW3,KerW4,KerW5,KerW6,KerW7,KerW8,KerW9;
wire [EXP_SIZE:0]     out_exp;
wire [(2*MANT_SIZE):0]sum;
wire [(2*MANT_SIZE):0]f_sum ;                    
 
conv_block #(.DATA_WIDTH(DATA_WIDTH), .EXP_SIZE(EXP_SIZE), .MANT_SIZE(MANT_SIZE)) CBB
(
.clk(clk),.rst(rst),
.ImgP1(ImgP1),.ImgP2(ImgP2),.ImgP3(ImgP3),.ImgP4(ImgP4),.ImgP5(ImgP5),.ImgP6(ImgP6),.ImgP7(ImgP7),.ImgP8(ImgP8),.ImgP9(ImgP9),                              
.KerW1(KerW1),.KerW2(KerW2),.KerW3(KerW3),.KerW4(KerW4),.KerW5(KerW5),.KerW6(KerW6),.KerW7(KerW7),.KerW8(KerW8),.KerW9(KerW9),
.out_exp(out_exp),.sum(sum),.f_sum(f_sum)                     
);
initial
begin
    clk = 0;
    rst = 0;
    #5 rst = 1;
end    
always 
#5 clk = ~clk ;                        
initial
begin 
@(posedge clk)
KerW1=16'b0011110001000000;
KerW2=16'b0011110010000000;
KerW3=16'b0011110001000000;
KerW4=16'b0011110010000000;
KerW5=16'b0011110100000000;
KerW6=16'b0011110010000000;
KerW7=16'b0011110001000000;
KerW8=16'b0011110010000000;
KerW9=16'b0011110001000000;
end
/*
1100001000000000;
1100001000000000;
1100001000000000;
1100001000000000;
0100111000000000;
1100001000000000;
1100001000000000;
1100001000000000;
1100001000000000;


end */

initial
begin
@(posedge clk)                                     
ImgP1=16'b010111_1101100000;
ImgP2=16'b010111_1100110000;
ImgP3=16'b010111_1011011000;
ImgP4=16'b010111_1101101100;
ImgP5=16'b010111_1010101000;      //1
ImgP6=16'b010110_1100011000;
ImgP7=16'b010111_1101110000;
ImgP8=16'b010111_1100011000;
ImgP9=16'b010111_1000100100;
@(posedge clk)
ImgP1=16'b0101111100110000;
ImgP2=16'b0101111011011000;                                                                                               
ImgP3=16'b0101111101001000;                                                                                               
ImgP4=16'b0101111010101000;                                                      
ImgP5=16'b0101110110001100;     //2     
ImgP6=16'b0101111010011000;             
ImgP7=16'b0101111100011000;
ImgP8=16'b0101111000100100;
ImgP9=16'b0101111011100000;
@(posedge clk)
ImgP1=16'b0101111011011000;
ImgP2=16'b0101111101001000;
ImgP3=16'b0101111101010100;                                         
ImgP4=16'b0101110110001100;      //3                                              
ImgP5=16'b0101111010011000;                                                       
ImgP6=16'b0101111101100100;             
ImgP7=16'b0101111000100100;             
ImgP8=16'b0101111011100000;
ImgP9=16'b0101111101010000;
@(posedge clk)
ImgP1=16'b0101111101101100;
ImgP2=16'b0101111010101000;
ImgP3=16'b0101110110001100;
ImgP4=16'b0101111101110000;               
ImgP5=16'b0101111100011000;                                                            
ImgP6=16'b0101111000100100;        //4                                                                                              
ImgP7=16'b0101111101011000;                                                                                                        
ImgP8=16'b0101111100010000;               
ImgP9=16'b0101111000111000;
@(posedge clk)
ImgP1=16'b0101111010101000;
ImgP2=16'b0101110110001100;
ImgP3=16'b0101111010011000;
ImgP4=16'b0101111100011000;                   
ImgP5=16'b0101111000100100;      //5                                                                                                              
ImgP6=16'b0101111011100000;                                                                                                                       
ImgP7=16'b0101111100010000;                                                                                                                       
ImgP8=16'b0101111000111000;                  
ImgP9=16'b0101111011001100;
@(posedge clk)
ImgP1=16'b0101110110001100;
ImgP2=16'b0101111010011000;
ImgP3=16'b0101111101100100;                 
ImgP4=16'b0101111000100100;                                                             
ImgP5=16'b0101111011100000;     //6                                                                                                   
ImgP6=16'b0101111101010000;                                                                                                           
ImgP7=16'b0101111000111000;                
ImgP8=16'b0101111011001100;
ImgP9=16'b0101111100100100;
@(posedge clk)
ImgP1=16'b0101111101110000;
ImgP2=16'b0101111100011000;
ImgP3=16'b0101111000100100;                     
ImgP4=16'b0101111101011000;                    
ImgP5=16'b0101111100010000;      //7                                                                                                       
ImgP6=16'b0101111000111000;                                                                                                                          
ImgP7=16'b0101111100010100;                                                                                                                          
ImgP8=16'b0101111100100000;
ImgP9=16'b0101111100010000;
@(posedge clk)
ImgP1=16'b0101111100011000;
ImgP2=16'b0101111000100100;
ImgP3=16'b0101111011100000;                        
ImgP4=16'b0101111100010000;                        
ImgP5=16'b0101111000111000;    //8                    
ImgP6=16'b0101111011001100;                           
ImgP7=16'b0101111100100000;                           
ImgP8=16'b0101111100010000;
ImgP9=16'b0101111011111100;
@(posedge clk)
ImgP1=16'b0101111000100100;
ImgP2=16'b0101111011100000;
ImgP3=16'b0101111101010000;
ImgP4=16'b0101111000111000;     //9           
ImgP5=16'b0101111011001100;                  
ImgP6=16'b0101111100100100;                       
ImgP7=16'b0101111100010000;                       
ImgP8=16'b0101111011111100;                       
ImgP9=16'b0101111011010100;
end                              
endmodule

/*module AA();
parameter img_size=5;
reg [15:0] mat1[img_size-1:0][img_size-1:0];
parameter ker_size=3;
integer i,j;
*/

