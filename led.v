//`include "pm.v";
//`include "bm.v";
//`include "top.v"

module led(
    // Inputs
    input [5:0] bx,
    input [5:0] by,
    input [5:0] p1y,
    input [5:0] p2y,
    input [2:0] sc1,
    input [2:0] sc2,

    // Outputs
    output reg [63:0] matrix [0:63]
);
    localparam midpt = 30; //30-31
    localparam p1x = 0; 
    localparam p2x = 62;
    localparam scy = 1;
    localparam sc1x = 14; //14-16
    localparam sc2x = 46; // 46-48;
    localparam ctr = 0;
    
    reg zero = 15'b111101101101111;
    reg one = 15'b010010010010010;
    reg two = 15'b111001111100111;
    reg three = 15'b111001111001111;
    reg four = 15'b101101111001001;
    reg five = 15'b111100111001111;
    reg six = 15'b111100111101111;
    reg seven = 15'b111001001001001;

    reg nums [7:0];
    assign nums[0] = zero;
    assign nums[1] = one;
    assign nums[2] = two;
    assign nums[3] = three;
    assign nums[4] = four; 
    assign nums[5] = five;
    assign nums[6] = six;
    assign nums[7] = seven;

    function loop(input num); // automatic??
        ctr = 0;
        begin
            for(integer row = 0; row < 15; row = row + 3) begin
                    matrix[sc1x][ctr] <= num[row];
                    matrix[sc1x+1][ctr] <= num[row+1];
                    matrix[sc1x+2][ctr] <= num[row+2];
                    assign ctr = ctr + 1;
            end
        end
    endfunction
    
    // Set everything to 0
    initial begin
        for (integer row = 0; row < 64; row = row + 1) begin
            matrix[row] <= 0;
        end
    end

    // Display ball 
    always @(bx or by) begin
        matrix[bx][by] <= 1;
    end

    always @(*) begin
        // Display the score
        loop(nums[sc1]);
        loop(nums[sc2]);
    
        // Display the middle line
        for(integer i=0; i<22; i=i+3) begin
            assign matrix[midpt][i:i+1] = 1;
            assign matrix[midpt][i+2] = 0;
        end
    end

    // Keep paddles within bounds 
    always @(p1y) begin
        if (p1y > 58) begin
            p1y <= 6'd58;
        end

        else if (p1y < 5) begin
            p1y <= 6'd5;
        end
    end

    always @(p2y) begin
        if (p2y > 58) begin
            p2y <= 6'd58;
        end

        else if (p2y < 5) begin
            p2y <= 6'd5;
        end
    end

    // Display paddles
    always @(p1y or p2y) begin
        matrix[p1x:p1x+1][p1y:p1y+5] <= 1;
        matrix[p2x:p2x+1][p2y:p2y+5] <= 1;
    end
endmodule