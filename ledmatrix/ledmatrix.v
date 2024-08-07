module led(
    input enc1a, enc1b, enc2a, enc2b, //encoders
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
    matrix[bx][by] = 1;

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
    matrix[p1x:p1x+1][p1y:p1y+5] = 1;
    matrix[p2x:p2x+1][p2y:p2y+5] = 1;

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

    always @(posedge enc1a) begin
        if (enc1b ==0)
            //paddle1 up
    end

    always @(posedge enc1b) begin
        if (enc1a ==0)
            //paddle1 down
    end

    always @(posedge enc2a) begin
        if (enc2b ==0)
            //paddle2 up
    end

    always @(posedge enc2b) begin
        if (enc2a ==0)
            //paddle2 down
    end

endmodule