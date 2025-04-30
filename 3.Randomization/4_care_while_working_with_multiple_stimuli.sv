class generator;
    rand bit [3:0] a, b; 
    bit [3:0] y; 
endclass

module tb;

    generator g; 
    int status = 0; 

    initial begin
        g = new(); 
		 /*Keeping g = new(); inside the loop ensures that a new object is created on each iteration, 
	  providing fresh randomization for each cycle. This approach avoids issues with the constraint that would stop 
	  randomization when a > 16, ensuring valid random values each time. */

        for (int i = 0; i < 10; i++) begin
            status = g.randomize(); 

            assert(status) else begin
                $display("Randomization failed at %0t", $time);
                $finish();
            end

            $display("Value of a : %0d and b: %0d with status : %0d", g.a, g.b, status);

            #10; 
        end
    end

endmodule
/*
# KERNEL: Value of a : 6 and b: 5 with status : 1
# KERNEL: Value of a : 3 and b: 4 with status : 1
# KERNEL: Value of a : 15 and b: 13 with status : 1
# KERNEL: Value of a : 11 and b: 8 with status : 1
# KERNEL: Value of a : 7 and b: 8 with status : 1
# KERNEL: Value of a : 10 and b: 10 with status : 1
# KERNEL: Value of a : 11 and b: 13 with status : 1
# KERNEL: Value of a : 13 and b: 4 with status : 1
# KERNEL: Value of a : 9 and b: 9 with status : 1
# KERNEL: Value of a : 1 and b: 11 with status : 1



