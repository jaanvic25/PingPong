module paddle_movement  (
    input enc1a,
    input enc1b, 
    input enc2a, 
    input enc2b, // Encoders
    input reset_game,
    input clk,
    input reset,
    output reg [0:5] p1y,
    output reg [0:5] p2y // Top of paddle 1, 2  
);
    // p1y <= 6'd28;
    // p2y <= 6'd28;

    // always @(reset_game or sc1 or sc2) begin
    always @(reset_game) begin
        p1y = 6'd28;
        p2y = 6'd28;
    end

    always @(posedge enc1a) begin
        if (enc1b == 0) begin
            p1y = p1y + 1;
        end
    end

    always @(posedge enc1b) begin
        if (enc1a == 0) begin
            p1y = p1y - 1;
        end 
    end

    always @(posedge enc2a) begin
        if (enc2b == 0) begin
            p2y = p2y + 1;
        end
    end

    always @(posedge enc2b) begin
        if (enc2a == 0) begin
            //p2y <= 6'28;
            p2y = p2y - 1;
        end
    end
endmodule