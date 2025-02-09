//Assume class consists of three data
//members a, b, and c each of size 4-bit.
//Create a task inside the class that 
//returns the result of the addition of 
//data members. The task must also be 
//capable of sending the value of a, b, c, 
//and result to the console. Verify code
//for a = 1, b = 2, and c = 4.



class first;
  
   bit [7:0] a;
  bit [7:0] b;
   bit [7:0]  c;
  
  function new(input bit [7:0] a = 0, input bit[7:0] b = 8'h00, input bit [7:0] c = 0);
   this.a = a;
   this.b = b;
   this.c = c;    
  endfunction
  
  task add_print();
    int sum;
    sum = a+b+c;
    $display("Value of a : %0d, b : %0d and c : %0d and sum : %0d",a,b,c,sum); //change done or task added
  endtask
  
endclass
 
 
module tb;
  
  first f1;
  
  initial begin
    //f1 = new(23,,35); ///follow position
    f1 = new( .a(4), .b(5), .c(23)); //follow name
    f1.add_print();  //calling the task 
  end
  
  
endmodule

