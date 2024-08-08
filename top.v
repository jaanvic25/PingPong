module top (
    input sys_clock, reset, start,
    output reset_game, sc1, sc2, start_o, clk, counter
);

//remember: you can change clock speed whenever u want
    always @(posedge sys_clk) begin
        if (sys_clk % 100 == 0) begin
            clk <= 1'd0 + clk;
        end
        counter = counter + 1;
        if (counter == 90) begin
            // Negative angles
            if (counter < 45) begin
                counter <= counter + 360;
            end

            // Positive angles
            else begin
                counter <= counter - 45;
            end
        end
    end

    // If start button is pressed, display opening screen in LED matrix
    always @(posedge clk && start) begin
        start_o <= 1;
    end

    // If there is a winner
    always @(sc1 == 7 || sc2 == 7) begin
        if (reset) begin
        end
    end

endmodule