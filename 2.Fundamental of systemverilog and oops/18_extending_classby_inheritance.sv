class first;
  int data = 12;
  function void display();
    $display("Value of data : %0d",data);
  endfunction
endclass

class second extends first; //it extends the first class to second and by default gives access to first
  
  int temp = 34;
  function void add();
  $display("Value after process: %0d",temp+4);
  endfunction
endclass

module tb;
  
  second s;
  
  initial begin
    s = new();
    $display("Value of data : %0d", s.data);
    s.display();
    $display("Value of temp: %0d",s.temp);
    s.add();
    
  end
  
endmodule

/*
# KERNEL: Value of data : 12
# KERNEL: Value of data : 12
# KERNEL: Value of temp: 34
# KERNEL: Value after process: 38
/*