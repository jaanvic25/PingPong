`timescale 1ns/1ns // 1 nanosecond

module collision_detection_tb;
    // Inputs
    reg [5:0] bx;
    reg [5:0] by;
    reg [5:0] p1y;
    reg [5:0] p2y;

    // Outputs
    wire [1:0] paddle_collision;
    wire wall_collision;
    wire [2:0] sc1;
    wire [2:0] sc2;

    collision_detection uut (
        .bx(bx),
        .by(by),
        .p1y(p1y),
        .p2y(p2y),
        .sc1(sc1),
        .sc2(sc2),
        .paddle_collision(paddle_collision),
        .wall_collision(wall_collision)
    );
    /*
    // Generate clock
    initial begin
        clk = 1'b0;
        forever #1 clk = ~clk;
    end

    Generate reset
    initial begin
        reset = 1'b1;
        #10
        reset = 1'b0;
     end
    */

    // Generate stimulus
    initial begin
        // Test 1
        by = 0; #5
        $display("Test 1: ball collides with top wall, wall collision = %b, by = %d, sc1 = %d, sc2 = %d",
        wall_collision, by, sc1, sc2); #0.5
        
        // Test 2
        by = 63; #5
        $display("Test 2: ball collides with bottom wall, wall collision = %b, by = %d, sc1 = %d, sc2 = %d",
        wall_collision, by, sc1, sc2); #1
        #50
        // Test 3
        bx = 2;
        by = 21; #5
        p1y = 19; #5
        $display("Test 3: ball collides with left paddle, paddle collision = %b, bx = %d, by = %d, sc1 = %d, sc2 = %d, p1y = %d",
        paddle_collision, bx, by, sc1, sc2, p1y); #1

        // Test 4
        bx = 61;
        by = 20; #5
        p2y = 18; #5
        $display("Test 4: ball collides with right paddle, paddle collision = %b, bx = %d, by = %d, sc1 = %d, sc2 = %d, p2y = %d",
        paddle_collision, bx, by, sc1, sc2, p2y); #1

        // Test 5
        bx = 30; #5
        by = 30; #5
        $display("Test 5: ball does not collide with anything, paddle collision = %b, wall collision = %b, sc1 = %d, sc2 = %d", paddle_collision, wall_collision, sc1, sc2); #1

        $display("Collision detection testbench completed."); #5
        $stop;
    end
endmodule