//custom method to copy

class first;
  
  int data = 34;
  bit [7:0] temp = 8'h11;
  //custom  copy method
  function first copy();
    copy = new(); //adding a constructor
    copy.data = data; 
  endfunction
 
endclass

module tb;
  
  first f1;
  first f2;
  
  initial begin 
    f1 = new();
    f2 = new();
    
    f2 = f1.copy;
    $display("Data : %0d and TEMP : %0x",f2.data,f2.temp);
  end 
endmodule
  /*
  initial begin
    f1 = new(); //different from custom method its simple one just add new to copy here
    ///////////
    f1.data = 45;
    ///////////
    f2 = new f1; //copy of data from f1 to f2
    ///////////
    f2.data = 56;
    $display("%0d",f2.data);  
    $display("%0d",f1.data); // changing f2 wont change f1 value both are independent
  end/*
  
endmodule


KERNEL: Data : 34 and TEMP : 11