`timescale 1ns/1ns // 1 nanosecond

module paddle_movement_tb;
    // Inputs
    wire enc1a;
    wire enc1b;
    wire enc2a;
    wire enc2b;

    wire reset_game;

    // Outputs
    reg p1y;
    reg p2y;

    paddle_movement uut (
        .enc1a(enc1a),
        .enc1b(enc1b),
        .enc2a(enc2a),
        .enc2b(enc2b),
        .reset_game(reset_game),
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
        reset_game = 0;
        // Test 1
        $display("Test 1: left paddle move up, left paddle y = %b", p1y); #1
        enc1a = 0;
        enc1b = 0; #5
        enc1a = 1; #5
        enc1b = 1; #5
        enc1a = 0; #5
        enc1b = 0; #5
       
        // Test 2
        $display("Test 2: right paddle move up, right paddle y = %b", p2y); #0.5
        enc2a = 0; 
        enc2b = 0; #5
        enc2a = 1; #5
        enc2b = 1; #5
        enc2a = 0; #5
        enc2b = 0; #5
        
        // Test 3
        $display("Test 3: left paddle move down, left paddle y = %b", p1y); #0.5
        enc1a =0;
        enc1b = 0; #5
        enc1b = 1; #5
        enc1a = 1; #5
        enc1b = 0; #5
        enc1a = 0; #5
        
        // Test 4
        $display("Test 4: right paddle move down, right paddle y = %b", p2y); #0.5
        enc2a = 0; 
        enc2b = 0; #5
        enc2b = 1; #5
        enc2a = 1; #5
        enc2b = 0; #5
        enc2a = 0; #5

        $display("Paddle movement testbench completed."); #5
        $stop;
    end
endmodule