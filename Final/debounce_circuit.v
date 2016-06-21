`timescale 1ns / 1ps

module debounce_circuit(debounce_out, clk, rst_n, debounce_in);
	output reg debounce_out;
	input clk, rst_n, debounce_in;
	
	reg [3:0]debounce_tmp;
	wire debounce_next;
	
	assign debounce_next = (debounce_tmp == 4'b1111)? 1'b1 : 1'b0;
	
	always@(posedge clk or negedge rst_n)begin
		if(~rst_n) begin 
			debounce_out <= 0;
			debounce_tmp <= 4'b0000;
		end
		else begin
			debounce_out <= debounce_next;
			debounce_tmp <= {debounce_tmp[2:0], ~debounce_in};
		end
	end
endmodule
