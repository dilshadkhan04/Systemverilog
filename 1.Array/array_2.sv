module array_2; // queue and push pop
  int queue[$]; // Declaring a queue
  
  initial begin
    queue.push_back(10);
    queue.push_back(20);
    queue.push_back(30);
    
    $display("Queue Before Pop: %p", queue);
    queue.pop_front(); // Removes first element (FIFO)
    $display("Queue After Pop: %p", queue);
  end
endmodule
