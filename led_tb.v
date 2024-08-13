`timescale 1ns/1ns

module led_tb;
    // Inputs
    reg [5:0] bx;
    reg [5:0] by;
    reg [5:0] p1y;
    reg [5:0] p2y;
    reg [2:0] sc1;
    reg [2:0] sc2;

    // Outputs
    wire [63:0] matrix [0:63];

    led uut (
        .bx(bx),
        .by(by),
        .p1y(p1y),
        .p2y(p2y),
        .sc1(sc1),
        .sc2(sc2),
        .matrix(matrix)
    );

    initial begin
        // Test 1
        bx = 31;
        by = 31; #5
        p1y = 20; #5
        p2y = 20; #5
        sc1 = 2; #5
        sc2 = 1; #5
        $display("Test 1: led matrix = \n %b \n %b  \n %b  \n %b \n %b", matrix[1], matrix[2], matrix[3], matrix[4], matrix[5], matrix[6]);

        $display("\n LED matrix testbench complete."); #0.5
        $stop;
    end
endmodule