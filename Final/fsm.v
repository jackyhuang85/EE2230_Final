`timescale 1ns / 1ps

module fsm(count_en, clk, rst_n, btn_press);
	input btn_press, clk, rst_n;
	output reg count_en;
	
	reg state_now, state_next;
	
	always @(state_now or btn_press)begin
		if(~state_now)begin
			if(btn_press) begin state_next = 1'b1; count_en = 1'b1; end
			else begin state_next = 0; count_en = 0; end
		end
		else begin
			if(btn_press) begin state_next = 0; count_en = 0; end
			else begin state_next = 1'b1; count_en = 1'b1; end
		end
	end
	
	always @(posedge clk or negedge rst_n)begin
		if(~rst_n) state_now <= 0;
		else state_now <= state_next;
	end
endmodule
