module tb;
  int i =0;
  bit [7:0] data1,data2;
  event done;
  event next;
  
  task generator();   
   for(i = 0; i<10; i++) begin  
      data1 = $urandom();
      $display("Data Sent : %0d", data1);
     #10;
    
     wait(next.triggered);
     
    end
    
   -> done; 
  endtask
  
  
  
  task receiver();
     forever begin
       #10;
      data2 = data1;
      $display("Data RCVD : %0d",data2);
      ->next; 
    end
   
  endtask
  
  
  
  
  task wait_event();
     wait(done.triggered);
    $display("Completed Sending all Stimulus");
     $finish();
  endtask
  
  
  
 initial begin
    fork
      generator();
      receiver();
      wait_event();
    join 
   
   ///////
     
  end
  
  
endmodule

/* //extra data recieved and sent issue was solved as compared to earlier
# KERNEL: Data Sent : 167
# KERNEL: Data RCVD : 167
# KERNEL: Data Sent : 220
# KERNEL: Data RCVD : 220
# KERNEL: Data Sent : 248
# KERNEL: Data RCVD : 248
# KERNEL: Data Sent : 81
# KERNEL: Data RCVD : 81
# KERNEL: Data Sent : 94
# KERNEL: Data RCVD : 94
# KERNEL: Data Sent : 101
# KERNEL: Data RCVD : 101
# KERNEL: Data Sent : 180
# KERNEL: Data RCVD : 180
# KERNEL: Data Sent : 205
# KERNEL: Data RCVD : 205
# KERNEL: Data Sent : 227
# KERNEL: Data RCVD : 227
# KERNEL: Data Sent : 151
# KERNEL: Data RCVD : 151