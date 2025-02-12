// Code your testbench here
// or browse Examples
class first;
  
rand bit wr;
  rand bit rd;
  rand bit [1:0] var1;
  rand bit [2:0] var2;
  
  constraint data {
    var1 dist{0:= 30, [1:3]:=70};
    var2 dist{0 :/ 30, [1:3]:/90};
  
  }
  
  constraint cntrl {
     
    wr dist {0 := 30 , 1 := 70}; //probability of 0 is 30 and 1 is 70 
    rd dist {0:/ 30 , 1:/ 70};
  }
  
  
endclass


module tb;
  
  first f;
  initial begin
    f = new();
    for(int i=0;i<10;i++) begin
      f.randomize();
      //$display("Value of wr : %0d and rd : %0d",f.wr,f.rd);
      $display("Value of var1(:=) : %0d and var2(:/) : %0d",f.var1,f.var2);//Increasing number of iteration will give more clear probability 
    end
    
  end
  
endmodule

/*# KERNEL: Value of var1(:=) : 0 and var2(:/) : 1
# KERNEL: Value of var1(:=) : 2 and var2(:/) : 0
# KERNEL: Value of var1(:=) : 1 and var2(:/) : 1
# KERNEL: Value of var1(:=) : 0 and var2(:/) : 2
# KERNEL: Value of var1(:=) : 1 and var2(:/) : 2
# KERNEL: Value of var1(:=) : 0 and var2(:/) : 1
# KERNEL: Value of var1(:=) : 2 and var2(:/) : 1
# KERNEL: Value of var1(:=) : 2 and var2(:/) : 1
# KERNEL: Value of var1(:=) : 0 and var2(:/) : 2
# KERNEL: Value of var1(:=) : 3 and var2(:/) : 1