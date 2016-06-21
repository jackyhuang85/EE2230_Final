`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:43:40 06/19/2016 
// Design Name: 
// Module Name:    song_sel 
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
module song_sel(button, song_sel, clk, rst_n);
	input [5:0]button;
	output reg[2:0]song_sel;
	input clk, rst_n;
	
	reg [2:0]state_next;
	
	always@(*)
		case(button)
			6'b111110:
				state_next = 6'd0;
			6'b111101:
				state_next = 6'd1;
			6'b111011:
				state_next = 6'd2;
			6'b110111:
				state_next = 6'd3;
			6'b101111:
				state_next = 6'd4;
			6'b011111:
				state_next = 6'd5;
			default:
				state_next = song_sel;
		endcase
	
	always@(posedge clk or negedge rst_n)
		if(~rst_n) song_sel <= 6'd0;
		else song_sel <= state_next;
	
endmodule
