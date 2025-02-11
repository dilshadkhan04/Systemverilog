
// We declared variable prior to task and can ignore the arguement here
module tb;
  bit [3:0] a,b;
  bit [4:0] y;
bit clk =0;
always #5 clk = ~clk;
// default direction :input
  
  task add();
y = a+b;
    $display("a : %0d and b:%0d and y : %0d", a, b, y);
  endtask
  
  task stim_a_b();
a=1;
b=3;
    add();
    #10;
a=5;
b=6;
    add();
    #10;
a=7;
b=8;
    add();
    #10;
  endtask
  
  task stim_clk();
    @(posedge clk); //wait
    a = $urandom;
    b = $urandom;
    add();
  endtask
  
initial begin
#110;
  $finish();
end

initial begin 
  
 //stim_a_b();
  
  for(int i=0;i<11;i++) begin
    stim_clk();
  end
end


endmodule

/*
# KERNEL: a : 3 and b:11 and y : 14
# KERNEL: a : 11 and b:3 and y : 14
# KERNEL: a : 4 and b:9 and y : 13
# KERNEL: a : 15 and b:15 and y : 30
# KERNEL: a : 4 and b:1 and y : 5
# KERNEL: a : 10 and b:12 and y : 22
# KERNEL: a : 11 and b:9 and y : 20
# KERNEL: a : 5 and b:15 and y : 20
# KERNEL: a : 11 and b:13 and y : 24
# KERNEL: a : 14 and b:9 and y : 23
# KERNEL: a : 8 and b:3 and y : 11