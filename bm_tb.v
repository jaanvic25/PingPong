`timescale 1ns/1ns

module ball_movement_tb;
    // Inputs
    // COME BACK: bm.v has clk and reset as inputs, but can you create them within in the tb??
    wire paddle_collision;
    wire wall_collision;
    reg counter;

    // Outputs
    reg bx_dir; // COME BACK: should this be reg or wire??
    reg by_dir;
    wire x_o;
    wire y_o;
    reg bx;
    reg by;

    // Connect inputs to hardware
    ball_movement uut (
        .clk(clk),
        .reset(reset),
        .paddle_collision(paddle_collision),
        .wall_collision(wall_collision),
        .counter(counter)
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
    // COME BACK: this is so wrong lmao i'm only going to both writing one test
    initial begin
        // Test 1
        $display("Test 1: ball collides with left paddle, x-velocity = %b,
        y-velocity = %b, x-position = %b, y-position = %b", bx_dir, by_dir, bx, by);
        paddle_collision = 1;
        wall_collision = 0; #5
        counter = 0; #5 // COME BACK: not an input??

        $display("Ball movement testbench completed.")
        $stop;
    end
endmodule