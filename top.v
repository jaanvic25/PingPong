module top (
    input sys_clock, reset, start, enc1a, enc1b, enc2a, enc2b,
    output reg reset_game, sc1, sc2, clk, 
    output reg [359:0] counter,
    output reg [63:0] matrix [0:63] //add other matrix things
);
wire [1:0] paddle_collision;//inp to bm and out from cd
wire wall_collision;//^^
reg [2:0] sc1;
reg [2:0] sc2; 
reg [5:0] bx;
reg [5:0] by;
reg [5:0] p1y;
reg [5:0] p2y;
 
bm ball_movement(.reset(reset), .paddle_collision(paddle_collision), .wall_collision(wall_collision),
.counter(counter), .bx(bx), .by(by), .bx_o(bx_o), .by_o(by_o), .sc1(sc1), .sc2(sc2));
 
cd collision_detection(.bx(bx), .by(by), .p1y(p1y), .p2y(p2y), .paddle_collision(paddle_collision), 
.wall_collision(wall_collision), .sc1(sc1), .sc2(sc2));
 
led led (.bx(bx), .by(by), .p1y(p1y), .p2y(p2y), .sc1(sc1), .sc2(sc2), .matrix(matrix));
 
pm paddle_movement (.enc1a(enc1a), .enc1b(enc1b), .enc2a(enc2a), .enc2b(enc2b), .reset_game(reset_game), 
.p1y(p1y), .p2y(p2y));
 
//remember: you can change clock speed whenever u want
    always @(posedge sys_clock) begin
        bx <= bx_o; // good luck!
        by <= by_o;
        if (sys_clock % 100 == 0) begin
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
    always @(posedge clk ) begin
        if ((start) || (sc1 == 7 || sc2 == 7)) begin
        reset_game <=1;
        end
    end

endmodule
