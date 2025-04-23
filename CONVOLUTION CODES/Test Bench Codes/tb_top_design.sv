`timescale 1ns / 1ps


module tb_top_design#(parameter IMAGE_SIZE = 16, KERNEL_SIZE = 3,EXP_SIZE = 5, MANT_SIZE = 10, DATA_WIDTH=16, ADDR_SIZE=4,MAX_ADDRESS=15, COLUMNS = 4, ROWS = 3)();
reg   clk, rst, ready, input_wr_en;                                                                                                           
reg   [DATA_WIDTH - 1:0] data_in [0:IMAGE_SIZE-1]; 
reg   ping_pong_enable;                                                                                                    
wire  write_enable_1,write_enable_2;                                                                                                                              
wire  [3:0]            switch;                                                                                                                                 
reg                  start;                                                                                                                                  
wire  [9:0]            counter ;
wire  [DATA_WIDTH - 1:0]out1_1, out1_2, out1_3, out2_1, out2_2, out2_3;                                                                                                                               
wire  ping_wr_en, pong_wr_en;                                                                                                                               
wire  ping_rd_en, pong_rd_en;                                                                                                                                 
wire [DATA_WIDTH-1:0] data_output1,data_output2,data_output3,data_output4,data_output5,data_output6,data_output7,data_output8,data_output9;                    
//reg   conv_en;
reg  [DATA_WIDTH - 1:0] KerW1, KerW2, KerW3, KerW4, KerW5, KerW6, KerW7, KerW8, KerW9;
wire [EXP_SIZE:0]out_exp;
wire [(2*MANT_SIZE):0]sum;
wire [(2*MANT_SIZE):0]f_sum ;

top_design #(IMAGE_SIZE, KERNEL_SIZE ,EXP_SIZE , MANT_SIZE , DATA_WIDTH, ADDR_SIZE,MAX_ADDRESS, COLUMNS , ROWS )  TTOP(
clk, rst, ready, input_wr_en,                                                                                                           
data_in, 
ping_pong_enable,                                                                                                              
write_enable_1,write_enable_2,                                                                                                                              
switch,                                                                                                                                 
start,                                                                                                                                  
counter ,
out1_1, out1_2, out1_3, out2_1, out2_2, out2_3,                                                                                                                               
ping_wr_en, pong_wr_en,                                                                                                                               
ping_rd_en, pong_rd_en,                                                                                                                                  
data_output1,data_output2,data_output3,data_output4,data_output5,data_output6,data_output7,data_output8,data_output9,
//conv_en,
KerW1, KerW2, KerW3, KerW4, KerW5, KerW6, KerW7, KerW8, KerW9,
out_exp,
sum,
f_sum                     
    );  
initial 
   begin
      clk <= 1;
      rst <= 0;

      #10 rst <= 1;
          input_wr_en = 0;
   // reset = 0; // Assert reset initially
   // #10 reset = 1; // De-assert reset after 10 time units

    // Apply stimulus
    #20 input_wr_en = 1;
    #160 input_wr_en = 0;
      #2020 $finish;       
        // Adjusted delay to reach 3000 ns
   end
initial
begin

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
initial
begin
    ping_pong_enable <= 0;
    #200;
    ping_pong_enable <= 1;
end 
initial
begin
   start <= 0;
   #0;
   start <= 1;
end
   initial
   begin
      ready <= 0;
      #190 ready <= 1;
      #2000 ready <= 0;
      // Adjusted delay to reach 3000 ns
   end
   initial
   begin
   #30
   data_in[0 ]=000;
   data_in[1 ]=001;
   data_in[2 ]=002;
   data_in[3 ]=003;
   data_in[4 ]=004;
   data_in[5 ]=005;
   data_in[6 ]=006;
   data_in[7 ]=007;
   data_in[8 ]=008;
   data_in[9 ]=009;
   data_in[10]=010;
   data_in[11]=011;
   data_in[12]=012;
   data_in[13]=013;
   data_in[14]=014;
   data_in[15]=015;       
             
   #10
   data_in[0 ]=016;
   data_in[1 ]=017;
   data_in[2 ]=018;
   data_in[3 ]=019;
   data_in[4 ]=020;
   data_in[5 ]=021;
   data_in[6 ]=022;
   data_in[7 ]=023;
   data_in[8 ]=024;
   data_in[9 ]=025;
   data_in[10]=026;
   data_in[11]=027;
   data_in[12]=028;
   data_in[13]=029;
   data_in[14]=030;
   data_in[15]=031; 
   #10      
   data_in[0 ]=032;
   data_in[1 ]=033;
   data_in[2 ]=034;
   data_in[3 ]=035;
   data_in[4 ]=036;
   data_in[5 ]=037;
   data_in[6 ]=038;
   data_in[7 ]=039;
   data_in[8 ]=040;
   data_in[9 ]=041;
   data_in[10]=042;
   data_in[11]=043;
   data_in[12]=044;
   data_in[13]=045;
   data_in[14]=046;
   data_in[15]=047; 
             
   #10
   data_in[0 ]=048;
   data_in[1 ]=049;
   data_in[2 ]=050;
   data_in[3 ]=051;
   data_in[4 ]=052;
   data_in[5 ]=053;
   data_in[6 ]=054;
   data_in[7 ]=055;
   data_in[8 ]=056;
   data_in[9 ]=057;
   data_in[10]=058;
   data_in[11]=059;
   data_in[12]=060;
   data_in[13]=061;
   data_in[14]=062;
   data_in[15]=063; 
             
   #10
   data_in[0 ]=064;
   data_in[1 ]=065;
   data_in[2 ]=066;
   data_in[3 ]=067;
   data_in[4 ]=068;
   data_in[5 ]=069;
   data_in[6 ]=070;
   data_in[7 ]=071;
   data_in[8 ]=072;
   data_in[9 ]=073;
   data_in[10]=074;
   data_in[11]=075;
   data_in[12]=076;
   data_in[13]=077;
   data_in[14]=078;
   data_in[15]=079; 
             
   #10
   data_in[0 ]=080;
   data_in[1 ]=081;
   data_in[2 ]=082;
   data_in[3 ]=083;
   data_in[4 ]=084;
   data_in[5 ]=085;
   data_in[6 ]=086;
   data_in[7 ]=087;
   data_in[8 ]=088;
   data_in[9 ]=089;
   data_in[10]=090;
   data_in[11]=091;
   data_in[12]=092;
   data_in[13]=093;
   data_in[14]=094;
   data_in[15]=095; 
            
   #10
   data_in[0 ]=096;
   data_in[1 ]=097;
   data_in[2 ]=098;
   data_in[3 ]=099;
   data_in[4 ]=100;
   data_in[5 ]=101;
   data_in[6 ]=102;
   data_in[7 ]=103;
   data_in[8 ]=104;
   data_in[9 ]=105;
   data_in[10]=106;
   data_in[11]=107;
   data_in[12]=108;
   data_in[13]=109;
   data_in[14]=110;
   data_in[15]=111; 
             
   #10
   data_in[0 ]= 112;
   data_in[1 ]= 113;
   data_in[2 ]= 114;
   data_in[3 ]= 115;
   data_in[4 ]= 116;
   data_in[5 ]= 117;
   data_in[6 ]= 118;
   data_in[7 ]= 119;
   data_in[8 ]= 120;
   data_in[9 ]= 121;
   data_in[10]= 122;
   data_in[11]= 123;
   data_in[12]= 124;
   data_in[13]= 125;
   data_in[14]= 126;
   data_in[15]= 127; 
               
   #10
   data_in[0 ]=128;
   data_in[1 ]=129;
   data_in[2 ]=130;
   data_in[3 ]=131;
   data_in[4 ]=132;
   data_in[5 ]=133;
   data_in[6 ]=134;
   data_in[7 ]=135;
   data_in[8 ]=136;
   data_in[9 ]=137;
   data_in[10]=138;
   data_in[11]=139;
   data_in[12]=140;
   data_in[13]=141;
   data_in[14]=142;
   data_in[15]=143; 
              
   #10
   data_in[0 ]=144;
   data_in[1 ]=145;
   data_in[2 ]=146;
   data_in[3 ]=147;
   data_in[4 ]=148;
   data_in[5 ]=149;
   data_in[6 ]=150;
   data_in[7 ]=151;
   data_in[8 ]=152;
   data_in[9 ]=153;
   data_in[10]=154;
   data_in[11]=155;
   data_in[12]=156;
   data_in[13]=157;
   data_in[14]=158;
   data_in[15]=159; 
              
   #10        
   data_in[0 ]=160;
   data_in[1 ]=161;
   data_in[2 ]=162;
   data_in[3 ]=163;
   data_in[4 ]=164;
   data_in[5 ]=165;
   data_in[6 ]=166;
   data_in[7 ]=167;
   data_in[8 ]=168;
   data_in[9 ]=169;
   data_in[10]=170;
   data_in[11]=171;
   data_in[12]=172;
   data_in[13]=173;
   data_in[14]=174;
   data_in[15]=175; 
   #10             
   data_in[0 ]=176;
   data_in[1 ]=177;
   data_in[2 ]=178;
   data_in[3 ]=179;
   data_in[4 ]=180;
   data_in[5 ]=181;
   data_in[6 ]=182;
   data_in[7 ]=183;
   data_in[8 ]=184;
   data_in[9 ]=185;
   data_in[10]=186;
   data_in[11]=187;
   data_in[12]=188;
   data_in[13]=189;
   data_in[14]=190;
   data_in[15]=191; 
   #10       
   data_in[0 ]=192;
   data_in[1 ]=193;
   data_in[2 ]=194;
   data_in[3 ]=195;
   data_in[4 ]=196;
   data_in[5 ]=197;
   data_in[6 ]=198;
   data_in[7 ]=199;
   data_in[8 ]=200;
   data_in[9 ]=201;
   data_in[10]=202;
   data_in[11]=203;
   data_in[12]=204;
   data_in[13]=205;
   data_in[14]=206;
   data_in[15]=207;        
   #10       
   data_in[0 ]=208;
   data_in[1 ]=209;
   data_in[2 ]=210;
   data_in[3 ]=211;
   data_in[4 ]=212;
   data_in[5 ]=213;
   data_in[6 ]=214;
   data_in[7 ]=215;
   data_in[8 ]=216;
   data_in[9 ]=217;
   data_in[10]=218;
   data_in[11]=219;
   data_in[12]=220;
   data_in[13]=221;
   data_in[14]=222;
   data_in[15]=223; 
   #10       
   data_in[0 ]=224;
   data_in[1 ]=225;
   data_in[2 ]=226;
   data_in[3 ]=227;
   data_in[4 ]=228;
   data_in[5 ]=229;
   data_in[6 ]=230;
   data_in[7 ]=231;
   data_in[8 ]=232;
   data_in[9 ]=233;
   data_in[10]=234;
   data_in[11]=235;
   data_in[12]=236;
   data_in[13]=237;
   data_in[14]=238;
   data_in[15]=239; 
   #10         
   data_in[0 ]=240;
   data_in[1 ]=241;
   data_in[2 ]=242;
   data_in[3 ]=243;
   data_in[4 ]=244;
   data_in[5 ]=245;
   data_in[6 ]=246;
   data_in[7 ]=247;
   data_in[8 ]=248;
   data_in[9 ]=249;
   data_in[10]=250;
   data_in[11]=251;
   data_in[12]=252;
   data_in[13]=253;
   data_in[14]=254;
   data_in[15]=255; 
 /*  #10      
   data_in[0 ]=256;
   data_in[1 ]=216;
   data_in[2 ]=216;
   data_in[3 ]=216;
   data_in[4 ]=216;
   data_in[5 ]=216;
   data_in[6 ]=216;
   data_in[7 ]=216;
   data_in[8 ]=216;
   data_in[9 ]=216;
   data_in[10]=216;
   data_in[11]=216;
   data_in[12]=216;
   data_in[13]=216;
   data_in[14]=216;
   data_in[15]=216; 
   end */
   end
   always #5 clk <= ~clk;    
      
    
    
endmodule
