`timescale 1ns / 1ps
module serializer(out, data, clk, rst_n);
	output reg out; //output
	input [15:0]data; //input 4-bit data
	input clk, rst_n; //clock; reset
	wire [3:0]out_cnt_tmp; //for counting
	reg [3:0]out_cnt; //counting
	reg out_tmp; //for always
	
	//next counting
	assign out_cnt_tmp = out_cnt + 4'b0001;
	
	always@(*) //use counter to determine output
		case(out_cnt)
			4'b0000: out_tmp = data[15];
			4'b0001: out_tmp = data[14];
			4'b0010: out_tmp = data[13];	
			4'b0011: out_tmp = data[12];
			4'b0100: out_tmp = data[11];
			4'b0101: out_tmp = data[10];
			4'b0110: out_tmp = data[9];	
			4'b0111: out_tmp = data[8];
			4'b1000: out_tmp = data[7];
			4'b1001: out_tmp = data[6];
			4'b1010: out_tmp = data[5];	
			4'b1011: out_tmp = data[4];
			4'b1100: out_tmp = data[3];
			4'b1101: out_tmp = data[2];
			4'b1110: out_tmp = data[1];	
			4'b1111: out_tmp = data[0];
		endcase

	//sequential logic: DFF
	always@(posedge clk or negedge rst_n)
		if(~rst_n) begin out <= 0; out_cnt <= 0; end
		else begin
			out <= out_tmp;
			out_cnt <= out_cnt_tmp;
		end
endmodule
