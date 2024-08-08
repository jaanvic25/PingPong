`include "paddle_movement.v";
`include "ball_movement.v";
`include "top.v"

module led(
    input bx, by // ball x, y
    input p1y, p2y //top of paddle 1, 2
    input sc1, sc2 //score 1, 2

    output reg [63:0] matrix [0:63];
);
    localparam midpt = 30; //30-31
    localparam p1x = 0; 
    localparam p2x = 62;
    localparam scy = 1;
    localparam sc1x = 14; //14-16
    localparam sc2x = 46; // 46-48;

    localparam ooo = [1,1,1]; //ones
    localparam ozo = [1,0,1]; //one zero one
    localparam zoz = [0,1,0]; //zero one zero
    localparam zzo = [0,0,1]; //zero zero one 
    localparam ozz = [1, 0, 0]; //one zero zero
    localparam zero = [ooo, ozo, ozo, ozo, ooo];
    localparam one = [zoz, zoz, zoz, zoz, zoz];
    localparam two = [ooo, zzo, ooo, ozz, ooo];
    localparam three = [ooo, zzo, ooo, zzo, ooo];
    localparam four = [ozo, ozo, ooo, zzo, zzo];
    localparam five = [ooo, ozz, ooo, zzo, ooo];
    localparam six = [ooo, ozz, ooo, ozo, ooo];
    localparam seven = [ooo, zzo, zzo, zzo, zzo];

    localparam nums = [zero, one, two, three, four, five six, seven];
    
    //set everything to 0
    for (row=0; row<64; row=row+1) begin
        matrix[row] = 0;
    end

    //display ball 
    always @(bx or by) begin
        matrix[bx][by] = 1;
    end

    //score displayer
    for(row =0; row<5; row=row+1) begin
        matrix[sc1x:sc1x+2][row] = nums[sc1][row];
    end

    for(row =0; row<5; row=row+1) begin
        matrix[sc2x:sc2x+2][row] = nums[sc2][row];
    end

    //display the middle line
    for(i=0; i<22; i=i+3) begin
        matrix[midpt][i:i+1] = 1;
        matrix[midpt][i+2] = 0;
    end

    //keeping paddles within bounds 
    always @ (p1y) begin
        if (p1y > 58)
            p1y = 58;
        else (if p1y < 5)
            p1y = 5;
    end

    always @ (p2y) begin
        if p2y > 58
            p2y = 58;
        else if p2y < 5
            p2y = 5;
    end

    //display paddles
    always @(p1y or p2y) begin
        matrix[p1x:p1x+1][p1y:p1y+5] = 1;
        matrix[p2x:p2x+1][p2y:p2y+5] = 1;
    end

endmodule