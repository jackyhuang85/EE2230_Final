`timescale 1ns / 1ps
`include"param.v"
`include"frequency.v"
module note(pitch_name, pitch, key, pressed);
	output reg [19:0]pitch_name; //pitch name displayed
	output reg [19:0]pitch;		 //pitch signal
	input [3:0]key;				 //which key is pressed
	input pressed;				 //if any key is pressed
	
	//Combinational logic: determine the output by the key pressed
	always@(*)
		if(pressed)begin
			case(key)
				`KEY_0: begin
					pitch_name = 20'b01011_11010_01011_00000; //L-LA
					pitch = `PITCH_LOW_LA;
				end
				`KEY_1: begin
					pitch_name = 20'b01011_11010_10010_01000; //L-SI
					pitch = `PITCH_LOW_SI;
				end
				`KEY_2: begin
					pitch_name = 20'b11011_11011_00011_01110; //DO
					pitch = `PITCH_DO;
				end
				`KEY_3: begin
					pitch_name = 20'b11011_11011_10001_00100; //RE
					pitch = `PITCH_RE;
				end
				`KEY_4: begin
					pitch_name = 20'b11011_11011_01100_01000; //MI
					pitch = `PITCH_MI;
				end
				`KEY_5: begin
					pitch_name = 20'b11011_11011_00101_00000; //FA
					pitch = `PITCH_FA;
				end
				`KEY_6: begin
					pitch_name = 20'b11011_11011_10010_01110; //SO
					pitch = `PITCH_SO;
				end
				`KEY_7: begin
					pitch_name = 20'b11011_11011_01011_00000; //LA
					pitch = `PITCH_LA;
				end
				`KEY_8: begin
					pitch_name = 20'b11011_11011_10010_01000; //SI
					pitch = `PITCH_SI;
				end
				`KEY_9: begin
					pitch_name = 20'b00111_11010_00011_01110; //H-DO
					pitch = `PITCH_HIGH_DO;
				end
				`KEY_A: begin
					pitch_name = 20'b00111_11010_10001_00100; //H-RE
					pitch = `PITCH_HIGH_RE;
				end
				`KEY_B: begin
					pitch_name = 20'b00111_11010_01100_01000; //H-MI
					pitch = `PITCH_HIGH_MI;
				end
				`KEY_C: begin
					pitch_name = 20'b00111_11010_00101_00000; //H-FA
					pitch = `PITCH_HIGH_FA;
				end
				`KEY_D: begin
					pitch_name = 20'b00111_11010_10010_01110; //H-SO
					pitch = `PITCH_HIGH_SO;
				end
				`KEY_E: begin
					pitch_name = 20'b00111_11010_01011_00000; //H-LA
					pitch = `PITCH_HIGH_LA;
				end
				`KEY_F: begin
					pitch_name = 20'b00111_11010_10010_01000; //H-SI
					pitch = `PITCH_HIGH_SI;
				end
			endcase
		end
		else begin
			pitch_name = 20'b11011_11011_11011_11011;
			pitch = 20'd0;
		end

endmodule
