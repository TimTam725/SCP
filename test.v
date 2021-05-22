`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/15 16:17:08
// Design Name: 
// Module Name: test
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


module test(a, b ,s);
    input [15:0] a, b;
    output [15:0] s;
    
    assign s = {1'b1, a[15:1]};
//    assign k = a << 2;
//    assign c = a[27:0] << 2;
//    assign b = {4'b1010, a[27:0] << 2}; 
    
endmodule
