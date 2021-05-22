`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/17 15:11:17
// Design Name: 
// Module Name: RCAres
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


module RCAres(a, b, s);
    input [15:0] a, b;
    output [31:0] s;
    (* keep = "true" *) wire [15:0] p [15:0];
    (* keep = "true" *) wire [15:0] res[15:0];
    (* keep = "true" *) wire [15:0] c;
    
    generate
    genvar i;
    for(i = 0; i <= 15; i = i + 1) begin : rca32
        assign p[i] = (b[i] == 1)? a: 16'b0;
        if(i == 0) begin
            assign s[i] = p[0];
            assign res[i] = p[0];
            assign c[i] = 0;
        end else begin
            RCA rca16({c[i-1], res[i-1][15:1]}, p[i], res[i], c[i]);
            assign s[i] = res[i][0];
        end
    end
    endgenerate
    
    assign s[31:16] = {c[15], res[15][15:1]};
    
endmodule
