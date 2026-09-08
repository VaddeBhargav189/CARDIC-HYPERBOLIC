`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.08.2026 23:42:42
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top (
        input clk,reset,
         input [15:0] X_in,Y_in,Z_in,
         output [15:0]X_out,Y_out,Z_out
    );
   wire [15:0] X1,X2,X3,X4_1,X4_2,X5,X6,X7,X8,X9,X10,X11,X12,X13_1,X13_2;
    wire [15:0] Y1,Y2,Y3,Y4_1,Y4_2,Y5,Y6,Y7,Y8,Y9,Y10,Y11,Y12,Y13_1,Y13_2;
    wire [15:0] Z1,Z2,Z3,Z4_1,Z4_2,Z5,Z6,Z7,Z8,Z9,Z10,Z11,Z12,Z13_1,Z13_2;
    
    datapath1 datapath1_insta(.clk(clk),.reset(reset),.X_in(X_in),.Y_in(Y_in),.Z_in(Z_in),.X_out(X1),.Y_out(Y1),.Z_out(Z1));
    datapath2 datapath2_insta(.clk(clk),.reset(reset),.X_in(X1),.Y_in(Y1),.Z_in(Z1),.X_out(X2),.Y_out(Y2),.Z_out(Z2));
    datapath3 datapath3_insta(.clk(clk),.reset(reset),.X_in(X2),.Y_in(Y2),.Z_in(Z2),.X_out(X3),.Y_out(Y3),.Z_out(Z3));
    datapath4 datapath4_1_insta(.clk(clk),.reset(reset),.X_in(X3),.Y_in(Y3),.Z_in(Z3),.X_out(X4_1),.Y_out(Y4_1),.Z_out(Z4_1));
    datapath4 datapath4_2_insta(.clk(clk),.reset(reset),.X_in(X4_1),.Y_in(Y4_1),.Z_in(Z4_1),.X_out(X4_2),.Y_out(Y4_2),.Z_out(Z4_2));
    datapath5 datapath5_insta(.clk(clk),.reset(reset),.X_in(X4_2),.Y_in(Y4_2),.Z_in(Z4_2),.X_out(X5),.Y_out(Y5),.Z_out(Z5));
    datapath6 datapath6_insta(.clk(clk),.reset(reset),.X_in(X5),.Y_in(Y5),.Z_in(Z5),.X_out(X6),.Y_out(Y6),.Z_out(Z6));
    datapath7 datapath7_insta(.clk(clk),.reset(reset),.X_in(X6),.Y_in(Y6),.Z_in(Z6),.X_out(X7),.Y_out(Y7),.Z_out(Z7));
    datapath8 datapath8_insta(.clk(clk),.reset(reset),.X_in(X7),.Y_in(Y7),.Z_in(Z7),.X_out(X8),.Y_out(Y8),.Z_out(Z8));
    datapath9 datapath9_insta(.clk(clk),.reset(reset),.X_in(X8),.Y_in(Y8),.Z_in(Z8),.X_out(X9),.Y_out(Y9),.Z_out(Z9));
    datapath10 datapath10_insta(.clk(clk),.reset(reset),.X_in(X9),.Y_in(Y9),.Z_in(Z9),.X_out(X10),.Y_out(Y10),.Z_out(Z10));
    datapath11 datapath11_insta(.clk(clk),.reset(reset),.X_in(X10),.Y_in(Y10),.Z_in(Z10),.X_out(X11),.Y_out(Y11),.Z_out(Z11));
    datapath12 datapath12_insta(.clk(clk),.reset(reset),.X_in(X11),.Y_in(Y11),.Z_in(Z11),.X_out(X12),.Y_out(Y12),.Z_out(Z12));
    datapath13 datapath13_1_insta(.clk(clk),.reset(reset),.X_in(X12),.Y_in(Y12),.Z_in(Z12),.X_out(X13_1),.Y_out(Y13_1),.Z_out(Z13_1));
   datapath13 datapath13_2_insta(.clk(clk),.reset(reset),.X_in(X13_1),.Y_in(Y13_1),.Z_in(Z13_1),.X_out(X13_2),.Y_out(Y13_2),.Z_out(Z13_2));
   datapath14 datapath14_insta(.clk(clk),.reset(reset),.X_in(X13_2),.Y_in(Y13_2),.Z_in(Z13_2),.X_out(X_out),.Y_out(Y_out),.Z_out(Z_out));
endmodule
