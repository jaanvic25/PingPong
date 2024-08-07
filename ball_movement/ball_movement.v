module ball_movement (
    input clk, reset, paddle_collision, ball_collision
    parameter bx, by, bx_vel, by_vel, theta
    output bx_dir, by_dir
);

    always @(posedge clk) begin
        // If the game has just begun, the ball is at center and randomly served.
        by <= 31;
        bx <= 31;

        theta = $random_range(-45, 45);
        if (theta == 0) begin
            theta <= 1;
        end
        
        bx_vel <= 2 * ; // COME BACK: use trial and error to find best x velocity.
        by_vel <= $random_range(1, 3);

        else begin
            // Otherwise, ball position depends on collisions.
            if (paddle_collision) begin
                bx_vel <= -bx_vel; // COME BACK: try using CORDIC or trig.
            end
        end
    end

endmodule