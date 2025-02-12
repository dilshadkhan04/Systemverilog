class generator;
  
  rand bit [3:0] a,b; //////// either use rand or randc keyword 
  //randc wont generate same values
  bit [3:0] y;

  
endclass

module tb;
  
  generator g;
  int i =0;
  int status =0;
  
  initial begin
   
    for(int i=0;i<10;i++) begin
      status = g.randomize(); 
      g = new();//Keeping g = new(); inside the loop ensures that a new object is created on each iteration, providing fresh randomization for each cycle. This approach avoids issues with the constraint that would stop randomization when a > 16, ensuring valid random values each time. 
      assert(g.randomize()) else
        begin
          $display("Randomization failed at %0t",$time);
          $finish();
        end
      $display("Value of a : %0d and b: %0d with status : %0d",g.a,g.b,status);
      
     #10;
    end
  end
  
endmodule