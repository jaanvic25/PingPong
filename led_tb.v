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
    wire [63:0][0:63] matrix ;

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
        bx = 6'd20;
        by = 6'd20; #5
        p1y = 20; #5
        p2y = 20; #5
        sc1 = 5; #5
        sc2 = 3; #5

        $display("Test 1: score 1 = %b, score 2 = %b", sc1, sc2);
        for(integer i = 0; i <64; i=i+1) begin
            $display("%b", matrix[i]);
        end

        $display("\n LED matrix testbench complete."); #0.5
        $stop;
    end
endmodule