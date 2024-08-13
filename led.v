//`include "pm.v";
//`include "bm.v";
//`include "top.v"

module led(
    // Inputs
    input [5:0] bx,
    input [5:0] by,
    input [5:0] p1y,
    input [5:0] p2y,
    input [3:0] sc1,
    input [3:0] sc2,

    // Outputs
    output reg [63:0] matrix [0:63]
);
    localparam midpt = 30; //30-31
    localparam p1x = 0; 
    localparam p2x = 62;
    localparam scy = 1;
    localparam sc1x = 14; //14-16
    localparam sc2x = 46; // 46-48;

    localparam [2:0] ooo = 3'b111; //ones 
    localparam [2:0] ozo = 3'b101; //one zero one
    localparam [2:0] zoz = 3'b010; //zero one zero
    localparam [2:0] zzo = 3'b001; //zero zero one 
    localparam [2:0] ozz = 3'b100; //one zero zero
    reg [4:0] zero [2:0] = {ooo, ozo, ozo, ozo, ooo};
    //localparam zero [4:0][1] = {ooo, ozo, ozo, ozo, ooo};
    reg [4:0] one [2:0] = {zoz, zoz, zoz, zoz, zoz};
    reg [4:0] two [2:0] = {ooo, zzo, ooo, ozz, ooo};
    reg [4:0] three [2:0] = {ooo, zzo, ooo, zzo, ooo};
    reg [4:0] four [2:0] = {ozo, ozo, ooo, zzo, zzo};
    reg [4:0] five [2:0] = {ooo, ozz, ooo, zzo, ooo};
    reg [4:0] six [2:0] = {ooo, ozz, ooo, ozo, ooo};
    reg [4:0] seven [2:0] = {ooo, zzo, zzo, zzo, zzo};

    reg [7:0] nums [4:0][2:0] = {zero, one, two, three, four, five six, seven};
    
    //set everything to 0
    for (row = 0; row < 64; row = row + 1) begin
        matrix[row] <= 0;
    end

    //display ball 
    always @(bx or by) begin
        matrix[bx][by] <= 1;
    end

    //score displayer
    for(row = 0; row < 5; row = row +1) begin
        matrix[sc1x:sc1x+2][row] = nums[sc1][row];
    end

    for(row =0; row<5; row=row+1) begin
        matrix[sc2x:sc2x+2][row] <= nums[sc2][row];
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