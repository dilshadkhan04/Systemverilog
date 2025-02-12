class generator;
  
  rand bit [3:0] a,b; //////// either use rand or randc keyword 
  //randc wont generate same values
  bit [3:0] y;
  constraint data {a>16;} //this stops randomization
  
endclass

module tb;
  
  generator g;
  int i =0;
  int status =0;
  
  initial begin
    g = new();
    for(int i=0;i<10;i++) begin
      status = g.randomize(); 
      /*
      if(!g.randomize()) begin
        $display("Randomization failed at %0t",$time);
        $finish(); //if randomization fail it will not move forward
      end
      */
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


/*# KERNEL: Randomization failed at 0