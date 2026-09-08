`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2026 22:03:33
// Design Name: 
// Module Name: test_bench
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


module test_bench ;
wire signed [15:0] X_out,Y_out,Z_out;
reg signed [15:0] X_in,Y_in,Z_in;
reg clk,reset;
top top(.clk(clk),.reset(reset),.X_in(X_in),.Y_in(Y_in),.Z_in(Z_in),.X_out(X_out),.Y_out(Y_out),.Z_out(Z_out));

   initial begin
        clk = 1'd1;
        reset = 1'd1;
        X_in = 32'sd0;
        Y_in = 32'sd0;
        Z_in = 32'sd0;
        #20 reset = 1'd0;
        X_in = 32'sd218103808;
        Y_in = 32'sd201326592;
        Z_in = 32'sd0;
        
        #10000 $finish;
   end
   
   always #5 clk = ~clk;
endmodule
