module and_tb;
    reg a;
    wire y;

    not uut (
        .a(a),
        .y(y)
    );

    initial begin
        // Test 1
        a = 0; #10
        $display("Test 1: a = %b, y = %b (we want 1)", a, y);

        // Test 2
        a = 1; #10
        $display("Test 2: a = %b, y = %b (we want 0)", a, y);

        $display("\n NOT gate testbench finished.")

        $stop;

    end
    
endmodule