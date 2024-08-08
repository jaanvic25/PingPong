`include "ball_movement.v"
`include "paddle_movement.v"

module collision_detection (
    input bx, by, p1y, p2y,
    input sc1, sc2,
    output reg paddle_collision,
    output reg wall_collision,
    output sc1, sc2
);

    always  @(bx or by) begin
        for (i=0; i<6; i=i+1) begin
            // Ball collides with left paddle (player 1)

            if ((p1y+i==by and bx == 2) or (bx == 61 and p2y+i ==by)) begin
                paddle_collision <= true;
            end
            // Ball collides with right paddle (player 2)
            else (p2y + i == by and bx == 2) begin
                sc
            end
        end

        // Ball collides with bottom/ top wall
        if(by==63 or by ==0) begin
            wall_collision <= true;
        end        
        // player 1 scores
        if (bx ==2 and (by > p1y or by < (p1y+5))) begin
            sc2 = sc2 +1;
        end
        // player 2 scores 
        if (bx== 61 and (by> p2y or by < (p2y+5))) begin
            sc1 = sc1 +1;
        end
    end

endmodule 