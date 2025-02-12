//pre randomize 
//post randomize

class generator;
  
  randc bit [3:0] a,b; //////// either use rand or randc keyword 
  
  bit [3:0] y;
  int min;
  int max;
  
  function void pre_randomize(input int min, input int max);
  
    this.min = min;
    this.max = max;
    
  endfunction
  
  constraint data{
    a inside{[min:max]};
    b inside{[min:max]};
  
  }
  function void post_randomize();
    
    $display("Value of a : %0d and b : %0d",a,b);
    
  endfunction
  
endclass
    

      
module tb;
  
  generator g;
  int i =0;

  
  initial begin
   
    for(int i=0;i<10;i++) begin
      
      g = new();
      g.pre_randomize(3,8);
      g.randomize();

      
     #10;
    end
  end
  
endmodule

/*
# KERNEL: Value of a : 5 and b : 5
# KERNEL: Value of a : 4 and b : 6
# KERNEL: Value of a : 5 and b : 4
# KERNEL: Value of a : 3 and b : 5
# KERNEL: Value of a : 3 and b : 4
# KERNEL: Value of a : 3 and b : 5
# KERNEL: Value of a : 3 and b : 4
# KERNEL: Value of a : 6 and b : 5
# KERNEL: Value of a : 3 and b : 6
# KERNEL: Value of a : 7 and b : 6