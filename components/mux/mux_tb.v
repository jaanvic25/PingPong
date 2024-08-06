module tb_mux;
  reg [1:0] sel;
  reg [3:0] D;
  wire Y;
  
  mux uut(
    .sel(sel),
    .D(D),
    .Y(Y)
  );
  
  initial begin
    
    D = 4'b0110; sel = 2'b00; #10;
    $display("Test 1: sel = %b, D = %b, Y = %b (Expected: %b)", sel, D, Y, D[0]);
    
    sel = 2'b01;  #10;
    $display("Test 1: sel = %b, D = %b, Y = %b (Expected: %b)", sel, D, Y, D[1]);
    
    sel = 2'b10; #10;
    $display("Test 1: sel = %b, D = %b, Y = %b (Expected: %b)", sel, D, Y, D[2]);
    
    sel = 2'b11; #10;
    $display("Test 1: sel = %b, D = %b, Y = %b (Expected: %b)", sel, D, Y, D[3]);
    
    $display("\n Sim over!");
    
    $stop;
    
  end
  
endmodule