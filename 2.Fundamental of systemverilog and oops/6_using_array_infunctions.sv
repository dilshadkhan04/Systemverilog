module tb;
  
  bit [3:0] res[32];
  
  function automatic void init_arr (ref bit [3:0] a[32]);  
    for(int i = 0; i < 32; i++) begin
      a[i] = 8 * i;
    end
  endfunction 
  
  initial begin
    init_arr(res);
    
    for(int i = 0; i < 32; i++) begin
      $display("res[%0d] : %0d", i, res[i]);
    end
    
  end
endmodule

/*
# KERNEL: res[0] : 0
# KERNEL: res[1] : 8
# KERNEL: res[2] : 0
# KERNEL: res[3] : 8
# KERNEL: res[4] : 0
# KERNEL: res[5] : 8
# KERNEL: res[6] : 0
# KERNEL: res[7] : 8
# KERNEL: res[8] : 0
# KERNEL: res[9] : 8
# KERNEL: res[10] : 0
# KERNEL: res[11] : 8
# KERNEL: res[12] : 0
# KERNEL: res[13] : 8
# KERNEL: res[14] : 0
# KERNEL: res[15] : 8
# KERNEL: res[16] : 0
# KERNEL: res[17] : 8
# KERNEL: res[18] : 0
# KERNEL: res[19] : 8
# KERNEL: res[20] : 0
# KERNEL: res[21] : 8
# KERNEL: res[22] : 0
# KERNEL: res[23] : 8
# KERNEL: res[24] : 0
# KERNEL: res[25] : 8
# KERNEL: res[26] : 0
# KERNEL: res[27] : 8
# KERNEL: res[28] : 0
# KERNEL: res[29] : 8
# KERNEL: res[30] : 0
# KERNEL: res[31] : 8