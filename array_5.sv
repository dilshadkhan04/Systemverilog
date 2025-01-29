// Task:
// Create a dynamic array capable of storing 7 elements. Add values that are multiples of 7 starting from 7 in the array (7, 14, 21, ..., 49).
// After 20 ns, update the size of the dynamic array to 20. Keep existing values of the array as they are and update the rest 13 elements to multiples of 5 starting from 5.
// Print the values of the dynamic array after updating all the elements.

// Expected result: 7, 14, 21, 28, 35, 42, 49, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65.


module array_5;
    int arr1[];
    int farr[20];
    int i;
    initial begin
    arr1 = new[7];
    for(i=0;i<7;i++)begin
    arr1[i] = 7*(i+1);
    end
    #20
    arr1 = new[20](arr1);
     for(i=7;i<20;i++)begin
    arr1[i] = 5 * (i-6);
    end
    
    $display("%0p",arr1);
    end
        endmodule
