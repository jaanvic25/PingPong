module game (
    input clk, reset, start
    output reset_game, sc1, sc2, start_o
);

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