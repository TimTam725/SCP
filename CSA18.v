`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/18 10:44:12
// Design Name: 
// Module Name: CSA
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


module CSA18(c_in, a, b, s, c_out);
    input [17:0] c_in, a, b;
    output [17:0] s, c_out;
    
    generate
    genvar i;
    for (i = 0; i <= 17; i = i + 1) begin : fa17
        FA2 fa(a[i], b[i], c_in[i], s[i], c_out[i]);
    end
    endgenerate
    
endmodule
