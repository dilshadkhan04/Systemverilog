`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2025 01:59:32
// Design Name: 
// Module Name: fundamental_class1
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


class first;

reg[2:0] data;
reg [1:0] data2;

endclass

module fundamental_class1;
first f; // f is handler just like uut or dut in verilog
initial begin
f = new(); //constructor (create an object)
f.data = 3'b010;
f.data2 = 2'b10;
f = null; // delete an object
#1;
$display("value of data:%0d and data2 :%0d",f.data,f.data2);

end
endmodule
//Create a Class consisting of 3 