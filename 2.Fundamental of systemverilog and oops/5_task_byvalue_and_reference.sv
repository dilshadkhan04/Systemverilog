module tb;

  ////// Pass by Value
  task swap_by_value(input bit [1:0] a, input bit [1:0] b); 
    bit [1:0] temp;
    temp = a;
    a = b;
    b = temp;   
    $display("Pass by Value - a: %0d, b: %0d", a, b);
  endtask
  
  ////// Pass by Reference
  task automatic swap_by_ref(ref bit [1:0] a, ref bit [1:0] b); 
    bit [1:0] temp;
    temp = a;
    a = b;
    b = temp;
    $display("Pass by Reference - a: %0d, b: %0d", a, b);
  endtask

  //// Restrict Access to Variables
  task automatic swap_const_ref(const ref bit [1:0] a, ref bit [1:0] b); 
    bit [1:0] temp;
    temp = a;
    // a = b; // This line is commented out since 'a' is const ref
    b = temp;
    $display("Const Ref - a: %0d, b: %0d", a, b);
  endtask
  
  bit [1:0] a;
  bit [1:0] b;

  initial begin
    a = 1;
    b = 2;
    
    // Demonstrating pass by value
    swap_by_value(a, b);
    $display("After Pass by Value - a: %0d, b: %0d", a, b);
    
    // Demonstrating pass by reference
    swap_by_ref(a, b);
    $display("After Pass by Reference - a: %0d, b: %0d", a, b);
    
    // Demonstrating restricted access to variables
    swap_const_ref(a, b);
    $display("After Const Ref - a: %0d, b: %0d", a, b);
  end

endmodule


/*
# KERNEL: Pass by Value - a: 2, b: 1
# KERNEL: After Pass by Value - a: 1, b: 2
# KERNEL: Pass by Reference - a: 2, b: 1
# KERNEL: After Pass by Reference - a: 2, b: 1
# KERNEL: Const Ref - a: 2, b: 2
# KERNEL: After Const Ref - a: 2, b: 2