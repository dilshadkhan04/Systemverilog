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
       g = new();
    
    $display("SPACE 1");
    g.pre_randomize(3,12);
    for(int i=0;i<6;i++) begin
      g.randomize();
     #10;
    end
      $display("SPACE 2");
    g.pre_randomize(3,12);
    for(int i=0;i<6;i++) begin
        g.randomize();
        #10;
      end
  end
  
endmodule

/*
# KERNEL: SPACE 1
# KERNEL: Value of a : 9 and b : 11
# KERNEL: Value of a : 5 and b : 6
# KERNEL: Value of a : 10 and b : 10
# KERNEL: Value of a : 3 and b : 4
# KERNEL: Value of a : 6 and b : 9
# KERNEL: Value of a : 7 and b : 5
//the value here repeated as space 2 has no effect from space 1
# KERNEL: SPACE 2
# KERNEL: Value of a : 11 and b : 8
# KERNEL: Value of a : 8 and b : 12
# KERNEL: Value of a : 12 and b : 3
# KERNEL: Value of a : 4 and b : 7
# KERNEL: Value of a : 10 and b : 6
# KERNEL: Value of a : 6 and b : 12
