module and_tb;
    reg a;
    reg b;
    wire y;

    and uut (
        .a(a),
        .b(b),
        .y(y)
    );

    initial begin
        // Test 1
        a = 0, b = 0; #10
        $display("Test 1: a = %b, b = %b, y = %b (we want 0)", a, b, y);

        // Test 2
        a = 0, b = 1; #10
        $display("Test 2: a = %b, b = %b, y = %b (we want 0)", a, b, y);

        // Test 3
        a = 1, b = 0; #10
        $display("Test 3: a = %b, b = %b, y = %b (we want 0)", a, b, y);

        // Test 4
        a = 1, b = 1; #10
        $display("Test 4: a = %b, b = %b, y = %b (we want 1)", a, b, y);

        $display("\n AND gate testbench finished.")

        $stop;

    end

endmodule