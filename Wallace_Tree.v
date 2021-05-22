`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/18 14:37:44
// Design Name: 
// Module Name: Wallace_Tree
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


module Wallace_Tree(a, b, s);
    input [15:0] a, b;
    output [31:0] s;
    //1 段目
    (* keep = "true" *) wire [17:0] res1 [4:0];
    (* keep = "true" *) wire [17:0] c1 [4:0];
    (* keep = "true" *) wire [15:0] p [14:0];
    //2 段目
    (* keep = "true" *) wire [20:0] res2 [2:0];
    (* keep = "true" *) wire [20:0] c2 [2:0];
    //3 段目
    (* keep = "true" *) wire [24:0] res31, c31;
    (* keep = "true" *) wire [25:0] res32, c32;
    //4 段目
    (* keep = "true" *) wire [25:0] res41, c41;
    (* keep = "true" *) wire [31:0] res42, c42;
    //5 段目
    (* keep = "true" *) wire [31:0] res5, c5;
    //6 段目
    (* keep = "true" *) wire [31:0] res6, c6;
    
    generate
    genvar i;
    for (i = 0; i <= 14; i = i + 1) begin : p16
        assign p[i] = (b[i])? a: 0;
    end
    endgenerate
    
    //1 段目
    CSA18 csa181({2'b00, p[0]}, {1'b0, p[1], 1'b0}, {p[2], 2'b00}, res1[0], c1[0]);
    CSA18 csa182({2'b00, p[3]}, {1'b0, p[4], 1'b0}, {p[5], 2'b00}, res1[1], c1[1]);
    CSA18 csa183({2'b00, p[6]}, {1'b0, p[7], 1'b0}, {p[8], 2'b00}, res1[2], c1[2]);
    CSA18 csa184({2'b00, p[9]}, {1'b0, p[10], 1'b0}, {p[11], 2'b00}, res1[3], c1[3]);
    CSA18 csa185({2'b00, p[12]}, {1'b0, p[13], 1'b0}, {p[14], 2'b00}, res1[4], c1[4]);
    
    //2 段目
    CSA21 csa211({2'b00, c1[0], 1'b0}, {3'b000, res1[0]}, {res1[1], 3'b000}, res2[0], c2[0]);
    CSA21 csa212({3'b00, c1[1]}, {c1[2], 3'b000}, {1'b0, res1[2], 2'b00}, res2[1], c2[1]);
    CSA21 csa213({2'b00, c1[3], 1'b0}, {3'b000, res1[3]}, {res1[4], 3'b000}, res2[2], c2[2]);
    
    //3 段目
    CSA25 csa251({3'b000, c2[0], 1'b0}, {4'b0000, res2[0]}, {res2[1], 4'b0000}, res31, c31);
    CSA26 csa261({5'b00000, c2[1]}, {c2[2], 5'b00000}, {1'b0, res2[2], 4'b0000}, res32, c32);
    
    //4 段目
    CSA26 csa262(c32, {1'b0, c1[4], 7'b0000000}, {1'b0, p[14], 9'b000000000}, res41, c41);
    CSA31 csa311({6'b000000, c31, 1'b0}, {7'b0000000, res31}, {1'b0, res32, 5'b00000}, res42, c42);
    
    //5 段目
    CSA31 csa312({c42[30:0], 1'b0}, res42, {res41, 6'b000000}, res5, c5);
    
    //6 段目
    CSA31 csa313({c5[30:0], 1'b0}, res5, {c41[24:0], 7'b0000000}, res6, c6);
    
    //7 段目
    RCA32 rca32({c6[30:0] , 1'b0}, res6, s,);
    
endmodule
