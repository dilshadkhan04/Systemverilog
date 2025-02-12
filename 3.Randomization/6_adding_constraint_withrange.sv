class generator;
  
  randc bit [3:0] a,b; //////// either use rand or randc keyword 
  //randc wont generate same values
  bit [3:0] y;
  constraint data {a inside {[0:8],[10:11],15};
                   b inside {[3:11]};} //adding range
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
# KERNEL: Value of a :1 and b: 5
# KERNEL: Value of a :0 and b: 6
# KERNEL: Value of a :5 and b: 10
# KERNEL: Value of a :11 and b: 9
# KERNEL: Value of a :3 and b: 8
# KERNEL: Value of a :11 and b: 5
# KERNEL: Value of a :11 and b: 10
# KERNEL: Value of a :6 and b: 5
# KERNEL: Value of a :3 and b: 4
# KERNEL: Value of a :15 and b: 4