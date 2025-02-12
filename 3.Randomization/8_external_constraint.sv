class generator;
  
  randc bit [3:0] a,b; //////// either use rand or randc keyword 
  
  bit [3:0] y;
  extern constraint data;  //in external constraint we add semicolon at end
  extern function void display();
endclass
    
constraint generator::data {
  a inside{[0:3]};
  b inside{[12:15]};
};
    function void generator::display(); //:: scope operator
      $display("Value of a : %0d and b : %0d",a,b);
    endfunction
      
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
# KERNEL: Value of a :3 and b: 14
# KERNEL: Value of a :1 and b: 12
# KERNEL: Value of a :2 and b: 13
# KERNEL: Value of a :0 and b: 14
# KERNEL: Value of a :1 and b: 12
# KERNEL: Value of a :3 and b: 14
# KERNEL: Value of a :0 and b: 14
# KERNEL: Value of a :0 and b: 13
# KERNEL: Value of a :1 and b: 12
# KERNEL: Value of a :2 and b: 15