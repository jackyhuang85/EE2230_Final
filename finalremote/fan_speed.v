`timescale 1ns / 1ps
`define HIGH 2'b00
`define MEDIUM 2'b01
`define LOW 2'b10
`define OFF 2'b11
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:05:34 06/09/2016 
// Design Name: 
// Module Name:    fan_speed 
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
module fan_speed(speed_ctl, speed, clk_us, rst_n);
	output speed_ctl;
	input [1:0]speed;
	input clk_us, rst_n;
	
	reg [10:0]cnt, cnt_tmp;
	reg [10:0]speed_lim;
	
	assign speed_ctl = (cnt <= speed_lim) ? 1'b1 : 1'b0;
	
	always@(*)
		case(speed)
			`LOW: speed_lim = 11'd1000;
			`MEDIUM: speed_lim = 11'd1500;
			`HIGH: speed_lim = 11'd2000;
			`OFF: speed_lim = 11'd0;
		endcase
		
	always@(*)
		if(cnt == 11'd1999)
			cnt_tmp = 11'd0;
		else 
			cnt_tmp = cnt + 11'd1;
	
	always@(posedge clk_us or negedge rst_n)
		if(~rst_n) cnt <= 11'd0;
		else cnt <= cnt_tmp;

endmodule
