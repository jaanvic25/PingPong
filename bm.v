module bm (
    input [5:0] bx, 
    input [5:0] by,
    input clk,
    input reset,
    input paddle_collision,
    input wall_collision,
    input counter,
    input sc1,
    input sc2,
 
    output reg [5:0] bx_o,
    output reg [5:0] by_o
);
    //localparam bx_dir <= 0;
    //localparam by_dir <= 0;
    reg x_o = 0;
    reg y_o = 0;
    reg bx_vel = 0;
    reg by_vel = 0;
    reg theta_i = 0;
    reg rotate = 1; // Select rotate for fixed-point calculations.\
 
    always @(sc1, sc2, posedge clk) begin
        //temp <= sys_clk;
        theta_i <= counter;
 
        // If the game has just begun, the ball is at center and randomly served.
        by_o <= 31;
        bx_o <= 31;
    end
 
    always @(posedge clk) begin
        // Calculate a non-zero angle for theta to use for the ball's velocity vectors.
        theta_i <= clk;
        if (theta_i == 0) begin
            theta_i <= 1;
        end
 
        x_o <= cos(theta_i);
        y_o <= sin(theta_i);
        bx_vel <= 2 * x_o; // COME BACK: use trial and error to find best scale value for velocity.
        by_vel <= 2 * y_o;
 
        // Position of the ball after the Pong game.
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
                bx_o <= bx + bx_vel;
            end
 
            // Left
            else if (bx_vel < 0) begin
                bx_o <= bx - bx_vel;
            end
 
            // Up
            else if (by_vel > 0) begin
                by_o <= by + by_vel;
            end
 
            // Down
            else if (by_vel < 0) begin
                by_o <= by - by_vel;
            end
        end
    end
endmodule
