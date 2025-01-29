module array_3;
  reg [7:0] arr [0:4]; // Declaring an array with 5 elements (0 to 4)
  
  initial begin
    arr[0] = 8'hA1;
    arr[1] = 8'hB2;
    arr[2] = 8'hC3;
    arr[3] = 8'hD4;
    arr[4] = 8'hE5;
    
    $display("Fixed Array: %p", arr);
  end
endmodule
