class generator;
  
  randc bit [3:0] a,b; //////// either use rand or randc keyword 
  //randc wont generate same values
  bit [3:0] y;
  constraint data {
    !(a inside {[3:7]});
    !(b inside {[5:9]});
  
  }//skip range of values
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
# KERNEL: Value of a :9 and b: 11
# KERNEL: Value of a :0 and b: 14
# KERNEL: Value of a :13 and b: 15
# KERNEL: Value of a :12 and b: 1
# KERNEL: Value of a :9 and b: 15
# KERNEL: Value of a :1 and b: 3
# KERNEL: Value of a :8 and b: 4
# KERNEL: Value of a :14 and b: 13
# KERNEL: Value of a :11 and b: 2
# KERNEL: Value of a :9 and b: 4