module tb;
  
  
  task first();
    $display("Task 1 started at %0t",$time);
    #20;
    $display("Task 1 completed at %0t",$time);
    
  endtask
  
  
  task second();
    $display("Task 2 started at %0t",$time);
    #30;
    $display("Task 2 completed at %0t",$time);
    
  endtask
  
  
  task third();
    $display("Reached next to join at %0t",$time);
    
  endtask
  initial begin
    fork
    first();
    second();
    join
    
    third();
  end
endmodule

/*
# KERNEL: Task 1 started at 0
# KERNEL: Task 2 started at 0
# KERNEL: Task 1 completed at 20
# KERNEL: Task 2 completed at 30
# KERNEL: Reached next to join at 30