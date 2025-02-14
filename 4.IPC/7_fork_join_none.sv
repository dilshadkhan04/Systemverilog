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
    join_none //Here it will not wait for the task 1 and 2 to execute so that third is executed
    
    third();
  end
endmodule

/*
# KERNEL: Reached next to join at 0
# KERNEL: Task 1 started at 0
# KERNEL: Task 2 started at 0
# KERNEL: Task 1 completed at 20
# KERNEL: Task 2 completed at 30