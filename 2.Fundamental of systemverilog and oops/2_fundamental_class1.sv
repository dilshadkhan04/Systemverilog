class Generator;
  reg [2:0] data1;
  reg [1:0] data2;
  reg [3:0] data3;

  // Constructor to initialize data members
  function new();
    data1 = 3'b000;
    data2 = 2'b00;
    data3 = 4'b0000;
  endfunction

  // Display method to print values
  function void display();
    $display("data1: %0d, data2: %0d, data3: %0d", data1, data2, data3);
  endfunction
endclass
module tb;
  Generator g; // g is a handler, just like uut or dut in Verilog

  initial begin
    g = new(); // Create an object (constructor)
    g.data1 = 3'b010;
    g.data2 = 2'b10;
    g.data3 = 4'b1101;
    g.display(); // Display the values

    g = null; // Delete the object

    // Ensure the object is not accessed after deletion to avoid runtime errors
    // Uncommenting the next line will cause a runtime error
    // g.display(); 
  end
endmodule

/*
# KERNEL: data1: 2, data2: 2, data3: 13