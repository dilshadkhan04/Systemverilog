//// Trigger : ->
//// edge sensitive_blocking @(), level_sensitive_non_blocking wait()

module tb;
  
  event a1,a2;
  initial begin
    -> a1;
    -> a2;
  end
  
  initial begin
    wait(a1.triggered);
    $display("Event A1 trigger");
    wait(a2.triggered);
             $display("Event A2 trigger");        
  end
  
endmodule

/* we might miss event in edge sensitive while in 
wait operator the level will remain for sometime 
so we can sense the triggering