`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:27:34 06/09/2016 
// Design Name: 
// Module Name:    clk_div 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clk_div (rst_n, clk, clk_div);
	input rst_n;
	input clk;
	output reg clk_div;
	
	parameter counter_width = 14;
	parameter half_cycle = 10000; // to generate a half clock period of 10000 cycles

	// internal signals
	reg [counter_width - 1:0] count, count_next;
	reg clk_div_next;

	always @* begin
		if (count == (half_cycle - 1)) begin
			count_next = 0;
			clk_div_next = ~clk_div;
		end 
		else begin
			count_next = count + 1'b1;
			clk_div_next = clk_div;
		end
  end
  
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			count <= 0;
			clk_div <= 0;
		end else begin
			count <= count_next;
			clk_div <= clk_div_next;
		end
	end

endmodule
