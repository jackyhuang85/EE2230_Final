`timescale 1ns / 1ps
`include"alphabet.v"
module ftsd(display_value, value);
	input [4:0]value;			//data to be converted
	output reg [14:0]display_value;	//data to be display
	
	always @(*)begin			// Combinational logics
		case(value)
			`A:	display_value = 15'b00010000_111111_1;
			`B:	display_value = 15'b00001110_101101_1;
			`C:	display_value = 15'b01100011_111111_1;
			`D:	display_value = 15'b00001111_101101_1;
			`E:	display_value =	15'b01100000_111111_1;
			`F:	display_value =	15'b01110000_111111_1;
			`G:	display_value =	15'b01000010_111111_1;
			`H:	display_value = 15'b10010000_111111_1;
			`I:	display_value =	15'b01101111_101101_1;
			`J:	display_value = 15'b10000111_111111_1;
			`K:	display_value = 15'b11110001_110110_1;
			`L:	display_value =	15'b11100011_111111_1;
			`M:	display_value =	15'b10010011_010111_1;
			`N:	display_value =	15'b10010011_011110_1;
			`O:	display_value = 15'b00000011_111111_1;
			`P:	display_value = 15'b00110000_111111_1;
			`Q:	display_value = 15'b00000011_111110_1;
			`R:	display_value =	15'b00110000_111110_1;
			`S:	display_value = 15'b01001000_111111_1;
			`T:	display_value = 15'b01111111_101101_1;
			`U:	display_value = 15'b10000011_111111_1;
			`V:	display_value = 15'b11110011_110011_1;
			`W:	display_value = 15'b10010011_111010_1;
			`X:	display_value = 15'b11111111_010010_1;
			`Y:	display_value = 15'b11111111_010101_1;
			`Z:	display_value = 15'b01101111_110011_1;
			`HYPHEN:	display_value = 15'b11111100_111111_1;
			`SPACE:	display_value = 15'b11111111_111111_1;
			default: display_value = 15'b11111111_111111_1;
		endcase
	end
endmodule

