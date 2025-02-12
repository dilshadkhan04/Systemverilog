//// Trigger : ->
//// edge sensitive_blocking @(), level_sensitive_non_blocking wait()

module tb;
  
  event a;
  initial begin
    #10;
    -> a;
  end
  
  initial begin
    @(a);
	//wait(a.triggered);
    $display("Recieved Event at %0t",$time);
    
  end
  
endmodule

# KERNEL: Recieved Event at 10