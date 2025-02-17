class generator;
  
  int data = 12;
  mailbox mbx; //gen2drv
  
  task run();
    mbx.put(data);
    $display("[GEN] : SENT DATA : %0d",data);
  endtask
  
endclass

class driver;
  
  int data = 0;
  mailbox mbx;
  task run();
    mbx.get(data);
    $display("[DRV] : RCVD Data : %0d",data);
  endtask
endclass

module tb;
  generator gen;
  driver drv;
  mailbox mbx;
  initial begin
    gen = new();
    drv = new();
    mbx = new();
    
    gen.mbx = mbx;
    drv.mbx = mbx;  //we estabished mailbox of gen and drv are same
    gen.run();
    drv.run();
    
  end
  
  
endmodule

/*
# KERNEL: [GEN] : SENT DATA : 12
# KERNEL: [DRV] : RCVD Data : 12