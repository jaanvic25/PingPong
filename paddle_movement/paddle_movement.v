module paddle_movement ( // player_bar
	parameter bar_height = 5; 
    //25
	parameter bar_width = 2; 
    //96 local param?
	p1_bar_y = 430;
	//33
	p2_bar_y = 20;
	//
	bar_x_sp = 8;
	//
); 

(
	input clk, reset, paddle_collision, wall_collision, //wire 
	output // ?? 
);

reg [9:0] p1_bar_x;
reg [8:0] p1_bar_y;

reg [9:0] p2_bar_x;
reg [8:0] p2_bar_y;

reg [9:0] bar_width;
reg [8:0] bar_height;

reg [7:0] bar_x_sp;

reg [9:0] ball_x;
reg [8:0] ball_y;

reg ball_x_dir;
reg ball_y_dir;

reg [1:0] ball_x_sp;
reg [1:0] ball_y_sp;

reg [19:0] count;

always@(posedge clk)
begin
	if (count == 20'd500_000)
	begin
		count <= 20'd0;
	end
    else
	begin
		count <= count + 20'd1;
	end
	
	count2 <= count2 + 1'b1;
end

//wire sq_b = (x > 0 && x < 480 && y > 0 && y < 640);
//wire sq_a = (x > 0 && x < 480 && y > 0 && y < 640);

endmodule