//shallow copy

class first;
 
  int data = 12;
 
endclass

class second;

  int ds = 34;
  first f1;
  function new();
    f1 = new();
    
  endfunction
  
endclass


module tb;
  
second s1,s2;
  
  initial begin
    s1 = new();
    s1.ds = 45;
    s2 = new s1; //simplest method to copy s1 into s2
    
    $display("Value of ds :%0d ",s2.ds);
    s2.ds = 78;
    $display("Value of ds :%0d ",s1.ds); // no change will be reflected in data member of s1 if there is change in s2
    
    s2.f1.data = 56; //modified data from copied object
    $display("Value of data :%0d ",s1.f1.data); //In class handler original and copied work on same handler which is the issue in shallow copy
    
  end

endmodule

/*
# KERNEL: Value of ds :45 
# KERNEL: Value of ds :45 
# KERNEL: Value of data :56
  
