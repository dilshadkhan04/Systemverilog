//design code

module dff (dff_if vif);
 
  // Always block triggered on the positive edge of the clock signal
  always @(posedge vif.clk)
    begin
      // Check if the reset signal is asserted
      if (vif.rst == 1'b1)
        // If reset is active, set the output to 0
        vif.dout <= 1'b0;
      else
        // If reset is not active, pass the input value to the output
        vif.dout <= vif.din;
    end
  
endmodule
 
// Define an interface "dff_if" with the following signals
interface dff_if;
  logic clk;   // Clock signal
  logic rst;   // Reset signal
  logic din;   // Data input
  logic dout;  // Data output
  
endinterface


//Testbench
class transaction;
   
  rand bit din;
  bit dout;
  
  function transaction copy();
    copy = new();
    copy.din = this.din;
    copy.dout = this.dout;
  endfunction
  
  function void display(input string tag);
    $display("[%0s] DIN : %0b DOUT : %0b ", tag,din,dout);
  endfunction
endclass

////////////////////////////////////////////////
class generator;
transaction tr;
  mailbox #(transaction) mbx;// sends data to driver
  mailbox #(transaction) mbxref; //Sends data to scoreboard for comparision
  event sconext; //sense completion of scoreboard work
  event done; // Trigger once requested number of stimulus is applied
  int count; //stimulus count
  
  // A custom constructor
  function new(mailbox#(transaction) mbx, mailbox#(transaction) mbxref);
this.mbx = mbx;
this.mbxref = mbxref;
    tr = new();
  endfunction
  
  task run();
    repeat(count) begin
      assert(tr.randomize) else $error("[GEN] : Randomization Failed");
      mbx.put(tr.copy);
      mbxref.put(tr.copy);
      tr.display("[GEN]");
      @(sconext);
      
    end
                 ->done;
                 endtask
                 
                 endclass
////////////////////////////////////////////////
class driver;                 
   transaction tr;
  mailbox #(transaction) mbx;
  virtual dff_if vif;

  function new(mailbox #(transaction) mbx);
    this.mbx = mbx; // Initialize the mailbox for receiving data
  endfunction
    
    task reset();
      vif.rst <= 1'b1;
      repeat(5) @(posedge vif.clk);
      vif.rst <= 1'b0;
      @(posedge vif.clk);
      $display("[DRV] : Reser Done");
    endtask
    
    task run();
      forever begin
        mbx.get(tr);
        vif.din <= tr.din;
        @(posedge vif.clk);
        tr.display("DRV");
		vif.din <= 1'b0;
        @(posedge vif.clk);
      end
    endtask
    endclass
    
////////////////////////////////////////////////
class monitor;
  
  transaction tr;
  mailbox#(transaction) mbx;
  virtual dff_if vif;
// custom constructor we are expecting a mailbox that would work between monitor & scoreboard 
  function new(mailbox#(transaction)mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    tr = new();
    forever begin
      repeat(2)@(posedge vif.clk); //2 as we have 2 clock tick wait in driver
      tr.dout = vif.dout; //store data in respective data member of transaction
      //since transaction class is objected oriented we are using simple = operator(there is nothing like blocking or non blocking in oop)
      mbx.put(tr); // call put method and send this data to scoreboard
      tr.display("NOW");
    end
  endtask
  
  endclass
    
////////////////////////////////////////////////
class scoreboard;
  
  transaction tr;
  transaction trref;
  mailbox #(transaction) mbx;
  mailbox #(transaction) mbxref;
  event sconext;
  
  function new(mailbox #(transaction) mbx, mailbox #(transaction) mbxref);
this.mbx = mbx;
    this.mbxref = mbxref;
  endfunction
  
  task run();
    forever begin
      
      mbx.get(tr);
      mbxref.get(trref);
      tr.display("SCO");
      trref.display("REF");
      if(tr.dout == trref.din)
        $display("[SCO] : DATA MATCHED");
      else
        $display("[SCO] : DATA MISMATCHED");
                 $display("-------------------------------");
                 ->sconext;    
    end
  endtask
endclass
 
///////////////////////////////////////////////////                 
  
class environment;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard sco;
  
  event next; /// gen -> sco
  
  mailbox #(transaction) gdmbx; // Mailbox for communication between generator and driver
  mailbox #(transaction) msmbx; // Mailbox for communication between monitor and scoreboard
  mailbox #(transaction) mbxref; // Mailbox for communication between generator and scoreboard
  
  virtual dff_if vif;
  
  function new(virtual dff_if vif);
    
    gdmbx = new();
    mbxref = new();
    
    gen = new(gdmbx,mbxref); // two mailboxes one works between generator and driver(gdmbx) other works between gen and scorbrd
    drv = new(gdmbx); //works btw gen and drv
    
    msmbx = new();
    mon = new(msmbx); //works btw mon and sco
    sco = new(msmbx,mbxref); //mon - sco and gen - sco
    
    this.vif = vif;
    drv.vif = this.vif;
    mon.vif = this.vif;
    
    gen.sconext = next;
    sco.sconext = next;
    
  endfunction
  
  task pre_test();
    drv.reset();
  endtask
  
  task test();
    fork
      
      gen.run();
      drv.run();
      mon.run();
      sco.run();
      
    join_any
  endtask
  
  task post_test();
    wait(gen.done.triggered);
    $finish();
  endtask
  
  task run();
    pre_test();
    test();
    post_test();
  endtask
    
endclass
////////////////////////////////////////////////

module tb;
  
  dff_if vif();
  
  dff dut(vif);
  
  initial begin
    vif.clk <= 0;
  end
  
  always #10 vif.clk <= ~vif.clk;
  
  environment env;
  
 initial begin
    env = new(vif); // Initialize the environment with the DUT interface
    env.gen.count = 30; // Set the generator's stimulus count
    env.run(); // Run the environment
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule

/* # KERNEL: [DRV] : Reser Done
# KERNEL: [[GEN]] DIN : 1 DOUT : 0 
# KERNEL: [DRV] DIN : 1 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 1 
# KERNEL: [SCO] DIN : 0 DOUT : 1 
# KERNEL: [REF] DIN : 1 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 0 DOUT : 0 
# KERNEL: [DRV] DIN : 0 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 0 
# KERNEL: [SCO] DIN : 0 DOUT : 0 
# KERNEL: [REF] DIN : 0 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 0 DOUT : 0 
# KERNEL: [DRV] DIN : 0 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 0 
# KERNEL: [SCO] DIN : 0 DOUT : 0 
# KERNEL: [REF] DIN : 0 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 0 DOUT : 0 
# KERNEL: [DRV] DIN : 0 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 0 
# KERNEL: [SCO] DIN : 0 DOUT : 0 
# KERNEL: [REF] DIN : 0 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 1 DOUT : 0 
# KERNEL: [DRV] DIN : 1 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 1 
# KERNEL: [SCO] DIN : 0 DOUT : 1 
# KERNEL: [REF] DIN : 1 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 0 DOUT : 0 
# KERNEL: [DRV] DIN : 0 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 0 
# KERNEL: [SCO] DIN : 0 DOUT : 0 
# KERNEL: [REF] DIN : 0 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 0 DOUT : 0 
# KERNEL: [DRV] DIN : 0 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 0 
# KERNEL: [SCO] DIN : 0 DOUT : 0 
# KERNEL: [REF] DIN : 0 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 1 DOUT : 0 
# KERNEL: [DRV] DIN : 1 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 1 
# KERNEL: [SCO] DIN : 0 DOUT : 1 
# KERNEL: [REF] DIN : 1 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 0 DOUT : 0 
# KERNEL: [DRV] DIN : 0 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 0 
# KERNEL: [SCO] DIN : 0 DOUT : 0 
# KERNEL: [REF] DIN : 0 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 1 DOUT : 0 
# KERNEL: [DRV] DIN : 1 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 1 
# KERNEL: [SCO] DIN : 0 DOUT : 1 
# KERNEL: [REF] DIN : 1 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 0 DOUT : 0 
# KERNEL: [DRV] DIN : 0 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 0 
# KERNEL: [SCO] DIN : 0 DOUT : 0 
# KERNEL: [REF] DIN : 0 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 0 DOUT : 0 
# KERNEL: [DRV] DIN : 0 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 0 
# KERNEL: [SCO] DIN : 0 DOUT : 0 
# KERNEL: [REF] DIN : 0 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 0 DOUT : 0 
# KERNEL: [DRV] DIN : 0 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 0 
# KERNEL: [SCO] DIN : 0 DOUT : 0 
# KERNEL: [REF] DIN : 0 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 0 DOUT : 0 
# KERNEL: [DRV] DIN : 0 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 0 
# KERNEL: [SCO] DIN : 0 DOUT : 0 
# KERNEL: [REF] DIN : 0 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 1 DOUT : 0 
# KERNEL: [DRV] DIN : 1 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 1 
# KERNEL: [SCO] DIN : 0 DOUT : 1 
# KERNEL: [REF] DIN : 1 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 0 DOUT : 0 
# KERNEL: [DRV] DIN : 0 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 0 
# KERNEL: [SCO] DIN : 0 DOUT : 0 
# KERNEL: [REF] DIN : 0 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 0 DOUT : 0 
# KERNEL: [DRV] DIN : 0 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 0 
# KERNEL: [SCO] DIN : 0 DOUT : 0 
# KERNEL: [REF] DIN : 0 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 1 DOUT : 0 
# KERNEL: [DRV] DIN : 1 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 1 
# KERNEL: [SCO] DIN : 0 DOUT : 1 
# KERNEL: [REF] DIN : 1 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 0 DOUT : 0 
# KERNEL: [DRV] DIN : 0 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 0 
# KERNEL: [SCO] DIN : 0 DOUT : 0 
# KERNEL: [REF] DIN : 0 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 0 DOUT : 0 
# KERNEL: [DRV] DIN : 0 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 0 
# KERNEL: [SCO] DIN : 0 DOUT : 0 
# KERNEL: [REF] DIN : 0 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 1 DOUT : 0 
# KERNEL: [DRV] DIN : 1 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 1 
# KERNEL: [SCO] DIN : 0 DOUT : 1 
# KERNEL: [REF] DIN : 1 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 1 DOUT : 0 
# KERNEL: [DRV] DIN : 1 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 1 
# KERNEL: [SCO] DIN : 0 DOUT : 1 
# KERNEL: [REF] DIN : 1 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 0 DOUT : 0 
# KERNEL: [DRV] DIN : 0 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 0 
# KERNEL: [SCO] DIN : 0 DOUT : 0 
# KERNEL: [REF] DIN : 0 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 0 DOUT : 0 
# KERNEL: [DRV] DIN : 0 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 0 
# KERNEL: [SCO] DIN : 0 DOUT : 0 
# KERNEL: [REF] DIN : 0 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 1 DOUT : 0 
# KERNEL: [DRV] DIN : 1 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 1 
# KERNEL: [SCO] DIN : 0 DOUT : 1 
# KERNEL: [REF] DIN : 1 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 0 DOUT : 0 
# KERNEL: [DRV] DIN : 0 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 0 
# KERNEL: [SCO] DIN : 0 DOUT : 0 
# KERNEL: [REF] DIN : 0 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 1 DOUT : 0 
# KERNEL: [DRV] DIN : 1 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 1 
# KERNEL: [SCO] DIN : 0 DOUT : 1 
# KERNEL: [REF] DIN : 1 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 1 DOUT : 0 
# KERNEL: [DRV] DIN : 1 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 1 
# KERNEL: [SCO] DIN : 0 DOUT : 1 
# KERNEL: [REF] DIN : 1 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 1 DOUT : 0 
# KERNEL: [DRV] DIN : 1 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 1 
# KERNEL: [SCO] DIN : 0 DOUT : 1 
# KERNEL: [REF] DIN : 1 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED
# KERNEL: -------------------------------
# KERNEL: [[GEN]] DIN : 1 DOUT : 0 
# KERNEL: [DRV] DIN : 1 DOUT : 0 
# KERNEL: [NOW] DIN : 0 DOUT : 1 
# KERNEL: [SCO] DIN : 0 DOUT : 1 
# KERNEL: [REF] DIN : 1 DOUT : 0 
# KERNEL: [SCO] : DATA MATCHED