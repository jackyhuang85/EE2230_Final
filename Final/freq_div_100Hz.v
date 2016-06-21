`timescale 1ns / 1ps
`define FREQ_DIV_BIT 14

module freqdiv(clk_ftsd_scan, clksys, rst_n);
	output reg [1:0]clk_ftsd_scan;
	input rst_n, clksys;
	reg [11:0]clk_buffer_low;
	wire [`FREQ_DIV_BIT - 1:0]clk_cnt;
	
	assign clk_cnt = {clk_ftsd_scan, clk_buffer_low} + `FREQ_DIV_BIT'b1;

	always @(posedge clksys or negedge rst_n)begin
		if(~rst_n) 
			{clk_ftsd_scan, clk_buffer_low} <= `FREQ_DIV_BIT'b0;
		else
			{clk_ftsd_scan, clk_buffer_low} <= clk_cnt;
	end
endmodule
