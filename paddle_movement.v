module paddle_movement (
    parameter p1y, p2y <= 28;
    input enc1a, enc1b, enc2a, enc2b, //encoders
    output p1y, p2y //top of paddle 1, 2
)
    always @(reset_game or sc1 or sc2) begin
        p1y, p2y <=28
    end
    always @(posedge enc1a) begin
        if (enc1b ==0)
            p1y <= p1y + 1;
    end

    always @(posedge enc1b) begin
        if (enc1a ==0)
            p1y <= p1y - 1;
    end

    always @(posedge enc2a) begin
        if (enc2b ==0)
            p2y <= p2y + 1;
    end

    always @(posedge enc2b) begin
        if (enc2a ==0)
            p2y <= p2y - 1;
    end
endmodule