class first;  ///parent class
  
  int data = 12;
  
  virtual function void display(); // using virtual here lets the child class to give data during f.display at tb
     $display("FIRST : Value of data : %0d", data);
  endfunction
  
 
  
endclass
 
 
class second extends first; //child class
  
  int temp = 34;
  
  function void add();
    $display("secomd:Value after process : %0d", temp+4);
  endfunction
  
 
  function void display();
    $display("SECOND : Value of data : %0d", data);
  endfunction
 
  
  
  
endclass
 
 
module tb;
  
  first f;
  second s;
  
  
  initial begin
    f = new();
    s = new();
    
    f = s;
    f.display();
    
  end
  
 
  
endmodule

/*
# KERNEL: SECOND : Value of data : 12

//If virtual is not used
# KERNEL: FIRST : Value of data : 12