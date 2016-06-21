`timescale 1ns / 1ps

module one_pulse(one_pulse_out, clk, rst_n, in_trig);
	output reg one_pulse_out;
	input clk, rst_n, in_trig;
	
	reg in_trig_tmp;
	wire one_pulse_next;
	
	assign one_pulse_next = in_trig & (~in_trig_tmp);
	
	always @(posedge clk or negedge rst_n)begin
		if(~rst_n) begin one_pulse_out <= 0; in_trig_tmp <= 0; end
		else begin one_pulse_out <= one_pulse_next; in_trig_tmp <= in_trig; end
	end

endmodule
