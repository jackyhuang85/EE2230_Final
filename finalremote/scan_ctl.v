`timescale 1ns / 1ps

module scan_ctl(ftsd_ctl, ftsd, in0, in1, in2, in3, ftsd_ctl_en);
	input [2:0]in0, in1, in2, in3;
	input [1:0]ftsd_ctl_en;
	output reg [3:0]ftsd_ctl;
	output reg [2:0]ftsd;
	
	always@ (ftsd_ctl_en or in3 or in2 or in1 or in0)begin
		case(ftsd_ctl_en)
			2'b00: begin ftsd_ctl = 4'b0111; ftsd = in0; end
			2'b01: begin ftsd_ctl = 4'b1011; ftsd = in1; end
			2'b10: begin ftsd_ctl = 4'b1101; ftsd = in2; end
			2'b11: begin ftsd_ctl = 4'b1110; ftsd = in3; end
			default: begin ftsd_ctl = 4'b0000; ftsd = in0; end
		endcase
	end
endmodule
