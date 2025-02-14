//Create two tasks each capable of sending a message to Console at a fixed 
//interval. Assume Task1 sends the message "Task 1 Trigger" at an interval of 
//20 ns while Task2 sends the message "Task 2 Trigger" at an interval of 40 ns.
// Keep the count of the number of times Task 1 and Task 2 trigger by adding a 
//variable for keeping the track of task execution and incrementing with each trigger. 
//Execute both tasks in parallel till 200 nsec. Display the number of times Task 1 and 
//Task 2 executed after 200 ns before calling $finish for stopping the simulation.


module tb;
    int task1_count = 0;
  int task2_count = 0;
  
  task first();
    forever begin
    #20;
task1_count++;
    $display("Task 1 Trigger at %0t",$time);
    end
  endtask
  
  
  task second();
  forever begin
    #40;
 task2_count++;
    $display("Task 2 Trigger at %0t",$time);
  end
  endtask
  

  initial begin
    fork
    first();
    second();
    join_none 
    
    #200;
    $display("Task 1 executed %0d times", task1_count);
    $display("Task 2 executed %0d times", task2_count);
    $finish;
  end
endmodule


/*
# KERNEL: Task 1 Trigger at 20
# KERNEL: Task 2 Trigger at 40
# KERNEL: Task 1 Trigger at 40
# KERNEL: Task 1 Trigger at 60
# KERNEL: Task 2 Trigger at 80
# KERNEL: Task 1 Trigger at 80
# KERNEL: Task 1 Trigger at 100
# KERNEL: Task 2 Trigger at 120
# KERNEL: Task 1 Trigger at 120
# KERNEL: Task 1 Trigger at 140
# KERNEL: Task 2 Trigger at 160
# KERNEL: Task 1 Trigger at 160
# KERNEL: Task 1 Trigger at 180
# KERNEL: Task 1 executed 9 times
# KERNEL: Task 2 executed 4 times