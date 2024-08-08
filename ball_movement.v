`include "collision_detection.v"

module ball_movement (
    parameter bx, by <= 31
)(
    input clk, reset, paddle_collision, wall_collision, rotate, theta_i,
    output bx_dir, by_dir, x_o, y_o, bx, by
);
    localparam bx_vel, by_vel;

    always @(posedge clk) begin
        // If the game has just begun, the ball is at center and randomly served.
        if (reset) begin
            by <= 31;
            bx <= 31;

            // Select rotate for fixed-point calculations.
            rotate = 1;

            // Calculate a non-zero angle for theta to use for the ball's velocity vectors.
            theta_i <= $random_range(-45, 45);
            if (theta_i == 0) begin
                theta_i <= 1;
            end

            x_o <= cos(theta_i);
            y_o <= sin(theta_i);
            
            bx_vel <= 2 * x_o; // COME BACK: use trial and error to find best scale value for velocity.
            by_vel <= 2 * y_o;
        end

        // Position of the ball after the Pong game.
        else begin
            if (paddle_collision) begin
                bx_vel <= -bx_vel;
            end

            else if (wall_collision) begin
                by_vel <= -by_vel;
            end

            // If there is no collision, move the ball normally for each clock pulse.
            else begin
                // Right
                if (bx_vel > 0) begin
                    bx <= bx + bx_vel;
                end

                // Left
                else if (bx_vel < 0) begin
                    bx <= bx - bx_vel;
                end

                // Up
                else if (by_vel > 0) begin
                    by <= by + by_vel;
                end

                // Down
                else if (by_vel < 0) begin
                    by <= by - by_vel;
                end
            end
        end
    end
endmodule