class first;  ///parent class
  
  int data;
  
  function new(input int data);
    this.data = data;
    
  endfunction
  
endclass
 
 
class second extends first; //child class
  
  int temp;
  function new(int data, int temp); //custom constructor
    super.new(data);
    this.temp = temp;
  endfunction
 
endclass
 
 
module tb;
  
second s;
  initial begin
  
    s = new(67,45);
    $display("value of data : %0d and temp : %0d",s.data,s.temp);
    
  end
  
endmodule

/*
# KERNEL: value of data : 67 and temp : 45