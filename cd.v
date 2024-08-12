//`include "top.v"
//`include "bm.v"
//`include "pm.v"

module collision_detection (
    input [5:0] bx,
    input [5:0] by,
    input wire [5:0] p1y,
    input wire [5:0] p2y,
    output reg [1:0] paddle_collision,
    output reg wall_collision,
    output reg [2:0] sc1,
    output reg [2:0] sc2

    //output reg [5:0] p1y,
    //output reg [5:0] p2y
);

    initial begin
        sc1 <= 0;
        sc2 <= 0;
        paddle_collision <= 2'b00;
        wall_collision <= 0;
    end

    //bx || by
    always @(*) begin
        for (integer i = 0; i < 6; i = i + 1) begin
            // Ball collides with left paddle (player 1)
            if (p1y + i == by && bx == 2) begin
                paddle_collision <= 2'b01;
            end

            // Ball collides with right paddle (player 2)
            else if (p2y + i == by && bx == 61) begin
                paddle_collision <= 2'b11;
            end
            
            else if ((p2y > by) || (p2y + 5 < by) || (2 < bx && bx < 61)) begin
                paddle_collision <= 2'b00;
            end
        end
   
        // Ball collides with bottom/top wall
        if (by == 63 || by == 0) begin
            wall_collision <= 1;
        end

        else begin
            wall_collision <= 0;
        end

        // Player 1 scores
        if (bx == 2 && (by < p1y || by > (p1y + 5))) begin
            sc2 = sc2 + 1;
        end

        // Player 2 scores 
        else if (bx == 61 && (by < p2y || by > (p2y + 5))) begin
            sc1 = sc1+ 1;
        end
    end
endmodule 