`timescale 1ns / 1ps
`define CLOCK_BIT_WIDTH 8
module speaker_control(au_appsel, au_sysclk, au_bck, au_ws, au_data, au_in_left, au_in_right, clk, rst_n);
	output au_appsel, au_bck;	//mode selection; bit clock
	output au_sysclk, au_ws;	//clock from system(40MHz); left/right selection
	output au_data;				//data bits
	input clk, rst_n;			//clock; reset
	input [15:0]au_in_right, au_in_left;	//left sound; right sound
	
	wire [`CLOCK_BIT_WIDTH-1:0]clock_tmp;
	reg [`CLOCK_BIT_WIDTH-1:0]clock;
	wire bck_clk;
	reg [15:0]data_in;
	
	assign au_appsel = 1;		//mode: stereo
	assign au_ws = clock[`CLOCK_BIT_WIDTH-1];	//sample rate: 5/32MHz
	assign au_sysclk = clk;		//40MHz
	assign clock_tmp = clock + `CLOCK_BIT_WIDTH'd1;
	assign bck_clk = clock[2];
	assign au_bck = clock[2];
	
	/* sequential logic: DFF */
	always@(posedge clk or negedge rst_n)
		if(~rst_n) clock <= `CLOCK_BIT_WIDTH'd0;
		else clock <= clock_tmp;
	/* determine left/right output */
	always@(*)
		if(clock[7] == 1) data_in = au_in_left;
		else data_in = au_in_right;
	/* deal with serial data */	
	serializer SERIALIZER(
		.out(au_data),
		.data(data_in), 
		.clk(bck_clk), 
		.rst_n(rst_n)
	);
endmodule
