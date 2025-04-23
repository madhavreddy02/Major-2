`timescale 1ns / 1ps


module tb_mem_ping_pong #(parameter IMAGE_SIZE = 16, KERNEL_SIZE = 3,EXP_SIZE = 5, MANT_SIZE = 10, DATA_WIDTH=16, ADDR_SIZE=4,MAX_ADDRESS=15, COLUMNS = 4, ROWS = 3)();

  reg clk;
  reg reset;
  wire write_enable_1,write_enable_2;
  wire read_enable_1,read_enable_2;
  reg [DATA_WIDTH-1:0] data_inputA1,data_inputA2,data_inputA3,data_inputB1,data_inputB2,data_inputB3;
  wire [DATA_WIDTH-1:0] data_output1,data_output2,data_output3,data_output4,data_output5,data_output6,data_output7,data_output8,data_output9;
 // wire [DATA_WIDTH-1:0] memory_1 [0:ROWS-1][0:COLUMNS-1]; 
 // wire [DATA_WIDTH-1:0] memory_2 [0:ROWS-1][0:COLUMNS-1];

  mem_ping_pong  #(IMAGE_SIZE , KERNEL_SIZE ,EXP_SIZE , MANT_SIZE , DATA_WIDTH, ADDR_SIZE,MAX_ADDRESS, COLUMNS , ROWS ) uut (
    .clk(clk),
    .reset(reset),
    .write_enable_1(write_enable_1),
    .write_enable_2(write_enable_2),
    .read_enable_1(read_enable_1),
    .read_enable_2(read_enable_2),
    
    .data_inputA1(data_inputA1),
    .data_inputA2(data_inputA2),
    .data_inputA3(data_inputA3),
    .data_inputB1(data_inputB1),
    .data_inputB2(data_inputB2),
    .data_inputB3(data_inputB3),
    
    .data_output1(data_output1),
    .data_output2(data_output2),
    .data_output3(data_output3),
    .data_output4(data_output4),
    .data_output5(data_output5),
    .data_output6(data_output6),
    .data_output7(data_output7),
    .data_output8(data_output8),
    .data_output9(data_output9)
    
  //  .memory_1(memory_1),  
  //  .memory_2(memory_2)

  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin

    reset = 0;

    data_inputA1 = 8'b0;
    data_inputA2 = 8'b0;
    data_inputA3 = 8'b0;
     
    data_inputB1 = 8'b0;
    data_inputB2 = 8'b0;
    data_inputB3 = 8'b0;

    #5 reset = 1;

    #20 data_inputA1 = 8'b10101010; 
        data_inputA2 = 8'b10101011; 
        data_inputA3 = 8'b10111010; 
    #10 data_inputA1 = 8'b11001100; 
        data_inputA2 = 8'b11001100; 
        data_inputA3 = 8'b11001100; 

    #10 data_inputA1 = 8'b11110000; 
        data_inputA2 = 8'b01010000; 
        data_inputA3 = 8'b10010000; 

    #10 data_inputA1 = 8'b10001001; 
        data_inputA2 = 8'b00101101; 
        data_inputA3 = 8'b11001111; 

    #10 data_inputA1 = 8'b01010110; 
        data_inputA2 = 8'b01110111; 
        data_inputA3 = 8'b11110101; 

    #10 data_inputA1 = 8'b10110011; 
        data_inputA2 = 8'b01110011; 
        data_inputA3 = 8'b00100011; 

    #10 data_inputA1 = 8'b10001110; 
        data_inputA2 = 8'b10101000; 
        data_inputA3 = 8'b10001000; 

    #10 data_inputA1 = 8'b10011111; 
        data_inputA2 = 8'b11000111; 
        data_inputA3 = 8'b11111001; 

    #10 data_inputA1 = 8'b01000000; 
        data_inputA2 = 8'b00111000; 
        data_inputA3 = 8'b01100011; 

    #10 data_inputA1 = 8'b01011011; 
        data_inputA2 = 8'b11111011; 
        data_inputA3 = 8'b11001011; 

    #10 data_inputA1 = 8'b11000001; 
        data_inputA2 = 8'b10000011; 
        data_inputA3 = 8'b11010011; 

    #10 data_inputA1 = 8'b01010110; 
        data_inputA2 = 8'b01110111; 
        data_inputA3 = 8'b11110101; 

    #10 data_inputA1 = 8'b10110011; 
        data_inputA2 = 8'b01110011; 
        data_inputA3 = 8'b00100011; 

    #10 data_inputA1 = 8'b10001110; 
        data_inputA2 = 8'b10101000; 
        data_inputA3 = 8'b10001000; 

    #10 data_inputA1 = 8'b10011111; 
        data_inputA2 = 8'b11000111; 
        data_inputA3 = 8'b11111001; 

    #10 data_inputA1 = 8'b00000000;
        data_inputA2 = 8'b00000000;
        data_inputA3 = 8'b00000000;
    
    #10 data_inputA1 = 8'b11111111; 
        data_inputA2 = 8'b11111111; 
        data_inputA3 = 8'b11111111; 
    #10 data_inputA1 = 8'b01000000;
        data_inputA2 = 8'b00111000;
        data_inputA3 = 8'b01100011;    

    #1000;

    $finish;
  end
initial
begin
#45;                                                       

    #10 data_inputB1 = 8'b10101010; 
        data_inputB2 = 8'b10101011; 
        data_inputB3 = 8'b10111010; 
    #10 data_inputB1 = 8'b11001100; 
        data_inputB2 = 8'b11001100; 
        data_inputB3 = 8'b11001100; 
                                    
    #10 data_inputB1 = 8'b11110000; 
        data_inputB2 = 8'b01010000; 
        data_inputB3 = 8'b10010000; 
                                    
    #80 data_inputB1 = 8'b10001001; 
        data_inputB2 = 8'b00101101; 
        data_inputB3 = 8'b11001111; 
                                    
    #10 data_inputB1 = 8'b01010110; 
        data_inputB2 = 8'b01110111; 
        data_inputB3 = 8'b11110101; 
                                    
    #10 data_inputB1 = 8'b10110011; 
        data_inputB2 = 8'b01110011; 
        data_inputB3 = 8'b00100011; 
                                    
    #10 data_inputB1 = 8'b10001110; 
        data_inputB2 = 8'b10101000; 
        data_inputB3 = 8'b10001000; 
                                    
    #10 data_inputB1 = 8'b10011111; 
        data_inputB2 = 8'b11000111; 
        data_inputB3 = 8'b11111001; 
                                    
    #10 data_inputB1 = 8'b01000000; 
        data_inputB2 = 8'b00111000; 
        data_inputB3 = 8'b01100011; 
                                    
    #10 data_inputB1 = 8'b01011011; 
        data_inputB2 = 8'b11111011; 
        data_inputB3 = 8'b11001011; 
                                    
    #10 data_inputB1 = 8'b11000001; 
        data_inputB2 = 8'b10000011; 
        data_inputB3 = 8'b11010011; 
                                    
    #10 data_inputB1 = 8'b01010110; 
        data_inputB2 = 8'b01110111; 
        data_inputB3 = 8'b11110101; 
                                    
    #10 data_inputB1 = 8'b10110011; 
        data_inputB2 = 8'b01110011; 
        data_inputB3 = 8'b00100011; 
                                    
    #10 data_inputB1 = 8'b10001110; 
        data_inputB2 = 8'b10101000; 
        data_inputB3 = 8'b10001000; 
                                    
    #10 data_inputB1 = 8'b10011111; 
        data_inputB2 = 8'b11000111; 
        data_inputB3 = 8'b11111001; 
                                    
    #10 data_inputB1 = 8'b01000000; 
        data_inputB2 = 8'b00111000; 
        data_inputB3 = 8'b01100011; 
    #100;                                              

end 

endmodule

