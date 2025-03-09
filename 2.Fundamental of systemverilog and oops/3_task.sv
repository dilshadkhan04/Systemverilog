// Code your testbench here
// or browse Examples
module tb;
// default direction :input
  task add(input bit [3:0] a, input bit [3:0] b, output bit [4:0] y);
y = a+b;

  endtask
  bit [3:0] a,b;
  bit [4:0] y;

initial begin 
a=7;
b=7;
  add(a,b,y);
  $display("Value of Y: %0d",y);
end
endmodule
/*# KERNEL: Value of Y: 14


/* 
// We declared variable prior to task and can ignore the arguement here
module tb;
  bit [3:0] a,b;
  bit [4:0] y;
// default direction :input
  task add();
y = a+b;

  endtask


initial begin 
  a=7;
  b=7;
  add();
  $display("Value of Y: %0d",y);
end


endmodule

