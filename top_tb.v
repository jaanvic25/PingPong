`timescale 1ns/1ns

module top_tb;
    // Inputs
    reg sys_clock;
    reg reset;
    reg start;

    // Outputs
    wire reset_game;
    wire sc1, sc2;
    wire clk;
    wire counter;

    top uut (
        .sys_clock(sys_clock),
        .reset(reset),
        .start(start),
        .p2y(p2y),
        .sc1(sc1),
        .sc2(sc2),
        .reset_game(reset_game),
        .clk(clk), 
        .counter(counter)
    );

    initial begin
        // Test 1
   

        $display("Test 1: score 1 = %b, score 2 = %b", sc1, sc2);

        $stop;
    end
endmodule