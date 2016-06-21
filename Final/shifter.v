`timescale 1ns / 1ps

module shifter(Q0, Q1, Q2, Q3, clk, rst_n);
	output reg [2:0]Q0, Q1, Q2, Q3;
	reg [2:0]P0, P1, P2, P3, P4, P5, P6, P7;
	reg [2:0]Q4, Q5, Q6, Q7;
	input clk, rst_n;
	
	always @(*) begin
		P0 = Q1; P1 = Q2; P2 = Q3; P3 = Q4; P4 = Q5; P5 = Q6; P6 = Q7; P7 = Q0;
	end
	
	always@ (posedge clk or negedge rst_n) begin
		if(~rst_n) begin Q0 <= 3'd0; Q1 <= 3'd1; Q2 <= 3'd2; Q3 <= 3'd3; Q4 <= 3'd4; Q5 <= 3'd5; Q6 <= 3'd6; Q7 <= 3'd7; end
		else begin
			Q0 <= P0;
			Q1 <= P1;
			Q2 <= P2;
			Q3 <= P3;
			Q4 <= P4;
			Q5 <= P5;
			Q6 <= P6;
			Q7 <= P7;
		end
	end
endmodule
