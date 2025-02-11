//using class in class
class first;

  local int data = 34;//using local to restrict the data to a class
  
  task set(input int data);
    this.data = data; //set the value of data
    endtask
  
  function int get();
    return data;
  endfunction
  
  task display();
    
  $display("Value of data : %0d",data);
    
  endtask

  
endclass


class second;
  
  first f1;
  function new();
    f1 = new();
    
  endfunction
  
endclass

module tb;
  
  second s;
  
  initial begin
    
    s = new();
    s.f1.set(123);
    $display("Value of data : %0d",s.f1.get()); //using get to obtain the data froma restrictive data to a class
  end
  
  endmodule
 
 /*
 # KERNEL: Value of data : 123