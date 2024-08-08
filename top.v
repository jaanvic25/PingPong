module top (
    input clk, reset, start
    output reset_game, sc1, sc2, start_o, winner
);

    // If start button is pressed, display opening screen in LED matrix
    always @(posedge clk && start) begin
        start_o <= 1;
    end

    // Reset scores when one player reaches 7
    always @(sc1 == 7 || sc2 == 7) begin
        sc1 <= 0;
        sc2 <= 0;

        if (sc1 > sc2) begin
            winner <= 1;
        end

        else begin
            winner <= 2;
        end
    end
endmodule