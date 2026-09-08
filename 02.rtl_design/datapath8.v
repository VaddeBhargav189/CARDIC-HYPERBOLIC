`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.08.2026 16:35:39
// Design Name: 
// Module Name: datapath8
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


module datapath8(
     input clk,reset,
     input [15:0] X_in,Y_in,Z_in,
     output reg [15:0] X_out,Y_out,Z_out
    );
    wire [15:0] X,Y;
    assign X = {{9{X_in[15]}},X_in[14:8]};
    assign Y = {{9{Y_in[15]}},Y_in[14:8]};
    
    always@(posedge clk )begin
        if(reset)begin
           X_out<=16'd0;
           Y_out<=16'd0;
           Z_out<=16'd0;
        end
        else begin
        
        // Rotation mode
          /*X_out<=X_in+(Y^{16{Z_in[15]}})+Z_in[15];
          Y_out<=Y_in+(X^{16{Z_in[15]}})+Z_in[15];
          Z_out<=Z_in-(16'd64^{16{Z_in[15]}})-Z_in[15];*/
          
          // Vectoring mode
          X_out<=X_in-(Y^{16{Y_in[15]}})-Y_in[15];
          Y_out<=Y_in-(X^{16{Y_in[15]}})-Y_in[15];
          Z_out<=Z_in+(16'd64^{16{Y_in[15]}})+Y_in[15];
        end
    end
endmodule

