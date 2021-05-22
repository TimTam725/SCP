`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2018/04/20 16:41:15
// Design Name:
// Module Name: INST_MEM
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


module INST_MEM(r_address, r_data);
    input  [31:0] r_address;
    output [31:0] r_data;
    reg [7:0] inst_mem [255:0]; 

    integer i;
    initial begin
		  for (i = 32; i <= 255; i = i + 1) begin
				inst_mem[i] <= 8'h0;
          end
          
          //乗算器を使った乗算命令
//          {inst_mem[0],  inst_mem[1],  inst_mem[2],  inst_mem[3]}    <= 32'b100011_11111_00001_0000000000000001;   //  0 : lw  $1, 1(M)     : $1 = M[1] (=  2)　
//		  {inst_mem[4],  inst_mem[5],  inst_mem[6],  inst_mem[7]}    <= 32'b100011_11111_00010_0000000000000010;   //  4 : lw  $2, 2(M)     : $2 = M[2] (= 11)
//		  {inst_mem[8],  inst_mem[9],  inst_mem[10], inst_mem[11]}   <= 32'b000000_00010_00001_00010_00000_100001; //  8 : mul $2, $2, $1   : $2 = $2*$1 (= 22)
//		  {inst_mem[12], inst_mem[13], inst_mem[14], inst_mem[15]}   <= 32'b101011_11111_00010_0000000000000011;   //  12 : sw  $2, 3(M)     : M[3] = $3

          //加算器を使った乗算命令
//          {inst_mem[0],  inst_mem[1],  inst_mem[2],  inst_mem[3]}    <= 32'b100011_11111_00100_0000000000000100;   //  0 : lw  $4, 0(M)     : $4 = M[0] (=  0) 結果
//          {inst_mem[4],  inst_mem[5],  inst_mem[6],  inst_mem[7]}    <= 32'b100011_11111_00001_0000000000000001;   //  4 : lw  $1, 1(M)     : $1 = M[1] (=  1)　
//		  {inst_mem[8],  inst_mem[9],  inst_mem[10], inst_mem[11]}   <= 32'b100011_11111_00010_0000000000000010;   //  8 : lw  $2, 2(M)     : $2 = M[2] (=  3) 被乗数
//		  {inst_mem[12], inst_mem[13], inst_mem[14], inst_mem[15]}   <= 32'b100011_11111_00011_0000000000000011;   // 12 : lw  $3, 3(M)     : $3 = M[3] (=  2) 乗数 != 0
//		  {inst_mem[16], inst_mem[17], inst_mem[18], inst_mem[19]}   <= 32'b000100_00011_11111_0000000000000011;   // 16 : beq $3, M, 1     : if M == $2 then PC = 20 + 12 else PC = 20		 
//		  {inst_mem[20], inst_mem[21], inst_mem[22], inst_mem[23]}   <= 32'b000000_00011_00001_00011_00000_100010; // 20 : sub $3, $3, $1   : $3 -= $1
//		  {inst_mem[24], inst_mem[25], inst_mem[26], inst_mem[27]}   <= 32'b000000_00100_00010_00100_00000_100000; // 24 : add $4, $4, $2   : $4 += $2
//		  {inst_mem[28], inst_mem[29], inst_mem[30], inst_mem[31]}   <= 32'b000010_00000000000000000000000100;     // 28 : jump 16           : PC = 16
//		  {inst_mem[32], inst_mem[33], inst_mem[34], inst_mem[35]}   <= 32'b101011_11111_00100_0000000000000100;   // 32 : sw  $4, 4(M)     : M[4] = $4

//													 // PC : Instruction 　　 : Meaning
		  {inst_mem[0],  inst_mem[1],  inst_mem[2],  inst_mem[3]}    <= 32'b100011_11111_00001_0000000000000001;   //  0 : lw  $1, 1(M)     : $1 = M[1] (=  1)　
		  {inst_mem[4],  inst_mem[5],  inst_mem[6],  inst_mem[7]}    <= 32'b100011_11111_00010_0000000000000010;   //  4 : lw  $2, 2(M)     : $2 = M[2] (= 11)
		  {inst_mem[8],  inst_mem[9],  inst_mem[10], inst_mem[11]}   <= 32'b100011_11111_00011_0000000000000011;   //  8 : lw  $3, 3(M)     : $3 = M[3] (=  0)
		  {inst_mem[12], inst_mem[13], inst_mem[14], inst_mem[15]}   <= 32'b000000_00010_00001_00010_00000_100010; // 12 : sub $2, $2, $1   : $2 -= $1　R形式
		  {inst_mem[16], inst_mem[17], inst_mem[18], inst_mem[19]}   <= 32'b000000_00011_00010_00011_00000_100000; // 16 : add $3, $3, $2   : $3 += $2
		  {inst_mem[20], inst_mem[21], inst_mem[22], inst_mem[23]}   <= 32'b000100_00010_11111_0000000000000001;   // 20 : beq $2, M, 1     : if M == $2 then PC = 24 + 4 else PC = 24
		  {inst_mem[24], inst_mem[25], inst_mem[26], inst_mem[27]}   <= 32'b000010_00000000000000000000000011;     // 24 : jump 3           : PC = 12
		  {inst_mem[28], inst_mem[29], inst_mem[30], inst_mem[31]}   <= 32'b101011_11111_00011_0000000000000011;   // 28 : sw  $3, 3(M)     : M[3] = $3
//													 // Result: M[3] = 10 + 9 + ... + 1 = 55 = 32'h37
    end

    assign r_data = {inst_mem[r_address], inst_mem[r_address+1], inst_mem[r_address+2], inst_mem[r_address+3]};
endmodule
