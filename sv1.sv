module sv1;
    reg [31:0] arr1[0:14];
    reg [31:0] arr2[0:14];
    reg [3:0] random_value;
    integer i;
    
    initial begin
        // Fill arrays with random values
        for (i = 0; i < 15; i = i + 1) begin
        random_value = $urandom;
            arr1[i] = $urandom % 15;
            arr2[i] = $urandom % 15;
        end
         $display("Arr1 : %0p",arr1);
          $display("Arr2 : %0p",arr2);
        end
       
        endmodule
