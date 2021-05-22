`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/18 15:44:12
// Design Name: 
// Module Name: RCA32
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


module RCA32(a, b, res, c_out);
    input [31:0] a, b;
    output [31:0] res;
    output c_out;
    (* keep = "true" *) wire [31:0] c;
    
    assign c_out = c[31];
    
    generate
    genvar i;
    for (i = 0; i <= 31; i = i + 1) begin : fa31
        if(i == 0)
            HA2 ha(a[i], b[i], res[i], c[i]);
        else
            FA2 fa(a[i], b[i], c[i-1], res[i], c[i]);
    end
    endgenerate
    
endmodule
