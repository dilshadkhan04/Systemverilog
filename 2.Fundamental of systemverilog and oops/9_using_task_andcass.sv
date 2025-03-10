class first;
  
  int data1;
  bit [7:0] data2;
  shortint data3;
  
  function new(input int data1 = 0, input bit[7:0] data2 = 8'h00, input shortint data3 = 0);
   this.data1 = data1;
   this.data2 = data2;
   this.data3 = data3;    
  endfunction
  
  task display();
  $display("Value of Data1 : %0d, Data2 : %0d and Data3 : %0d",data1,data2,data3); //change done or task added
  endtask
  
endclass
 
 
module tb;
  
  first f1;
  
  initial begin
    //f1 = new(23,,35); ///follow position
    f1 = new( .data2(4), .data3(5), .data1(23)); //follow name
    f1.display();  //calling the task 
  end
  
  
endmodule

/*
# KERNEL: Value of Data1 : 23, Data2 : 4 and Data3 : 5