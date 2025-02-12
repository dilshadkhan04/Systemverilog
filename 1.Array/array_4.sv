module array_4;
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
		
		/*
		# KERNEL: Arr1 : 5 12 14 7 8 14 8 0 12 14 2 5 5 9 0
# KERNEL: Arr2 : 10 12 13 13 9 11 1 13 1 8 0 3 10 10 3
