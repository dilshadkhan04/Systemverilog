//Create a deep copy of the Generator class. To verify the deep copy code assign value of the copy method 
//to another instance of the generator class in TB top. Print the value of data members in the generator 
//class as well as copied class. Refer Instruction tab for Generator class code.

class generator;
  
  bit [3:0] a = 5,b =7;
  bit wr = 1;
  bit en = 1;
  bit [4:0] s = 12;
    function generator copy();
    copy = new();
    copy.a =  this.a;
    copy.b =  this.b;
    copy.wr=  this.wr;
    copy.en=  this.en;
    copy.s =  this.s;
    endfunction
  function void display();
    $display("a:%0d b:%0d wr:%0b en:%0b s:%0d", a,b,wr,en,s);
  endfunction

endclass

class second;
  generator g1;
  function new();
    g1 = new(); // Initialize g1 to avoid null pointer issues
  endfunction
  
   function second copy();
    copy = new();
    copy.g1 = g1.copy();  // Perform deep copy of g1
  endfunction

endclass

module tb;
  second s1,s2;
  initial begin
  s1 = new();
  s2 = new();
  s2 = s1.copy();
  s2.g1.wr = 0;
    $display("Value of wr: %0d",s2.g1.wr);
    $display("Value of wr: %0d",s1.g1.wr);
s2.g1.a = 78;
    $display("Value of a: %0d",s2.g1.a);
    $display("Value of a: %0d",s1.g1.a);
s2.g1.b = 18;
    $display("Value of b: %0d",s2.g1.b);
    $display("Value of b: %0d",s1.g1.b);
s2.g1.en = 0;
    $display("Value of en: %0d",s2.g1.en);
    $display("Value of en: %0d",s1.g1.en);
s2.g1.s = 10;
    $display("Value of s: %0d",s2.g1.s);
    $display("Value of s: %0d",s1.g1.s);
  end
    endmodule

/*
# KERNEL: Value of wr: 0
# KERNEL: Value of wr: 1
# KERNEL: Value of a: 14
# KERNEL: Value of a: 5
# KERNEL: Value of b: 2
# KERNEL: Value of b: 7
# KERNEL: Value of en: 0
# KERNEL: Value of en: 1
# KERNEL: Value of s: 10
# KERNEL: Value of s: 12
# KERNEL: Simulation has 