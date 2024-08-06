module clock_tb;
    wire clk

    clock uut (
        .clock(clk)
    );

    initial begin 
        $monitor("Time = %0t | clk = %b", $time, clk);
    end

    initial begin
        $display("Clock testbench: \n");
        $display("Time = %0t | clk = %b", $time, clk);

        #100
        $display("Simulation complete.");
        $finish;
    end

endmodule