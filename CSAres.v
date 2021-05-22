`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/18 10:48:27
// Design Name: 
// Module Name: CSAres
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


module CSAres(a, b, s);
    input [15:0] a, b;
    output [31:0] s;
    (* keep = "true" *) wire [15:0] p [15:0];
    (* keep = "true" *) wire [14:0] res [15:0];
    (* keep = "true" *) wire [14:0] c [15:0];
    (* keep = "true" *) wire [14:0] rcares;
    (* keep = "true" *) wire rca_cout;
    
    generate
    genvar i;
    for(i = 0; i <= 15; i = i + 1) begin : csa32
        assign p[i] = (b[i] == 1)? a: 16'b0;
        if(i == 0) begin
            assign s[i] = p[i];
            assign res[i] = p[i][15:1];
            assign c[i] = 0;
        end else if(i == 1) begin
            CSA csa16(c[i-1], res[i-1], p[i][14:0], res[i], c[i]);
            assign s[i] = res[i][0]; 
        end else begin
            CSA csa16(c[i-1], {p[i-1][15], res[i-1][14:1]}, p[i][14:0], res[i], c[i]);
            assign s[i] = res[i][0];
        end
    end
    endgenerate
    
    RCA15 rca(c[15], {p[15][15], res[15][14:1]}, rcares, rca_cout);
    assign s[30:16] = rcares;
    assign s[31] = rca_cout;
    
endmodule
