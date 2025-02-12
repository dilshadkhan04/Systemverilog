module array_1;  //multidimensional array
  reg [3:0] matrix [0:2][0:2]; // 3x3 matrix
  
  initial begin
    matrix[0][0] = 4'h1;
    matrix[0][1] = 4'h2;
    matrix[0][2] = 4'h3;
    matrix[1][0] = 4'h4;
    matrix[1][1] = 4'h5;
    matrix[1][2] = 4'h6;
    matrix[2][0] = 4'h7;
    matrix[2][1] = 4'h8;
    matrix[2][2] = 4'h9;

    $display("Matrix[1][1]: %h", matrix[1][1]); // Should print 5
  end
endmodule

/*
# KERNEL: Matrix[1][1]: 5