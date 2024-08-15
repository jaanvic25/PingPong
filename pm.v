module paddle_movement  (
    input enc1a,
    input enc1b, 
    input enc2a, 
    input enc2b,
    input reset_game,
    input clk,
    input reset,
    output reg [5:0] p1y,
    output reg [5:0] p2y // Top of paddle 1, 2  
);
    // Always @(reset_game or sc1 or sc2) begin
    always @(reset_game) begin
        p1y <= 6'd28;
        p2y <= 6'd28;
    end
 
    (*ASYNC_REG="TRUE"*)reg[1:0] sync1, AB1; // synchronization the regs for the encoder?
    (*ASYNC_REG="TRUE"*)reg[1:0] sync2, AB2; // synchronization the regs for the encoder?

    reg[1:0] state1;
    reg[1:0] state2;
    reg signed [31:0] count1;
    reg signed [31:0] count2;
    function [31:0] count (input [1:0] state, input [1:0] AB, input [5:0] py);
        begin
            case(state)              
                S00: if(AB == 2'b01) begin
                        count <= count-1;
                        py <= py-1; //unsure about this line!
                        state <= S01;
                    end else if(AB == 2'b10) begin
                        count <= count+1;
                        state <= S10;
                    end                                        
                S01: if(AB == 2'b00) begin
                        count <= count+1;
                        py <= py+1;
                        state <= S00;
                    end else if(AB == 2'b11) begin
                        count <= count-1;
                        py <= py-1;
                        state <= S11;
                    end                      
                S10: if(AB == 2'b00) begin
                        count <= count-1;
                        py <= py-1;
                        state <= S00;
                    end else if(AB == 2'b11) begin
                        count <= count+1;
                        py <= py+1;
                        state <= S11;
                    end                     
                S11: if(AB == 2'b01) begin
                        count <= count+1;
                        py <= py+1;
                        state <= S01;
                    end else if(AB == 2'b10) begin
                        count <= count-1;
                        py <= py-1;
                        state <= S10;
                    end
            endcase
        end
    endfunction

    localparam S00=2'b00, S01=2'b01, S10=2'b10, S11=2'b11; // states

    always @ (posedge clk) // two-stage input synchronizer
        begin
            sync1 <= {enc1a, enc1b};
            AB1 <= sync1;
            sync2 <= {enc2a, enc2b};
            AB2 <= sync2;
        end



    always @(posedge clk) // always block to compute output
        begin 
            if(reset) begin
                state1 <= S00;//initial state + output
                state2 <= S00;
                count1 <= 0;
                count2 <= 0;
            end else begin //might not need begin + end here
                count1 = count(state1, AB1);
                count2 = count(state2, AB2);
            end

            if (p1y > 58) begin
                p1y <= 6'd58;
            end

            else if (p1y < 5) begin
                p1y <= 6'd5;
            end
            if (p2y > 58) begin
                p2y <= 6'd58;
            end

            else if (p2y < 5) begin
                p2y <= 6'd5;
            end
            
        end

endmodule
    /*

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

*/