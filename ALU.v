`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/06 12:48:42
// Design Name: 
// Module Name: ALU
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


module ALU(a, b, sm, sa, sb, c_in, op, result, c_out);
    input a, b, sm, sa, sb, c_in;
    input [1:0] op;
    output reg result;
    //output��wire�Ƃ��Đ錾���ĂĂ�always���̒��ł�register�ɂ�������ł��Ȃ����疳��
    output c_out;
    (* keep = "true" *) wire A, B;
    
    assign A = (sa)? ~a: a;
    assign B = (sb)? ~b: b;
    assign c_out = (A & B) | (B & c_in) | (c_in & A);
    
    always@(A, B, sm, c_in, op) begin
        case(op)
         2'b00 : result <= A & B;
         2'b01 : result <= A | B;
         2'b10 : result <= A ^ B ^ c_in;
         2'b11 : result <= sm;
        default : result <= 0;
        endcase
    end
    
endmodule
