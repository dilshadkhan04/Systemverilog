module tb;

  int unsigned test;

  int unsigned  res;

  int unsigned  a = 12;

  int unsigned  b = 11;

  function  int unsigned mul();

  return a*b;

  endfunction

 

initial begin

  test = a*b;

  res = mul();

  $display("Answer is : %0d",res);

  if(test == res) begin

    $display("Test passed");

  end

else begin

  $display("Test failed");

end

end

endmodule

/*
# KERNEL: Answer is : 132
# KERNEL: Test passed