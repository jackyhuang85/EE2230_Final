`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:56:38 06/09/2016 
// Design Name: 
// Module Name:    fan_direction 
// Project Name: 	MusicFan
// Target Devices: 	EVS6
// Tool versions: 
// Description: 	To control the direction of the wind from fan.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fan_direction(fan_dic, dip, clk_us, clk_5Hz, rst_n);
	input clk_us, clk_5Hz, dip;
	input rst_n;
	output fan_dic;
	
	reg [10:0]direct, direct_tmp;
	reg [14:0]cnt, cnt_tmp;
	reg turn_back, turn_back_next;
	
	assign fan_dic = (cnt <= direct) ? 1'b1 : 1'b0;
	
	always@(*) begin
		if(direct >= 11'd2000) turn_back_next = 1;
		else if(direct <= 11'd1000) turn_back_next = 0;
		else turn_back_next = turn_back;
	end
	
	always@(*) begin
		if(turn_back)
			direct_tmp = direct - 11'd35;
		else
			direct_tmp = direct + 11'd35;
	end
	
	always@(*) begin
		if(cnt == 15'd19999)
			cnt_tmp = 15'd0;
		else begin
			if(dip)
				cnt_tmp = cnt;
			else
				cnt_tmp = cnt + 15'd1;
		end
	end
	
	always@(posedge clk_us or negedge rst_n)
		if(~rst_n) turn_back <= 0;
		else turn_back <= turn_back_next;
	always@(posedge clk_us or negedge rst_n)
		if(~rst_n) cnt <= 15'd0;
		else cnt <= cnt_tmp;
	always@(posedge clk_5Hz or negedge rst_n)
		if(~rst_n) direct <= 11'd1000;
		else direct <= direct_tmp;

endmodule
