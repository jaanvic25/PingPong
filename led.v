[5:45 PM] Noah Vonlanthen
led 

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

    //localparam index = 0;

    //localparam bx_temp = bx;

    reg [2:0] ctr = 0;

    reg [63:0] matrix_row;
 
    reg [120:0] nums;
 
    // Set everything to 0 and set up nums 

    initial begin

        nums[14:0] = 15'b111101101101111; // 0

        nums[30:15] = 15'b010010010010010; // 1

        nums[45:30] =  15'b111100111001111; // 2

        nums[60:45] = 15'b111001111001111; // 3

        nums[75:60] = 15'b101101111001001; // 4

        nums[90:75] =  15'b111001111100111; // 5

        nums[105:90] = 15'b111100111101111; // 6

        nums[120:105] = 15'b111001001001001; // 7

        for (integer row = 0; row < 64; row = row + 1) begin

            matrix[row] <= 0;

        end

    end
 
    task loop(input x, input [15:0] n); // automatic??

        begin

            $display("in loop ");

            //n is the index start

            ctr = 0;

            for(integer row = 0; row < 15; row = row + 3) begin

                $display("score 1 = %d, col = %d, n = %d ", sc2x, ctr, n);

                ctr = ctr + 1;

                if(x == 0) begin

                    matrix[sc1x][ctr] <= nums[n+row];

                    matrix[sc1x+1][ctr] <= nums[n+row+1];

                    matrix[sc1x+2][ctr] <= nums[n+row+2];

                end

                else begin

                    matrix[sc2x][ctr] <= nums[n+row];

                    matrix[sc2x+1][ctr] <= nums[n+row+1];

                    matrix[sc2x+2][ctr] <= nums[n+row+2];

                end 

            end

        end

    endtask

    // Display ball 

//    always @(bx or by) begin  

//        matrix_row = 64'b0;

//        matrix_row[by] = 1;

//        matrix[bx] <= matrix_row;

//        $display("%b", matrix_row);

//    end
 
//    always @(sc1) begin

//         Display the score

//        $display("sc1 = %d, sc1*n = %d", sc1, (sc1*15));

//        loop(0, sc1*15);

//    end

//    always @(sc2) begin

//         Display the score

//        loop(1, sc2*15);

//    end

    always @(*) begin

        matrix_row = 64'b0;

        matrix_row[by] = 1;

        matrix[bx] <= matrix_row;

        $display("%b", matrix_row);

        // Display the middle line

        for(integer i=0; i<62; i=i+3) begin

            matrix[midpt][i] <= 1;

            matrix[midpt][i+1] <= 1;

            matrix[midpt][i+2] <= 0;

        end

        loop(0, sc1*15);

        loop(1, sc1*15);

        for(integer i =0; i<6; i = i+1) begin

            matrix[p1x][p1y+i] <= 1;

            matrix[p1x+1][p1y+i] <= 1;

            matrix[p2x][p2y+i] <= 1;

            matrix[p2x+1][p2y+i] <= 1;

        end

    end

    // // Display paddles

    // always @(p1y or p2y) begin

    // end

endmodule
 
[5:45 PM] Noah Vonlanthen
pm
 
[5:45 PM] Noah Vonlanthen
module pm  (

    input enc1a,

    input enc1b, 

    input enc2a, 

    input enc2b, // Encoders

    input reset_game,

    //input clk,

    //input reset,

    output reg [5:0] p1y,

    output reg [5:0] p2y // Top of paddle 1, 2  

);

    initial begin

    // Always @(reset_game or sc1 or sc2) begin

        if (reset_game == 1) begin

            p1y <= 6'd28;

            p2y <= 6'd28;

        end

    end
 
    // Test 3

    always @(posedge enc1a) begin

        if (enc1b == 0) begin

            p1y <= p1y + 1;

        end

    end
 
    // Test 1

    always @(posedge enc1b) begin

        if (enc1a == 0) begin

            p1y <= p1y - 1;

        end

    end
 
    // Test 4

    always @(posedge enc2a) begin

        if (enc2b == 0) begin

            p2y <= p2y + 1;

        end

    end
 
    // Test 2

    always @(posedge enc2b) begin

        if (enc2a == 0) begin

            //p2y <= 6'28;

            p2y <= p2y - 1;

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

endmodule
 
