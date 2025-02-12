class generator;
  
  rand bit [3:0] a,b; //////// either use rand or randc keyword 
  //randc wont generate same values
  bit [3:0] y;
  constraint data_a {a > 3; a < 7;}//internal constraint for data signal a
  constraint data_b{b == 3;}
endclass

module tb;
  
  generator g;
  int i =0;

  
  initial begin
   
    for(int i=0;i<10;i++) begin
      
      g = new();
      g.randomize();
      $display("Value of a :%0d and b: %0d", g.a,g.b);

      
     #10;
    end
  end
  
endmodule

/*
# KERNEL: Value of a :5 and b: 3
# KERNEL: Value of a :4 and b: 3
# KERNEL: Value of a :6 and b: 3
# KERNEL: Value of a :4 and b: 3
# KERNEL: Value of a :4 and b: 3
# KERNEL: Value of a :4 and b: 3
# KERNEL: Value of a :4 and b: 3
# KERNEL: Value of a :6 and b: 3
# KERNEL: Value of a :5 and b: 3
# KERNEL: Value of a :5 and b: 3