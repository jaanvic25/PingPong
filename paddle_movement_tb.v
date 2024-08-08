`timescale 1ns/1ns // 1 nanosecond

module paddle_movement_tb;
    wire enc1a, enc1b, enc2a, enc2b; // Inputs
    reg p1y, p2y; // Outputs

    paddle_movement_tb uut (
        .enc1a(enc1a),
        .enc1b(enc1b),
        .enc2a(enc2a),
        .enc2b(enc2b),
        .p1y(p1y),
        .p2y(p2y)
     );

    // Generate clock
    initial begin
        clk = 1'b0;
        forever #1 clk = ~clk;
    end

    // Generate reset
    initial begin
        reset = 1'b1;
        #10
        reset = 1'b0;
    end

    // Generate stimulus
    initial begin
        // Test 1
        $display("Test 1: left paddle move up"); #1
        enc1a, enc1b = 0; #5
        enc1a = 1; #5
        enc1b = 1; #5
        enc1a = 0; #5
        enc1b = 0; #5
        
        // Test 2
        $display("Test 2: right paddle move up"); #0.5
        enc2a, enc2b = 0; #5
        enc2a = 1; #5
        enc2b = 1; #5
        enc2a = 0; #5
        enc2b = 0; #5
        
        // Test 3
        $display("Test 3: left paddle move down"); #0.5
        enc1a, enc1b = 0; #5
        enc1b = 1; #5
        enc1a = 1; #5
        enc1b = 0; #5
        enc1a = 0; #5
        
        // Test 4
        $display("Test 4: right paddle move down"); #0.5
        enc2a, enc2b = 0; #5
        enc2b = 1; #5
        enc2a = 1; #5
        enc2b = 0; #5
        enc2a = 0; #5

        $display("Paddle movement testbench completed."); #5
        $stop;
    end
endmodule