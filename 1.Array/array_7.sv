 /*Initialize a dynamic array with multiples of 7
 Resize it after 20 ns, keeping previous values intact
 Fill new elements with multiples of 5
 Print the updated array*/
 
module dynamic_array_example;
  int dyn_array[]; 
  
  initial begin
 
    dyn_array = new[7];
    foreach (dyn_array[i]) 
      dyn_array[i] = (i + 1) * 7;
    
    $display("Before resize at 20 ns: %p", dyn_array);
    
   
    #20;
    
 
    dyn_array = new[20](dyn_array);
    

    foreach (dyn_array[i])
      if (i >= 7) dyn_array[i] = (i - 6) * 5;

    $display("After resize at 20 ns: %p", dyn_array);
  end
endmodule

/*
# KERNEL: Before resize at 20 ns: '{7, 14, 21, 28, 35, 42, 49}
# KERNEL: After resize at 20 ns: '{7, 14, 21, 28, 35, 42, 49, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65}