`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2025 15:54:05
// Design Name: 
// Module Name: using_funct
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


module using_funct;

function bit [4:0] add(input bit [3:0] a,b);
return a + b;
endfunction

bit [4:0] res =0;
bit [3:0] ain = 4'b0100;
initial begin
res = add(4'b0100, 4'b0010);
$display("Value of addition : %0d",res);
end
endmodule
