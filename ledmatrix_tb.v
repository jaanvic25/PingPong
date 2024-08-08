module ledmatrix_tb (
    wire bx, by, p1y, p2y, sc1, sc2;

    ledmatrix uut (
        .bx(bx),
        .by(by),
        .p1y(p1y),
        .p2y(p2y),
        .sc1(sc1),
        .sc2(sc2)
    );

    initial begin
        // Test 1
        bx = 31, by = 31, p1y = 20, p2y = 20, sc1 = 0, sc2 = 0; #10

        $display("\n LED matrix testbench complete.")
        $stop
    end
);

endmodule