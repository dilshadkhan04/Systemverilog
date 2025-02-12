// Task:
// Create a fixed-size array capable of storing 20 elements. Add random values to all the 20 elements using the $urandom function.
// Now add all the elements of the fixed-size array to the queue in such a way that the first element of the fixed-size array should be the last element of the queue.
// Print all the elements of both the fixed-size array and the queue on the console.

module array_6;
    int arr1[20];
    int arr2[$];
    initial begin
 for(int i=0;i<20;i++) begin
     arr1[i] = $urandom % 20;
 end
for (int i = 0; i < 20; i = i + 1) begin
            arr2.push_front(arr1[i]);
        end
 $display("arr1 : %0p",arr1);
 $display("arr2 : %0p",arr2);
    end

        endmodule
/*
# KERNEL: arr1 : 18 9 4 18 4 5 4 12 1 16 6 1 15 1 0 9 13 0 17 16
# KERNEL: arr2 : 16 17 0 13 9 0 1 15 1 6 16 1 12 4 5 4 18 4 9 18