class transaction;
  rand bit [3:0] din1;
  rand bit [3:0] din2;
  bit [4:0]dout;
  
endclass

class generator;
  
  transaction t;
  mailbox mbx;
  
  function new(mailbox mbx);
    this.mbx = mbx;
  endfunction
  task main();
  for(int i=0; i<10;i++) begin
    t = new();
    assert(t.randomize) else $display("Randomization Failed");
    $display("[GEN] : DATA SENT : din1 : %0d and din2 : %0d",t.din1,t.din2);
    mbx.put(t);
    #10;
    
  end
  endtask
endclass
  
  class driver;
    
    transaction dc;
    mailbox mbx;
    
     function new(mailbox mbx);
    this.mbx = mbx;
  endfunction
    
    task main();
    forever begin
      mbx.get(dc);
      $display("[DRV} : DATA RCVD din : %0d and din2 : %0d",dc.din1,dc.din2 );
    end
    endtask
    
  endclass
  
  
  
  module tb;
    
 generator g;
    driver d;
    mailbox mbx;
   initial begin
     mbx = new();
     g = new(mbx);
     d = new(mbx);
     
    fork
      g.main();
      d.main();
    join
     end
    
  endmodule
  
  /*
  # KERNEL: [GEN] : DATA SENT : din1 : 4 and din2 : 10
# KERNEL: [DRV} : DATA RCVD din : 4 and din2 : 10
# KERNEL: [GEN] : DATA SENT : din1 : 1 and din2 : 5
# KERNEL: [DRV} : DATA RCVD din : 1 and din2 : 5
# KERNEL: [GEN] : DATA SENT : din1 : 7 and din2 : 14
# KERNEL: [DRV} : DATA RCVD din : 7 and din2 : 14
# KERNEL: [GEN] : DATA SENT : din1 : 14 and din2 : 1
# KERNEL: [DRV} : DATA RCVD din : 14 and din2 : 1
# KERNEL: [GEN] : DATA SENT : din1 : 12 and din2 : 3
# KERNEL: [DRV} : DATA RCVD din : 12 and din2 : 3
# KERNEL: [GEN] : DATA SENT : din1 : 6 and din2 : 3
# KERNEL: [DRV} : DATA RCVD din : 6 and din2 : 3
# KERNEL: [GEN] : DATA SENT : din1 : 14 and din2 : 14
# KERNEL: [DRV} : DATA RCVD din : 14 and din2 : 14
# KERNEL: [GEN] : DATA SENT : din1 : 8 and din2 : 15
# KERNEL: [DRV} : DATA RCVD din : 8 and din2 : 15
# KERNEL: [GEN] : DATA SENT : din1 : 15 and din2 : 9
# KERNEL: [DRV} : DATA RCVD din : 15 and din2 : 9
# KERNEL: [GEN] : DATA SENT : din1 : 15 and din2 : 10
# KERNEL: [DRV} : DATA RCVD din : 15 and din2 : 10