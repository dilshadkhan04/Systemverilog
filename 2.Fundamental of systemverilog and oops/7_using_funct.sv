
module using_funct;

function bit [4:0] add(input bit [3:0] a,b);
return a + b;
endfunction

bit [4:0] res =0;
bit [3:0] ain = 4'b0100;
initial begin
res = add(4'b0100, 4'b0010);
$display("Value of addition : %0d",res);
end
endmodule
/*

KERNEL: Value of addition : 6