`timescale 1ns / 1ps
`include "param.v"
`define HIGH 2'b00
`define MEDIUM 2'b01
`define LOW 2'b10
`define OFF 2'b11
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:44:55 06/09/2016 
// Design Name: 
// Module Name:    fsm_fan_speed 
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
module fsm_fan_speed(key, speed, clk, rst_n);
	input [3:0]key;
	output reg [1:0]speed;
	input clk, rst_n;
	
	reg [1:0]speed_tmp;
	
	always@(*)
		case(key)
			`KEY_1: 
				speed_tmp = `LOW;
			`KEY_2:
				speed_tmp = `MEDIUM;
			`KEY_3:
				speed_tmp = `HIGH;
			`KEY_0:
				speed_tmp = `OFF;
			default:
				speed_tmp = speed;
		endcase
	
	always@(posedge clk or negedge rst_n)
		if(~rst_n) speed <= `OFF;
		else speed <= speed_tmp;
		
endmodule
